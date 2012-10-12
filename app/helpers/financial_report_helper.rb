module FinancialReportHelper
  def menu
    s  = link_to "Fluxo de caixa" , "financial_report/cash_flow_filter"   , :class => "button"
    s += link_to "Despesas"       , "financial_report/expenditure_filter" , :class => "button"
    s += link_to "Receitas"       , "financial_report/sales_filter"       , :class => "button"
    s += link_to "Balancete"      , "financial_report/account_plan_filter", :class => "button"
  end
end
