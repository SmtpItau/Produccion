USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[CARTERA_AJUSTE_BONEXT_IFRS3_VENTAS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CARTERA_AJUSTE_BONEXT_IFRS3_VENTAS]
AS
BEGIN
	
	SET NOCOUNT ON

	DECLARE @DFECPRO	DATETIME	
	,	@FECHA_VCTO	DATETIME	
	,	@FP		DATETIME	
	,	@FE		DATETIME	
	,	@FV		DATETIME	
	,	@FU		DATETIME	
	,	@FX		DATETIME	
	,	@FC		DATETIME	
	,	@FIP		DATETIME	
	,	@FECPAGO	DATETIME	
	,	@FECEMI		DATETIME	
	,	@FECVEN		DATETIME	
	,	@RUTCART	NUMERIC(09, 0)	
	,	@NUMDOCU	NUMERIC(12, 0)	
	,	@NOMINAL	NUMERIC(19, 4)	
	,	@TIRCOMP	NUMERIC(19, 4)	
	,	@PVPCOMP	NUMERIC(19, 4)	
	,	@VPCOMP		NUMERIC(19, 8)	
	,	@TASEMI		NUMERIC(19, 4)	
	,	@BASEMI		NUMERIC(03, 0)	
	,	@MONEMI		NUMERIC(03, 0)	
	,	@VPTIRC		NUMERIC(19, 4)	
	,	@CAPITAL	NUMERIC(19, 4)	
	,	@INTERES	NUMERIC(19, 4)	
	,	@REAJUST	NUMERIC(19, 4)	
	,	@valor_venta NUMERIC(19, 4)
	,	@ndif		NUMERIC(19, 4)
	,	@REAJUSTE_ACUM	NUMERIC(19, 4)	
	,	@INTERES_ACUM	NUMERIC(19, 4)	
	,	@TIPO_CALCULO	NUMERIC(03, 0)	
	,	@TIPO_TASA	NUMERIC(03)	
	,	@COD_FAMILIA	NUMERIC(04)	
	,	@TR		FLOAT		
	,	@TE		FLOAT		
	,	@TV		FLOAT		
	,	@TT		FLOAT		
	,	@BA		FLOAT		
	,	@BF		FLOAT		
	,	@NOM		FLOAT		
	,	@MT		FLOAT		
	,	@VV		FLOAT		
	,	@VP		FLOAT		
	,	@PVP		FLOAT		
	,	@VAN		FLOAT		
	,	@CI		FLOAT		
	,	@CT		FLOAT		
	,	@INDEV		FLOAT		
	,	@PRINC		FLOAT		
	,	@INCTR		FLOAT		
	,	@TIPO_CAL	FLOAT		
	,	@CAP		FLOAT		
	,	@SPREAD		FLOAT		
	,	@VALCOMU	FLOAT		
	,	@TIPFOMULAS	CHAR(1)		
	,	@RETORNO	CHAR(1)		
	,	@COD_NEMO	CHAR(20)	

	DECLARE @dFechaproc	DATETIME
		SET @dFechaproc	='20160401';

	DECLARE	@I	INTEGER
		,	@E	INTEGER
		,	@CORRELATIVO NUMERIC(5)
			
	CREATE TABLE #CARTERA	(	RUTCART		NUMERIC(9, 0)	,
					NUMDOCU		NUMERIC(10, 0)	,
					CORRELA		NUMERIC(5, 0)	,
					COD_FAMILIA	NUMERIC(5, 0)	,
					carteraFin	NUMERIC(2)		,		
					COD_NEMO	CHAR (20)	,
					NOMINAL		NUMERIC(19, 4)	,
					FECPAGO		DATETIME	,
					VALCOMU		FLOAT		,
					TIRCOMP		NUMERIC(19, 4)	,
					PVPCOMP		NUMERIC(19, 4)	,
					VPCOMP		NUMERIC(19, 8)	,
					FECEMI		DATETIME	,
					FECVEN		DATETIME	,
					TASEMI		NUMERIC(19, 4)	,
					BASEMI		NUMERIC(3, 0)	,
					MONEMI		NUMERIC(3, 0)	,
					VPTIRC		NUMERIC(19, 4)	,
					CAPITAL		NUMERIC(19, 4)	,
					INTERES		NUMERIC(19, 4)	,
					REAJUST		NUMERIC(19, 4)	,
					TIPO_TASA	NUMERIC(3)	,
					SW			CHAR(1)		,
					TIPO_CAL	NUMERIC(1)	,
					
					NEW_MT		NUMERIC(19, 4)	,
					NEW_PVP		NUMERIC(19, 8)	,
					NEW_PRINC	NUMERIC(19, 4)	,
					
					FECHAPRO	DATETIME,
					valorventa	NUMERIC(19, 4)	,
					resultado	NUMERIC(19, 4)	,
					dif1	NUMERIC(19, 4)	,
					dif2	NUMERIC(19, 4)	,
					POSICION	NUMERIC(10) IDENTITY(1,1) 	
				)

