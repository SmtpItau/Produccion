USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_SALDOS_OPERACIONALES_SWAP]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_SALDOS_OPERACIONALES_SWAP '20190401'
CREATE PROCEDURE [dbo].[SP_SALDOS_OPERACIONALES_SWAP]
(
	@FECHA DATE=NULL
)
AS
BEGIN
/*
	INTERFAP SALDOS OPERACIONALES SWAP
	RSILVA.
*/
--SONDA			: RENTABILIDAD
--DESCRIPCION	: INTERFAZ SALDOS OPERACIONES SWAP
--MODIFICACION	: 13-08-2018	
--MODIFICACION	: 09-04-2019	
--MODIFICACION	: 11-04-2019	

SET NOCOUNT ON
SET DATEFORMAT YMD

   DECLARE @dFechaProceso    DATETIME

   SET @dFechaProceso=@FECHA

   IF @dFechaProceso IS NULL
   BEGIN
		SELECT  @dFechaProceso    = fechaproc 
		FROM    BacSwapSuda..SWAPGENERAL
   END

   DECLARE @iFound      INTEGER
       SET @iFound      = -1

   SELECT  @iFound      = 0
   FROM    BacParamSuda..VALOR_MONEDA_CONTABLE
   WHERE   Fecha        = @dFechaProceso
   AND     Tipo_Cambio <> 0

   IF @iFound = -1
   BEGIN
      RAISERROR( '¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY. !', 16, 6, 'ERROR.' )
      RETURN
   END


   CREATE TABLE #TMP_CARTERA_SWAP
   (   Numero_Contrato   NUMERIC(9)      
   ,   tipo_flujo	     NUMERIC(4)   
   ,   tipo_swap	     NUMERIC(4)   
   ,   Numero_flujo      NUMERIC(4)   )   

	CREATE INDEX #ix_TMP_CARTERA_SWAP ON #TMP_CARTERA_SWAP (Numero_Contrato)
   
	INSERT INTO #TMP_CARTERA_SWAP
	SELECT DISTINCT numero_operacion,1,tipo_swap,1 FROM BacSwapSuda.dbo.CARTERA with(nolock) WHERE fecha_termino > @dFechaProceso

	update p
		set p.numero_flujo  = (select MAX(c.numero_flujo) from BacSwapSuda.dbo.CARTERA c where c.numero_operacion=p.Numero_Contrato)
	from #TMP_CARTERA_SWAP p
	inner join BacSwapSuda.dbo.CARTERA c on c.numero_operacion=p.Numero_Contrato

	update p
		set p.tipo_flujo  = c.tipo_flujo
	from #TMP_CARTERA_SWAP p
	inner join BacSwapSuda.dbo.CARTERA c on c.numero_operacion=p.Numero_Contrato and c.numero_flujo=p.Numero_flujo


   DECLARE @dFechaFinMes     DATETIME
   EXECUTE BacparamSuda..SP_RETORNA_FECHA_CIERRE_ANTERIOR @dFechaProceso , @dFechaFinMes OUTPUT

   SELECT  vmcodigo , vmvalor INTO #nValMon                      FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha  = @dFechaFinMes
                       INSERT INTO #nValMon SELECT 13  , vmvalor FROM #nValMon                   WHERE vmcodigo = 994
                       INSERT INTO #nValMon SELECT 999 , 1.0
   
   -- CREA TABLA DE VALORES DE MONEDA NO REAJUSTABLES Tipo Cambio Contable --
   SELECT vmcodigo      = CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END
   ,      vmvalor       = Tipo_Cambio
   INTO   #VALOR_TC_CONTABLE
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE 
   WHERE  Fecha         = @dFechaProceso
   AND    Codigo_Moneda NOT IN(13,995,997,998,999)
   
   -- INSERTA VALORES DE MONEDA REAJUSTABLES Tipo Cambio del día          --
   INSERT INTO #VALOR_TC_CONTABLE
   SELECT vmcodigo
   ,      vmvalor
   FROM   #nValMon 
   WHERE  vmcodigo  IN(994,995,997,998,999)


   DECLARE @FechaGen      DATETIME
   SELECT  @FechaGen      = @dFechaProceso

   SELECT Registros       = CONVERT(NUMERIC(9), 0) --> @iRegistros
   ,	  NRO_OPERACION	  = s.Numero_Contrato	
   ,      NRO_DOCUMENTO	  = 0
   ,      NRO_CORRELATIVO = case when s.tipo_flujo=1 then s.Numero_flujo + 1000 else s.Numero_flujo + 2000 end
   ,      COD_CTA_CONT    = vd.cuenta
   ,	  TIP_SDO         = isnull(t2.COD_T_SALDO,'')
   ,	  COD_EST_SDO     = 1
   ,	  COD_DIVISA      = mn.mnnemo
   ,      FEC_DATA        = @FechaGen
   ,	  CLS_SDO         = isnull(t2.COD_CLS_SALDO,'')
   ,	  COD_ENTIDAD     = '1769'
   ,	  COD_PRODUCTO    = 'PCS'
   ,	  COD_SUBPRODU    = (case s.tipo_swap  when 1 then 'ST' when 2 then 'SM' when 3 then 'FR' when 4 then 'SP' end) 
   ,      IMP_SDO_CONT_MO = CASE WHEN mn.mncodmon = 999 THEN ROUND(vd.monto,0) ELSE ROUND(vd.monto,4) END
   ,      IMP_SDO_CONT_ML = CASE WHEN mn.mncodmon = 999 THEN ROUND(vd.monto,0)
                                 WHEN mn.mncodmon = 998 THEN ROUND(vd.monto,4)
                                 ELSE                        ROUND(vd.monto *  round((SELECT vmvalor FROM #VALOR_TC_CONTABLE /*#nValMon*/ WHERE vmcodigo = mn.mncodmon),2),4)
                            END
   ,      COD_CENTRO_CONT = '2230'
   ,      T_FLUJO         = s.tipo_flujo
   INTO   #TMP_RETORNO_FINAL
   FROM   BacSwapSuda..BAC_CNT_VOUCHER_BALANCE vh
          INNER JOIN BacSwapSuda..BAC_CNT_DETALLE_VOUCHER_BALANCE vd ON vh.numero_voucher = vd.numero_voucher
          INNER JOIN BacParamSuda..PLAN_DE_CUENTA    pc ON vd.cuenta         = pc.cuenta
          INNER JOIN BacParamSuda..MONEDA            mn ON mn.mncodmon       = vd.moneda
  		  INNER JOIN REPORTES.DBO.RNT_INT_MTX_CONTABLE t2 with (nolock) ON CONVERT(NUMERIC,t2.CUENTA) = vd.cuenta and t2.INTERFAZ='SALDO'
  		  inner join #TMP_CARTERA_SWAP s on s.Numero_Contrato= CONVERT(NUMERIC(9),SUBSTRING(LTRIM(RTRIM(vh.Operacion)),1,LEN(LTRIM(RTRIM(vh.Operacion))) - 3 ))
   WHERE  vh.fecha_ingreso = @dFechaProceso
   AND    pc.tipo_cuenta   IN('ACT','PAS')
   AND    vd.Tipo_Monto    = CASE WHEN pc.tipo_cuenta = 'ACT' THEN 'D' ELSE 'H' END
   ORDER BY CONVERT(NUMERIC(9),vh.Operacion) , vh.tipo_operacion


   DELETE #TMP_RETORNO_FINAL 
   WHERE NRO_OPERACION    NOT IN(SELECT Numero_Contrato FROM #TMP_CARTERA_SWAP)   

   
   SELECT 
      	  NRO_OPERACION
      ,   NRO_DOCUMENTO
      ,   NRO_CORRELATIVO
      ,   COD_CTA_CONT
      ,	  TIP_SDO
      ,	  COD_EST_SDO
      ,	  COD_DIVISA
      ,   FEC_DATA
	  ,	  CLS_SDO
	  ,	  COD_ENTIDAD
	  ,	  COD_PRODUCTO
	  ,	  COD_SUBPRODU
      ,   IMP_SDO_CONT_MO
      ,   IMP_SDO_CONT_ML
	  ,   COD_CENTRO_CONT
	  ,   T_FLUJO
     FROM #TMP_RETORNO_FINAL


END
GO
