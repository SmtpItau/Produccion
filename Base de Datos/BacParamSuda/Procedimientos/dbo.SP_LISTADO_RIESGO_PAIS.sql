USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADO_RIESGO_PAIS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTADO_RIESGO_PAIS]
AS
BEGIN
   DECLARE @ACFECPRO    CHAR(10)
   DECLARE @ACFECPRX    CHAR(10)
   DECLARE @UF_HOY      FLOAT   
   DECLARE @UF_MAN      FLOAT   
   DECLARE @IVP_HOY     FLOAT   
   DECLARE @IVP_MAN     FLOAT   
   DECLARE @DO_HOY      FLOAT   
   DECLARE @DO_MAN      FLOAT   
   DECLARE @DA_HOY      FLOAT   
   DECLARE @DA_MAN      FLOAT   
   DECLARE @ACNOMBRE    CHAR(40)
   DECLARE @RUT_EMPRESA CHAR(12)
   DECLARE @HORA        CHAR(8) 
   EXECUTE SP_BASE_DEL_INFORME
          @ACFECPRO    OUTPUT
      ,   @ACFECPRX    OUTPUT
      ,   @UF_HOY      OUTPUT
      ,   @UF_MAN      OUTPUT
      ,   @IVP_HOY     OUTPUT
      ,   @IVP_MAN     OUTPUT
      ,   @DO_HOY      OUTPUT
      ,   @DO_MAN      OUTPUT
      ,   @DA_HOY      OUTPUT
      ,   @DA_MAN      OUTPUT
      ,   @ACNOMBRE    OUTPUT
      ,   @RUT_EMPRESA OUTPUT
      ,   @HORA        OUTPUT
IF EXISTS (SELECT * FROM   RIESGO_PAIS
        
     )
BEGIN
    SELECT 
   'CODIGOPAIS'    = CODIGO_PAIS
         ,'PAIS'             = NOMBRE
  ,'PORCASIGNADO'  = PORCENTAJE
        ,'TOTALLINEA'  = TOTALASIGNADO
  ,'TOTALOCUPADO'  = TOTALOCUPADO
  ,'TOTALDISPONIBLE'   = TOTALDISPONIBLE
  ,'TOTALEXCESO'  = TOTALEXCESO
  
  /*RESCATA INFORMACION DE VALORES MONEDAS EXTERNA*/
      ,'FECHA PROC'       = @ACFECPRO
  ,'FECHA PROX'       = @ACFECPRX
        ,'UF HOY'           = @UF_HOY
  ,'UF MAñANA'        = @UF_MAN
        ,'IVP HOY'          = @IVP_HOY
        ,'IVP MAñANA'       = @IVP_MAN
        ,'DOLOBS HOY'       = @DO_HOY
       ,'DOLOBS MAñANA'    = @DO_MAN
        ,'DOLCIE HOY'       = @DA_HOY
        ,'DOLCIE MAñANA'    = @DA_MAN
        ,'NOMBRE EMPRESA'   = @ACNOMBRE
        ,'RUT EMPRESA'      = @RUT_EMPRESA
        ,'HORA'             = @HORA
 FROM 
  RIESGO_PAIS
ORDER BY PAIS ASC
END
ELSE
BEGIN
 SELECT 
    'CODIGOPAIS'    = ''
         ,'PAIS'             = ''
  ,'PORCASIGNADO'  = 0  
  ,'TOTALLINEA'  = 0
  ,'TOTALOCUPADO'  = 0
  ,'TOTALDISPONIBLE'   = 0
  ,'TOTALEXCESO'  = 0
  
  /*RESCATA INFORMACION DE VALORES MONEDAS EXTERNA*/
      ,'FECHA PROC'       = @ACFECPRO
  ,'FECHA PROX'       = @ACFECPRX
        ,'UF HOY'           = @UF_HOY
  ,'UF MAñANA'        = @UF_MAN
        ,'IVP HOY'          = @IVP_HOY
        ,'IVP MAñANA'       = @IVP_MAN
        ,'DOLOBS HOY'       = @DO_HOY
       ,'DOLOBS MAñANA'    = @DO_MAN
        ,'DOLCIE HOY'       = @DA_HOY
        ,'DOLCIE MAñANA'    = @DA_MAN
        ,'NOMBRE EMPRESA'   = @ACNOMBRE
        ,'RUT EMPRESA'      = @RUT_EMPRESA
        ,'HORA'             = @HORA
 
END
END

GO