--	WHILE nContador <= 2 BEGIN
						
		SELECT	@DFECPRO	= ''
		,	@FECHA_VCTO	= ''
		,	@FP		= ''
		,	@FE		= ''
		,	@FV		= ''	
		,	@FU		= ''	
		,	@FX		= ''	
		,	@FC		= ''	
		,	@FIP		= ''	
		,	@FECPAGO	= ''	
		,	@FECEMI		= ''	
		,	@FECVEN		= ''	
		,	@RUTCART	= 0	
		,	@NUMDOCU	= 0
		,	@BASEMI		= 0
		,	@MONEMI		= 0
		,	@TIPO_CALCULO	= 0
		,	@TIPO_TASA	= 0
		,	@COD_FAMILIA	= 0
		,	@NOMINAL	= 0.0
		,	@TIRCOMP	= 0.0
		,	@PVPCOMP	= 0.0
		,	@VPCOMP		= 0.0
		,	@TASEMI		= 0.0
		,	@VPTIRC		= 0.0
		,	@CAPITAL	= 0.0
		,	@INTERES	= 0.0
		,	@REAJUST	= 0.0
		,	@REAJUSTE_ACUM	= 0.0
		,	@INTERES_ACUM	= 0.0	
		,	@TR		= 0.0		
		,	@TE		= 0.0		
		,	@TV		= 0.0		
		,	@TT		= 0.0		
		,	@BA		= 0.0		
		,	@BF		= 0.0		
		,	@NOM		= 0.0		
		,	@MT		= 0.0		
		,	@VV		= 0.0		
		,	@VP		= 0.0		
		,	@PVP		= 0.0		
		,	@VAN		= 0.0		
		,	@CI		= 0.0		
		,	@CT		= 0.0		
		,	@INDEV		= 0.0		
		,	@PRINC		= 0.0		
		,	@INCTR		= 0.0		
		,	@TIPO_CAL	= 0.0		
		,	@CAP		= 0.0		
		,	@SPREAD		= 0.0		
		,	@VALCOMU	= 0.0		
		,	@TIPFOMULAS	= ''
		,	@RETORNO	= ''
		,	@COD_NEMO	= ''	
		

	declare @Resultado_Dif_Precio		numeric(21,4);	set @Resultado_Dif_Precio		= 0.0

	declare @Resultado_Dif_Mercado		numeric(21,4);	set @Resultado_Dif_Mercado		= 0.0

	declare @nValMercadoProporcional	numeric(21,4);	set @nValMercadoProporcional	= 0.0

	declare @fResultado					numeric(21,4);  SET @fResultado					= 0.0;					


;WITH ctevp
AS (
       SELECT * 
       FROM   BacBonosExtSuda.dbo.text_mvt_dri tmd
       WHERE  tmd.mofecpro >= '2016-04-01'
              AND tmd.motipoper = 'VP'
              AND tmd.mostatreg =''
              AND tmd.mofecpro = tmd.mofecpago
   ),
	cteCP
