USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[BO52]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--dbo.BO52 '2021-10-01'
CREATE PROCEDURE [dbo].[BO52](@dFechaProceso DateTime=Null)
AS
BEGIN

   SET NOCOUNT ON

   ----declare @dFechaProceso DateTime
   ----set @dFechaProceso ='20220413'

  
   Declare @BO52_SALIDA Table ( REG_SALIDA  Varchar(185))  

   --DECLARE @dFechaProceso    DATETIME
--   SELECT  @dFechaProceso    = fechaproc 
--   FROM    BacSwapSuda.dbo.SWAPGENERAL

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

   Declare @BO52 table(
			 ctry				CHAR(3)				--		1
			,intf_dt			CHAR(8)				--		2
			,src_id				CHAR(14)			--		3
			,cem				CHAR(3)				--		4
			,prod				CHAR(16)			--		5
			,con_no				CHAR(20)			--		6
			,book_dt			CHAR(8)				--		7
			,ain				CHAR(20)			--		8
			,dr_cr_ind			CHAR(1)				--		9
			,actg_evnt_cod		CHAR(3)				--		10
			,ocy_bal_sign		VARCHAR(1)			--		11
			,ocy_bal			Numeric(19,4)		--		12
			,lcy_bal_sign		VARCHAR(1)			--		13
			,lcy_bal			Numeric(19,2)		--		14
			,lcy_agg_bal_sign	VARCHAR(1)			--		15
			,lcy_agg_bal		Numeric(19,2)		--		16
			,br					CHAR(04)			--		17
			,cc					VARCHAR(10)			--		18
)


   CREATE TABLE #TMP_CARTERA_SWAP
   (   Numero_Contrato   NUMERIC(9)   )   

   CREATE INDEX #ix_TMP_CARTERA_SWAP ON #TMP_CARTERA_SWAP (Numero_Contrato)
   
   INSERT INTO #TMP_CARTERA_SWAP
      SELECT DISTINCT numero_operacion FROM BacSwapSuda..CARTERA with(nolock) WHERE fecha_termino > @dFechaProceso 



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
   ,      Pais            = 'CL'
   ,      Fecha           = LTRIM(CONVERT(char(8),@FechaGen,112))	 
   ,      Identificacion  = 'BOC2'  + SPACE(10)
   ,      Empresa         = '001'
   ,      CProducto       = 'MD02' + SPACE(12)	
   ,      TProducto       = 'MD02'
   ,      Interno         = 'MD02'
   ,      CProductoi      = ' '
   ,      TipoProducto    = 'M'
   ,      Operacion       = CONVERT(NUMERIC(9),SUBSTRING(LTRIM(RTRIM(vh.Operacion)),1,LEN(LTRIM(RTRIM(vh.Operacion))) - 3 ))
   ,      FechaContable   = CONVERT(char(8),vh.fecha_ingreso,112)
   ,      Cuenta          = CONVERT(CHAR(16),LTRIM(RTRIM(vd.cuenta)) + REPLICATE('0',16 - LEN(LTRIM(RTRIM(vd.cuenta)))))
   ,      Moneda          = CASE WHEN mn.mncodmon IN (999,998,994) THEN '00' ELSE mncodfox END
   ,      Indicador       = CASE WHEN vd.Tipo_Monto = 'D'          THEN 'D'  ELSE 'C'      END
   ,      EvtoContable    = '0'
   ,      SgnoMdaOrig     = case when vd.monto >= 0 then '+' else '-' end	
   ,      MontoOriginal   = CASE WHEN mn.mncodmon = 999 THEN ROUND(vd.monto,0) ELSE ROUND(vd.monto,4) END
   ,      SgnoMdaCnv      = case when vd.monto >= 0 then '+' else '-' end	
   ,      MontoMonedaMn   = CASE WHEN mn.mncodmon = 999 THEN ROUND(vd.monto,0)
                                 WHEN mn.mncodmon = 998 THEN ROUND(vd.monto,4)
                                 ELSE                        ROUND(vd.monto *  (SELECT vmvalor FROM #VALOR_TC_CONTABLE /*#nValMon*/ WHERE vmcodigo = mn.mncodmon),4)
                            END
   ,      SgnoMdaxxx      = '+'
   ,      Montoxxx        = CASE WHEN mn.mncodmon = 999 THEN ROUND(vd.monto,0)
                                 WHEN mn.mncodmon = 998 THEN ROUND(vd.monto,4)
                                 ELSE                        ROUND(vd.monto *  (SELECT vmvalor FROM #VALOR_TC_CONTABLE /*#nValMon*/ WHERE vmcodigo = mn.mncodmon),4)
                            END

   ,      Sucursal        = 1
   ,      Centro          = ' '
   ,	  Operacion_Original = CONVERT(NUMERIC(9),SUBSTRING(LTRIM(RTRIM(vh.Operacion)),1,LEN(LTRIM(RTRIM(vh.Operacion))) - 3 ))

   INTO   #TMP_RETORNO_FINAL
   FROM   BacSwapSuda..BAC_CNT_VOUCHER_BALANCE vh
          INNER JOIN BacSwapSuda.dbo.BAC_CNT_DETALLE_VOUCHER_BALANCE vd ON vh.numero_voucher = vd.numero_voucher
          INNER JOIN BacParamSuda..PLAN_DE_CUENTA    pc ON vd.cuenta         = pc.cuenta
          INNER JOIN BacParamSuda..MONEDA            mn ON mn.mncodmon       = vd.moneda
   WHERE  vh.fecha_ingreso = @dFechaProceso
   AND    pc.tipo_cuenta   IN('ACT','PAS')
   AND    vd.Tipo_Monto    = CASE WHEN pc.tipo_cuenta = 'ACT' THEN 'D' ELSE 'H' END
   ORDER BY CONVERT(NUMERIC(9),vh.Operacion) , vh.tipo_operacion

 --SELECT * FROM #TMP_RETORNO_FINAL

   DELETE #TMP_RETORNO_FINAL 
    WHERE Operacion        NOT IN(SELECT Numero_Contrato FROM #TMP_CARTERA_SWAP)   


	INSERT INTO @BO52
	SELECT	Pais
	,		Fecha
	,		Identificacion
	,		Empresa
	,		CProducto
	,	    Operacion_Original
	,		FechaContable
	,		cuenta
	,		Indicador
	,		Moneda
	,		SgnoMdaOrig
	,		MontoMonedaMn
	,		SgnoMdaCnv
	,		Montoxxx
	,		SgnoMdaCnv
	,		Montoxxx
	,		'0011'
	,		REPLICATE('0',10)	
	FROM #TMP_RETORNO_FINAL


 Declare @TipoSalida bit = 0
   Declare @Pie_Archivo Varchar(20) = ''
   Declare @iCantidadRegistros int = 1

   set @iCantidadRegistros = (select count(1) from @BO52)
   set @Pie_Archivo		= '99'+LTRIM(RTRIM(CONVERT(CHAR(10),getdate(),112)))+REPLICATE('0', 10 - len(LTRIM(RTRIM(@iCantidadRegistros))))+RTRIM(RTRIM(@iCantidadRegistros))


   if @TipoSalida != 0
	SELECT 
			  ctry																																						--		1					
			    , intf_dt																																					--		2	
				, src_id																																					--		3	
				, cem																																						--		4	
				, 'MD02' + SPACE(12)--prod																																						--		5	
				,  left(con_no+space(20), 20)	as con_no--con_no																																					--		6	
				, book_dt																																					--		7
				, ain																																						--		8	
				, dr_cr_ind																																					--		9	
				, REPLICATE('0', 3 - DATALENGTH(LTRIM(RTRIM(STR(actg_evnt_cod))))) + LTRIM(RTRIM(STR(actg_evnt_cod)))														--		10
				, ocy_bal_sign																																				--		11	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(ocy_bal*10000))),19)
				, lcy_bal_sign																																				--		13
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_bal*100))),19)
				, lcy_agg_bal_sign																																			--		15
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_agg_bal*100))),19)
				, br																																						--		17
				, cc	
	FROM @BO52 Order by CONVERT(NUMERIC(9),con_no)--cem , ain , prod , con_no
	else
	begin
		INSERT INTO @BO52_SALIDA
		select 
				  ctry																																						--		1					
			    + intf_dt																																					--		2	
				+ src_id																																					--		3	
				+ cem																																						--		4	
				+ 'MD02' + SPACE(12)--prod																																						--		5	
				+  left(con_no+space(20), 20)--con_no																																					--		6	
				+ book_dt																																					--		7
				+ ain																																						--		8	
				+ dr_cr_ind																																					--		9	
				+ REPLICATE('0', 3 - DATALENGTH(LTRIM(RTRIM(STR(actg_evnt_cod))))) + LTRIM(RTRIM(STR(actg_evnt_cod)))														--		10
				+ ocy_bal_sign																																				--		11	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(ocy_bal*10000))),19)
				+ lcy_bal_sign																																				--		13
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_bal*100))),19)
				+ lcy_agg_bal_sign																																			--		15
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_agg_bal*100))),19)
				+ br																																						--		17
				+ cc																																						--		18

				from @BO52
			Order by cem , ain , prod , con_no
		
--		insert into @BO52_SALIDA
--		select @Pie_Archivo

		select * from @BO52_SALIDA
	end 

drop table #TMP_CARTERA_SWAP
drop table #nValMon
drop table #VALOR_TC_CONTABLE
drop table #TMP_RETORNO_FINAL

END

GO
