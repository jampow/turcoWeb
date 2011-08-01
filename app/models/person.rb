class Person < ActiveRecord::Base
  has_many :phones, :dependent => :destroy

  accepts_nested_attributes_for :phones, :reject_if => proc { |a| a[:number].blank? }

  before_save :mark_phone_for_removal

  def mark_phone_for_removal
    phones.each do |child|
      child.mark_for_destruction if child.number.blank?
    end
  end

  named_scope :main, {
    :select     => "people.*",
    :joins      => "Join phones Pho On Pho.person_id = people.id",
    :conditions => "Pho.main = 1 "
  }

  named_scope :others, {
    :select     => "Distinct people.*",
    :joins      => "Left Join phones Pho On Pho.person_id = people.id",
    :conditions => "people.id not in (Select Peo.id From people Peo Join phones Pho On Pho.person_id = Peo.id Where Pho.main = 1) "
  }

end

