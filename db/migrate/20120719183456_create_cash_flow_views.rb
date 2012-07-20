class CreateCashFlowViews < ActiveRecord::Migration
  def self.up

# Select cf.date
# --     , Date_Add(cf.date, Interval 1 Month) As next_month -- 31/08/2012 + 1 mês = 30/09/2012
#      , Sum(cf.rec)  As rec
#      , Sum(cf.recd) As recd
#      , Sum(cf.pay)  As pay
#      , Sum(cf.payd) As payd
#      , If(cf.date < Cast(Now() As Date)
#         , Sum(cf.recd) - Sum(cf.payd)
#         , Sum(cf.rec) - Sum(cf.pay)) As test
# From
#     (-- Receber
#     Select sub.issue_date As date
#          , Sum(sub.payable) As rec
#          , 0.00 As recd
#          , 0.00 As pay
#          , 0.00 As payd
#     From
#         (Select rec.id
#               , Cast(rec.issue_date As Date) As issue_date
#               , rec.value - Sum(IfNull(reb.value, 0.00)) As payable
#         From receivables rec
#         Left Join receivable_billings reb On reb.receivable_id = rec.id
#         Where IfNull(reb.value, 0.00) < rec.value
#         And rec.settled is False
#         Group By id) As sub
#     Group By issue_date
#     Union All
#     -- Recebido
#     Select Cast(received_at As Date) As date
#          , 0.00 As rec
#          , Sum(value) As recd
#          , 0.00 As pay
#          , 0.00 As payd
#     From receivable_billings
#     Group By received_at
#     Union All
#     -- Pagar
#     Select sub.due_date As date
#          , 0.00 As rec
#          , 0.00 As recd
#          , Sum(sub.payable) As pay
#          , 0.00 As payd
#     From
#         (Select pay.id
#               , Cast(pay.due_date As Date) As due_date
#               , pay.value - Sum(IfNull(pab.value, 0.00)) As payable
#         From payables pay
#         Left Join payable_billings pab On pab.payable_id = pay.id
#         Where IfNull(pab.value, 0.00) < pay.value
#         And pay.settled is False
#         Group By id) As sub
#     Group By due_date
#     Union All
#     -- Pagos
#     Select Cast(received_at As Date) As date
#          , 0.00 As rec
#          , 0.00 As recd
#          , 0.00 As pay
#          , Sum(value) As payd
#     From payable_billings
#     Group By received_at) As cf
# Group By date
# Order by date


    execute <<-SQL
      Create Or Replace View VwCashFlowReceivablesPre As
      Select rec.id
            , Cast(rec.issue_date As Date) As issue_date
            , rec.value - Sum(IfNull(reb.value, 0.00)) As payable
      From receivables rec
      Left Join receivable_billings reb On reb.receivable_id = rec.id
      Where IfNull(reb.value, 0.00) < rec.value
      And rec.settled is False
      Group By id;
    SQL
    execute <<-SQL
      Create Or Replace View VwCashFlowReceivables As
      Select sub.issue_date As date
           , Sum(sub.payable) As rec
           , 0.00 As recd
           , 0.00 As pay
           , 0.00 As payd
      From
          VwCashFlowReceivablesPre As sub
      Group By issue_date;
    SQL
    execute <<-SQL
      Create Or Replace View VwCashFlowReceived As
      Select Cast(received_at As Date) As date
           , 0.00 As rec
           , Sum(value) As recd
           , 0.00 As pay
           , 0.00 As payd
      From receivable_billings
      Group By received_at
    SQL

    execute <<-SQL
      Create Or Replace View VwCashFlowPayablesPre As
      Select pay.id
            , Cast(pay.due_date As Date) As due_date
            , pay.value - Sum(IfNull(pab.value, 0.00)) As payable
      From payables pay
      Left Join payable_billings pab On pab.payable_id = pay.id
      Where IfNull(pab.value, 0.00) < pay.value
      And pay.settled is False
      Group By id
    SQL
    execute <<-SQL
      Create Or Replace View VwCashFlowPayables As
      Select sub.due_date As date
           , 0.00 As rec
           , 0.00 As recd
           , Sum(sub.payable) As pay
           , 0.00 As payd
      From
          VwCashFlowPayablesPre As sub
      Group By due_date;
    SQL
    execute <<-SQL
      Create Or Replace View VwCashFlowPayd As
      Select Cast(received_at As Date) As date
           , 0.00 As rec
           , 0.00 As recd
           , 0.00 As pay
           , Sum(value) As payd
      From payable_billings
      Group By received_at
    SQL

    execute <<-SQL
      Create Or Replace View VwCashFlowUnion As
      -- Receber
      Select * From VwCashFlowReceivables
      Union All
      -- Recebido
      Select * From VwCashFlowReceived
      Union All
      -- Pagar
      Select * From VwCashFlowPayables
      Union All
      -- Pagos
      Select * From VwCashFlowPayd;
    SQL

    execute <<-SQL
      Create Or Replace View VwCashFlow As
      Select cf.date
      --     , Date_Add(cf.date, Interval 1 Month) As next_month -- 31/08/2012 + 1 mês = 30/09/2012
           , Sum(cf.rec)  As rec
           , Sum(cf.recd) As recd
           , Sum(cf.pay)  As pay
           , Sum(cf.payd) As payd
           , If(cf.date < Cast(Now() As Date)
              , Sum(cf.recd) - Sum(cf.payd)
              , Sum(cf.rec) - Sum(cf.pay)) As total
      From
          VwCashFlowUnion As cf
      Group By date
      Order by date;
    SQL
  end

  def self.down
    execute "Drop View VwCashFlowReceivablesPre, VwCashFlowReceivables, VwCashFlowReceived, VwCashFlowPayablesPre, VwCashFlowPayables, VwCashFlowPayd, VwCashFlowUnion, VwCashFlow;"
  end
end
