Select uf.ibge_cod                             As B02_cUF
   , 'WTF'                                   As B03_cNF
   , 'OMG!!'                                 As B04_natOp
   , 'criar scaffold'                        As B05_indPag
     , '55'                                    As B06_mod
     , '1'                                     As B07_Serie
     , nf.invoice_number                       As B08_nNf
     , nf.operation                            As B09_dEmi
     , nf.operation                            As B10_dSaiEnt
     , '1'                                     As B11_tpNF
     , uf.ibge_cod                             As B12_cMunFG
     , en.danfe_orientation                    As B21_tpImp
     , en.nfe_ambient                          As B24_tpAmb
     , '1'                                     As B25_finNFFe
     , '0'                                     As B26_procEmi
     , '2.0'                                   As B27_verProc
     , 'CNPJ'                                  As TipoEmitente
     , en.cnpj                                 As C02_a_CNPJ
     , en.name                                 As C03_xNome
     , en.nickname                             As C04_xFant
     , ea.street                               As C06_xLgr
     , ea.number                               As C07_nro
     , ea.complement                           As C08_xCpl
     , ea.neighborhood                         As C09_xBairro
     , ec.ibge_cod                             As C10_cMun
     , ec.name                                 As C11_xMun
     , ec.estate_acronym                       As C12_UF
     , ea.cep                                  As C13_CEP
     , '1058'                                  As C14_cPais
     , 'BRASIL'                                As C15_xPais
     , en.phone                                As C16_fone
     , en.ie                                   As C17_IE
     , ''                                      As C18_IEST
     , ''                                      As C19_IM
     , ''                                      As C20_CNAE
     , '3'                                     As C21_CRT
     , 'CNPJ'                                  As TipoDestin
     , If(en.nfe_ambient=2, '99999999000191',
          cl.cnpj)                             As E02_03_CnpjCpf
     , If(en.nfe_ambient=2, 'NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL',
          cl.name)                             As E04_xNome
     , ca.street                               As E06_xLgr
     , ca.number                               As E07_nro
     , ca.complement                           As E08_xCpl
     , ca.neighborhood                         As E09_xBairro
     , cc.ibge_cod                             As E10_cMun
     , cc.name                                 As E11_xMun
     , cc.estate_acronym                       As E12_UF
     , ca.cep                                  As E13_CEP
     , '1058'                                  As E14_cPais
     , 'BRASIL'                                As E15_xPais
     , ph.number                               As E16_Fone
     , If(en.nfe_ambient=2, space(17), cl.ie)  As E17_IE
     , ''                                      As E18_ISUF
     , pe.email                                As E19_email
     , nf.icms_base                            As W03_vBC_ICMS
     , nf.icms                                 As W04_vICMS
     , 0                                       As W05_vBCST_ICMS
     , 0                                       As W06_vST_ICMS
     , nf.products_value                       As W07_vProd
     , nf.freight                              As W08_vFrete
     , nf.insurance                            As W09_vSeg
     , nf.manaus_discount                      As W10_vDesc
     , 0                                       As W11_vII
     , nf.ipi                                  As W12_vIPI
     , nf.pis                                  As W13_vPIS
     , nf.cofins                               As W14_vCOFINS
     , 0                                       As W15_vOutro
     , nf.invoice_value                        As W16_vNF
   , 'tipo de frete'                         As X02_modFrete
     , 'CNPJ'                                  As TpDocTrans
   , 'cadastro de transportadora'            As X04_CNPJ_CPF_Trans
   , 'cadastro de transportadora'            As X06_xNome_Trans
   , 'cadastro de transportadora'            As X07_IE_Trans
   , 'cadastro de transportadora'            As X08_xEnder_Trans
   , 'cadastro de transportadora'            As X09_xMun_Trans
   , 'cadastro de transportadora'            As X10_UF_Trans
   , 'cadastro de transportadora'            As X19_placa_Veic
   , 'cadastro de transportadora'            As X20_UF_Veic
   , 'cadastro de transportadora'            As X27_qVol
     , 'NE'                                  As X28_esp
   , 'cadastro de transportadora'            As X29_marca
     , '999999'                              As X30_nVol
   , 'cadastro de transportadora'            As X31_pesoL
   , 'cadastro de transportadora'            As X32_pesoB
   , ''                                      As Z03_infCpl
   , te.term                                 As Termos
   , nf.observations                         As ObsNota
From orders      so                                            Left Join
     invoices    nf On nf.order_id    = so.id                  Left Join
     estates     uf On uf.acronym     = 'SP'                   Left Join
     clients     cl On cl.id          = nf.client_id           Left Join
     addresses   ca On ca.id          = cl.delivery_address_id Left Join
     cities      cc On cc.id          = ca.city_id             Left join
     people      pe On pe.external_id = cl.id 
                   And pe.type        = 'Contact'              Left Join
     phones      ph On ph.person_id   = pe.id 
                   And ph.main        = 1                      Left Join
     terms       te On te.id          = nf.term_id             Left Join
     enterprises en On en.id          = 1                      Left Join
     addresses   ea On ea.id          = en.address_id          Left Join
     cities      ec On ec.id          = ea.city_id
where so.id = 3