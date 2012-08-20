class RemovePastOfVwCashFlow < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      Create Or Replace View VwCashFlow As
      Select cf.date
           , Sum(cf.rec)  As rec
           , Sum(cf.pay)  As pay
           , Sum(cf.rec) - Sum(cf.pay) As total
      From
          VwCashFlowUnion As cf
      Group By date
      Order by date;
    SQL
  end

  def self.down
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
end
