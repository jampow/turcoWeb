module StocksHelper
  def btn_stocks(id)
    link_to "Movimentações", stocks_path + "?product=#{id}", {:class => "button", :icon => "arrow-4"}
  end
end
