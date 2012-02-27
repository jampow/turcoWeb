class MeasureUnit < ActiveRecord::Base
  belongs_to :product
  before_save :validate_uniqueness_main
  
  named_scope :find_main , lambda { |product_id| { :conditions => { :product_id => product_id, :main => true }}}
  named_scope :by_product, lambda { |product_id| { :conditions => { :product_id => product_id }}}
  
private
  
  def validate_uniqueness_main
    if self.main
      mu = MeasureUnit.find_main(self.product_id)[0]
      if !mu.nil? && mu.id != self.id
        mu.main = false
        mu.save!
      end
    end
  end
  
end
