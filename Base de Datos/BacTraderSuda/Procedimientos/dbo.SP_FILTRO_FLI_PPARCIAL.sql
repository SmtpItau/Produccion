USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTRO_FLI_PPARCIAL]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FILTRO_FLI_PPARCIAL]
   (   @numoper      NUMERIC(10) 
   ,   @gsbac_user   varchar(15)
   ,   @hWnd         NUMERIC(9)
   )
AS 
BEGIN

	SET NOCOUNT ON

	DECLARE @acfecante   DATETIME
	DECLARE @acfecproc   DATETIME


	DECLARE @cProg               CHAR(10)	,
		@iModcal             INTEGER	,
		@iCodigo             INTEGER	,
		@cInstser            CHAR(10)	,
		@mascara             CHAR(10)	,
		@iMonemi             INTEGER	,
		@dFeccal             CHAR(10)	,
		@dFecemi             CHAR(10)	,
		@dFecven             CHAR(10)	,
		@fTasemi             FLOAT	,
		@fBasemi             FLOAT	,
		@fTasest             FLOAT	,
		@fNominal            FLOAT	,
		@fTir                FLOAT	,
		@fPvp                FLOAT	,
		@fMT                 FLOAT	;

	DECLARE @Usuario            VARCHAR(15)	,
		@Marca              CHAR(1)	,
		@Documento          NUMERIC(9)	,
		@Correlativo        NUMERIC(9)	,
		@Serie              VARCHAR(20)	,
		@Moneda             CHAR(3)	,
		@Nominal	     FLOAT	,
		@Tasa_Compra        FLOAT	,
		@Valor_Par          FLOAT	,
		@Valor_Presente     FLOAT	,
		@Margen             FLOAT	,
		@Valor_Inicial      FLOAT	,
		@plazo		    INTEGER	,	
		@Ventana            NUMERIC(9)	;

	SELECT  @acfecante   = acfecante 
	,       @acfecproc   = acfecproc
	  FROM    dbo.MDAC     with(nolock)
   DELETE FROM dbo.DETALLE_FLI
         WHERE Usuario = @gsbac_user
           AND Ventana = @hWnd

   INSERT INTO dbo.DETALLE_FLI
   (   Usuario
   ,   Marca
   ,   Documento
   ,   Correlativo
   ,   Serie
   ,   Moneda
   ,   Nominal_Compra
   ,   Tasa_Compra
   ,   Valor_Par
   ,   Valor_Presente
   ,   Margen
   ,   Valor_Inicial
   ,   Nominal_Venta
   ,   Tasa_Venta
   ,   vPar_Venta
   ,   vPresente_Venta
   ,   vInicial_Venta
   ,   Plazo
   ,   Ventana
   ,   CarteraSuper
   )
   SELECT DISTINCT 
	  Usuario            = @gsbac_user
   ,      Marca              = CASE WHEN ISNULL(blusuario,'') = '' THEN 'N' ELSE 'S' END
   ,      Documento          = cp.vinumdocu
   ,      Correlativo        = cp.vicorrela
   ,      Serie              = cp.viinstser
   ,      Moneda             = mn.mnnemo
   ,      Nominal_Compra     = cp.vinominal
   ,      Tasa_Compra        = cp.vitirvent
   ,      Valor_Par          = mo.movpar 
   ,      Valor_Presente     = cp.vivptirv
   ,      Margen             = ISNULL( ROUND(ms.margen, 4), 1.0)
   ,      Valor_Inicial      = cp.vivptirv * ISNULL( ROUND(ms.margen, 4), 1.0)
   ,      Nominal_Venta      = 0
   ,      Tasa_Venta         = 0
   ,      vPar_Venta         = 0
   ,      vPresente_Venta    = 0
   ,      vInicial_Venta     = 0
   ,      Plazo              = DATEDIFF(DAY, @acfecproc, di.difecsal)
   ,      Ventana            = @hWnd
   ,       cp.Codigo_carterasuper
   FROM   dbo.MDVI                               cp with(nolock)
         INNER JOIN dbo.MDDI                     di with(nolock) ON di.dinumdocu          = cp.vinumdocu 
                                                                and di.dicorrela          = cp.vicorrela 
                                                            --    and di.ditipoper          = 'CP' 
                                                            --    and di.digenemi           = 'BCCH' 
                                                                and di.dinemmon          <> 'USD'
         INNER JOIN dbo.MDMO                     mo with(nolock) ON mo.monumoper          = cp.vinumoper
                                                                and mo.monumdocu          = cp.vinumdocu
                                                                and mo.mocorrela          = cp.vicorrela
         INNER JOIN BacParamSuda.dbo.INSTRUMENTO fi with(nolock) ON fi.incodigo           = cp.vicodigo
         INNER JOIN BacParamSuda..INSTRUMENTOS_SOMA       InstSoma with(nolock) 
                                                          ON InstSoma.InTipSOMA = 'FLI'  
                                                           and InstSoma.InCodigo = cp.vicodigo
         LEFT  JOIN BacParamSuda.dbo.MONEDA      mn with(nolock) ON mn.mnnemo  = di.dinemmon
         LEFT  JOIN dbo.MDBL           bl with(nolock) ON bl.blrutcart          = cp.virutcart 
                                                                and bl.blnumdocu          = cp.vinumdocu 
                                                                and bl.blcorrela          = cp.vicorrela
