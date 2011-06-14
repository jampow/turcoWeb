# ESTADOS

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

  puts "Tabela de estados semeada com " + Estate.count.to_s  + " registros"
else
  puts "Tabela de estados não semeada, já contem registros"
end


# RAMO DE ATIVIDADE

if Activity.count == 0
  Activity.create([{:name => "Comércio" },
                   {:name => "Indústria"}])

  puts "Tabela de ramos de atividade semeada com " + Activity.count.to_s  + " registros"
else
  puts "Tabela de ramos de atividade não semeada, já contem registros"
end


# CLIENTES

if Client.count == 0
  @xml = Nokogiri::XML(File.open("xmls/clients.xml")) {|config| config.noblanks}

  fields = { :old_id           => 'codigocl',
             :name             => 'nomemp'  ,
             :ie               => 'inscest' ,
             :cnpj             => 'cgc'     ,
             :observations     => 'obs'     ,
             :active           => 'ativo'   ,
             :activity_id      => 'indcon'  ,
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
                                    :cep          => 'cepe'                     }}

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
        case k
        when :active
          node.xpath(v)[0].content == "true" ? client[k] = 1 : client[k] = 0
        when :activity_id
          node.xpath(v)[0].content == "C" ? client[k] = 1 : client[k] = 2
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


# NOTAS FISCAIS

if Invoice.count == 0
  @xml = Nokogiri::XML(File.open("xmls/nf.xml")) {|config| config.noblanks}

  fields = {:operation        => "dataop",
            :invoice_number   => "notafis",
            :client_id        => "codigocl",
            :seller_id        => "codigorp",
            :term_id          => "cod_termo",
            :ipi              => "totalipi",
            :icms_base        => "baseicm",
            :icms             => "totalicm",
            :pis              => "totpis",
            :cofins           => "totcofins",
            :products_value   => "totalpro",
            :invoice_value    => "totalnot",
            :commission_rate  => "txcomis",
            :activity_id      => "indcon",
            :observations     => "obsven",
            :sell_id          => "tipoven",
            :parcels          => "parcelas",
            #:natop_id         => "",
            #:delivery         => "",
            :freight          => "frete",
            :insurance        => "seguro",
            #:carrier_id       => "",
            :freight_type     => "modfrete",
            :nfe              => "nfe",
            :nfe_received_key => "recibonfe",
            :nfe_key          => "chavenfe",
            :nfe_protocol     => "protnfe",
            :nfe_env          => "tpamb",
            :manaus_discount  => "descmanaus",
            :canceled         => "cancelada"}

  @xml.xpath("//cadvenda").each do |node|
    nf  = {}
    fields.each do |k, v|
      if %w[canceled nfe].include? k
        nf[k] = eval(node.xpath(v)[0].content)
      else
        nf[k] = node.xpath(v)[0].content
      end
    end

    invoice = Invoice.new(nf)
    invoice.save!
  end

  puts "Tabela de notas fiscais semeada com " + Invoice.count.to_s + " registros"
else
  puts "Tabela de notas fiscais não semeada, já contem registros"
end


# TÍTULOS A RECEBER

if Receivable.count == 0
  @xml = Nokogiri::XML(File.open("xmls/tr.xml")) {|config| config.noblanks}

  fields = {:invoice_number    => "notafis",
            :parcel            => "parcela",
            :due_date          => "datavenc",
            :value             => "valorfat",
            #:bank_id           => "banco",
            :email             => "email",
            #:deposit_id        => "tipodep",
            :payment_date      => "datapag",
            :collection_number => "nbanco",
            :daily_penalty     => "morad",
            :observations      => "obsfre"}

  @xml.xpath("//cadfatre").each do |node|
    tr  = {}
    fields.each do |k, v|
      tr[k] = node.xpath(v)[0].content
    end

    receivable = Receivable.new(tr)
    receivable.save!
  end

  puts "Tabela de titulos a receber semeada com " + Receivable.count.to_s + " registros"
else
  puts "Tabela de titulos a receber não semeada, já contem registros"
end

