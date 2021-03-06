USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_PARAMETROS_RENTABILIDAD]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_TRAE_PARAMETROS_RENTABILIDAD]
AS
BEGIN
 DECLARE @Fecha_Proceso_Hoy  DATETIME ,
  @Fecha_Proceso_Ayer  DATETIME ,
  @Fecha_Proceso_Prox  DATETIME ,
  @Dolar_Observado_Hoy  FLOAT  ,
  @Dolar_Observado_Ayer  FLOAT  ,
  @Dolar_Observado_Prox  FLOAT  ,
  @Tasa_USD_Hoy   FLOAT  ,
  @Tasa_USD_Ayer   FLOAT  ,
  @Tasa_USD_Prox   FLOAT  ,
  @Tasa_Inter_Prom_Hoy  FLOAT  ,
  @Tasa_Inter_Prom_Ayer  FLOAT  ,
  @Tasa_Inter_Prom_Prox  FLOAT
 SELECT  @Fecha_Proceso_Hoy  = ACFECPRO  ,
  @Fecha_Proceso_Ayer = ACFECANT  ,
  @Fecha_Proceso_Prox = ACFECPRX
  FROM meac
 SELECT  @Dolar_Observado_Hoy  = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 AND vmfecha = @Fecha_Proceso_Hoy
 SELECT  @Dolar_Observado_Ayer  = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 AND vmfecha = @Fecha_Proceso_Ayer
 SELECT  @Dolar_Observado_Prox  = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 AND vmfecha = @Fecha_Proceso_Prox
 SELECT  @Tasa_USD_Hoy   = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 1 AND vmfecha = @Fecha_Proceso_Hoy
 SELECT  @Tasa_USD_Ayer   = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 1 AND vmfecha = @Fecha_Proceso_Ayer
 SELECT  @Tasa_USD_Prox   = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 1 AND vmfecha = @Fecha_Proceso_Prox
 SELECT  @Tasa_Inter_Prom_Hoy  = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 3 AND vmfecha = @Fecha_Proceso_Hoy
 SELECT  @Tasa_Inter_Prom_Ayer  = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 3 AND vmfecha = @Fecha_Proceso_Ayer
 SELECT  @Tasa_Inter_Prom_Prox  = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 3 AND vmfecha = @Fecha_Proceso_Prox
 SELECT 'Fecha_Proceso_Hoy'  =CONVERT(CHAR(10),@Fecha_Proceso_Hoy,103) ,
  'Fecha_Proceso_Ayer'  =CONVERT(CHAR(10),@Fecha_Proceso_Ayer,103) ,
  'Fecha_Proceso_Prox'  =CONVERT(CHAR(10),@Fecha_Proceso_Prox,103) ,
  'Dolar_Observado_Hoy'  =ISNULL(@Dolar_Observado_Hoy,0)   ,
  'Dolar_Observado_Ayer'  =ISNULL(@Dolar_Observado_Ayer,0)  ,
  'Dolar_Observado_Prox'  =ISNULL(@Dolar_Observado_Prox,0)  ,
  'Tasa_USD_Hoy'   =ISNULL(@Tasa_USD_Hoy,0)   ,
  'Tasa_USD_Ayer'   =ISNULL(@Tasa_USD_Ayer,0)   ,
  'Tasa_USD_Prox'   =ISNULL(@Tasa_USD_Prox,0)   ,
  'Tasa_Inter_Prom_Hoy'  =ISNULL(@Tasa_Inter_Prom_Hoy,0)   ,
  'Tasa_Inter_Prom_Ayer'  =ISNULL(@Tasa_Inter_Prom_Ayer,0)  ,
  'Tasa_Inter_Prom_Prox'  =ISNULL(@Tasa_Inter_Prom_Prox,0)  
END



GO
