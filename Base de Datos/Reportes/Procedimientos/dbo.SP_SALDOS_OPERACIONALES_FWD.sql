USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_SALDOS_OPERACIONALES_FWD]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_SALDOS_OPERACIONALES_FWD '20190401'
CREATE PROCEDURE [dbo].[SP_SALDOS_OPERACIONALES_FWD]
(
	@FECHA DATE=NULL
)
AS
BEGIN
/*
	INTERFAP SALDOS OPERACIONALES FORWARD
	RSILVA.
*/
--SONDA			: RENTABILIDAD
--DESCRIPCION	: INTERFAZ SALDOS OPERACIONES FWD
--MODIFICACION	: 27-06-2018	
--MODIFICACION	: 17-01-2019	
--MODIFICACION	: 11-04-2019	

SET NOCOUNT ON
SET DATEFORMAT YMD

DECLARE @dFechaProceso   DATETIME


--IF OBJECT_ID('TEMPDB..##TMP_RESULTADO_FWD') IS NOT NULL BEGIN
--	DROP TABLE ##TMP_RESULTADO_FWD	
--END 
	SET @dFechaProceso = @FECHA
	
	IF @dFechaProceso IS NULL 
	BEGIN
	    SELECT @dFechaProceso   = acfecproc 
		FROM BacFwdSuda..MFAC with(Nolock)
	END

	SELECT vmcodigo, vmfecha, vmvalor INTO #VM FROM Bacfwdsuda..VIEW_VALOR_MONEDA with (nolock) WHERE vmfecha = @dFechaProceso AND vmcodigo not in(999,998)
	INSERT INTO #VM SELECT  999, @dFechaProceso,  1.0 
	INSERT INTO #VM SELECT  998, @dFechaProceso, 1.0 

	SELECT vmcodigo      = Codigo_Moneda
	,      vmfecha       = Fecha
	,      vmvalor       = Tipo_Cambio
	INTO   #VALOR_TC_CONTABLE
	FROM   BacParamSuda..VALOR_MONEDA_CONTABLE with (nolock)
	WHERE  Fecha         = @dFechaProceso
	AND    Codigo_Moneda NOT IN(998,999)

	INSERT INTO #VALOR_TC_CONTABLE
        SELECT 999 , @dFechaProceso , 1.0

	UPDATE v
	SET v.vmvalor=m.vmvalor
	FROM #VALOR_TC_CONTABLE v
	inner join BacParamSuda..valor_moneda m on m.vmfecha=v.vmfecha and m.vmcodigo=v.vmcodigo
	where v.vmcodigo=129

		
   CREATE TABLE #Cartera
   (   canumoper                NUMERIC(9)
   ,   cacodpos1				NUMERIC(5)
   ,   cafecha                  DATETIME
   ,   cafecvcto                DATETIME
   ,   camtomon1                NUMERIC(21,4)
   ,   camtomon2                NUMERIC(21,4)
   ,   fres_obtenido            NUMERIC(21,4)
   ,   caclpmoneda1             NUMERIC(21,4)
   ,   cacodigo                 NUMERIC(9)
   ,   cacodcli                 INT
   ,   cacodmon1                INT
   ,   cacodmon2                INT
   ,   catipoper                CHAR(1)
   ,   cafpagomn                INT
   ,   catipmoda                CHAR(1)
   ,   cacartera_normativa      CHAR(5)
   ,   casubcartera_normativa   CHAR(5)
   )

   INSERT INTO #Cartera
   SELECT canumoper
   ,	  cacodpos1
   ,      cafecha
   ,      cafecvcto
   ,      camtomon1
   ,      camtomon2
   ,      fres_obtenido
   ,      caclpmoneda1
   ,      cacodigo
   ,      cacodcli
   ,      cacodmon1
   ,      cacodmon2
   ,      catipoper
   ,      cafpagomn
   ,      catipmoda
   ,      cacartera_normativa
   ,      casubcartera_normativa
   FROM   BacFwdSuda..MFCA with (nolock) 
   WHERE  cafecvcto      > @dFechaProceso

   CREATE TABLE #InterfazBalanceFwd
   (   Documento   NUMERIC(9)
   ,   Correlativo NUMERIC(9)
   ,   Producto    VARCHAR(5)
   ,   Fecha       DATETIME
   ,   Cuenta      VARCHAR(20)
   ,   Movimiento  CHAR(1)
   ,   Monto       NUMERIC(21,4)
   ,   Moneda      INT
   ,   Campo       INT
   ,   Nocional    NUMERIC(21,4)
   ,   Conversion  NUMERIC(21,4)
   ,   FechaInicio DATETIME
   ,   NumVoucher  NUMERIC(9)
   ,   Validacion  CHAR(1)
   ,   cacodpos1   NUMERIC(4)
   ,   TipSdo      varchar(2)  
   ,   ClsSdo	   varchar(1)  
   )

   CREATE INDEX #_ippo_InterfazBalanceFwd ON #InterfazBalanceFwd (Documento, Cuenta, Moneda, Fecha, FechaInicio, Validacion)

   --> (1.0) Vouchers del Día de Hoy
   INSERT INTO #InterfazBalanceFwd
   SELECT Documento   = vh.operacion
   ,      Correlativo = vd.correlativo
   ,      Producto    = vh.tipo_operacion
   ,      Fecha       = vh.fecha_ingreso 
   ,      Cuenta      = vd.cuenta
   ,      Movimiento  = vd.tipo_monto
   ,      Monto       = vd.monto
   ,      Moneda      = vd.moneda
   ,      Campo       = 0 --> pd.codigo_campo
   ,      Nocional    = ca.camtomon1
   ,      Conversion  = ca.camtomon2
   ,      FechaInicio = CASE WHEN ca.cafecha < vh.fecha_ingreso THEN ca.cafecha ELSE vh.fecha_ingreso END
   ,      NumVoucher  = vd.numero_voucher
   ,      Validacion  = CASE WHEN vd.cuenta = P.cuenta THEN '1' ELSE '0' END
   ,      ca.cacodpos1
   ,      t2.COD_T_SALDO
   ,      t2.COD_CLS_SALDO
   FROM   #Cartera                                            ca 
          INNER JOIN BacFwdSuda..VOUCHER_CNT_BALANCE          vh with (nolock) ON ca.canumoper      = vh.operacion    AND ca.cafecvcto   > vh.fecha_ingreso
          INNER JOIN BacFwdSuda..DETALLE_VOUCHER_CNT_BALANCE  vd with (nolock) ON vd.numero_voucher = vh.numero_voucher
          INNER JOIN BacParamSuda..PLAN_DE_CUENTA             pc with (nolock) ON pc.cuenta         = vd.Cuenta
          LEFT  JOIN BacFwdSuda..DETALLE_VOUCHER_CNT           P with (nolock) ON vd.numero_voucher = P.numero_voucher AND vd.correlativo = P.correlativo
  		  INNER JOIN REPORTES.DBO.RNT_INT_MTX_CONTABLE		  T2 with (nolock) ON CONVERT(NUMERIC,T2.CUENTA) = vd.cuenta AND T2.INTERFAZ='SALDO'
 WHERE  vh.fecha_ingreso = @dFechaProceso
   AND    pc.tipo_cuenta   IN('ACT','PAS')
   AND    vd.tipo_monto    = CASE WHEN pc.tipo_cuenta = 'ACT' THEN 'D' ELSE 'H' END
   ORDER BY vh.operacion , vh.tipo_operacion , vd.correlativo , vh.fecha_ingreso

   DELETE  I
   FROM    #InterfazBalanceFwd I
           INNER JOIN #InterfazBalanceFwd P ON P.Documento = I.Documento AND P.Cuenta = I.Cuenta AND P.Moneda = I.Moneda AND P.Validacion <> I.Validacion
   WHERE  (I.Fecha > I.FechaInicio AND I.Validacion = 0)


   SELECT 'NRO_OPERACION'        = Documento
   ,      'NRO_DOCUMENTO'        = 0
   ,      'NRO_CORRELATIVO'      = 1001
   ,      'COD_CTA_CONT'         = LTRIM(RTRIM( Cuenta )) 
   ,      'TIP_SDO'              = isnull(TipSdo,'')
   ,      'COD_EST_SDO'          = 1
   ,      'COD_DIVISA'           = mnnemo
   ,      'FEC_DATA'			 = Fecha
   ,      'CLS_SDO'              = isnull(ClsSdo,'')  
   ,      'COD_ENTIDAD'			 = '1769'
   ,      'COD_PRODUCTO'         = 'BFW'
   ,      'COD_SUBPRODU'         = cacodpos1
   ,      'IMP_SDO_CONT_MO'      = ( Monto )
   ,      'IMP_SDO_CONT_ML'      = CASE WHEN Moneda <> 999 THEN round(Monto * round(isnull(vmvalor,0.0),2),0) ELSE round((Monto), 0) END 
   ,      'COD_CENTRO_CONT'      = '2230'    
   ,      'T_FLUJO'              = 1
   INTO   #tmp_grupo_balance
   FROM   #InterfazBalanceFwd
          LEFT JOIN BacParamSuda..MONEDA with(nolock) ON mncodmon = Moneda
          LEFT JOIN #VALOR_TC_CONTABLE                ON vmcodigo = CASE WHEN Moneda = 13 THEN 994 ELSE Moneda END
 ORDER BY FechaInicio, Documento, Correlativo



   SELECT NRO_OPERACION     = NRO_OPERACION
      ,   NRO_DOCUMENTO     = 0
      ,   NRO_CORRELATIVO   = 1001
      ,   COD_CTA_CONT      = COD_CTA_CONT
      ,	  TIP_SDO		    = TIP_SDO
      ,   COD_EST_SDO       = COD_EST_SDO
      ,   COD_DIVISA        = COD_DIVISA
      ,   FEC_DATA          = FEC_DATA
      ,   CLS_SDO           = CLS_SDO
      ,   COD_ENTIDAD       = COD_ENTIDAD
      ,   COD_PRODUCTO      = COD_PRODUCTO
      ,   COD_SUBPRODU      = COD_SUBPRODU
      ,   IMP_SDO_CONT_MO   = sum( IMP_SDO_CONT_MO )
      ,   IMP_SDO_CONT_ML   = sum( IMP_SDO_CONT_ML )
      ,   COD_CENTRO_CONT   = COD_CENTRO_CONT
      ,   T_FLUJO           = T_FLUJO
  FROM   #tmp_grupo_balance
  GROUP BY 
		  NRO_OPERACION
      ,   NRO_DOCUMENTO
      ,   NRO_CORRELATIVO
      ,   COD_CTA_CONT
      ,	  TIP_SDO
      ,   COD_EST_SDO
      ,   COD_DIVISA
      ,   FEC_DATA
      ,   CLS_SDO
      ,   COD_ENTIDAD
      ,   COD_PRODUCTO
      ,   COD_SUBPRODU
      ,   IMP_SDO_CONT_MO
      ,   IMP_SDO_CONT_ML
      ,   COD_CENTRO_CONT
      ,   T_FLUJO
  ORDER BY FEC_DATA, Nro_Operacion, COD_CTA_CONT

   DROP TABLE #Cartera
   DROP TABLE #InterfazBalanceFwd




/*
-- SALIDA 
SELECT 
/*1*/ NRO_OPERACION		
/*2*/,NRO_DOCUMENTO		
/*3*/,NRO_CORRELATIVO	
/*4*/,COD_CTA_CONT       
/*5*/,TIP_SDO            
/*6*/,COD_EST_SDO        
/*7*/,COD_DIVISA         
/*8*/,FEC_DATA           
/*9*/,CLS_SDO            
/*10*/,COD_ENTIDAD        
/*11*/,COD_PRODUCTO       
/*12*/,COD_SUBPRODU       
/*13*/,IMP_SDO_CONT_MO    
/*14*/,IMP_SDO_CONT_ML    
/*15*/,COD_CENTRO_CONT    
/*16*/,T_FLUJO			
FROM ##TMP_RESULTADO_FWD
ORDER BY NRO_OPERACION
*/

--DROP TABLE ##TMP_RESULTADO_FWD
END
GO
