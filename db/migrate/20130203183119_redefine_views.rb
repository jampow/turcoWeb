class RedefineViews < ActiveRecord::Migration
  def self.up

    # únicas alterações nas views:
    #  - VwCashFlowPayablesPre
    #  - VwCashFlowReceivablesPre
    # adicionado "OR settled is null" na cláusula Where

    execute <<-SQL
      Drop table if exists VwCashFlow;
      CREATE OR REPLACE VIEW `VwCashFlow` AS select `cf`.`date` AS `date`,sum(`cf`.`rec`) AS `rec`,sum(`cf`.`pay`) AS `pay`,(sum(`cf`.`rec`) - sum(`cf`.`pay`)) AS `total` from `VwCashFlowUnion` `cf` group by `cf`.`date` order by `cf`.`date`;
      Drop table if exists VwCashFlowPayables;
      CREATE OR REPLACE VIEW `VwCashFlowPayables` AS select `sub`.`due_date` AS `date`,0.00 AS `rec`,0.00 AS `recd`,sum(`sub`.`payable`) AS `pay`,0.00 AS `payd` from `VwCashFlowPayablesPre` `sub` group by `sub`.`due_date`;
      Drop table if exists VwCashFlowPayablesPre;
      CREATE OR REPLACE VIEW `VwCashFlowPayablesPre` AS select `pay`.`id` AS `id`,cast(`pay`.`due_date` as date) AS `due_date`,(`pay`.`value` - sum(ifnull(`pab`.`value`,0.00))) AS `payable` from (`payables` `pay` left join `payable_billings` `pab` on((`pab`.`payable_id` = `pay`.`id`))) where ((ifnull(`pab`.`value`,0.00) < `pay`.`value`) and (`pay`.`settled` is false or `pay`.`settled` is null)) group by `pay`.`id`;
      Drop table if exists VwCashFlowPayd;
      CREATE OR REPLACE VIEW `VwCashFlowPayd` AS select cast(`payable_billings`.`received_at` as date) AS `date`,0.00 AS `rec`,0.00 AS `recd`,0.00 AS `pay`,sum(`payable_billings`.`value`) AS `payd` from `payable_billings` group by `payable_billings`.`received_at`;
      Drop table if exists VwCashFlowReceivables;
      CREATE OR REPLACE VIEW `VwCashFlowReceivables` AS select `sub`.`due_date` AS `date`,sum(`sub`.`receivable`) AS `rec`,0.00 AS `recd`,0.00 AS `pay`,0.00 AS `payd` from `VwCashFlowReceivablesPre` `sub` group by `sub`.`due_date`;
      Drop table if exists VwCashFlowReceivablesPre;
      CREATE OR REPLACE VIEW `VwCashFlowReceivablesPre` AS select `rec`.`id` AS `id`,cast(`rec`.`due_date` as date) AS `due_date`,(`rec`.`value` - sum(ifnull(`reb`.`value`,0.00))) AS `receivable` from (`receivables` `rec` left join `receivable_billings` `reb` on((`reb`.`receivable_id` = `rec`.`id`))) where ((ifnull(`reb`.`value`,0.00) < `rec`.`value`) and (`rec`.`settled` is false or `rec`.`settled` is null)) group by `rec`.`id`;
      Drop table if exists VwCashFlowReceived;
      CREATE OR REPLACE VIEW `VwCashFlowReceived` AS select cast(`receivable_billings`.`received_at` as date) AS `date`,0.00 AS `rec`,sum(`receivable_billings`.`value`) AS `recd`,0.00 AS `pay`,0.00 AS `payd` from `receivable_billings` group by `receivable_billings`.`received_at`;
      Drop table if exists VwCashFlowUnion;
      CREATE OR REPLACE VIEW `VwCashFlowUnion` AS select `VwCashFlowReceivables`.`date` AS `date`,`VwCashFlowReceivables`.`rec` AS `rec`,`VwCashFlowReceivables`.`recd` AS `recd`,`VwCashFlowReceivables`.`pay` AS `pay`,`VwCashFlowReceivables`.`payd` AS `payd` from `VwCashFlowReceivables` union all select `VwCashFlowReceived`.`date` AS `date`,`VwCashFlowReceived`.`rec` AS `rec`,`VwCashFlowReceived`.`recd` AS `recd`,`VwCashFlowReceived`.`pay` AS `pay`,`VwCashFlowReceived`.`payd` AS `payd` from `VwCashFlowReceived` union all select `VwCashFlowPayables`.`date` AS `date`,`VwCashFlowPayables`.`rec` AS `rec`,`VwCashFlowPayables`.`recd` AS `recd`,`VwCashFlowPayables`.`pay` AS `pay`,`VwCashFlowPayables`.`payd` AS `payd` from `VwCashFlowPayables` union all select `VwCashFlowPayd`.`date` AS `date`,`VwCashFlowPayd`.`rec` AS `rec`,`VwCashFlowPayd`.`recd` AS `recd`,`VwCashFlowPayd`.`pay` AS `pay`,`VwCashFlowPayd`.`payd` AS `payd` from `VwCashFlowPayd`;
    SQL

  end

  def self.down
  end
end
