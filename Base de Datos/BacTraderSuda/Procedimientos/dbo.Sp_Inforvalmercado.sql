USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Inforvalmercado]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Inforvalmercado]

(
    @cSistema     CHAR(3) = '',
    @cFecha       CHAR(8) = '',
    @cCartera     CHAR(1) = '',
    @vTitulo      VARCHAR(200) = '',
    @cDolar       CHAR(01)
)
AS
BEGIN
	SET NOCOUNT ON
	
	
	
	DECLARE @acfecproc DATETIME,
	        @hora CHAR(8),
	        @Inst CHAR(12),
	        @Numdocu NUMERIC(10),
	        @Numoper NUMERIC(10),
	        @Correla NUMERIC(03),
	        @Capital FLOAT,
	        @monemis NUMERIC(03),
	        @FecPag DATETIME,
	        @Instser CHAR(12),
	        @nTascont NUMERIC(8, 6),	--fLOAT,
	        
	        @Seriado CHAR(1),
	        @Fecemis DATETIME,
	        @nominal FLOAT,	--Numeric(19,4),
	        
	        @Fecpcup DATETIME,
	        @mascara CHAR(12),
	        @nCupon NUMERIC(03),
	        @dUltFecCup DATETIME,
	        @dFeccal DATETIME,
	        @dFec DATETIME,
	        @nValMoh FLOAT,
	        @nValMoPag FLOAT,
	        @nIntereses FLOAT,
	        @nreajustes FLOAT,
	        @xi INT,
	        @nConta INT,
	        @cInst CHAR(12),
	        @dFecucup DATETIME,
	        @Pervcup INT,
	        @acfecante DATETIME,
	        @fTasaMercado FLOAT,
	        @nValMercado NUMERIC(19, 4),
	        @IndVpm CHAR(1),
	        @dFeccomp DATETIME
	
	
	
	DECLARE @UF_HOY         FLOAT,
	        @IVP_HOY        FLOAT,
	        @DO_HOY         FLOAT,
	        @DA_HOY         FLOAT,
	        @tc_rep_cnt     CHAR(01),
	        @DO_TC          FLOAT
	
	
	
	SELECT @UF_HOY = ISNULL(vmvalor, 0.0000)
	FROM   VIEW_VALOR_MONEDA,
	       mdac
	WHERE  vmfecha = acfecproc
	       AND vmcodigo = 998
	
	SELECT @IVP_HOY = ISNULL(vmvalor, 0.0000)
	FROM   VIEW_VALOR_MONEDA,
	       mdac
	WHERE  vmfecha = acfecproc
	       AND vmcodigo = 997
	
	SELECT @DO_HOY = ISNULL(vmvalor, 0.0000)
	FROM   VIEW_VALOR_MONEDA,
	       mdac
	WHERE  vmfecha = acfecproc
	       AND vmcodigo = 994
	
	SELECT @DA_HOY = ISNULL(vmvalor, 0.0000)
	FROM   VIEW_VALOR_MONEDA,
	       mdac
	WHERE  vmfecha = acfecproc
	       AND vmcodigo = 995
	
	
	
	
	
	SELECT @DO_TC = ISNULL(Tipo_Cambio, 0)
	FROM   BacParamSuda..VALOR_MONEDA_CONTABLE,
	       MDAC
	WHERE  Codigo_Moneda = 994
	       AND Fecha = ACFECPROC
	
	
	
	--SELECT @DO_TC   = isnull(VMVALOR_TCRC,0)     /* Dolar T/C Rep. Contable */
	
	--FROM VIEW_VALOR_MONEDA, MDAC
	
	--WHERE VMCODIGO = 994 AND VMFECHA = ACFECPROC
	
	
	
	IF @DO_TC = 0
	BEGIN
	    SELECT @tc_rep_cnt = 'N' /* SE OCUPA T/C OBS */
	END
	ELSE
	BEGIN
	    SELECT @tc_rep_cnt = 'S' /* SE OCUPA T/C REP CONTABLE */
	END
	
	
	
	SELECT @acfecante = acfecante
	FROM   MDAC
	
	SELECT @acfecproc = @cFecha
	
	
	
	CREATE TABLE #Tmp
	(
		fecha                  DATETIME,	--01
		
		id_sistema             CHAR(03),	--02
		
		Numdocu                NUMERIC(10),	--03
		
		Numoper                NUMERIC(10),	--04
		
		Correla                NUMERIC(03),	--05
		
		Inst                   CHAR(12),	--06
		
		Cartera                CHAR(3),	--07
		
		RutEmi                 NUMERIC(9, 0),	--08
		
		Instser                CHAR(12),	--09
		
		monemis                NUMERIC(3),	--10
		
		Fecvcto                DATETIME,	--11
		
		Fecemis                DATETIME,	--12
		
		Factor                 FLOAT,	--13
		
		Numcont                NUMERIC(10),	--14
		
		Tasacont               NUMERIC(8, 6),	--15
		
		Fecpcup                DATETIME,	--16
		
		Fecucup                DATETIME,	--17
		
		Numucup                NUMERIC(05),	--18
		
		nominal                FLOAT,	--numeric(19,4),	--19
		
		Capital                FLOAT,	--numeric(19,4),	--20
		
		ValCup                 NUMERIC(19, 4),	--21
		
		Interes                NUMERIC(19, 4),	--22
		
		Reajuste               NUMERIC(19, 4),	--23
		
		ValMerc                NUMERIC(19, 4),	--24
		
		FecPag                 DATETIME,	--25
		
		codigo                 NUMERIC(10),	--26
		
		mascara                CHAR(12),	--27
		
		TasaMerc               FLOAT,	--28
		
		CartFin                char(05),	--29
		
		IndVpm                 CHAR(1),	--30
		
		Flag                   INT,	--31
		
		ID_NIVEL_DE_RIESGO     VARCHAR(2)
	)
	
	
	
	
	
	-- 1° Rescato cartera total CP + VI
	
	INSERT INTO #Tmp
	SELECT VALORIZACION_MERCADO.fecha_valorizacion,	--01
	       
	       VALORIZACION_MERCADO.id_sistema,	--02
	       
	       rmnumdocu,	--03
	       
	       rmnumoper,	--04
	       
	       rmcorrela,	--05
	       
	       inserie,	--06
	       
	       '100',	--07
	       
	       VALORIZACION_MERCADO.rut_emisor,	-- RutEmi	--08
	       
	       ISNULL(rminstser, ''),	--09
	       
	       moneda_emision,	--10
	       
	       Mdcp.Cpfecven,	--11
	       
	       Mdcp.cpfecemi,	--12
	       
	       0,	-- Factor Float,						--13
	       
	       Mdcp.Numero_Contrato,	--14
	       
	       Mdcp.Tasa_Contrato,	--15
	       
	       Mdcp.cpFecpcup,	--16
	       
	       Mdcp.cpfecucup,	--17
	       
	       Mdcp.cpnumucup,	--18
	       
	       valor_nominal,	--19
	       
	       MDCP.Valor_Contable,	--20
	       
	       0,	-- ValCupMOTLXP1						--21
	       
	       0,	-- Interes,								--22
	       
	       0,	-- Reajuste,								--23
	       
	       ISNULL(valor_mercado, 0.0),	--24
	       
	       CASE 
	            WHEN mdcp.cpfeccomp < CONVERT(DATETIME, '20070115') THEN MDCP.Fecha_PagoMañana
	            ELSE MDCP.cpfeccomp
	       END,	--25
	       
	       rmcodigo,	--26
	       
	       Mdcp.cpmascara,	--27
	       
	       ISNULL(tasa_mercado, 0.0),	--28
	       
	       MDCP.codigo_carterasuper, -->  .cptipcart,	--29
	       
	       CASE 
	            WHEN MDCP.Fecha_PagoMañana > @cFecha THEN 'S'
	            ELSE 'N'
	       END,	--30
	       
	       0,	--31
	       
	       VALORIZACION_MERCADO.ID_NIVEL_DE_RIESGO
	       
	       
	       
	       -- Sp_Inforvalmercado 'BTR', '20100803', 'T', 'VALORIZACION DE MERCADO','N'
	FROM   VALORIZACION_MERCADO,
	       MDCP,
	       VIEW_instrumento
	WHERE  VALORIZACION_MERCADO.id_sistema = @cSistema
	       AND VALORIZACION_MERCADO.fecha_valorizacion = @cFecha
	       AND VALORIZACION_MERCADO.tipo_operacion = 'CP'
	       AND VALORIZACION_MERCADO.rmnumdocu = mdcp.cpnumdocu
	       AND VALORIZACION_MERCADO.rmcorrela = mdcp.cpcorrela
	       AND VALORIZACION_MERCADO.rminstser = mdcp.cpinstser
	       AND VALORIZACION_MERCADO.rmcodigo = VIEW_instrumento.incodigo
	
	
	
	INSERT INTO #Tmp
	SELECT @cFecha,	--01
	       
	       @cSistema,	--02
	       
	       vinumdocu,	--03
	       
	       vinumoper,	--04
	       
	       vicorrela,	--05
	       
	       inserie,	--06
	       
	       '100',	--07		
	       
	       virutemi,	-- RutEmi		--08
	       
	       ISNULL(viinstser, ''),	--09
	       
	       vimonemi,	--10
	       
	       Cpfecven,	--11
	       
	       cpfecemi,	--12
	       
	       0,	-- Factor Float,		--13
	       
	       Mdcp.Numero_Contrato,	--14
	       
	       Mdcp.Tasa_Contrato,	--15
	       
	       cpFecpcup,	--16
	       
	       Mdcp.cpFecucup,	--17
	       
	       Mdcp.cpnumucup,	--18
	       
	       vinominal,	--0,--valor_nominal,
	       
	       mdvi.Valor_Contable,	--0,--MDCP.Valor_Contable,
	       
	       0.0,	-- ValCup
	       
	       0.0,	-- Interes,
	       
	       0.0,	-- Reajuste,
	       
	       (
	           SELECT ISNULL(Valor_mercado, 0.0)
	           FROM   Valorizacion_Mercado
	           WHERE  id_sistema             = @cSistema
	                  AND fecha_valorizacion = @cFecha
	                  AND tipo_operacion     = 'VI'
	                  AND rmnumdocu          = mdcp.cpnumdocu
	                  AND rmcorrela          = mdcp.cpcorrela
	                  AND rmnumoper          = vinumoper
	                  AND rminstser          = viinstser
	                  AND rmcodigo           = VIEW_instrumento.incodigo
	       ),
	       --0,--valor_mercado,
	       
	       CASE 
	            WHEN mdcp.cpfeccomp < CONVERT(DATETIME, '20070115') THEN MDCP.Fecha_PagoMañana
	            ELSE MDCP.cpfeccomp
	       END,
	       vicodigo,
	       Mdcp.cpmascara,
	       (
	           SELECT ISNULL(tasa_mercado, 0.0)
	           FROM   Valorizacion_Mercado
	           WHERE  id_sistema             = @cSistema
	                  AND fecha_valorizacion = @cFecha
	                  AND tipo_operacion     = 'VI'
	                  AND rmnumdocu          = mdcp.cpnumdocu
	                  AND rmcorrela          = mdcp.cpcorrela
	                  AND rmnumoper          = vinumoper
	                  AND rminstser          = viinstser
	                  AND rmcodigo           = VIEW_instrumento.incodigo
	       ),
	       mdcp.codigo_carterasuper, --> MDCP.cptipcart,
	       CASE 
	            WHEN MDCP.Fecha_PagoMañana > @cFecha THEN 'S'
	            ELSE 'N'
	       END,
	       0,
	       (
	           SELECT VALORIZACION_MERCADO.ID_NIVEL_DE_RIESGO
	           FROM   Valorizacion_Mercado
	           WHERE  id_sistema             = @cSistema
	                  AND fecha_valorizacion = @cFecha
	                  AND tipo_operacion     = 'VI'
	                  AND rmnumdocu          = mdcp.cpnumdocu
	                  AND rmcorrela          = mdcp.cpcorrela
	                  AND rmnumoper          = vinumoper
	                  AND rminstser          = viinstser
	                  AND rmcodigo           = VIEW_instrumento.incodigo
	       ) 
	       
	       
	       
	       -- Sp_Inforvalmercado 'BTR', '20100803', 'T', 'VALORIZACION DE MERCADO','N'
	FROM   Mdvi,
	       Mdcp,
	       VIEW_instrumento
	WHERE  vinumdocu = cpnumdocu
	       AND vicorrela = cpcorrela
	       AND viinstser = cpinstser 
	           
	           --					cpnominal=0 and
	       AND viinstser = cpinstser
	       AND vicodigo = incodigo 
	
	
	
	
	
	-- 2° Rescato Solo cartera CP
	
	INSERT INTO #Tmp
	SELECT VALORIZACION_MERCADO.fecha_valorizacion,
	       VALORIZACION_MERCADO.id_sistema,
	       rmnumdocu,
	       rmnumoper,
	       rmcorrela,
	       inserie,
	       '111',
	       VALORIZACION_MERCADO.Rut_Emisor,	-- RutEmi
	       
	       ISNULL(rminstser, ''),
	       moneda_emision,
	       Mdcp.Cpfecven,
	       Mdcp.cpfecemi,
	       0,	-- Factor Float,
	       
	       Mdcp.Numero_Contrato,
	       Mdcp.Tasa_Contrato,
	       Mdcp.cpFecpcup,
	       Mdcp.Cpfecucup,
	       Mdcp.cpnumucup,
	       valor_nominal,
	       MDCP.Valor_Contable,-- 17/01/2006 VGS eliminado ya que las ventas se rebajan inmediatamente de la cartera + Isnull((Select Sum(VALORCONTABLE) FROM tabla_ventas Where Numdocu = Mdcp.Cpnumdocu And Correla = Mdcp.Cpcorrela And tipo_listado = ''H'' and VENTAFECPAGO > @cFecha) ,0 ),
	
	0, -- ValCup
	
	0, -- Interes,
	
	0, -- Reajuste,
	
	ISNULL(valor_mercado, 0.0),
	
	CASE 
	     WHEN mdcp.cpfeccomp < CONVERT(DATETIME, '20070115') THEN MDCP.Fecha_PagoMañana
	     ELSE MDCP.cpfeccomp
	END,
	
	rmcodigo,
	
	Mdcp.cpmascara,
	
	ISNULL(tasa_mercado, 0.0),
	
	mdcp.codigo_carterasuper, --> MDCP.cptipcart,
	
	CASE 
	     WHEN MDCP.Fecha_PagoMañana > @cFecha THEN 'S'
	     ELSE 'N'
	END,
	
	0,
	
	VALORIZACION_MERCADO.ID_NIVEL_DE_RIESGO
	
	
	
	FROM VALORIZACION_MERCADO, Mdcp , VIEW_instrumento
	
	WHERE VALORIZACION_MERCADO.id_sistema = @cSistema 
	
	AND VALORIZACION_MERCADO.fecha_valorizacion = @cFecha 
	
	AND VALORIZACION_MERCADO.tipo_operacion = 'CP' 
	
	AND VALORIZACION_MERCADO.rmnumdocu = mdcp.cpnumdocu 
	
	AND VALORIZACION_MERCADO.rmcorrela = mdcp.cpcorrela 
	
	AND VALORIZACION_MERCADO.rminstser = mdcp.cpinstser 
	
	AND VALORIZACION_MERCADO.rmcodigo = VIEW_instrumento.incodigo
	
	
	
	-- 2° Rescato Solo cartera intermadiada VI
	
	INSERT INTO #Tmp
	SELECT VALORIZACION_MERCADO.fecha_valorizacion,
	       VALORIZACION_MERCADO.id_sistema,
	       rmnumdocu,
	       rmnumoper,
	       rmcorrela,
	       inserie,
	       '114',
	       VALORIZACION_MERCADO.Rut_Emisor,	-- RutEmi
	       
	       ISNULL(rminstser, ''),
	       moneda_emision,
	       Mdcp.Cpfecven,
	       Mdcp.cpfecemi,
	       0,	-- Factor Float,
	       
	       Mdcp.Numero_Contrato,
	       Mdcp.Tasa_Contrato,
	       Mdcp.cpFecpcup,
	       Mdcp.cpfecucup,
	       Mdcp.cpnumucup,
	       valor_nominal,
	       (
	           SELECT Valor_Contable
	           FROM   mdvi
	           WHERE  vinumdocu         = VALORIZACION_MERCADO.rmnumdocu
	                  AND vinumoper     = VALORIZACION_MERCADO.rmnumoper
	                  AND vicorrela     = VALORIZACION_MERCADO.rmcorrela
	                  AND viinstser     = VALORIZACION_MERCADO.rminstser
	       ),
	       0,	-- ValCup
	       
	       0,	-- Interes,
	       
	       0,	-- Reajuste,
	       
	       ISNULL(valor_mercado, 0.0),
	       CASE 
	            WHEN mdcp.cpfeccomp < CONVERT(DATETIME, '20070115') THEN MDCP.Fecha_PagoMañana
	            ELSE MDCP.cpfeccomp
	       END,
	       rmcodigo,
	       Mdcp.Cpmascara,
	       ISNULL(tasa_mercado, 0.0),
	       mdcp.codigo_carterasuper,--> MDCP.cptipcart,
	       'N',
	       0,
	       VALORIZACION_MERCADO.ID_NIVEL_DE_RIESGO
	FROM   VALORIZACION_MERCADO,
	       Mdcp,
	       VIEW_instrumento
	WHERE  VALORIZACION_MERCADO.id_sistema = @cSistema
	       AND VALORIZACION_MERCADO.fecha_valorizacion = @cFecha
	       AND VALORIZACION_MERCADO.tipo_operacion = 'VI'
	       AND VALORIZACION_MERCADO.rmnumdocu = mdcp.cpnumdocu
	       AND VALORIZACION_MERCADO.rmcorrela = mdcp.cpcorrela
	       AND VALORIZACION_MERCADO.rminstser = mdcp.cpinstser
	       AND VALORIZACION_MERCADO.rmcodigo = VIEW_instrumento.incodigo
	
	
	
	SELECT @dFec = DATEADD(mm, 1, @acfecproc)
	
	SELECT @dFec = @dFec + DATEPART(dd, @dFec)
	
	
	
	
	
	
	
	SELECT @xi = COUNT(*)
	FROM   #Tmp
	
	SELECT @nConta = 0
	
	WHILE @nConta <= @xi
	BEGIN
	    SELECT @Inst = '*'
	    
	    SET ROWCOUNT 1
	    
	    SELECT @Inst = ISNULL(Inst, '*'),
	           @Numdocu                     = Numdocu,
	           @Numoper                     = Numoper,
	           @Correla                     = Correla,
	           @Capital                     = Capital,
	           @monemis                     = monemis,
	           @FecPag                      = FecPag,
	           @Instser                     = Instser,
	           @nTascont                    = Tasacont,
	           @Seriado                     = (
	               SELECT inmdse
	               FROM   VIEW_instrumento
	               WHERE  incodigo          = codigo
	           ),
	           @Fecemis                     = Fecemis,
	           @nominal                     = nominal,
	           @Fecpcup                     = Fecpcup,
	           @cInst                       = Inst,
	           @dFecucup                    = Fecucup,
	           @nCupon                      = Numucup,
	           @mascara                     = Mascara,
	           @IndVpm                      = IndVpm,
	           @dFeccomp                    = (
	               SELECT cpfeccomp
	               FROM   MDCP
	               WHERE  cpnumdocu         = Numdocu
	                      AND cpcorrela     = Correla
	           )
	    FROM   #Tmp
	    WHERE  Flag                         = 0
	    
	    SET ROWCOUNT 0
	    
	    
	    
	    IF @Inst = '*'
	        BREAK
	    
	    
	    
	    SELECT @nIntereses = 0
	    
	    SELECT @nreajustes = 0
	    
	    --			SELECT @Nominal		= 0
	    
	    SELECT @dFeccal = ''
	    
	    SELECT @nCupon = 0
	    
	    SELECT @nCupon = 0
	    
	    SELECT @dUltFecCup = CONVERT(DATETIME, '')
	    
	    SELECT @Pervcup = CASE 
	                           WHEN @Seriado = 'S' THEN (
	                                    SELECT sepervcup
	                                    FROM   View_Serie
	                                    WHERE  Semascara = @mascara
	                                )
	                           ELSE 0
	                      END
	    
	    
	    
	    IF @Nominal <> 0
	    BEGIN
	        IF @Seriado = 'S'
	        BEGIN
	            IF @cInst <> 'LCHR'
	            BEGIN
	                SET ROWCOUNT 1
	                
	                SELECT @nCupon = ISNULL(tdcupon, 0),
	                       @dUltFecCup     = ISNULL(Tdfecven, '')
	                FROM   view_tabla_desarrollo
	                WHERE  tdmascara       = @mascara
	                       AND tdfecven < @Fecpcup
	                ORDER BY
	                       tdfecven DESC
	                
	                SET ROWCOUNT 0
	            END
	            ELSE
	            BEGIN
	                SELECT @dUltFecCup = @dFecucup
	            END
	            
	            
	            
	            SELECT @dUltFecCup = CASE 
	                                      WHEN @FecPAg > @dUltFecCup THEN @FecPAg
	                                      ELSE @dUltFecCup
	                                 END
	            
	            
	            
	            SELECT @dFeccal = (
	                       CASE 
	                            WHEN (
	                                     CHARINDEX('&', @Instser) > 0
	                                     OR CHARINDEX('*', @Instser) > 0
	                                 ) THEN @FecPag
	                            ELSE @dUltFecCup
	                       END
	                   )
	        END
	        ELSE
	        BEGIN
	            SELECT @dFeccal = @FecPag
	        END
	        
	        
	        
	        IF @tc_rep_cnt = 'S'
	           AND @monemis = 994
	        BEGIN
	            SELECT @nValMoh = ISNULL(Tipo_Cambio, 0)
	            FROM   BacParamSuda..VALOR_MONEDA_CONTABLE
	            WHERE  Codigo_Moneda     = @monemis
	                   AND Fecha         = @acfecproc
	            
	            SELECT @nValMoPag = ISNULL(Tipo_Cambio, 0)
	            FROM   BacParamSuda..VALOR_MONEDA_CONTABLE
	            WHERE  Codigo_Moneda     = @monemis
	                   AND Fecha         = (
	                           CASE 
	                                WHEN @dFeccomp < CONVERT(DATETIME, '20070115') THEN 
	                                     @FecPag
	                                ELSE @dFeccomp
	                           END
	                       )
	                       
	                       
	                       
	                       --SELECT @nValMoh		= (SELECT vmvalor_tcrc FROM VIEW_VALOR_MONEDA WHERE vmfecha=@acfecproc AND vmcodigo=@monemis)
	                       
	                       --SELECT @nValMoPag	= (SELECT vmvalor_tcrc FROM VIEW_VALOR_MONEDA WHERE vmfecha=(CASE WHEN @dFeccomp < CONVERT(DATETIME,'20070115') THEN @FecPag ELSE @dFeccomp END) AND vmcodigo=@monemis)
	        END
	        ELSE
	        BEGIN
	            SELECT @nValMoh = CASE 
	                                   WHEN @monemis IN (999, 13) THEN 1
	                                   ELSE ISNULL(
	                                            (
	                                                SELECT vmvalor
	                                                FROM   VIEW_VALOR_MONEDA
	                                                WHERE  vmfecha = @acfecproc
	                                                       AND vmcodigo = @monemis
	                                            ),
	                                            1
	                                        )
	                              END
	            
	            SELECT @nValMoPag = CASE 
	                                     WHEN @Monemis IN (999, 13) THEN 1
	                                     ELSE ISNULL(
	                                              (
	                                                  SELECT vmvalor
	                                                  FROM   VIEW_VALOR_MONEDA
	                                                  WHERE  vmfecha = (
	                                                             CASE 
	                                                                  WHEN @dFeccomp 
	                                                                       <
	                                                                       CONVERT(DATETIME, '20070115') THEN 
	                                                                       @FecPag
	                                                                  ELSE @dFeccomp
	                                                             END
	                                                         )
	                                                         AND vmcodigo = @monemis
	                                              ),
	                                              1
	                                          )
	                                END
	        END
	        
	        
	        
	        SELECT @Nominal = @Capital / @nValMoPag
	        
	        
	        
	        IF @IndVpm = 'S'
	            SELECT @dFeccal = @dFeccomp
	        
	        
	        
	        IF @monemis <> 13
	            SELECT @nIntereses = ROUND(
	                       (
	                           ((@Nominal * (@nTascont / 100)) / 360) * (DATEDIFF(dd, @dFeccal, @acfecproc) + 1)
	                       ) * @nValMoh,
	                       0
	                   )
	        ELSE
	            SELECT @nIntereses = ROUND(
	                       (
	                           ((@Nominal * (@nTascont / 100)) / 360) * (DATEDIFF(dd, @dFeccal, @acfecproc) + 1)
	                       ) * @nValMoh,
	                       2
	                   )
	        
	        
	        
	        SELECT @nreajustes = ROUND((@nValMoh - @nValMoPag) * @nominal, 0)
	    END
	    
	    
	    
	    UPDATE #Tmp
	    SET    ValCup          = 0,
	           interes         = @nIntereses,
	           Reajuste        = @nreajustes,
	           TasaMerc        = TasaMerc,
	           ValMerc         = ValMerc,
	           Flag            = 1
	    WHERE  Numdocu         = @Numdocu
	           AND Numoper     = @Numoper
	           AND Correla     = @Correla
	           AND Instser     = @Instser
	END
	
	
	
	-- Sp_Inforvalmercado 'BTR', '20100803', 'T', 'VALORIZACION DE MERCADO','N'
	
	
	
	SELECT 'Cartera' = cartera,
	       'Inst' = Inst,
	       'Instser' = Instser,
	       'Fecemis' = CASE 
	                        WHEN CONVERT(CHAR(10), Fecemis, 103) = '01/01/1900' THEN 
	                             '  /  /  '
	                        ELSE CONVERT(CHAR(10), Fecemis, 103)
	                   END,
	       'NOMINAL' = nominal,
	       'TasaMer' = TasaMerc,
	       'FACTOR' = CONVERT(FLOAT, 0.0),
	       'CAPITAL' = capital,
	       'reajustes' = reajuste,
	       'Intereses' = interes,
	       'Contable' = capital + reajuste + interes,
	       'Mercado' = ValMerc,
	       'Dife' = ValMerc -(capital + reajuste + interes),
	       'Cupon' = ValCup,
	       'fecproc' = @acfecproc,
	       'Hora' = CONVERT(CHAR(10), GETDATE(), 108),
	       'RutEmi' = RutEmi,
	       'CartFin' = tbglosa,
	       'IndVpm' = IndVpm,
	       banco         = acnomprop,
	       rut_banco     = acrutprop,
	       dig           = acdigprop,
	       ID_NIVEL_DE_RIESGO
	       
	       INTO #Salida
	FROM   #Tmp,
	       mdac,
	       view_tabla_general_detalle
	WHERE  tbcateg = 1111 --204
	       AND tbcodigo1 = CartFin
	
	
	
	IF EXISTS(
	       SELECT *
	       FROM   #SALIDA
	   )
	BEGIN
	    SELECT *,
	           'UF' = @uf_hoy,
	           'IVP' = @IVP_HOY,
	           'DOLAR_OBS' = @DO_HOY,
	           'DOLAR_ACU' = @DA_HOY
	    FROM   #SALIDA
	    ORDER BY
	           Inst,
	           cartera
	END
	ELSE
	BEGIN
	    SELECT 'Cartera' = SPACE(3),
	           'Inst' = SPACE(12),
	           'Instser' = SPACE(12),
	           'Fecemis' = '  /  /  ',
	           'NOMINAL' = CONVERT(NUMERIC(19, 4), 0),
	           'TasaMer' = CONVERT(FLOAT, 0),
	           'FACTOR' = CONVERT(FLOAT, 0.0),
	           'CAPITAL' = CONVERT(NUMERIC(19, 4), 0),
	           'reajustes' = CONVERT(NUMERIC(19, 4), 0),
	           'Intereses' = CONVERT(NUMERIC(19, 4), 0),
	           'Contable' = CONVERT(NUMERIC(19, 4), 0),
	           'Mercado' = CONVERT(NUMERIC(19, 4), 0),
	           'Dife' = CONVERT(NUMERIC(19, 4), 0),
	           'Cupon' = CONVERT(NUMERIC(19, 4), 0),
	           'fecproc' = @acfecproc,
	           'Hora' = CONVERT(CHAR(10), GETDATE(), 108),
	           'RutEmi' = CONVERT(NUMERIC(9), 0),
	           'CartFin' = CONVERT(CHAR(50), ''),
	           'IndVpm' = '',
	           banco                  = acnomprop,
	           rut_banco              = acrutprop,
	           dig                    = acdigprop,
	           ID_NIVEL_DE_RIESGO     = 0,
	           'UF' = @uf_hoy,
	           'IVP' = @IVP_HOY,
	           'DOLAR_OBS' = @DO_HOY,
	           'DOLAR_ACU' = @DA_HOY
	    FROM   mdac
	END
	
	
	
	
	
	-- Sp_Inforvalmercado 'BTR', '20100803', 'T', 'VALORIZACION DE MERCADO','N'
END


-- Base de Datos --
GO
