require 'test_helper'

class CfopTest < ActiveSupport::TestCase

  test "should not save the CFOP with out a number" do
    cfop = Cfop.new
    assert !cfop.save
  end

  test "should be invalid with a big name" do
    cfop = Cfop.new :number => 2000,
                    :name => "aqui vai um nome absurdo com mais de 40 caracteres"
    assert !cfop.valid?, "Nome muito grande"
  end

  test "should number is between 1100 and 8000" do
    cfop = Cfop.new :number => 1000,
                    :name => "cfop inválida"
    assert !cfop.valid?, "Número fora do intervalo"
  end
end
