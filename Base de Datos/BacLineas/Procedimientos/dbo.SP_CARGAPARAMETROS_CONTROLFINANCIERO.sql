USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGAPARAMETROS_CONTROLFINANCIERO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CARGAPARAMETROS_CONTROLFINANCIERO]
   (   @entidad   CHAR(2)   )
AS
BEGIN

  SET NOCOUNT ON

	DECLARE @fecha_hoy  DATETIME
   ,       @Fecha_Anterior       DATETIME
	,       @valor_uf   FLOAT
	,       @valor_do   FLOAT
	,       @valor_ac   FLOAT
	,       @posiniusd  FLOAT
	,       @banco      CHAR(40)
	,       @gloUm      CHAR(03)
	,       @patrimonio FLOAT
   ,       @TipoCambioContable   FLOAT 

	SELECT @gloUm = mnsimbol  
          FROM VIEW_CONTROL_FINANCIERO
          ,    VIEW_MONEDA
         WHERE monedacontrol = mncodmon

   SELECT @fecha_hoy      = acfecproc 
   ,      @Fecha_Anterior = acfecante
   FROM   BacTraderSuda.dbo.MDAC  with(nolock)

   SET @valor_uf           = 0.0
   SET @valor_do           = 0.0
   SET @valor_ac           = 0.0
   SET @banco              = ' '
   SET @posiniusd          = 0.0
   SET @patrimonio         = 0.0
   SET @TipoCambioContable = 0.0

	SELECT 	@valor_uf   = ISNULL(vmvalor ,0.0)   	FROM VIEW_VALOR_MONEDA  WHERE vmcodigo = 998   AND vmfecha = @fecha_hoy
	SELECT 	@valor_do   = ISNULL(vmvalor ,0.0)   	FROM VIEW_VALOR_MONEDA  WHERE vmcodigo = 994   AND vmfecha = @fecha_hoy
	SELECT 	@valor_ac   = ISNULL(vmvalor ,0.0)   	FROM VIEW_VALOR_MONEDA  WHERE vmcodigo = 995   AND vmfecha = @fecha_hoy
	SELECT 	@banco      = ISNULL(acnomprop,'')   	FROM VIEW_MDAC
	SELECT 	@posiniusd  = ISNULL(vmposini,0.0)   	FROM VIEW_POSICION_SPT  WHERE vmcodigo = 'USD' AND vmfecha = @fecha_hoy
	SELECT 	@patrimonio = ISNULL(capitalbasico,0)	FROM CONTROL_FINANCIERO
   SELECT @TipoCambioContable = ISNULL(Tipo_Cambio, 0)  FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE 
                                                       WHERE Fecha = @Fecha_Anterior AND Codigo_Moneda = 994

	SELECT 'acfecpro'  = CONVERT(CHAR(10),acfecproc,103)    -- Fecha de Proceso
	,      'observado' = @valor_do                          -- Observado
	,      'valor_uf'  = @valor_uf                          -- Valor UF
	,      'acfecprx'  = CONVERT(CHAR(10),acfecprox,103)    -- Fecha Proximo Proceso
	,      'acnombre'  = @banco                             -- 5. Nombre
	,      'acuerdo'   = @valor_ac                          -- 6. Dolar Acuerdo
	,      'glomon'    = @gloUm 
	,      'patrimonio'= @patrimonio
    ,      'Tcrc'      = @TipoCambioContable                --> Se agrego el Tipo de Cambio Representacion Contable 
    ,      'acfecAnt'  = Convert(Char(10),acfecante, 103)   -- Fecha Anterior a la de proceso
	FROM 	VIEW_MDAC

	SET NOCOUNT OFF
END
GO
