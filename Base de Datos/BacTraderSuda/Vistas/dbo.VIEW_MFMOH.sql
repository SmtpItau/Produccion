USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_MFMOH]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_mfmoh    fecha de la secuencia de comandos: 05/04/2001 9:20:54 ******/
CREATE VIEW [dbo].[VIEW_MFMOH]
AS
SELECT
            monumoper    
            ,mocodpos1
            ,mocodmon1 
            ,mocodsuc1
            ,mocodpos2 
            ,mocodmon2
            ,mocodcart 
            ,mocodigo  
            ,mocodcli  
            ,motipoper
            ,motipmoda 
            ,mofecha   
            ,motipcam  
            ,momdausd
            ,momtomon1
            ,moequusd1 
            ,moequmon1  
            ,momtomon2  
            ,moequusd2  
            ,moequmon2  
            ,moparmon1  
            ,mopremon1  
            ,moparmon2  
            ,mopremon2  
            ,moestado
            ,moretiro 
            ,mocontraparte 
            ,moobserv      
            ,mospread      
            ,motasadolar   
            ,motasaufclp   
            ,moprecal      
            ,moplazo 
            ,mofecvcto     
            ,molock     
            ,mooperador 
            ,motasfwdcmp  
            ,motasfwdvta  
            ,mocalcmpdol
            ,mocalcmpspr  
            ,mocalvtadol  
            ,mocalvtaspr  
            ,motasausd    
            ,motasacon    
            ,momtomon1ini 
            ,momtomon1fin 
            ,momtomon2ini  
            ,momtomon2fin   
            ,modiferen      
            ,mofpagomn 
            ,mofpagomx 
            ,mobroker
FROM BACFWDSUDA..MFMOH

GO
