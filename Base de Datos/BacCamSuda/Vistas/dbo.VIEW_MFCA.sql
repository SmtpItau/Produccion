USE [BacCamSuda]
GO
/****** Object:  View [dbo].[VIEW_MFCA]    Script Date: 11-05-2022 16:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[VIEW_MFCA]
AS
SELECT canumoper    
, cacodpos1 
, cacodmon1 
, cacodsuc1 
, cacodpos2 
, cacodmon2 
, cacodcart   
, cacodigo    
, cacodcli    
, catipoper 
, catipmoda 
, cafecha                     
, catipcam                                              
, camdausd 
, camtomon1               
, caequusd1               
, caequmon1               
, camtomon2               
, caequusd2               
, caequmon2               
, caparmon1                                             
, capremon1                                             
, caparmon2                                             
, capremon2                                             
, caestado 
, caretiro 
, cacontraparte 
, caobserv                                                                                                                                                                                                                                                     
, captacom                                              
, captavta                                              
, caspread                                              
, cacolmon1                                             
, cacapmon1                                             
, catasadolar                                           
, catasaufclp                                           
, caprecal                                              
, caplazo  
, cafecvcto                   
, capreant                                              
, cavalpre                                              
, caoperador 
, catasfwdcmp                                           
, catasfwdvta                                           
, cacalcmpdol                                           
, cacalcmpspr                                           
, cacalvtadol                                           
, cacalvtaspr                                           
, catasausd                                             
, catasacon                                             
, cadiferen                                             
, cafpagomn 
, cafpagomx 
, cadiftipcam             
, cadifuf                 
, caclpinicial            
, caclpfinal              
, camtodiferir            
, camtodevengar           
, cadevacum               
, catipcamval             
, camtoliq                
, camtocalzado          
, calock     
, camarktomarket          
, capreciomtm             
, capreciofwd             
, camtomon1ini            
, camtomon1fin            
, camtomon2ini            
, camtomon2fin            
, caplazoope 
, caplazovto 
, caplazocal 
, cadiasdev 
, cadelusd       
, cadeluf        
, carevusd                
, carevuf                 
, carevtot                
, cavalordia              
, cactacambio_a           
, cactacambio_c           
, cautildiferir           
, caperddiferir           
, cautildevenga           
, caperddevenga           
, cautilacum              
, caperdacum              
, cautilsaldo             
, caperdsaldo             
, caclpmoneda1            
, caclpmoneda2            
, camtocomp               
, caantici 
, cafecvenor                  
, cabroker    
, cavalorayer             
, camontopfe                 
, camontocce                 
, id_sistema 
, precio_transferencia    
, tipo_sintetico 
, precio_spot  
, pais_origen 
, moneda_compensacion 
, riesgo_sintetico 
, precio_reversa_sintetico 
, calzada 
, marca                          
, numerointerfaz 
, contrato_entrega_via 
, contrato_emitido_por 
, contrato_ubicado_en 
, fechaemision                
, fecharecepcion              
, fechaingresocustodia        
, fechafirmacontrato          
, fecharetirocustodia         
, numerocontratocliente
FROM bacfwdsuda..MFCA


GO
