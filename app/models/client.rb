class Client < ActiveRecord::Base
  has_many   :attachments                               , :foreign_key => 'external_id'         , :dependent => :destroy
  has_many   :invoices
  has_many   :receivables     , :through => :invoices
  has_many   :contacts                                  , :foreign_key => 'external_id'         , :dependent => :destroy
  has_many   :addresses       , :as => :addressable                                             , :dependent => :destroy
  belongs_to :main_address    , :class_name => 'Address', :foreign_key => 'main_address_id'     , :dependent => :destroy
  belongs_to :billing_address , :class_name => 'Address', :foreign_key => 'billing_address_id'  , :dependent => :destroy
  belongs_to :delivery_address, :class_name => 'Address', :foreign_key => 'delivery_address_id' , :dependent => :destroy
  belongs_to :activity


  accepts_nested_attributes_for :contacts         , :reject_if => proc { |a| a[:name].blank? }
  accepts_nested_attributes_for :main_address
  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :delivery_address

  validates_presence_of :name
  validates_presence_of :activity_id

  named_scope :actives, :conditions => { :active => true }, :order => "name"

  before_save :mark_contact_for_removal

  def mark_contact_for_removal
    contacts.each do |child|
      child.mark_for_destruction if child.name.blank?
    end
  end

#  Select Cli.id
#       , Cli.name
#       , Cli.nickname
#       , Cli.cnpj
#       , Peo.name as contact
#       , Pho.number
#    From clients Cli Left Join
#         people  Peo On Peo.external_id = Cli.id Left Join
#         phones  Pho On Pho.person_id   = Peo.id
#   Where Cli.active = 1 And (Pho.main is null or Pho.main = 1)

  named_scope :grid, {
    :select     => "Cli.id, Cli.name, Cli.nickname, Cli.cnpj, Peo.name as contact, Pho.number",
    :joins      => "Cli Left Join people Peo On Peo.external_id = Cli.id Left Join phones Pho On Pho.person_id = Peo.id",
    :conditions => "Cli.active = 1 And (Pho.main is null or Pho.main = 1)"
  }

end