--                                                              and bl.blusuario          = ''
         LEFT JOIN  BacParamSuda.dbo.MARGEN_INSTRUMENTO_SOMA ms with(nolock) ON ms.codigo_instrumento = fi.incodigo
                                                                            and ms.Plazo_desde       <= DATEDIFF(DAY, @acfecproc, di.difecsal)
                                                                            and ms.Plazo_hasta       >= DATEDIFF(DAY, @acfecproc, di.difecsal)
		
   WHERE   vinumoper    = @numoper
   ORDER BY cp.vinumdocu, cp.vicorrela

	SELECT Serie    = Serie
	   ,   Moneda   = Moneda
	   ,   Nominal  = SUM( Nominal_Compra )
	   ,   Tir      = AVG( Tasa_Compra )
	   ,   vPar     = AVG( Valor_Par )
	   ,   vPresent = SUM( Valor_Presente )
	   ,   Plazo    = Plazo
	   ,   Margen   = AVG( Margen )
	   ,   vinicial = SUM( Valor_Inicial )
	   ,   TirX     = AVG( Tasa_Compra )
	   ,   Cartera  = CarteraSuper
	   ,   IDENTITY(NUMERIC(10))  AS Registro   --> VB
	  INTO #TemporalFli
	  FROM dbo.DETALLE_FLI
	 WHERE Marca    = 'N'
	   AND Ventana  = @hWnd
	   AND Usuario  = @gsbac_user
      GROUP BY CarteraSuper, Serie, Moneda, Plazo
	
/*
	UPDATE #TemporalFli
	   SET vpresent = m.MtoOrigen-p.MtoPago
	  FROM #TemporalFli,
		( 	
	      	SELECT moinstser 	AS SerieM	,
		       round(SUM(movpresen),0) 	AS MtoOrigen
		  FROM mdmo 
		 WHERE monumoper = @numoper
	      GROUP BY moinstser) m
	 INNER
	  JOIN (
		SELECT painstser 	AS Seriex	, 
		       	sum(round(pavpresen,0)) aS MtoPago
		  FROM pagos_fli 
		 WHERE paptipopago='S' 
		   AND panumoper = @numoper
	      GROUP BY painstser) p
   	   ON m.SerieM=p.Seriex
	WHERE m.SerieM=Serie
		

*/
	UPDATE #TemporalFli
  	   SET VInicial = vPresent * Margen


   SELECT Serie 
   ,      Moneda
   ,      Nominal
   ,      CASE  WHEN tir = 0 THEN tirx 
		WHEN tir >50 THEN tirx 
	  ELSE CAST(Tir AS NUMERIC(10,4)) END as Tir
   ,      vPar
   ,      vPresent
   ,      Plazo 
   ,      Margen
   ,      vinicial
	,      tbglosa
	,      cartera  --> Corresponde al código de Cartera
   FROM #TemporalFli
	INNER JOIN VIEW_TABLA_GENERAL_DETALLE ON tbcateg = '1111' AND tbcodigo1 = Cartera
	ORDER BY serie, tbglosa
END


GO
