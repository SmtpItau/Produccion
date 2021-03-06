USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_CargaParametros_ControlFinanciero]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_CargaParametros_ControlFinanciero]
         (
               @entidad CHAR(2)
         ) 
AS
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
	SET DATEFORMAT dmy

   DECLARE @fecha_hoy  DATETIME,
           @valor_uf   FLOAT   ,
           @valor_do   FLOAT   ,
           @valor_ac   FLOAT   ,
           @posiniusd  FLOAT   ,
           @banco      CHAR(40)

    SELECT @fecha_hoy = Fecha_proceso             FROM DATOS_GENERALES WITH (NOLOCK)
    SELECT @valor_uf  = 0.0
    SELECT @valor_do  = 0.0
    SELECT @valor_ac  = 0.0
    SELECT @banco     = ' '
    SELECT @posiniusd = 0.0

    SELECT @valor_uf  = ISNULL(vmvalor ,0.0) FROM LNKMDPASIVO.BACPARAMSUDA.DBO.VALOR_MONEDA WITH (NOLOCK) WHERE vmcodigo = 998   AND vmfecha = @fecha_hoy
    SELECT @valor_do  = ISNULL(vmvalor ,0.0) FROM LNKMDPASIVO.BACPARAMSUDA.DBO.VALOR_MONEDA WITH (NOLOCK) WHERE vmcodigo = 994   AND vmfecha = @fecha_hoy
    SELECT @valor_ac  = ISNULL(vmvalor ,0.0) FROM LNKMDPASIVO.BACPARAMSUDA.DBO.VALOR_MONEDA WITH (NOLOCK) WHERE vmcodigo = 995   AND vmfecha = @fecha_hoy
    SELECT @banco     = ISNULL(Nombre_entidad,'') FROM DATOS_GENERALES WITH (NOLOCK)
--    SELECT @posiniusd = ISNULL(vmposini,0.0) FROM VIEW_POSICION WHERE vmcodigo = "USD" AND vmfecha = @fecha_hoy


    SELECT 'acfecpro'  = CONVERT(CHAR(10),Fecha_proceso,103)
    ,       'observado' = @valor_do
    ,       'valor_uf'  = @valor_uf
    ,       'acfecprx'  = CONVERT(CHAR(10),Fecha_proxima,103)
    ,       'acnombre'  = @banco
    ,       'acuerdo'   = @valor_ac
    ,       'RUTENTID'  = ( SELECT  rcrut    FROM ENTIDAD WITH (NOLOCK) )
    ,       'DVENTID'   = ( SELECT  rcdv     FROM ENTIDAD WITH (NOLOCK) )
    ,       'CODCART'   = ( SELECT  rccodcar FROM ENTIDAD WITH (NOLOCK) )  
     FROM DATOS_GENERALES WITH (NOLOCK)

END

GO
