USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORIZA_CUOTAS_FMUTUOS]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALORIZA_CUOTAS_FMUTUOS]
   (   @cSistema    CHAR(03)
   ,   @dFecha      DATETIME
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @nRutcart	      NUMERIC(09)
   DECLARE @dfecfmes	      DATETIME
   DECLARE @acfecproc	      DATETIME
   DECLARE @acfecprox	      DATETIME
   DECLARE @acfecante	      DATETIME
   DECLARE @dFecha2	      DATETIME
   DECLARE @sw_tasa	      CHAR(1)
   DECLARE @dFecFMesProx      DATETIME
   DECLARE @dPrimerDiaProxMes DATETIME
   DECLARE @dUltDiaMes        DATETIME
   DECLARE @cProg	      CHAR(10)
   DECLARE @nError	      INTEGER
   DECLARE @fTir	      FLOAT

   DECLARE @iRegistros          NUMERIC(9)
   DECLARE @iContador           NUMERIC(9)

   declare 
	@fec_proc 		datetime,
	@num_docu 		numeric(10,0),
	@num_oper 		numeric(10,0),
	@num_corr 		numeric(3,0),
	@num_cod 		numeric(5,0),
	@instrumento 		varchar(20),
	@rut_emi 		char(10),
	@moneda_emi 		numeric(3,0),

	@valor_nominal 		numeric(19,4),
	@precio_compra 		numeric(19,4), --> numeric(8,4),
	@precio_mercado 	numeric(19,4), --> numeric(8,4),
	@valor_presente 	numeric(19,4),
	@valor_mercado 		numeric(19,4),
	@diferencia_mercado 	numeric(19,4),


	@fec_venc 		datetime,
	@carterasuper		char(1),
   	@morutcart		numeric(9,0),
	@fecemi              	datetime,     
	@mascara             	varchar(12)    


   SELECT  @nRutcart          = acrutprop
   ,       @acfecante         = acfecante
   ,       @acfecproc         = acfecproc
   ,	   @acfecprox         = acfecprox
   FROM    MDAC

   SET     @dPrimerDiaProxMes = SUBSTRING(CONVERT(CHAR(8),@acfecprox,112),1,6) + '01'
   SET     @dUltDiaMes        = DATEADD(DAY,-1,@dPrimerDiaProxMes)

   IF (SELECT COUNT(1) FROM TASA_MERCADO WHERE fecha_proceso = @dFecha) = 0 
   BEGIN
      SET @dFecha    = @acfecante
   END

   IF MONTH(@acfecante) < MONTH(@acfecproc) AND SUBSTRING(CONVERT(CHAR(8),@acfecproc,112),7,2) <> '01' 
   BEGIN -- INICIO DE MES ESPECIAL
      SET @dFecha    = DATEADD(DAY, -1,(SUBSTRING(CONVERT(CHAR(8),@acfecproc,112),1,6)+'01'))
   END

	delete from VALORIZACION_MERCADO
	where fecha_valorizacion=@dFecha
	and tmmascara='FMUTUO'

       	SELECT @cProg   = 'SP_' + inprog 
       	FROM   VIEW_INSTRUMENTO 
	WHERE  incodigo = 98

	select 	  'fec_proc' 		= @dfecha
		, 'morutcart'		= a.cprutcart
		, 'num_docu' 		= a.cpnumdocu
		, 'num_oper' 		= a.cpnumdocuo
		, 'num_corr' 		= a.cpcorrela
		, 'num_cod' 		= a.cpcodigo
		, 'instrumento'		= a.cpinstser
		, 'rut_emi' 		= b.nsrutemi
		, 'moneda_emi' 		= b.nsmonemi
		, 'valor_nominal' 	= a.cpnominal
		, 'precio_compra' 	= a.valor_par_compra_original
		, 'precio_mercado' 	= c.PRECIO_MERCADO
		, 'valor_presente' 	= a.valor_compra_original
		, 'valor_mercado' 	= CONVERT(NUMERIC(19,4),0.0)
		, 'diferencia_mercado' 	= CONVERT(NUMERIC(19,4),0.0)
		, 'fec_venc' 		= a.cpfecven
		, 'carterasuper' 	= a.codigo_carterasuper
		, 'fecemi'		= b.nsfecemi
		, 'mascara'		= a.cpmascara
		, 'Puntero'     	= identity(Int)
	INTO  #TEMPO
	FROM  MDCP a, view_noserie b, precio_cuota c
	where a.cpmascara='FMUTUO'
	and   a.cpnominal>0
	and   a.cpcodigo=98
        and   a.Estado_Operacion_Linea=''
	and   a.cpnumdocu=b.nsnumdocu 
	and   a.cpcorrela=b.nscorrela
	and   c.fec_proc=@dFecha
        and   c.num_docu=a.cpnumdocu
        and   c.num_oper=a.cpnumdocuo
        and   c.num_corr=a.cpcorrela
        and   c.num_cod=a.cpcodigo
	and   c.INSTRUMENTO=a.cpinstser
	and   c.RUT_EMI=b.nsrutemi

	select  @iregistros          = max(puntero)
	,       @icontador           = min(puntero)
	from    #tempo

	while     @iregistros       >= @icontador
	begin

		select 	@fec_proc           = fec_proc
                     ,  @morutcart          = morutcart
                     ,  @num_docu           = num_docu
                     ,  @num_oper           = num_oper
                     ,  @num_corr           = num_corr
                     ,  @num_cod = num_cod
                     ,  @instrumento        = instrumento
                     ,  @rut_emi            = rut_emi
                     ,  @moneda_emi         = moneda_emi
                     ,  @valor_nominal      = valor_nominal
                     ,  @precio_compra      = precio_compra
                     ,  @precio_mercado     = precio_mercado
                     ,  @valor_presente     = valor_presente

                     ,  @valor_mercado      = valor_mercado
                     ,  @diferencia_mercado = diferencia_mercado

                     ,  @fec_venc           = fec_venc
                     ,  @carterasuper       = carterasuper
                     ,  @fecemi             = fecemi
                     ,  @mascara            = mascara	        	         		
	   	from   #TEMPO 
		where  puntero = @icontador
               --** Valorizaci¢n a Tasa de Mercado **--

		EXECUTE @nError = @cProg 1, @fec_proc, @num_cod, @instrumento, @moneda_emi, @fec_venc, @fec_venc, 0, 0, 0
                                , @valor_nominal OUTPUT, @fTir OUTPUT, @precio_mercado OUTPUT, @valor_mercado  OUTPUT, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

		SET @diferencia_mercado	= @valor_mercado - @valor_presente

		INSERT INTO VALORIZACION_MERCADO
			(		fecha_valorizacion
				,	id_sistema
				,	tipo_operacion
				,	codigo_carterasuper
				,	rmrutcart
				,	rmnumdocu
				,	rmcorrela
				,	rmnumoper
				,	rmcodigo
				,	rminstser
				,	rut_emisor
				,	moneda_emision
				,	valor_nominal
				,	tasa_compra
				,	tasa_mercado
				,	tasa_market
				,	tasa_market1
				,	tasa_market2
				,	valor_presente
				,	valor_mercado
				,	valor_market
				,	valor_market1
				,	valor_market2
				,	diferencia_mercado
				,	diferencia_market
				,	diferencia_market1
				,	diferencia_market2
				,	tmfecemi
				,	tmfecven
				,	tmmascara
				,	PorcjeCob
				,	OrigenCurva
				,	ValorMercadoParPrx
				,	ValorMercadoCLPParPrx	)

		SELECT 			@fec_proc
				,	'BTR'
				,	'CP'
				,	@carterasuper
				,	@morutcart
				,	@num_docu
				,	@num_corr
				,	@num_oper
				,	@num_cod
				,	@instrumento
				,	@rut_emi
				,	@moneda_emi
				,	@valor_nominal
				,	@precio_compra
				,	@precio_mercado
				,	0
				,	0
				,	0
				,	@valor_presente
				,	@valor_mercado
				,	0
				,	0
				,	0
				,	@diferencia_mercado
				,	0
				,	0
				,	0
				,	@fecemi
				,	@fec_venc
				,	@mascara
				,	0
				,	''
				,	0
				,	0

		set @iContador = @iContador + 1

	end

END


GO
