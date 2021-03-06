USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VERIFICA_LNKSERVER_OPC]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_VERIFICA_LNKSERVER_OPC]
                 (
                   @Retorno    CHAR(1) 
                  ,@SrvLink    NUMERIC(05) = 0  OUTPUT
                  )

AS
BEGIN
  SET NOCOUNT ON

  DECLARE @Mensaje          VARCHAR(256)
  
   CREATE TABLE #LnkServerOPC
	(	SRV_NAME              VARCHAR(256) 
	,	SRV_PROVIDERNAME      VARCHAR(256)         
	,	SRV_PRODUCT           VARCHAR(256)         
        ,       SRV_DATASOURCE        VARCHAR(256)         
	)

   INSERT INTO #LnkServerOPC
   SELECT  SRV_NAME = srvname
          ,SRV_PROVIDERNAME = providername
	  ,SRV_PRODUCT = srvproduct
	  ,SRV_DATASOURCE = datasource
   FROM master.dbo.sysservers

  IF EXISTS (SELECT  1  FROM #LnkServerOPC  WHERE SRV_NAME = 'LnkOpc')
  BEGIN
       SELECT @SrvLink = 0    
             ,@Mensaje = 'LnkServer OK.'  
  END
  ELSE
  BEGIN   
       SELECT @SrvLink = -1    
             ,@Mensaje = 'No Existe LnkServer para Opciones.' 
  END 

   IF @Retorno = 'S'
             SELECT  @SrvLink
                    ,@Mensaje 




  SET NOCOUNT OFF

END
GO
