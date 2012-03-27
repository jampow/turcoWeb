class CreateFunctionFnCodlimpo < ActiveRecord::Migration
  def self.up
    execute 'DROP FUNCTION IF EXISTS `fn_CodLimpo`;'
    execute <<-SQL
      CREATE FUNCTION `fn_CodLimpo` (s varchar(254)) RETURNS VarChar(254)
      BEGIN

        Set @res = s;
        Set @res = Replace(@res, '.', '');
        Set @res = Replace(@res, '/', '');
        Set @res = Replace(@res, '-', '');
        Set @res = Replace(@res, ',', '');
        Set @res = Replace(@res, ' ', '');
        Set @res = Replace(@res, '(', '');
        Set @res = Replace(@res, ')', '');

        Return @res;

      END;
    SQL
  end

  def self.down
    execute 'DROP FUNCTION IF EXISTS `fn_CodLimpo`'
  end
end
