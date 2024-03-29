class Client < ActiveRecord::Base
  has_many   :attachments                               , :foreign_key => 'external_id'         , :dependent => :destroy
  has_many   :invoices
  has_many   :receivables
  has_many   :contacts                                  , :foreign_key => 'external_id'         , :dependent => :destroy
  has_many   :addresses       , :as => :addressable                                             , :dependent => :destroy
  has_many   :sales_orders
  has_many   :locations
  belongs_to :main_address    , :class_name => 'Address', :foreign_key => 'main_address_id'     , :dependent => :destroy
  belongs_to :billing_address , :class_name => 'Address', :foreign_key => 'billing_address_id'  , :dependent => :destroy
  belongs_to :delivery_address, :class_name => 'Address', :foreign_key => 'delivery_address_id' , :dependent => :destroy
  belongs_to :activity

  accepts_nested_attributes_for :contacts         , :reject_if => proc { |a| a[:name].blank? }
  accepts_nested_attributes_for :main_address
  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :delivery_address

  validates_presence_of :code
  validates_presence_of :name
  validates_presence_of :doc
  validates_presence_of :activity_id

  validates_uniqueness_of :code

  attr_accessor  :doc
  attr_accessor  :doc_mask
  #usar_como_cnpj :cnpj
  #usar_como_cpf  :cpf

  before_save :mark_contact_for_removal
  validate :validate_cpf_or_cnpj

  def mark_contact_for_removal
    contacts.each do |child|
      child.mark_for_destruction if child.name.blank?
    end
  end

  before_destroy :validate_dependencies

  def validate_dependencies
    de = true

    de = false if invoices.count > 0
    de = false if receivables.count > 0
    de = false if sales_orders.count > 0
    de = false if locations.count > 0

    return false if !de;
  end

  def doc=(value)
    if value.length > 14
      self.cnpj = value
      self.cpf = nil
    else
      self.cpf = value
      self.cnpj = nil
    end
  end

  def doc
    self.cnpj ? self.cnpj : self.cpf
  end

  def validate_cpf_or_cnpj
    if self.doc.length > 14
      valid = Cnpj.new(self.doc).valido?
    else
      valid = Cpf.new(self.doc).valido?
    end
    self.errors.add("doc", " inválido") unless valid
  end

  # def after_initialize
  #   if self.respond_to?('cnpj') && self.respond_to?('cpf')
  #     if self.cnpj
  #       self.doc = self.cnpj
  #       self.doc_mask = "mask-cnpj"
  #     elsif self.cpf
  #       self.doc = self.cpf
  #       self.doc_mask = "mask-cpf"
  #     end
  #   end
  # end

 # Select Cli.id
 #      , Cli.name
 #      , Cli.nickname
 #      , Cli.cnpj
 #      , Cli.cpf
 #      , Peo.name as contact
 #      , Pho.number
 #   From clients Cli Left Join
 #        people  Peo On Peo.external_id = Cli.id Left Join
 #        phones  Pho On Pho.person_id   = Peo.id
 #  Where Cli.active = 1 And (Pho.main is null or Pho.main = 1)

  named_scope :grid, {
    :select     => "Cli.id, Cli.code, Cli.name, Cli.nickname, Cli.cnpj, Cli.cpf, Peo.name as contact, Pho.number",
    :joins      => "Cli Left Join people Peo On Peo.external_id = Cli.id Left Join phones Pho On Pho.person_id = Peo.id",
    :conditions => "Cli.active = 1 And (Pho.main is null or Pho.main = 1)"
  }

  named_scope :actives, :conditions => { :active => true }, :order => "name"

  def aliq_icms
    delivery_estate.aliq_icms
  end

  def billing_estate
    billing_address.estate
  end

  def delivery_estate
    delivery_address.estate
  end

  def phone index
    contacts.main[0].phones[index-1].number
  end

  def email
    contacts.main[0].email
  end

  def located_items
    LocationItem.from_client self.id
  end

end

