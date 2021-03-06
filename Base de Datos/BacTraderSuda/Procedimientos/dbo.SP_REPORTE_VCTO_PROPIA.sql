USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTE_VCTO_PROPIA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_REPORTE_VCTO_PROPIA]
     (
      @cFechaHasta        CHAR(08)
     )
AS
BEGIN
   SET NOCOUNT ON
   	DECLARE @dFechaHasta    DATETIME
   	DECLARE @dFechaProceso  DATETIME
   	DECLARE @dFecVen  	DATETIME
   	DECLARE @dFecPag  	DATETIME
   	DECLARE @sw   		CHAR(1)
   	declare @fecha  	DATETIME
   	declare @fecha_habil 	DATETIME
	DECLARE @ACNOMPROP  	CHAR(40)
	DECLARE @ACFECPROC  	CHAR(10)
	DECLARE @ACRUTPROP 	NUMERIC (9)
	DECLARE @ACDIGPROP      CHAR(1)

	SELECT 
 	 @ACNOMPROP = acnomprop,
	 @ACFECPROC = acfecproc,
 	 @ACRUTPROP = acrutprop,
 	 @ACDIGPROP = acdigprop
	FROM MDAC               

   SELECT @dFechaHasta    = @cFechaHasta
   SELECT @dFechaProceso  = acfecproc  FROM mdac

   -- Recuperar Datos para la generación de los cupones.
   SELECT       'Rut_Cartera'          = cprutcart,
                'Nro_Documento'        = cpnumdocu,
                'Correlativo'          = cpcorrela,
                'Serie'                = cpinstser,
                'Mascara'              = cpmascara,
                'Familia'              = CASE WHEN cptipoletra='E' THEN 'LCHR ESTA'
      WHEN cptipoletra='V' THEN 'LCHR VIV'
      WHEN cptipoletra='F' THEN 'LCHR F.GEN'
      WHEN cptipoletra='O' THEN 'LCHR OTROS'
      ELSE inserie
      END,
                'Rut_Emisor'           = CONVERT( NUMERIC(10), 0 ),
                'Emisor'               = CONVERT( VARCHAR(10), '' ),
                'Fecha_Emision'        = cpfecemi,
                'Fecha_Vencimiento'    = cpfecven,
                'Seriado'              = cpseriado,
                'Codigo_Instrumento'   = cpcodigo,
                'Nominal'              = cpnominal,
                'Tasa_Emision'         = cptircomp,
                'Tir_Compra'           = cptircomp,
                'Porc_VC'              = cppvpcomp,
                'Valor_Compra'         = cpvalcomp,
                'Valor_Presente'       = ISNULL( cpvptirc, 0 ),
                'C_Moneda_Emision'     = CONVERT( NUMERIC(05), 0 ),
                'Moneda_Emision'       = CONVERT( VARCHAR(05), '' ),
                'Base_Emision'         = CONVERT( NUMERIC(05), 0 ),
                'Tipo_Operacion'       = 'CP',
                'valor_pesos'          = CONVERT( NUMERIC(19), 0 ),
                'Fecha_pago'           = cpfecven
          INTO  #temporal_mdcp
          FROM  mdcp, VIEW_INSTRUMENTO
          WHERE cpnominal              > 0          AND
                cpcodigo               = incodigo


   INSERT INTO #temporal_mdcp
          SELECT       virutcart,
                       vinumdocu,
                       vicorrela,
                       viinstser,
                       vimascara,
                       inserie,
                       CONVERT( NUMERIC(10), 0 ),
                       CONVERT( VARCHAR(10), '' ),
                       vifecemi,
                       vifecven,
                       viseriado,
                       vicodigo,
                       vinominal,
                       vitircomp,
                       vitircomp,
                       valor_par_compra_original,
                       vivalcomp,
                       ISNULL( vivpcomp, 0 ),
                       CONVERT( NUMERIC(05), 0 ),
                       CONVERT( VARCHAR(05), '' ),
                       CONVERT( NUMERIC(05), 0 ),
                       'VI',
                        0,
                        ''
                 FROM  mdvi, VIEW_INSTRUMENTO
                 WHERE vitipoper              = 'CP'        AND
                       vicodigo               = incodigo

   UPDATE       #temporal_mdcp
          SET   C_Moneda_Emision    = nsmonemi,
                Fecha_Emision       = nsfecemi,
                Fecha_Vencimiento   = nsfecven,
                Base_Emision        = nsbasemi,
                Rut_Emisor          = nsrutemi,
                Tasa_Emision  = nstasemi
          FROM VIEW_NOSERIE
          WHERE Rut_Cartera         = nsrutcart   AND
     		Nro_Documento       = nsnumdocu   AND
                Correlativo         = nscorrela   AND
                Seriado             = 'N'

   UPDATE       #temporal_mdcp
          SET   C_Moneda_Emision    = semonemi,
                Base_Emision        = sebasemi,
                Rut_Emisor          = serutemi,
                Tasa_Emision        = setasemi
          FROM  VIEW_SERIE_MASCARA
          WHERE Seriado             = 'S'         AND
           	Mascara             = semascara

   UPDATE    #temporal_mdcp
          SET   Moneda_Emision      = mnnemo
          FROM  VIEW_MONEDA
          WHERE C_Moneda_Emision    = mncodmon

   UPDATE       #temporal_mdcp
  	SET   Emisor              = emgeneric
        FROM  VIEW_EMISOR
        WHERE Rut_Emisor          = emrut


   -- Generación de los cupones (No Seriados).
   SELECT       'Rut_Cartera'          = Rut_Cartera,
                'Nro_Documento'        = Nro_Documento,
                'Correlativo'          = Correlativo,
                'Serie'                = Serie,
                'Mascara'              = Mascara,
                'Familia'              = Familia,
                'Rut_Emisor'           = Rut_Emisor,
                'Emisor'               = Emisor,
                'Fecha_Emision'        = Fecha_Emision,
                'Fecha_Vencimiento'    = Fecha_Vencimiento,
                'Seriado'              = Seriado,
                'Codigo_Instrumento'   = Codigo_Instrumento,
                'Nominal'              = Nominal,
                'Tasa_Emision'         = Tasa_Emision,
                'Tir_Compra'           = Tir_Compra,
                'Porc_VC'              = Porc_VC,
                'Valor_Compra'         = Valor_Compra,
                'Valor_Presente'       = Valor_Presente,
                'C_Moneda_Emision'     = C_Moneda_Emision,
                'Moneda_Emision'       = Moneda_Emision,
                'Base_Emision'         = Base_Emision,
                'Tipo_Operacion'       = Tipo_Operacion,
                'Cupon'                = Nominal,
                'Fecha_Vcto_Cupon'     = ISNULL(Fecha_Vencimiento,'19000101'),
                'Nro_Cupon'            = CONVERT( INTEGER, 1 ),
                'valor_pesos'          = valor_pesos,
                'Fecha_Pago'           = Fecha_Pago,
  		'BANCO'         = @ACNOMPROP
          INTO  #Reportes_Cupones
          FROM  #temporal_mdcp
          WHERE Seriado = 'N'


   -- Generación de los cupones (Seriados).
   INSERT INTO #Reportes_Cupones
          SELECT       Rut_Cartera,
                       Nro_Documento,
                       Correlativo,
                       Serie,
                       Mascara,
                       Familia,
                       Rut_Emisor,
                       Emisor,
                       Fecha_Emision,
                       ISNULL(Fecha_Vencimiento,'19000101'),
                       Seriado,
                       Codigo_Instrumento,
                       Nominal,
                       Tasa_Emision,
                       Tir_Compra,
                       Porc_VC,
                       Valor_Compra,
                       Valor_Presente,
                       C_Moneda_Emision,
                       Moneda_Emision,
                       Base_Emision,
                       Tipo_Operacion,
                       ROUND( Nominal * tdflujo / 100, 4 ),
                       ISNULL(CASE WHEN Codigo_Instrumento <> 20 THEN tdfecven
                            WHEN setipvcup = 'M'          THEN DATEADD( MONTH, (sepervcup * tdcupon), Fecha_Emision )
                            WHEN setipvcup = 'D'          THEN DATEADD(   DAY, (sepervcup * tdcupon), Fecha_Emision )
                            ELSE tdfecven
                       END,'19000101'),
   		       tdcupon,
   		       0,
   		       '',
  		       'BANCO'         = @ACNOMPROP
                 FROM  #temporal_mdcp, VIEW_SERIE_MASCARA, VIEW_TABLA_DESARROLLO_MASCARA
		   WHERE Seriado    = 'S'        AND
                       	 Mascara    = tdmascara  AND
                         Mascara    = semascara

   DELETE       #Reportes_Cupones 
          WHERE Fecha_Vcto_Cupon > @dFechaHasta    OR
                Fecha_Vcto_Cupon < @dFechaProceso

   DELETE       #Reportes_Cupones 
   WHERE Codigo_Instrumento = 20
   AND  (CHARINDEX('*',Serie) > 0 OR CHARINDEX('&',Serie) > 0)

