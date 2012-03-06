class Enterprise < ActiveRecord::Base
	belongs_to :address
  accepts_nested_attributes_for :address

  validates_presence_of :name  , :cnpj
  validates_length_of :name    , :maximum => 70
  validates_length_of :cnpj    , :maximum => 18
  validates_length_of :ie      , :maximum => 15
  validates_length_of :nickname, :maximum => 50
  validates_length_of :phone   , :maximum => 30

  class DanfeOrientation <
    Struct.new(:id, :name)
    VALUES = [
      {:id => 1, :name => 'Retrato'},
      {:id => 2, :name => 'Paisagem'}
    ]
    def self.all
      VALUES.map { |v| self.new(v[:id], v[:name]) }
    end

    def self.to_select
      VALUES.map { |v| [v[:name], v[:id]] }
    end

    def self.find(id)
      h=VALUES.find { |v| v[:id] == id }
      return nil if h.nil?
      self.new(h[:id], h[:name])
    end
  end

  class NfeAmbient <
    Struct.new(:id, :name)
    VALUES = [
      {:id => 1, :name => 'Produção'},
      {:id => 2, :name => 'Homologação'}
    ]
    def self.all
      VALUES.map { |v| self.new(v[:id], v[:name]) }
    end

    def self.to_select
      VALUES.map { |v| [v[:name], v[:id]] }
    end

    def self.find(id)
      h=VALUES.find { |v| v[:id] == id }
      return nil if h.nil?
      self.new(h[:id], h[:name])
    end
  end
end
