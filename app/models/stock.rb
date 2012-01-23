class Stock < ActiveRecord::Base
  belongs_to :product
  belongs_to :measure_unit
  belongs_to :total_measure_unit       , :class_name => "MeasureUnit"
  belongs_to :total_before_measure_unit, :class_name => "MeasureUnit"
  before_create :check_measure_unit_convertions
  
  #Verifica o último saldo antes de gravar um novo registro
  def check_measure_unit_convertions
    last      = Stock.last_movimentation(self.product_id)[0]
    main_unit = MeasureUnit.find_main(self.product_id)[0]

    #converte para a unidade de medida principal caso tenha sido alterada
      #Total anterior
    if last.total_measure_unit_id != main_unit.id
      self.total_before = last.total * MeasureUnit.find(last.total_measure_unit_id).ratio
    else
      self.total_before = last.total
    end
    self.total_before_measure_unit_id = last.total_measure_unit_id
    
      #Movimentação
    if self.quantity_in
      if self.measure_unit_id != main_unit.id
        self.total = self.total_before + (self.quantity_in * MeasureUnit.find(self.measure_unit_id).ratio)
      else
        self.total = self.total_before + self.quantity_in
      end
    else
      if self.measure_unit_id != main_unit.id
        self.total = self.total_before - (self.quantity_out * MeasureUnit.find(self.measure_unit_id).ratio)
      else
        self.total = self.total_before - self.quantity_out
      end
    end
    self.total_measure_unit_id = main_unit.id
    
  end
  
  attr_accessor :total_before_to_show
  attr_accessor :total_to_show

  # Select st.*
  #      , IFNULL(st.quantity_in, - st.quantity_out) quantity
  #      , tb.measure_unit as tb_munit
  #      , mu.measure_unit as mu_munit
  #      , tm.measure_unit as tm_munit
  # From stocks        st Join
  #      measure_units tb On tb.id = st.total_before_measure_unit_id Join
  #      measure_units mu On mu.id = st.measure_unit_id              Join
  #      measure_units tm On tm.id = st.total_measure_unit_id
  # Where st.product_id = 1
  # Order By st.created_at

  named_scope :product, lambda { |product_id| 
    {:select => "st.*, IFNULL(st.quantity_in, - st.quantity_out) quantity, tb.measure_unit as tb_munit, mu.measure_unit as mu_munit, tm.measure_unit as tm_munit",
     :joins => "st Join measure_units tb On tb.id = st.total_before_measure_unit_id Join measure_units mu On mu.id = st.measure_unit_id Join measure_units tm On tm.id = st.total_measure_unit_id",
     :conditions => ["st.product_id = ?", product_id], 
     :order => "st.created_at"}
  }

  named_scope :last_movimentation, lambda { |product_id|
    {:conditions => ["product_id = ?", product_id], 
     :order => "created_at Desc",
     :limit => 1 }
  }
  
  
  
end
