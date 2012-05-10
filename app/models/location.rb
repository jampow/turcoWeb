class Location < ActiveRecord::Base
  has_many :location_items, :dependent => :delete_all
  belongs_to :client
  belongs_to :seller
  belongs_to :payment_form, :foreign_key => "payment_condition_id"

  attr_accessor :client_name
  attr_accessor :seller_name

  accepts_nested_attributes_for :location_items, :reject_if => proc { |a| a[:product_name].blank? }

  def item_grid
    LocationItem.grid self.id
  end

  protected

  def mark_item_for_removal
    location_items.each do |child|
      child.mark_for_destruction if child.product_name.blank?
    end
  end

# Select loc.id
#      , loc.number
#      , cli.name As cli
#      , loc.starts_at
#      , loc.ends_at
# From locations loc
# Left Join clients   cli On cli.id = loc.client_id

  named_scope :grid, :select => "loc.id, loc.number, cli.name As cli, loc.starts_at, loc.ends_at",
                     :joins => "loc Left Join clients cli On cli.id = loc.client_id"

end
