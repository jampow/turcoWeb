module LocationReceiptsHelper
  def btn_print(id)
    link_to "Imprimir", "/location_receipts/print/#{id}", :class => "button", :icon => "print", :ajax => "false", :target => "_blank"
  end
end
