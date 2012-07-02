class Contract < ActiveRecord::Base
  validates_presence_of :text

  KEYWORDS = { :cliente_nome          => "@cli.name",
               :cliente_tel_1         => "@cli.phone(1)",
               :cliente_tel_2         => "@cli.phone(2)",
               :cliente_doc           => "@cli.doc",
               :cliente_endereco      => "@cli.main_address.to_s",
               :cliente_email         => "@cli.email",

               :locacao_inicio        => "date @loc.starts_at",
               :locacao_representante => "@loc.seller.name",

               :empresa_fantasia      => "@ent.nickname",
               :empresa_nome          => "@ent.name",
               :empresa_tel           => "@ent.phone",
               :empresa_doc           => "@ent.cnpj",
               :empresa_email         => "@ent.email",
               :empresa_endereco      => "@ent.address.to_s"}

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
