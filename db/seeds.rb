# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
if Estate.count == 0
  Estate.create([{:acronym => "AC", :name => "Acre"                },
                 {:acronym => "AL", :name => "Alagoas"             },
                 {:acronym => "AP", :name => "Amapá"               },
                 {:acronym => "AM", :name => "Amazonas"            },
                 {:acronym => "BA", :name => "Bahia"               },
                 {:acronym => "CE", :name => "Ceará"               },
                 {:acronym => "DF", :name => "Distrito Federal"    },
                 {:acronym => "ES", :name => "Espírito Santo"      },
                 {:acronym => "GO", :name => "Goiás"               },
                 {:acronym => "MA", :name => "Maranhão"            },
                 {:acronym => "MT", :name => "Mato Grosso"         },
                 {:acronym => "MS", :name => "Mato Grosso do Sul"  },
                 {:acronym => "MG", :name => "Minas Gerais"        },
                 {:acronym => "PA", :name => "Pará"                },
                 {:acronym => "PB", :name => "Paraíba"             },
                 {:acronym => "PR", :name => "Paraná"              },
                 {:acronym => "PE", :name => "Pernambuco"          },
                 {:acronym => "PI", :name => "Piauí"               },
                 {:acronym => "RJ", :name => "Rio de Janeiro"      },
                 {:acronym => "RN", :name => "Rio Grande do Norte" },
                 {:acronym => "RS", :name => "Rio Grande do Sul"   },
                 {:acronym => "RO", :name => "Rondônia"            },
                 {:acronym => "RR", :name => "Roraima"             },
                 {:acronym => "SC", :name => "Santa Catarina"      },
                 {:acronym => "SP", :name => "São Paulo"           },
                 {:acronym => "SE", :name => "Sergipe"             },
                 {:acronym => "TO", :name => "Tocantins"           }])

  puts "Tabela de estados semeada com " + Estate.count + " registros"
else
  puts "Tabela de estados não semeada, já contem registros"
end


if Client.count == 0
  @xml = Nokogiri::XML(File.open("xmls/clients.xml")) {|config| config.noblanks}

  fields = { :old_id           => 'codigocl',
             :name             => 'nomemp'  ,
             :ie               => 'inscest' ,
             :cnpj             => 'cgc'     ,
             :observations     => 'obs'     ,
             :active           => 'ativo'   ,
             :main_address     => { :street       => ['logradouro', 'endereco']  ,
                                    :number       => 'numero'                    ,
                                    :complement   => 'complemento'               ,
                                    :neighborhood => 'bairro'                    ,
                                    :city         => 'cidade'                    ,
                                    :estate_id    => 'estado'                    ,
                                    :country      => 'pais'                      ,
                                    :cep          => 'cep' }                     ,
             :billing_address  => { :street       => ['logradouroc', 'enderecoc'],
                                    :number       => 'numeroc'                   ,
                                    :complement   => 'complementoc'              ,
                                    :neighborhood => 'bairroc'                   ,
                                    :city         => 'cidadec'                   ,
                                    :estate_id    => 'estadoc'                   ,
                                    :country      => 'paisc'                     ,
                                    :cep          => 'cepc' }                    ,
             :delivery_address => { :street       => ['logradouroe', 'enderecoe'],
                                    :number       => 'numeroe'                   ,
                                    :complement   => 'complementoe'              ,
                                    :neighborhood => 'bairroe'                   ,
                                    :city         => 'cidadee'                   ,
                                    :estate_id    => 'estadoe'                   ,
                                    :country      => 'paise'                     ,
                                    :cep          => 'cepe' }}

  @xml.xpath("//cadclirs").each do |node|
    client  = {}
    address = {}
    fields.each do |k, v|
      if v.type == Hash
        address[k] = {}
        v.each do |k_, v_|
          if v_.type == Array
            v_.each do |a|
              address[k][k_] ||= ""
              address[k][k_] += node.xpath(a)[0].content + " "
            end
          else
            if ["estado", "estadoc", "estadoe"].include? v_
              id = Estate.find(:first, :select => "id", :conditions => ["acronym = ?", node.xpath(v_)[0].content])
              id.nil? ? address[k][k_] = nil : address[k][k_] = id.id
            else
              address[k][k_] = node.xpath(v_)[0].content
            end
          end
        end
      else
        if k == "active"
          node.xpath(v)[0].content == "true" ? client[k] = 1 : client[k] = 0
        else
          client[k] = node.xpath(v)[0].content
        end
      end
    end

    c                  = Client.new(client)
    c.main_address     = Address.new(address[:main_address])
    c.billing_address  = Address.new(address[:billing_address])
    c.delivery_address = Address.new(address[:delivery_address])
    c.save!
  end

  puts "Tabela de clientes semeada com " + Client.count.to_s + " registros"
else
  puts "Tabela de clientes não semeada, já contem registros"
end

