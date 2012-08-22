class ChangeCashFlowReceivablesViewsToDueDate < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      Create Or Replace View VwCashFlowReceivablesPre As
      Select rec.id
            , Cast(rec.due_date As Date) As due_date
            , rec.value - Sum(IfNull(reb.value, 0.00)) As payable
      From receivables rec
      Left Join receivable_billings reb On reb.receivable_id = rec.id
      Where IfNull(reb.value, 0.00) < rec.value
      And rec.settled is False
      Group By id;
    SQL
    execute <<-SQL
      Create Or Replace View VwCashFlowReceivables As
      Select sub.due_date As date
           , Sum(sub.payable) As rec
           , 0.00 As recd
           , 0.00 As pay
           , 0.00 As payd
      From
          VwCashFlowReceivablesPre As sub
      Group By due_date;
    SQL
  end

  def self.down
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
  end
end
