Select 0                                        As Item
     , 'OMG!!'                                  As I02_cProd
     , ''                                       As I03_cEAN
     , ii.product_name                          As I04_xProd
     , pr.ncm                                   As I05_NCM
     , Left(pr.ncm, 2)                          As Genero
     , ''                                       As I06_EXTIPI
     , cf.number                                As I08_CFOP
     , mu.measure_unit                          As I09_uCom
     , ii.quantity                              As I10_qCom
     , ii.unit_value                            As I10a_vUnCom
     , ii.total_value                           As I11_vProd
     , ''                                       As I12_cEANTrib
     , mu.measure_unit                          As I13_uTrib
     , ii.quantity                              As I14_qTrib
     , ii.unit_value                            As I14a_vUnTrib
     , 0000000.00                               As I15_vFrete
     , 0000000.00                               As I16_vSeg
     , 0000000.00                               As I17_vDesc
     , 0                                        As I17a_vOutro
     , '1'                                      As I17b_indTot
     , '0'                                      As N11_Orig
     , cc.value                                 As N12_CST
     , '3'                                      As N13_modBC
     , 0                                        As N14_pRedBC
     , ii.icm_base                              As N15_vBC
     , ii.aliq_icm                              As N16_pICMS
     , ii.icm                                   As N17_vICMS
     , '4'                                      As N18_modBCST
     , 0                                        As N19_pMVAST
     , 0                                        As N20_pRedBCST
     , 0                                        As N21_vBCST
     , 0                                        As N22_pICMSST
     , 0                                        As N23_vICMSST
     , 0                                        As N29_pCredSN
     , 0                                        As N30_vCredICMSSN
     , If(ii.ipi > 0, '1', '0')                 As FlagIpi
     , ''                                       As O04_cSelo_IPI
     , 0                                        As O05_qSelo_IPI
     , '999'                                    As O09_CSTIPI
     , ii.total_value                           As O10_vBCIPI
     , ii.aliq_ipi                              As O13_pIPI
     , ii.ipi                                   As O14_vIPI
     , '0'                                      As FlagII
     , 0                                        As P02_vBC
     , 0                                        As P03_vDespAdu
     , 0                                        As P04_vII
     , 0                                        As P05_vIOF
     , cp.value                                 As Q06_CST_PIS
     , ii.pis_base                              As Q07_vBC_PIS
     , ii.aliq_pis                              As Q08_pPIS
     , ii.pis                                   As Q09_vPIS
     , '0'                                      As Flag_PIS_ST
     , 0                                        As R02_vBC_PIS_ST
     , 0                                        As R03_pPIS_ST
     , 0                                        As R06_vPIS_ST
     , co.value                                 As S06_CST_COFINS
     , ii.cofins_base                           As S07_vBC_COFINS
     , ii.aliq_cofins                           As S08_pCOFINS
     , ii.cofins                                As S11_vCOFINS
     , '0'                                      As Flag_COFINS_ST
     , 0                                        As T02_vBC_COFINS_ST
     , 0                                        As T03_pCOFINS_ST
     , 0                                        As T06_vCOFINS_ST
From invoice_items ii                                    Join
     products      pr On pr.id = ii.product_id           Join
     invoices      iv On iv.id = ii.invoice_id           Join
     cfops         cf On cf.id = iv.natop_id        Left Join
     measure_units mu On mu.id = ii.measure_unit_id Left Join
     csts          cc On cc.id = pr.cst_icm_id      Left Join
     csts          ci On ci.id = pr.cst_ipi_id      Left Join
     csts          cp On cp.id = pr.cst_pis_id      Left Join
     csts          co On co.id = pr.cst_cofins_id
Where ii.invoice_id = 734