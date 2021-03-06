USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_Datos_Tabla_CaEncContrato]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_Datos_Tabla_CaEncContrato]
   		(  @CodLnkServer   NUMERIC(05)                   
                )
AS
BEGIN
  SET NOCOUNT ON

     CREATE TABLE #TEMP
         (      CaNumFolio              NUMERIC (08) 
         ,      CaTipoTransaccion       CHAR (10)
         ,      CaNumContrato           NUMERIC (08) 
         ,      CaFechaContrato         DATETIME     
         ,      CaEstado                CHAR (01) 
         ,      CaCarteraFinanciera     CHAR (06) 
         ,      CaLibro                 CHAR (06)
         ,      CaCarNormativa          CHAR (06) 
         ,      CaSubCarNormativa       CHAR (06)
         ,      CaRutCliente            NUMERIC (09)
         ,      CaCodigo                NUMERIC (09)
         )

    IF @CodLnkServer = 0
    BEGIN 

   
         INSERT INTO #TEMP       
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

         FROM CaEncContrato



     END
     ELSE
     BEGIN 

          SELECT   0
                  ,''
                  ,0 
                  ,''
                  ,''
                  ,''
                  ,''
                  ,''
                  ,''
                  ,0
                  ,0
     END

         SELECT   CaNumFolio
                 ,CaTipoTransaccion
                 ,CaNumContrato
                 ,CaFechaContrato
                 ,CaEstado
                 ,CaCarteraFinanciera
                 ,CaLibro
                 ,CaCarNormativa
                 ,CaSubCarNormativa
                 ,CaRutCliente
                 ,CaCodigo
        FROM #TEMP


  SET NOCOUNT OFF
     
END



-- SP_Datos_Tabla_CaEncContrato 0
--SP_HELPTEXT SP_Datos_Tabla_CaEncContrato

GO
