module MeasureUnitsHelper

  def btn_measure_units(id)
    link_to "Unidades de medida", measure_units_path + "?product=#{id}", {:class => "button", :icon => "arrowthickstop-1-s"}
  end
end
