class Product < ActiveRecord::Base
  belongs_to :product_kind  , :foreign_key => "type_id"
  belongs_to :product_family, :foreign_key => "family_id"
  belongs_to :cst_cofins
  belongs_to :cst_icm
  belongs_to :cst_ipi
  belongs_to :cst_pis
  has_many   :attachments, :foreign_key => 'external_id', :dependent => :destroy
  has_many   :measure_units

  validates_uniqueness_of :code
  validate :length_of_ncm

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
 # Where pro.name like '%term%' Or pro.code like '%term%'
 # Order By name

  named_scope :to_autocomplete, lambda { |term| {
    :select => "pro.id As product_id, concat(pro.code, ' - ', pro.name) As label, pro.name As value, pro.cofins, icm.value As icm, pro.ipi As aliq_ipi, pro.pis, pro.price As unit_value, pro.net_weight As net_weight, pro.gross_weight As gross_weight",
    :conditions => ["pro.name like ? Or pro.code like ?", "%#{term}%", "%#{term}%"],
    :order => "name",
    :joins => "pro Left Join csts cof On cof.id = pro.cst_cofins_id Left Join csts icm On icm.id = pro.cst_icm_id Left Join csts ipi On ipi.id = pro.cst_ipi_id Left Join csts pis On pis.id = pro.cst_pis_id"}}

  named_scope :grid, :select => "pro.id, pro.code, pro.name, fam.name As family",
                     :joins => "pro Left Join product_families fam On fam.id = pro.family_id"

  def quantity
    Stock.last :conditions => ["product_id = ?", self.id]
  end

  protected

  def length_of_ncm
    len = self.ncm.length
    self.errors.add("ncm", " tem #{len} caracteres. Deve ter 2, 7 ou 8.") unless [2,7,8].include? len
  end
end


