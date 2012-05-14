class Role < ActiveRecord::Base
  acts_as_authorization_role

  has_and_belongs_to_many :users

  ROLES = {
          :account_plans             => 'Plano de contas'                ,
          :activities                => 'Atividades'                     ,
          :bank_account_transactions => 'Contas bancárias'               ,
          :bank_accounts             => 'Contas bancárias'               ,
          :carriers                  => 'Transportadoras'                ,
          :cfops                     => 'CFOP\'s'                        ,
          :clients                   => 'Clientes'                       ,
          :cost_centers              => 'Centros de custo'               ,
          :cst_cofins                => 'CST Cfins'                      ,
          :cst_icms                  => 'CST ICMS'                       ,
          :cst_ipis                  => 'CST IPIS'                       ,
          :cst_pis                   => 'CST PIS'                        ,
          :departments               => 'Departamentos'                  ,
          :dept_contacts             => 'Departamentos dos contatos'     ,
          :enterprises               => 'Cadastro da empresa'            ,
          :func_contacts             => 'Funções dos contatos'           ,
          :hollydays                 => 'Feriados'                       ,
          :invoices                  => 'Notas Fiscais'                  ,
          :locations                 => 'Locações'                       ,
          :measure_units             => 'Unidades de medida'             ,
          :messages                  => 'Mensagens'                      ,
          :ncms                      => 'NCM\'s'                         ,
          :payment_forms             => 'Formas de pagamento'            ,
          :permissions               => 'Permissões'                     ,
          :product_families          => 'Família de produtos'            ,
          :product_kinds             => 'Tipos de propdutos'             ,
          :products                  => 'Produtos'                       ,
          :providers                 => 'Fornecedores'                   ,
          :purchase_orders           => 'Pedidos de compra'              ,
          :receivable_billings       => 'Recebimentos'                   ,
          :receivables               => 'Contas a receber'               ,
          :sales_orders              => 'Pedidos de venda'               ,
          :seller_credit_accounts    => 'Conta-corrente do representante',
          :sellers                   => 'Representantes'                 ,
          :sells_types               => 'Tipos de NF\'s'                 ,
          :st_cofins                 => 'ST Cofins'                      ,
          :st_icms                   => 'ST ICMS'                        ,
          :st_ipis                   => 'ST IPI\'s'                      ,
          :st_pis                    => 'ST PIS'                         ,
          :stocks                    => 'Almoxarifado'                   ,
          :terms                     => 'Termos'                         ,
          :users                     => 'Usuários'
          }

  def self.roles
    ROLES
  end

  def self.to_array
    x = []
    ROLES.each { |k,v| x << {k => v} }
    x
  end

  def self.order_by_keys
    Role.to_array.sort { |g, h| g.keys[0].to_s <=> h.keys[0].to_s }
  end

  def self.order_by_values
    Role.to_array.sort { |g, h| g.values[0] <=> h.values[0] }
  end

end

