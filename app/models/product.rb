class Product < ActiveRecord::Base
  # belongs_to :kind  , :class_name => 'ProductKind'  , :foreign_key => "type_id"
  belongs_to :family, :class_name => 'ProductFamily', :foreign_key => "family_id"
  belongs_to :cst_cofins
  belongs_to :cst_icm
  belongs_to :cst_ipi
  belongs_to :cst_pis
  has_many   :attachments, :foreign_key => 'external_id', :dependent => :destroy
  has_many   :measure_units                             , :dependent => :destroy

  validates_uniqueness_of :code
  #validate :length_of_ncm

  def m2
    width * depth
  end

  def m3
    m2 * height
  end


  #named_scope :quantity, :select => "sum()" :conditions => { :field => condition }, :order => "field"

 # Select pro.id
 #      , concat(pro.code, ' - ', pro.name) As label
 #      , pro.name         As value
 #      , pro.code
 #      , cof.value        As cofins
 #      , icm.value        As icm
 #      , ipi.value        As ipi
 #      , pis.value        As pis
 #      , pro.net_weight   As net_weight
 #      , pro.gross_weight As gross_weight
 # From products pro Left Join
 #      csts     cof On cof.id = pro.cst_cofins_id Left Join
 #      csts     icm On icm.id = pro.cst_icm_id    Left Join
 #      csts     ipi On ipi.id = pro.cst_ipi_id    Left Join
 #      csts     pis On pis.id = pro.cst_pis_id
 # Where (pro.name like '%term%' Or pro.code like '%term%')
 # And   pro.type_id = 1
 # Order By name

  named_scope :to_autocomplete, lambda { |term, prod_type| {
    :select => "pro.id As product_id, concat(pro.code, ' - ', pro.name) As label, pro.name As value, pro.cofins, icm.value As icm, pro.ipi As aliq_ipi, pro.pis, pro.price As unit_value, pro.net_weight As net_weight, pro.gross_weight As gross_weight",
    :conditions => ["(pro.name like ? Or pro.code like ?) And pro.type_id = ?", "%#{term}%", "%#{term}%", prod_type],
    :order => "name",
    :joins => "pro Left Join csts cof On cof.id = pro.cst_cofins_id Left Join csts icm On icm.id = pro.cst_icm_id Left Join csts ipi On ipi.id = pro.cst_ipi_id Left Join csts pis On pis.id = pro.cst_pis_id"}}

# Select id As product_id
#      , concat(code, ' - ', name) As label
#      , name
# From products
# Where type_id = 2 -- locação
# And (pro.name like '%term%' Or pro.code like '%term%')
# And id Not In (
#     Select Distinct pro.id
#     From products pro
#     Join location_items loi On loi.product_id = pro.id
#     Join locations loc On loc.id = loi.location_id
#     Where pro.type_id = 2 -- locação
#     And (loc.ends_at Is Null Or loc.ends_at > Cast(Now() As Date))
# );

  named_scope :to_autocomplete_location, lambda { |term| {
    :select => "id As product_id, concat(code, ' - ', name) As label, name",
    :conditions => ["type_id = 2 And (name like ? Or code like ?) And id Not In (Select Distinct pro.id From products pro Join location_items loi On loi.product_id = pro.id Join locations loc On loc.id = loi.location_id Where pro.type_id = 2 And (loc.ends_at Is Null Or loc.ends_at > Cast(Now() As Date)))", "%#{term}%", "%#{term}%"]
  }}

  named_scope :grid, :select => "pro.id, pro.code, pro.name, fam.name As family",
                     :joins => "pro Left Join product_families fam On fam.id = pro.family_id"

# Select Count(id) As qtd
#      , Sum(width * depth) As met2
#      , Sum(width * depth * height) As met3
# From products
# Where type_id = 2;

  named_scope :report_totals, :select => "Count(id) As qtd, Sum(width*depth) As met2, Sum(width*depth*height) As met3",
                              :conditions => "type_id = 2"

  def quantity
    Stock.last :conditions => ["product_id = ?", self.id]
  end

  class Type <
    Struct.new(:id, :name)
    VALUES = [
      {:id => 1, :name => 'Venda'},
      {:id => 2, :name => 'Locação'},
      {:id => 3, :name => 'Compra'}
    ]
    def self.all
      VALUES.map { |v| self.new(v[:id], v[:name]) }
    end

    def self.to_select
      VALUES.map { |v| [v[:name], v[:id]] }
    end

    def self.find(id)
      h=VALUES.find { |v| v[:id] == id }
      return nil if h.nil?
      self.new(h[:id], h[:name])
    end

    def to_s
      self.name
    end
  end

  protected

  def length_of_ncm
    len = self.ncm.length
    self.errors.add("ncm", " tem #{len} caracteres. Deve ter 2, 7 ou 8.") unless [2,7,8].include? len
  end
end


