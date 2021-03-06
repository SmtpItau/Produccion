USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOS_TABLA_CAENCCONTRATO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DATOS_TABLA_CAENCCONTRATO]
   		(  @CodLnkServer   NUMERIC(05)                   
                )
AS
BEGIN
  SET NOCOUNT ON

    TRUNCATE TABLE  InkCaEncContrato

    IF @CodLnkServer = 0
    BEGIN 

   
         INSERT INTO InkCaEncContrato
         SELECT   'CaNumFolio'          = ISNULL(CONVERT(NUMERIC(08),CaNumFolio),0)
                 ,'CaTipoTransaccion'   = ISNULL(CONVERT(CHAR(10),CaTipoTransaccion),'') 
                 ,'CaNumContrato'       = ISNULL(CONVERT(NUMERIC(08),CaNumContrato),0) 
                 ,'CaFechaContrato'     = ISNULL(CONVERT(DATETIME,CaFechaContrato),'')  
                 ,'CaEstado'            = ISNULL(CONVERT(CHAR(01),CaEstado),'') 
                 ,'CaCarteraFinanciera' = ISNULL(CONVERT(CHAR(06),CaCarteraFinanciera),'') 
                 ,'CaLibro'             = ISNULL(CONVERT(CHAR(06),CaLibro),'') 
                 ,'CaCarNormativa'      = ISNULL(CONVERT(CHAR(06),CaCarNormativa),'') 
                 ,'CaSubCarNormativa'   = ISNULL(CONVERT(CHAR(06),CaSubCarNormativa),'') 
                 ,'CaRutCliente'        = ISNULL(CONVERT(NUMERIC(09),CaRutCliente),0) 
                 ,'CaCodigo'            = ISNULL(CONVERT(NUMERIC(09),CaCodigo),0)

         FROM LnkOpc.CbMdbOpc.dbo.CaEncContrato

     END
     ELSE
     BEGIN 
          INSERT INTO InkCaEncContrato
          SELECT  'CaNumFolio'          = 0
                 ,'CaTipoTransaccion'   = ''
                 ,'CaNumContrato'       = 0
                 ,'CaFechaContrato'     = ''
                 ,'CaEstado'            = ''
                 ,'CaCarteraFinanciera' = ''
                 ,'CaLibro'             = ''
                 ,'CaCarNormativa'      = ''
                 ,'CaSubCarNormativa'   = ''
                 ,'CaRutCliente'        = 0
                 ,'CaCodigo'            = 0


     END

  SET NOCOUNT OFF
     
END


GO
