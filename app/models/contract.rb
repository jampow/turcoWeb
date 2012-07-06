class Contract < ActiveRecord::Base
  validates_presence_of :text
  has_one :father, :class_name => "Contract", :primary_key => "father_id", :foreign_key => 'id'

  KEYWORDS = { :cliente_nome          => {:command => "@cli.name"                 , :description => "Razão Social do Locatário"},
               :cliente_tel_1         => {:command => "@cli.phone(1)"             , :description => "Telefone principal do contato principal"},
               :cliente_tel_2         => {:command => "@cli.phone(2)"             , :description => "Telefone secundário do contato principal"},
               :cliente_doc           => {:command => "@cli.doc"                  , :description => "CNPJ ou CPF do Locatário"},
               :cliente_endereco      => {:command => "@cli.main_address.to_s"    , :description => "Endereço principal do Locatário"},
               :cliente_email         => {:command => "@cli.email"                , :description => "E-mail do contato principal"},

               :locacao_inicio        => {:command => "date @loc.starts_at"       , :description => "Data de início da locação"},
               :locacao_representante => {:command => "@loc.seller.name"          , :description => "Representante da locação"},
               :locacao_m2_total      => {:command => "@loc.m2_total"             , :description => "Somatória em m<sup>2</sup> de todos os boxes da locação"},
               :locacao_boxes         => {:command => "@loc.items_to_s"           , :description => "Código dos itens da locação separados por vírgulas"},
               :locacao_total         => {:command => "@loc.total.real.to_s"      , :description => "Código dos itens da locação separados por vírgulas"},
               :locacao_total_extenso => {:command => "@loc.total.real.to_extenso", :description => "Código dos itens da locação separados por vírgulas"},

               :empresa_fantasia      => {:command => "@ent.nickname"             , :description => "Fantasia da locadora"},
               :empresa_nome          => {:command => "@ent.name"                 , :description => "Razão Social da locadora"},
               :empresa_tel           => {:command => "@ent.phone"                , :description => "Telefone da locadora"},
               :empresa_doc           => {:command => "@ent.cnpj"                 , :description => "CNPJ da locadora"},
               :empresa_email         => {:command => "@ent.email"                , :description => "E-mail da locadora"},
               :empresa_endereco      => {:command => "@ent.address.to_s"         , :description => "Endereço da locadora"}}

# Select c1.id
#      , RPad(
#        Concat(IfNull(Concat(LPad(c4.`order`, 3, '0'),'.'),'')
#              ,IfNull(Concat(LPad(c3.`order`, 3, '0'),'.'),'')
#              ,IfNull(Concat(LPad(c2.`order`, 3, '0'),'.'),'')
#              ,IfNull(LPad(c1.`order`, 3, '0'),'')), 15, '.000') As ordenator
#      , SubString(c1.text, 1, 200) as text
# From contracts c1
# Left Join contracts c2 On c2.id = c1.father_id
# Left Join contracts c3 On c3.id = c2.father_id
# Left Join contracts c4 On c4.id = c3.father_id
# Order by ordenator;

  named_scope :grid, :select => "c1.id, RPad(Concat(IfNull(Concat(LPad(c4.`order`, 3, '0'),'.'),''), IfNull(Concat(LPad(c3.`order`, 3, '0'),'.'),''), IfNull(Concat(LPad(c2.`order`, 3, '0'),'.'),''), IfNull(LPad(c1.`order`, 3, '0'),'')), 15, '.000') As ordenator, SubString(c1.text, 1, 200) as text",
                     :joins  => "c1 Left Join contracts c2 On c2.id = c1.father_id Left Join contracts c3 On c3.id = c2.father_id Left Join contracts c4 On c4.id = c3.father_id",
                     :order  => "ordenator"

  named_scope :tops, :conditions => "father_id Is Null",
                     :order      => "`order`"

  named_scope :childs, lambda { |father_id| {
                      :conditions => "father_id = #{father_id}",
                      :order      => "`order`" } }

  def childs
    Contract.childs self.id
  end

  def classification
    klass = "%03d" % order
    this = self
    while !this.father.nil? do
      this = this.father
      klass = ("%03d" % this.order) + "." + klass
    end
    klass += ".000.000.000.000"
    klass[0..14]
  end

  class ListTypes <
    Struct.new(:id, :name, :human)
    VALUES = [
      {:id => 1, :name => 'number', :human => "Números"},
      {:id => 2, :name => 'roman' , :human => "Números Romanos"},
      {:id => 3, :name => 'alpha' , :human => "Letras"}
    ]
    def self.all
      VALUES.map { |v| self.new(v[:id], v[:name], h[:human]) }
    end

    def self.to_select
      VALUES.map { |v| [v[:human], v[:id]] }
    end

    def self.find(id)
      h=VALUES.find { |v| v[:id] == id }
      return nil if h.nil?
      self.new(h[:id], h[:name], h[:human])
    end
  end

end