--SELECT * FROM  #Reportes_Cupones 

   UPDATE #Reportes_Cupones
   set    fecha_pago = Fecha_Vcto_Cupon
   SELECT DISTINCT
      	Fecha_Vcto_Cupon,
   	fecha_pago,
   	sw=0
   INTO   #tempFecha
   FROM    #Reportes_Cupones
   WHILE 1=1
   BEGIN
 SELECT @sw = '*'
 SET ROWCOUNT 1
 SELECT @dFecVen = Fecha_Vcto_Cupon,
  	@dFecPAg = fecha_pago,
  	@sw = '1'
 FROM  #tempFecha
 WHERE sw=0
 SET ROWCOUNT 0
 IF @sw = '*' BREAK
 
 SELECT @fecha   = @dFecVen
 SELECT @fecha_habil = @dFecVen
 SELECT @fecha  = DATEADD(day,-1,@fecha)
 EXECUTE SP_BUSCA_FECHA_HABIL @fecha,1,@fecha_habil output
 SELECT @dFecPAg = @fecha_habil
 UPDATE #tempFecha
 SET fecha_pago =  @dFecPAg,
  sw=1
 WHERE  Fecha_Vcto_Cupon = @dFecVen
   END
   UPDATE #Reportes_Cupones
   SET    #Reportes_Cupones.fecha_pago = #tempFecha.fecha_pago
   FROM   #tempFecha
   WHERE  #Reportes_Cupones.Fecha_Vcto_Cupon = #tempFecha.Fecha_Vcto_Cupon
   
   UPDATE #Reportes_Cupones
   set    valor_pesos = cupon
   WHERE  C_Moneda_Emision = 999

   UPDATE #Reportes_Cupones
   set    valor_pesos = cupon * vmvalor
   FROM   VIEW_valor_moneda
   WHERE  C_Moneda_Emision <> 999
   AND    vmcodigo= C_Moneda_Emision
   AND    vmfecha = @cFechaHasta --fecha_pago

   IF ( SELECT COUNT(*) FROM #Reportes_Cupones) = 0
   BEGIN
         INSERT INTO #Reportes_Cupones
         SELECT        0,
                       0,
                       0,
                       '',
                       '',
                       '',
                       0,
                       '',
                       '',
                       '',
                       '',
                       0,
                       0,
                       0,
                       0,
                       0,
        	       0,
                       0,
                       0, --C_Moneda_Emision,
                       '',
                       0,
                       '',
                       0,
                       '',
                       0,
   		       0,
   		       '',
     		       'BANCO'         = @ACNOMPROP
   END
   SELECT          'Rut_Cartera'          = Rut_Cartera,
                   'Nro_Documento'        = Nro_Documento,
                   'Correlativo'          = Correlativo,
                   'Nro_Operacion'        = CONVERT( VARCHAR(10), Nro_Documento ) + '-' +
                                            RIGHT( '000' + CONVERT( VARCHAR(03), Correlativo ), 3 ),
                   'Serie'                = Serie,
                   'Mascara'              = Mascara,
                   'Familia'              = Familia,
                   'Rut_Emisor'           = Rut_Emisor,
                   'Emisor'               = Emisor,
                   'Fecha_Emision'        = CONVERT(CHAR(10), Fecha_Emision, 103 ),
                   'Fecha_Vencimiento'    = CONVERT(CHAR(10), Fecha_Vencimiento, 103 ),
                   'Seriado'              = Seriado,
                   'Codigo_Instrumento'   = Codigo_Instrumento,
                   'Nominal'              = Nominal,
                   'Tasa_Emision'         = Tasa_Emision,
                   'Tir_Compra'           = Tir_Compra,
                   'Porc_VC'              = Porc_VC,
                   'Valor_Compra'         = Valor_Compra,
                   'Valor_Presente'       = Valor_Presente,
                   'C_Moneda_Emision'     = C_Moneda_Emision,
                   'Moneda_Emision'       = Moneda_Emision,
                   'Base_Emision'         = Base_Emision,
                   'Tipo_Operacion'       = Tipo_Operacion,
                   'Cupon'                = Cupon,
                   'Fecha_Vcto_Cupon'     = ISNULL(CONVERT(CHAR(10), Fecha_Vencimiento, 103 ),'19000101'),
                   'Nro_Cupon'            = Nro_Cupon,
                   'Fecha_Proceso'        = CONVERT( CHAR(10), @dFechaProceso, 103 ),
                   'Fecha_Hasta'          = CONVERT( CHAR(10), @dFechaHasta, 103 ),
                   'Hora'                 = CONVERT( CHAR(08), GETDATE(), 108 ),
     		   'valor_pesos'          = valor_pesos,
       		   'fecha_pago'           = CONVERT( CHAR(10), fecha_pago, 103 ),
  		   'BANCO'                = @ACNOMPROP
          FROM     #Reportes_Cupones 
          ORDER BY Fecha_Vcto_Cupon
   DROP TABLE #temporal_mdcp
   DROP TABLE #Reportes_Cupones
   SET NOCOUNT OFF
END

GO