AS (
       SELECT *
         FROM TEXT_RSU
       WHERE  rsfecpro = '2016-04-01'
              AND rstipoper = 'DEV'
   ), cteTM
AS (
       SELECT DISTINCT      COD_NEMO,
              RSTIRMERC  AS TM,
              rspvpmerc  AS PV
       FROM   TEXT_RSU
       WHERE  rsfecpro = '2016-03-31'
        
   )
			INSERT #CARTERA
			(	RUTCART	
			,	NUMDOCU	
			,	CORRELA
			,	COD_FAMILIA
			,	carteraFin
			,	COD_NEMO
			,	NOMINAL	
			,	FECPAGO	
			,	VALCOMU	
			,	TIRCOMP	
			,	PVPCOMP	
			,	VPCOMP	
			,	FECEMI	
			,	FECVEN	
			,	TASEMI	
			,	BASEMI	
			,	MONEMI	
			,	VPTIRC	
			,	CAPITAL
			,	INTERES
			,	REAJUST
			,	TIPO_TASA
			,	SW
			,	TIPO_CAL,FECHAPRO,valorventa,resultado
			)
	
SELECT MORUTCART,
       MONUMDOCU,
       MOCORRELATIVO,
       VP.COD_FAMILIA,
       vp.tipo_cartera_financiera,
       VP.COD_NEMO,
       moNOMINAL,
       MOFECPAGO,
       MOVALCOMU,
       ct.TM,
       ct.PV,
       MOPVP,
       MOFECEMI,
       MOFECVEN,
       MOTASEMI,
       MOBASEMI,
       MOMONEMI,
       0,
       0,
       MOINTERES,
       MOREAJUSTE,
       VP.TIPO_TASA,
       'N',
       2 AS TipoCal,
       
       MOFECPRO,movalven,moutilidad+moperdida
FROM   cteVP VP
       left JOIN cteCP CP
				ON  RSNUMDOCU = VP.MONUMDOCU
            AND RSCORRELATIVO = VP.MOCORRELATIVO
       INNER JOIN cteTM ct
            ON  ct.cod_nemo = VP.cod_nemo
