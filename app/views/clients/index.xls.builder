xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.Workbook({
  'xmlns'      => "urn:schemas-microsoft-com:office:spreadsheet",
  'xmlns:o'    => "urn:schemas-microsoft-com:office:office",
  'xmlns:x'    => "urn:schemas-microsoft-com:office:excel",
  'xmlns:html' => "http://www.w3.org/TR/REC-html40",
  'xmlns:ss'   => "urn:schemas-microsoft-com:office:spreadsheet"
  }) do

  xml.Worksheet 'ss:Name' => 'Clientes' do
    xml.Table do
      # Header
      xml.Row do
        xml.Cell { xml.Data 'ID'                 , 'ss:Type' => 'String' }
        xml.Cell { xml.Data 'Nome'               , 'ss:Type' => 'String' }
        xml.Cell { xml.Data 'CNPJ'               , 'ss:Type' => 'String' }
        xml.Cell { xml.Data 'Inscr. Estadual'    , 'ss:Type' => 'String' }
        xml.Cell { xml.Data 'Inscr. Municipal'   , 'ss:Type' => 'String' }
        xml.Cell { xml.Data 'SCI'                , 'ss:Type' => 'String' }
        #xml.Cell { xml.Data 'Ramo de Atividade'  , 'ss:Type' => 'String' }
        xml.Cell { xml.Data 'Indústria/Comércio' , 'ss:Type' => 'String' }
        xml.Cell { xml.Data 'Ativa'              , 'ss:Type' => 'String' }
        xml.Cell { xml.Data 'e-mail NF-e'        , 'ss:Type' => 'String' }
        xml.Cell { xml.Data 'Observações'        , 'ss:Type' => 'String' }
      end

      # Rows
      @all_clients.each do |client|
        xml.Row do
          xml.Cell { xml.Data client.id             ,'ss:Type' => 'Number' }
          xml.Cell { xml.Data client.name           ,'ss:Type' => 'String' }
          xml.Cell { xml.Data client.cnpj           ,'ss:Type' => 'String' }
          xml.Cell { xml.Data client.ie             ,'ss:Type' => 'String' }
          xml.Cell { xml.Data client.im             ,'ss:Type' => 'String' }
          xml.Cell { xml.Data client.sci            ,'ss:Type' => 'String' }
          #xml.Cell { xml.Data client.activity.name  ,'ss:Type' => 'String' }
          xml.Cell { xml.Data client.ind_com        ,'ss:Type' => 'String' }
          xml.Cell { xml.Data client.active         ,'ss:Type' => 'String' }
          xml.Cell { xml.Data client.email_nfe      ,'ss:Type' => 'String' }
          xml.Cell { xml.Data client.observations   ,'ss:Type' => 'String' }
        end
      end
    end
  end
end

