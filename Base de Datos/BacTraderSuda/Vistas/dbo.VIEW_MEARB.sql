USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_MEARB]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_mearb    fecha de la secuencia de comandos: 05/04/2001 9:20:54 ******/
CREATE VIEW [dbo].[VIEW_MEARB]
AS
SELECT
arbnumope ,
arbtipope ,
arbcodmon ,
arbcodcnv ,
arbmtomex  ,           
arbmtomus   ,          
arbmtomch    ,         
arbparida     ,        
arbobserv      ,       
arbticamx       ,      
arbnomcli        ,                   
arbrutcli   ,
arbcodcli   ,
arbrecibi ,
arbentreg ,
arbvalrec  ,                 
arbvalent   ,                
arbparref    ,         
arbmtoref     ,        
arbdifref      ,       
arbprcref       ,      
arbfecha         ,           
arbhora  ,
arbuser   , 
arbstatus ,
arbproduc 
arbcoda ,
arbcode ,
arbcodd ,
arbterm  ,       
arbfecini ,                  
arbnumfut  ,
arbmtusbh   ,          
arbcodoma ,
arbtipcar ,
arbseek ,
arbcodswc,   
arbcodswr,   
arbcuenta ,                     
arbcodswe  , 
arbentidad  
FROM BACCAMSUDA..MEARB

GO
