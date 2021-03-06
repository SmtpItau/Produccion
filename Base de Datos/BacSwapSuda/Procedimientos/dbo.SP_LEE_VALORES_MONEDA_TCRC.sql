USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_VALORES_MONEDA_TCRC]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEE_VALORES_MONEDA_TCRC]
   (   @dFechaValores   DATETIME   )
AS
BEGIN

   SET NOCOUNT ON

   CREATE TABLE #TMP_VM_TRCR
   (   vmcodigo   INTEGER   NOT NULL DEFAULT(0)
   ,   vmvalor    FLOAT     NOT NULL DEFAULT(0.0)
   )
   CREATE INDEX #ixt_#TMP_VM_TRCR ON #TMP_VM_TRCR ( vmcodigo )

   -->    Inserta Valor para el Peso
   INSERT INTO #TMP_VM_TRCR
   SELECT 999
   ,      1

   -->    Inserta Valor para Monedas Mx
   INSERT INTO #TMP_VM_TRCR
   SELECT CASE WHEN codigo_moneda = 994 THEN 13 ELSE codigo_moneda END
   ,      tipo_cambio
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE WITH (NOLOCK)
   WHERE  Fecha          = @dFechaValores
   AND    Codigo_Moneda  NOT IN(13,995,997,998,999)
   AND    Tipo_Cambio   <> 0.0

   IF @@ROWCOUNT = 0
   BEGIN
   /* 
      RAISERROR('¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY. ! ',16,6,'ERROR.')
      RETURN -1
	  */
	   INSERT INTO #TMP_VM_TRCR
	   SELECT CASE WHEN codigo_moneda = 994 THEN 13 ELSE codigo_moneda END
	   ,      tipo_cambio
	   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE WITH (NOLOCK)
	      ,   BacSwapSuda.dbo.SwapGeneral TabControl
	   WHERE  TabControl.fechaproc =  @dFechaValores
	   AND    Fecha = TabControl.fechaant 
	   AND    Codigo_Moneda  NOT IN(13,995,997,998,999)
	   AND    Tipo_Cambio   <> 0.0
   END

   -->    Inserta Valor para Monedas Mn
   INSERT INTO #TMP_VM_TRCR
   SELECT vmcodigo
   ,      vmvalor
   FROM   BacParamSuda..VALOR_MONEDA WITH (NOLOCK)
   WHERE  vmfecha   = @dFechaValores
   AND    vmcodigo  IN(995,997,998,999)

   IF @@ROWCOUNT = 0
   BEGIN
      RAISERROR('¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY. ! ',16,6,'ERROR.')
      RETURN -1
   END

   SELECT vmcodigo, vmvalor
     FROM #TMP_VM_TRCR
 ORDER BY vmcodigo

END
GO
