Create Or Replace View VwCashFlowReceivablesPre As
Select rec.id
     , Cast(rec.due_date As Date) As due_date
     , rec.value - Sum(IfNull(reb.value, 0.00)) As payable
From receivables rec
Left Join receivable_billings reb On reb.receivable_id = rec.id
Where IfNull(reb.value, 0.00) < rec.value
And rec.settled is False
Group By id;

Create Or Replace View VwCashFlowReceivables As
Select sub.due_date As date
     , Sum(sub.payable) As rec
     , 0.00 As recd
     , 0.00 As pay
     , 0.00 As payd
From
    VwCashFlowReceivablesPre As sub
Group By due_date;

Create Or Replace View VwCashFlowReceived As
Select Cast(received_at As Date) As date
     , 0.00 As rec
     , Sum(value) As recd
     , 0.00 As pay
     , 0.00 As payd
From receivable_billings
Group By received_at;

Create Or Replace View VwCashFlowPayablesPre As
Select pay.id
     , Cast(pay.due_date As Date) As due_date
     , pay.value - Sum(IfNull(pab.value, 0.00)) As payable
From payables pay
Left Join payable_billings pab On pab.payable_id = pay.id
Where IfNull(pab.value, 0.00) < pay.value
And pay.settled is False
Group By id;

Create Or Replace View VwCashFlowPayables As
Select sub.due_date As date
     , 0.00 As rec
     , 0.00 As recd
     , Sum(sub.payable) As pay
     , 0.00 As payd
From
    VwCashFlowPayablesPre As sub
Group By due_date;

Create Or Replace View VwCashFlowPayd As
Select Cast(received_at As Date) As date
     , 0.00 As rec
     , 0.00 As recd
     , 0.00 As pay
     , Sum(value) As payd
From payable_billings
Group By received_at;

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

Create Or Replace View VwCashFlow As
Select cf.date
     , Sum(cf.rec)  As rec
     , Sum(cf.pay)  As pay
     , Sum(cf.rec) - Sum(cf.pay) As total
From
    VwCashFlowUnion As cf
Group By date
Order by date;