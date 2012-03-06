select cli.cnpj         As Cnpj
     , cli.ie           As InscEst
     , cli.name         As Nome
     , pho.number       As Fone

     , adP.street       As Endereco
     , adP.number       As NumEnd
     , adP.complement   As ComplEnd
     , adP.neighborhood As Bairro
     , adP.city         As Cidade
     , adP.cep          As Cep
     , ciP.ibge_cod     As CodMuni
     , ufP.acronym      As Uf
     , ufP.ibge_cod     As CodUf
     , adP.country      As Pais
     , '1058'           As CodPais

     , adE.street       As EnderecoE
     , adE.number       As NumEndE
     , adE.complement   As ComplEndE
     , adE.neighborhood As BairroE
     , adE.city         As CidadeE
     , adE.cep          As CepE
     , ciE.ibge_cod     As CodMuniE
     , ufE.acronym      As UfE
     , ufE.ibge_cod     As CodUfE
     , adE.country      As PaisE
     , '1058'           As CodPaisE
From clients   cli Left join
     people    peo On peo.external_id = cli.id And type = 'Contact' Left Join
     phones    pho On pho.person_id   = peo.id And pho.main = 1 Left Join

     addresses adP On adP.id = cli.main_address_id Left Join
     estates   ufP On ufP.id = adP.estate_id Left Join
     cities    ciP On ciP.id = adP.city_id Left Join

     addresses adE On adE.id = cli.delivery_address_id Left Join
     estates   ufE On ufE.id = adE.estate_id Left Join
     cities    ciE On ciE.id = adE.city_id 
Where cli.id = 23