WHERE  MOfecpro > '2016-03-31'



		DECLARE @total NUMERIC(10)
			SET @total = (SELECT MAX(posicion) FROM #CARTERA c);
			set @I 		= 1
	
		WHILE (@i<=@total)
		BEGIN 
			SELECT	@RUTCART	= RUTCART	,	
				@NUMDOCU	= NUMDOCU	,	
				@COD_FAMILIA	= COD_FAMILIA	,
				@CORRELATIVO	= CORRELA,	
				@COD_NEMO	= COD_NEMO	,	--5
				@NOMINAL	= NOMINAL	,	
				@FECPAGO	= FECPAGO	,	
				@VALCOMU	= VALCOMU	,	
				@TIRCOMP	= TIRCOMP	,	
				@PVPCOMP	= PVPCOMP	,	--10
				@VPCOMP		= VPCOMP	,	
				@FECEMI		= FECEMI	,	
				@FECVEN		= FECVEN	,
				@TASEMI		= TASEMI	,
				@BASEMI		= BASEMI	,	--15
				@MONEMI		= MONEMI	,
				@VPTIRC		= VPTIRC	,
				@CAPITAL	= CAPITAL	,
				@INTERES_ACUM	= INTERES	,
				@REAJUSTE_ACUM	= REAJUST	,	--20
				@TIPO_TASA	= TIPO_TASA	,
				@INTERES	= 0		,
				@REAJUST	= 0		,
				@TIPO_CAL	= TIPO_CAL	,	--24	
				--@DFECPRO	= FECPAGO,
				@valor_venta = valorventa,
				@ndif = resultado
			FROM	#CARTERA
			WHERE posicion = @i
		
			SELECT	@DFECPRO	= @FECPAGO,	--1
				@TIPFOMULAS	= ' '		,
				@TIPO_CAL	= TIPO_CAL	,
				@FECHA_VCTO	= @FECVEN	,
				@TR		= @TIRCOMP	,	--5
				@TE		= @TASEMI	,
				@TV		= @TASEMI	,
				@TT		= @TIPO_TASA	,
				@BA		= @BASEMI	,
				@BF		= @BASEMI	,	--10
				@NOM		= @NOMINAL	,
				@MT		= @VPTIRC	,
				@VV		= 0		,
				@VP		= 0		,
				@PVP		= @PVPCOMP	,	--15
				@VAN		= 0		,
				@FP		= @FECPAGO	,
				@FE		= @FECEMI	,
				@FV		= @FECVEN	,
				@FU		= ''		,	--20
				@FX		= ''		,
				@FC		= @FECPAGO	,
				@CI		= 0		,
				@CT		= 0		,
				@INDEV		= 0		,	--25
				@PRINC		= 0		,
				@FIP		= @FECPAGO	,
				@INCTR		= 0		,
				@CAP		= @VPTIRC	,
				@RETORNO	= 'N'		,	--27
				@SPREAD		= 0
			FROM #CARTERA
			WHERE posicion = @i
	
			EXECUTE Svc_Prc_val_ins		@DFECPRO		,
							@TIPFOMULAS		,
							@TIPO_CAL		,
							@COD_FAMILIA		,
							@COD_NEMO		,
							@FECHA_VCTO		,
							@TR		OUTPUT	,
							@TE		OUTPUT	,
							@TV		OUTPUT	,
							@TT		OUTPUT	,
							@BA		OUTPUT	,
							@BF		OUTPUT	,
							@NOM		OUTPUT	,
							@MT		OUTPUT	,
							@VV		OUTPUT	,
							@VP		OUTPUT	,
							@PVP		OUTPUT	,
							@VAN		OUTPUT	,
							@FP		OUTPUT	,
							@FE		OUTPUT	,
							@FV		OUTPUT	,
							@FU		OUTPUT	,
							@FX		OUTPUT	,
							@FC		OUTPUT	,
							@CI		OUTPUT	,
							@CT		OUTPUT	,
							@INDEV		OUTPUT	,
							@PRINC		OUTPUT	,
							@FIP		OUTPUT	,
							@INCTR		OUTPUT	,
							@CAP		OUTPUT	,
							@SPREAD		OUTPUT	,
							@RETORNO		,
							@MONEMI
	



				 -- -------------------------------------------------------------------------------------------------------------------------------------
				SET @fResultado = ( @valor_venta - @MT )  -- Nuevo resultado de la venta 
			 -- -------------------------------------------------------------------------------------------------------------------------------------  			
			 
				SET @Resultado_Dif_Precio	= 0; 
				SET @Resultado_Dif_Mercado	= 0;
			 


	Execute BacTraderSuda.dbo.sp_fx_utilidad_ventaHIST	'BEX'

												,	@numdocu

												,	@CORRELATIVO

												,	@nominal

												,	@valor_venta

												,	@fResultado
												
												,	@DFECPRO

												,	@Resultado_Dif_Precio	output

												,	@Resultado_Dif_Mercado	output


				UPDATE #CARTERA SET NEW_MT = @MT,
									NEW_PVP = @PVP,
									NEW_PRINC = @PRINC,dif1 = @Resultado_Dif_Precio	, dif2=@Resultado_Dif_Mercado
									, resultado = 		@fResultado
				WHERE POSICION = @I



				SET @i=@i+1
		END
		
		SELECT c.*, fin.tbglosa FROM #CARTERA c
			INNER JOIN bacparamsuda.dbo.TABLA_GENERAL_DETALLE Fin
	ON Fin.tbcateg = '204'
	AND Fin.tbcodigo1 =carterafin
 
	SET NOCOUNT OFF	
END
GO
