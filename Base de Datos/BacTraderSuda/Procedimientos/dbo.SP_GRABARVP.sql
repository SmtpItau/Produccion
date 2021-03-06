USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARVP]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABARVP]
(
    @nnumoper                    NUMERIC(10, 0),	-- numero de operaci½n de venta  
    @nrutcart                    NUMERIC(09, 0),	-- rut de la cartera  
    @ntipcart                    NUMERIC(05, 0),	-- codigo del tipo de cartera  
    @nnumdocu                    NUMERIC(10, 0),	-- numero del  documento  
    @ncorrela                    NUMERIC(03, 0),	-- correlativo de la operaci½n  
    @nnominal                    NUMERIC(19, 4),	-- nominales vENDidos  
    @ntir                        NUMERIC(19, 4),	-- tir de venta  
    @npvp                        NUMERIC(19, 2),	-- porcentaje valor par (v)  
    @nvpar                       NUMERIC(19, 8),	-- valor par (v)  
    @nvptirv                     FLOAT		   ,	-- valor presente a tir de venta (v)  
    @nnumucup                    NUMERIC(03, 0),	-- numero del œltimo cup½n vencido (v)  
    @nrutcli                     NUMERIC(09, 0),	-- rut del cliente (v)  
    @ncodcli                     NUMERIC(09, 0),	-- rut del cliente (v)  
    @cfecpro                     DATETIME	   ,	-- fecha de proces o (v)  
    @ntasest                     NUMERIC(09, 4),	-- tasa estimada (v)  
    @nmonemi                     NUMERIC(03, 0),	-- moneda del emISor  
    @nrutemi                     NUMERIC(09, 0),	-- rut del emISor  
    @ntasemi                     NUMERIC(09, 4),	-- tasa estimada  
    @nbasemi                     NUMERIC(03, 0),	-- base estimada  
    @ctipcust                    CHAR(01)	   ,	-- tipo de custodia  
    @nforpagi                    NUMERIC(05, 0),	-- forma de pago  
    @cretiro                     CHAR(01),	-- tipo de retiro  
    @cusuario                    CHAR(12),	-- usuario  
    @cterminal                   CHAR(12),	-- terminal  
    @cmascara                    CHAR(12),	--  familia del instrumento  
    @cinstser                    CHAR(12),	-- serie  
    @cgenemi                     CHAR(10),	-- generico del emISor  
    @cnemomon                    CHAR(05),	-- generico de la moneda  
    @cfecemi                     DATETIME,	-- fecha de emISi½n  
    @cfecven                     DATETIME,	-- fecha de venc imiento  
    @ncodigo                     NUMERIC(05, 0),	-- codigo de la familia  
    @ncorrvent                   INTEGER,	-- correlativo de ventas  
    @clave_dcv                   CHAR(10),	-- clave dcv  
    @codigo_carterasuper         CHAR(01),
    @tipo_cartera_financiera     CHAR(05),	--> CAMBIO EL LARGO DE 1 A 5 CARACTERES
    @mercado                     CHAR(01),
    @sucursal                    VARCHAR(05),
    @id_sIStema                  CHAR(03),
    @fecha_pagomañana            DATETIME,
    @laminas                     CHAR(01),
    @tipo_inversion              CHAR(01),
    @observ                      CHAR(70),
    @St                          CHAR(01),
    @Codigo_Libro                CHAR(06),
    @nValorCompraPM              FLOAT,	--> Agregado con Fines de Recalcular la Utilidad Para Operaciones PM. 22-07-2008.-  
    @nTirTran                    NUMERIC(19, 4) = 0,
    @nPvpTran                    NUMERIC(19, 4) = 0,
    @nVpTran                     NUMERIC(19, 4) = 0,
    @nDifTran_MO                 NUMERIC(19, 4) = 0,
    @nDifTran_CLP                NUMERIC(19, 0) = 0
)
AS
BEGIN
	SET NOCOUNT ON
	
	
	
	/*	
	
	BITACORA DE MODIFICACIONES
	
	
	
	FECHA INICIO	:	04-11-2015
	
	CAMBIOS			:	REQUERIMENTO LD1_035 CORP-ITAU - TASA DE CONTRATO
	
	AUTOR			:	CORPBANCA GRUPO 3
	
	FECHA TERMINO	:	04-11-2015
	
	*/
	
	
	
	
	
	DECLARE @nestado INTEGER
	DECLARE @fcontrol DATETIME
	DECLARE @dfecvtop DATETIME
	DECLARE @cTipoLchr CHAR(01)
	DECLARE @nRut NUMERIC(09, 0)
	DECLARE @ffactor FLOAT  
	DECLARE @fcapitalc NUMERIC(19, 4) -- capital de la compra MDDI actual  
	DECLARE @finteresc NUMERIC(19, 4) -- intereses de la compra MDDI actuales  
	DECLARE @freajustc NUMERIC(19, 4) -- reajustes de la compra MDDI actuales  
	DECLARE @fnominal NUMERIC(19, 4) -- nominales dISponibles MDDI actuales  
	DECLARE @ncapitalc NUMERIC(19, 4) -- nuevo capital dISponible  
	DECLARE @ninteresc NUMERIC(19, 4) -- nuevos intereses MDDI  
	DECLARE @nreajustc NUMERIC(19, 4) -- nuevos reajustes  MDDI  
	DECLARE @fvptirc NUMERIC(19, 4) -- valor presente MDDI actual  
	--* variables para obtener datos de la tabla MDCP  
	DECLARE @fcapitalo NUMERIC(19, 4) -- capital de la compra propia  
	DECLARE @fintereso NUMERIC(19, 4) -- intereses de la compra propia  
	DECLARE @freajusto NUMERIC(19, 4) -- reajustes de la compra propia  
	DECLARE @fnominalo NUMERIC(19, 4) -- nominales originales  
	DECLARE @fvalcomu NUMERIC(19, 4) -- capital  um de la compra propia  
	DECLARE @fvalcomp NUMERIC(19, 4) -- capital $$ de la compra propia  
	DECLARE @ncapitalo NUMERIC(19, 4) -- nuevo capital de la compra MDCP  
	DECLARE @nintereso NUMERIC(19, 4) -- nuevo intereses de la compra MDCP  
	DECLARE @nreajusto NUMERIC(19, 4) -- nuevo reajustes de la compra MDCP  
	DECLARE @nvalcomu NUMERIC(19, 4) -- nuevo capital um MDCP  
	DECLARE @nvalcomp NUMERIC(19, 4) -- nuevo capital $$ MDCP  
	DECLARE @nvalcompv NUMERIC(19, 4) -- capital $$ venta  
	DECLARE @nvalcomuv NUMERIC(19, 4) -- capital um venta  
	DECLARE @nvalcomuo NUMERIC(19, 4) -- nuevo capital um MDCP original  
	DECLARE @nvalcompo NUMERIC(19, 4) -- nuevo capital $$ MDCP original  
	DECLARE @nvalcompvo NUMERIC(19, 4) -- capital $$ venta  
	DECLARE @nvalcomuvo NUMERIC(19, 4) -- capital um venta  
	DECLARE @fvalcompo NUMERIC(19, 4) -- capital $$ venta  
	DECLARE @fvalcomuo NUMERIC(19, 4) -- capital um venta  
	DECLARE @nfeccompo DATETIME  
	DECLARE @ntircompo NUMERIC(8, 4)  
	DECLARE @nvparo NUMERIC(19, 8) --88  
	DECLARE @npvparo NUMERIC(8, 4)  
	DECLARE @ninteresv NUMERIC(19, 2) -- interes venta  
	DECLARE @nreajustv NUMERIC(19, 2) -- reajuste venta  
	DECLARE @nutilidad NUMERIC(19, 2) -- utilidad venta  
	DECLARE @nperdida NUMERIC(19, 2) -- perdida venta  
	DECLARE @cseriado CHAR(01)  
	DECLARE @calculo NUMERIC(19, 4)
	--** Calculos LCHR Emision Propia **--  
	DECLARE @fPrimadesco NUMERIC(19, 4) -- Prima o Descuento Hist¢rico  
	DECLARE @fValtasemio NUMERIC(19, 4) -- Valor Tasa Emmisi¢n Hist¢rico  
	DECLARE @nPrimadesco NUMERIC(19, 4) -- Prima o Descuento Hist¢rico  
	DECLARE @nValtasemio NUMERIC(19, 4) -- Valor Tasa Emmisi¢n Hist¢rico  
	DECLARE @nPrimadesv NUMERIC(19, 4)
	DECLARE @nPrimadesvo NUMERIC(19, 4)
	DECLARE @nValtasemv NUMERIC(19, 4)
	DECLARE @nPriDesAcum NUMERIC(19, 4)
	DECLARE @nPriDesDia NUMERIC(19, 4)
	DECLARE @nDifPriDesVta NUMERIC(19, 4)
	DECLARE @dFeccomp DATETIME
	DECLARE @dFecven DATETIME
	DECLARE @nValParVta NUMERIC(19, 4)
	DECLARE @fValmon_Hoy FLOAT
	DECLARE @nperdidaLetra NUMERIC(19, 4)
	DECLARE @var1 NUMERIC(19, 4)
	DECLARE @nutilidadLetra NUMERIC(19, 4)
	DECLARE @cTipo_Moneda_papel CHAR(01)
	DECLARE @nDecimal INTEGER
	-->		LD1_035 CALCULO A TASA DE CONTRATO
	
	DECLARE @tasa_contrato FLOAT
	DECLARE @nValcont NUMERIC(19, 4);	
	SET @nvalcont = 0.0
	DECLARE @fValcont NUMERIC(19, 4);	
	SET @fValcont = 0.0
	DECLARE @nValMerc NUMERIC(19, 4);	
	SET @nValMerc = 0.0
	DECLARE @fValMerc NUMERIC(19, 4);	
	SET @fValMerc = 0.0
	DECLARE @fValMercv NUMERIC(19, 4);	
	SET @fValMercv = 0.0
	DECLARE @nValContv NUMERIC(19, 4);	
	SET @nValContv = 0.0
	DECLARE @nMtmAyer NUMERIC(19, 2);	
	SET @nMtmAyer = 0.0
	DECLARE @nValMcdo FLOAT;			
	SET @nValMcdo = 0.0
	DECLARE @nIntTCOntrato NUMERIC(21, 4);	
	SET @nIntTCOntrato = 0.0
	DECLARE @valor_moneda_hoy FLOAT;			
	SET @valor_moneda_hoy = 0.0
	DECLARE @valor_moneda_fecha_p FLOAT;			
	SET @valor_moneda_fecha_p = 0.0
	DECLARE @FechaPagoOriginal DATETIME;		
	SET @FechaPagoOriginal = (
	        SELECT acfecproc
	        FROM   BacTraderSuda.dbo.mdac WITH(NOLOCK)
	    )
	
	DECLARE @valor_moneda_PagoVta FLOAT;			
	SET @valor_moneda_PagoVta = 0.0
	
	DECLARE @fecha_hoy DATETIME;		
	SET @fecha_hoy = (
	        SELECT acfecproc
	        FROM   BacTraderSuda.dbo.mdac WITH(NOLOCK)
	    )
	
	DECLARE @dias NUMERIC(5);		
	SET @dias = 0.0
	
	DECLARE @fecha_pago DATETIME;		
	SET @fecha_pago = ''
	
	DECLARE @dTmpFechaCase DATETIME;		
	SET @dTmpFechaCase = '20070115'
	
	DECLARE @valor_cont_um FLOAT;			
	SET @valor_cont_um = 0.0
	
	DECLARE @valor_cont_hoy FLOAT;			
	SET @valor_cont_hoy = 0.0
	
	
	
	DECLARE @nreajustv_itau NUMERIC(19, 2);	
	SET @nreajustv_itau = 0.0 -- reajuste venta  
	
	DECLARE @ninteresv_itau NUMERIC(19, 2);	
	SET @ninteresv_itau = 0.0 -- interes venta  
	-->		LD1_035 CALCULO A TASA DE CONTRATO
	SELECT @nRut = acrutprop,
	       @cTipoLchr         = '',
	       @fValmon_Hoy       = 0.0,
	       @nPrimadesv        = 0,
	       @nValtasemv        = 0,
	       @nPriDesDia        = 0,
	       @nPriDesAcum       = 0,
	       @nValParVta        = 0,
	       @nDifPriDesVta     = 0
	FROM   MDAC
	SELECT @cTipo_Moneda_papel = CASE 
	                                  WHEN mnmx = 'C' THEN '0'
	                                  ELSE '1'
	                             END,
	       @nDecimal     = mndecimal
	FROM   VIEW_MONEDA
	WHERE  mncodmon      = @nmonemi
	
	
	
	-->     Se Agrego 22-07-2008.- Para Reemplazar la "CASE WHEN .... " en cada uno de los Redondeos mas abajo.-  
	
	DECLARE @nRedondeo NUMERIC(9)
	
	SET @nRedondeo = CASE 
	                      WHEN @cTipo_Moneda_papel = '0' THEN @nDecimal
	                      ELSE 0
	                 END
	
	
	
	SELECT @fcapitalc = dicapitalc,
	       @finteresc        = diinteresc,
	       @freajustc        = direajustc,
	       @fnominal         = CASE 
	                        WHEN @St = 'S' THEN dinominal + @nnominal
	                        ELSE dinominal
	                   END,
	       @fvptirc          = divptirc
	       
	       ------  LD1_035				------
	       ,
	       @fValMerc         = divpmcd100,
	       @fValcont         = valor_contable
	       
	       ------  LD1_035				------
	FROM   MDDI
	WHERE  @nrutcart         = dirutcart
	       AND @nnumdocu     = dinumdocu
	       AND @ncorrela     = dicorrela
	DECLARE @nNominalDisp NUMERIC(19, 4)
	
	SET @nNominalDisp = @fnominal
	
	
	
	-- *******************************************************************************  
	
	-- * calculo del factor, nuevo capital, rejustes, intereses y valor presente MDDI*  
	
	-- *******************************************************************************  
	
	DECLARE @ValorPrenteT0 FLOAT; -- VB+-08/05/2009 Recibira monto T0 de ventas PM  
	
	SET @ValorPrenteT0 = @fvptirc; -- VB+-08/05/2009 Asignacion de Valor Presente T0 de ventas PM  
	
	
	
	SET @ffactor = 1.00 -(
	        @nnominal / CASE 
	                         WHEN @fnominal = 0 THEN 1
	                         WHEN @fnominal IS NULL THEN 1
	                         ELSE @fnominal
	                    END
	    )
	
	SET @ncapitalc = ROUND(@fcapitalc * @ffactor, 0)
	
	SET @ninteresc = ROUND(@finteresc * @ffactor, 0)
	
	SET @nreajustc = ROUND(@freajustc * @ffactor, 0)
	
	------  LD1_035				------
	
	SET @nValcont = ROUND(@fValcont * @ffactor, 0)
	
	SET @nValMerc = ROUND(@fValMerc * @ffactor, 0)
	
	------  LD1_035				------
	
	
	
	IF @ffactor <> 0
	    SET @ValorPrenteT0 = @fvptirc - ROUND(@fvptirc * @ffactor, 0); -- VB+-08/05/2009 Asignacion de Valor Presente T0 de ventas PM
	
	
	
	SET @fvptirc = ROUND(@fvptirc * @ffactor, 0)
	
	
	
	IF @St = ''
	BEGIN
	    UPDATE MDDI
	    SET    dinominal          = dinominal - @nnominal,
	           dicapitalc         = @ncapitalc,
	           diinteresc         = @ninteresc,
	           direajustc         = @nreajustc,
	           divptirc           = @fvptirc
	           
	           --		divptirc		= @ncapitalc + @ninteresc + @nreajustc  
	           
	           ------  LD1_035				------
	           ,
	           divpmcd100         = @nValMerc,
	           Valor_Contable     = @nvalcont
	           
	           ------  LD1_035				------
	    WHERE  @nrutcart          = dirutcart
	           AND @nnumdocu      = dinumdocu
	           AND @ncorrela      = dicorrela
	END
	
	
	
	SELECT @fcapitalo = cpcapitalc,
	       @fintereso             = cpinteresc,
	       @freajusto             = cpreajustc,
	       @fvalcomu              = cpvalcomu,
	       @fvalcomp              = cpvalcomp,
	       @fvalcomuo             = valor_compra_um_original,
	       @fvalcompo             = valor_compra_original,
	       @nfeccompo             = fecha_compra_original,
	       @ntircompo             = tir_compra_original,
	       @nvparo                = valor_par_compra_original,
	       @npvparo               = porcentaje_valor_par_compra_original,
	       @cseriado              = cpseriado,
	       @cTipoLchr             = cptipoletra,
	       @fprimadesco           = cpprimadesc,
	       @fvaltasemio           = cpvaltasemi,
	       @dFeccomp              = ISNULL(cpfeccomp, ''),
	       @dFecven               = ISNULL(cpfecven, '')
	       
	       
	       
	       ------  LD1_035		------
	       ,
	       @tasa_contrato         = ISNULL(Tasa_Contrato, 0.0),
	       @fValcont              = valor_contable,
	       @fValMerc              = cpvcum100,
	       @FechaPagoOriginal     = Fecha_PagoMañana,
	       @fecha_pago            = CASE 
	                          WHEN cpseriado = 'N' THEN CASE 
	                                                         WHEN cpfeccomp < @dTmpFechaCase THEN 
	                                                              fecha_PagoMañana
	                                                         ELSE cpfeccomp
	                                                    END
	                          WHEN CHARINDEX('*', cpinstser) > 0 
	                               
	                               OR CHARINDEX('&', cpinstser) > 0 THEN CASE 
	                                                                          WHEN 
	                                                                               cpfeccomp 
	                                                                               <
	                                                                               @dTmpFechaCase THEN 
	                                                                               fecha_PagoMañana
	                                                                          ELSE 
	                                                                               cpfeccomp
	                                                                     END
	                          ELSE CASE 
	                                    WHEN cpfecucup < cpfeccomp THEN CASE 
	                                                                         WHEN 
	                                                                              cpfeccomp 
	                                                                              <
	                                                                              @dTmpFechaCase THEN 
	                                                                              fecha_PagoMañana
	                                                                         ELSE 
	                                                                              cpfeccomp
	                                                                    END
	                                    ELSE cpfecucup
	                               END
	                     END
	       
	       ------  LD1_035		------
	FROM   MDCP
	WHERE  @nrutcart = cprutcart
	       AND @nnumdocu = cpnumdocu
	       AND @ncorrela = cpcorrela
	SELECT @ncapitalo = ROUND(@fcapitalo * @ffactor, @nRedondeo)
	SELECT @nintereso = ROUND(@fintereso * @ffactor, @nRedondeo)
	SELECT @nreajusto = ROUND(@freajusto * @ffactor, @nRedondeo)
	SELECT @nvalcomu = ROUND(@fvalcomu * @ffactor, 4)
	SELECT @nvalcomp = ROUND(@fvalcomp * @ffactor, @nRedondeo)
	SELECT @nvalcomuo = ROUND(@fvalcomuo * @ffactor, 4)
	SELECT @nvalcompo = ROUND(@fvalcompo * @ffactor, @nRedondeo)
	SELECT @nprimadesco = ROUND(@fprimadesco * @ffactor, 0)
	SELECT @nvaltasemio = ROUND(@fvaltasemio * @ffactor, 0)
	------  LD1_035		------
	
	SELECT @nvalcont = ROUND(@fValcont * @ffactor, @nRedondeo)
	
	SELECT @nValMerc = ROUND(@fValMerc * @ffactor, @nRedondeo)
	
	------  LD1_035		------
	
	
	
	UPDATE MDCP
	SET    cpnominal = cpnominal - @nnominal,
	       cpcapitalc = @ncapitalo,
	       cpinteresc = @nintereso,
	       cpreajustc = @nreajusto,
	       --		cpvalcomp				= CASE	WHEN (@nRutemi=@nRut and @nCodigo=20 and @ffactor<1) THEN @nvaltasemio-@nprimadesco
	       
	       --										ELSE  @nvalcomp  END ,  /*	Para que calcule capital correcto para las ventas de letras parciales,
	       
	       --																	ya que no estaba sumando o  restando la prima o descto. respectivamente.*/
	       
	       cpvalcomp = @nvalcomp,
	       cpvalcomu = @nvalcomu,
	       valor_compra_original = @nvalcompo,
	       valor_compra_um_original = @nvalcomuo,
	       --		cpvptirc				= @ncapitalo + @nintereso + @nreajusto,  
	       
	       cpvptirc = @fvptirc,
	       cpprimadesc = @nprimadesco,
	       cpvaltasemi = @nvaltasemio,
	       cpprimdescacum = CASE 
	                             WHEN (@nRutemi = @nRut AND @nCodigo = 20 AND @ffactor < 1) THEN 
	                                  ROUND((@nprimadesco / (DATEDIFF(DAY, @dFeccomp, @dFecven))), 0)
	                                  * (DATEDIFF(DAY, @dFeccomp, @cfecpro))
	                             ELSE 0
	                        END /* se agreg¢ para calcular prima descuento acumulada diariamente de ventas parciales  
	       
	       ,ya que al momento de vender no estaba descontando y lo hac¡a solo al inicio del d¡a   
	       
	       siguiente en el procedimiento sp_actualiza_cartera*/ 
	       
	       ------  LD1_035		------
	       ,
	       Valor_Contable = @nvalcont,
	       cpvcum100 = @nValMerc
	       
	       ------  LD1_035		------
	WHERE  @nrutcart = cprutcart
	       AND @nnumdocu = cpnumdocu
	       AND @ncorrela = cpcorrela

    SET @nvalcompv = ROUND(@fvalcomp - @nvalcomp, @nRedondeo)
	SET @nvalcomuv = ROUND(@fvalcomu - @nvalcomu, 4)
	SET @nvalcompvo = ROUND(@fvalcompo - @nvalcompo, @nRedondeo)
	SET @nvalcomuvo = ROUND(@fvalcomuo - @nvalcomuo, 4)
	SET @ninteresv = ROUND(@fintereso - @nintereso, @nRedondeo)
	SET @nreajustv = ROUND(@freajusto - @nreajusto, 0)
	SET @nprimadesv = ROUND(@fprimadesco - @nprimadesco, 0)
	SET @nvaltasemv = ROUND(@fvaltasemio - @nvaltasemio, 0)
	SET @nperdida = 0.0  
	SET @nutilidad = 0.0 

	------  LD1_035		------
	
	SET @nValContv = @fValcont - @nvalcont
	
	SET @fValMercv = @fValMerc - @nValMerc
	
	------  LD1_035		------
	
	
	
	------  LD1_035		------
	
	DECLARE @iFound INT
	
	SET @iFound = -1
	
	SELECT @iFound = 1,
	       @nMtmAyer              = ISNULL(diferencia_mercado, 0),
	       @nValMcdo              = ISNULL(valor_mercado, 0)
	FROM   BacTraderSuda.dbo.Valorizacion_Mercado WITH(NOLOCK)
	WHERE  fecha_valorizacion     = (
	           SELECT acfecante
	           FROM   BacTraderSuda.dbo.mdac WITH(NOLOCK)
	       )
	       AND rmnumdocu          = @nnumdocu
	       AND rmcorrela          = @ncorrela
	       AND tipo_operacion     = 'CP'
	
	
	
	IF @iFound = 1
	BEGIN
	    SET @nMtmAyer = ROUND(@nMtmAyer -(@nMtmAyer * @ffactor), 0)
	    
	    SET @nValMcdo = ROUND(@nValMcdo -(@nValMcdo * @ffactor), 0)
	END
	
	
	
	SET @valor_moneda_hoy = 1.0
	
	SET @valor_moneda_fecha_p = 1.0
	
	SET @valor_moneda_PagoVta = 1.0
	
	
	
	IF (@nmonemi <> 999)
	   AND (@nmonemi <> 13)
	BEGIN
	    SET @valor_moneda_hoy = (
	            SELECT vmvalor
	            FROM   BacParamSuda.dbo.Valor_Moneda WITH(NOLOCK)
	            WHERE  vmfecha          = (
	                       SELECT acfecproc
	                       FROM   BacTraderSuda.dbo.Mdac WITH(NOLOCK)
	                   )
	                   AND vmcodigo     = @nmonemi
	        )
	    
	    SET @valor_moneda_fecha_p = (
	            SELECT vmvalor
	            FROM   BacParamSuda.dbo.Valor_Moneda WITH(NOLOCK)
	            WHERE  vmfecha          = @FechaPagoOriginal
	                   AND vmcodigo     = @nmonemi
	        )
	    
	    SET @valor_moneda_PagoVta = (
	            SELECT vmvalor
	            FROM   BacParamSuda.dbo.Valor_Moneda WITH(NOLOCK)
	            WHERE  vmfecha          = @fecha_pagomañana
	                   AND vmcodigo     = @nmonemi
	        )
	END
	
	
	
	SET @fecha_hoy = @cfecpro
	
	SET @dias = DATEDIFF(d, @fecha_pago, @fecha_hoy)
	
	
	
	SET @valor_moneda_fecha_p = CASE 
	                                 WHEN @valor_moneda_fecha_p = 0 THEN 1.0
	                                 ELSE @valor_moneda_fecha_p
	                            END
	
	SET @valor_cont_um = @nValContv / CASE 
	                                       WHEN @valor_moneda_fecha_p = 0 THEN 1
	                                       ELSE @valor_moneda_fecha_p
	                                  END
	
	SET @valor_cont_hoy = @valor_cont_um * @valor_moneda_PagoVta
	
	
	
	SET @nreajustv_itau = ROUND(@valor_cont_hoy - @nValContv, 0)
	
	SET @ninteresv_itau = ROUND(
	        (@valor_cont_um * @tasa_contrato * (@dias) / 36000) * @valor_moneda_PagoVta,
	        0
	    )
	
	------  LD1_035		------
	
	
	
	
	
	-->     Se Agrego 22-07-2008.- Para Reemplazar la Fecha de Calculo de variable '@nPriDesAcum' y '@fValmon_Hoy'  
	
	DECLARE @dFechaCalculoPrima DATETIME  
	
	SET @dFechaCalculoPrima = CASE 
	                               WHEN @cFecpro = @fecha_pagomañana THEN @cFecpro
	                               ELSE @fecha_pagomañana
	                          END  
	
	
	
	DECLARE @swPagoMañana INT
	
	SET @swPagoMañana = CASE 
	                         WHEN @cFecpro = @fecha_pagomañana THEN 0
	                         ELSE 1
	                    END
	
	
	
	IF @nRutemi = @nRut
	   AND @nCodigo = 20
	BEGIN
	    IF @nmonemi = 999
	        /* Se debe validad la moneda de emision ya que el 2004 se emitieron letras en Pesos VGS 09/02/2005 */  
	        
	        SET @fValmon_Hoy = 1
	    ELSE
	        SELECT @fValmon_Hoy = vmvalor
	        FROM   VIEW_VALOR_MONEDA
	        WHERE  vmcodigo        = @nMonemi
	               AND vmfecha     = @dFechaCalculoPrima
	    
	    
	    
	    SET @nPrimadesv = ROUND(@fPrimadesco - @nPrimadesco, 0)  
	    SET @nPrimadesvo = ROUND(@nPrimadesv, 0)  
	    SET @nValtasemv = ROUND(@fValtasemio - @nValtasemio, 0) 
	    
	    
	    
	    --  SELECT @nPriDesDia = ROUND(@fPrimadesco/DATEDIFF(DAY,@dFeccomp,@dFecven),0) antes  
	    SET @nPriDesDia = ROUND(@nPrimadesv / DATEDIFF(DAY, @dFeccomp, @dFecven), 0)
	    /* Correcci¢n para que calcule bien prima o descuento para venta de letras parciales*/  
	    
	    
	    
	    SET @nPriDesAcum = ROUND(@nPriDesDia * DATEDIFF(DAY, @dFeccomp, @dFechaCalculoPrima),
	            0
	        )
	    
	    SET @nValParVta = ROUND(((@nNominal * @nVpar) / 100.0) * @fValmon_Hoy, 0)
	    
	    SET @calculo = CASE 
	                        WHEN @nPrimadesv > 0 THEN @nPrimadesv
	                        ELSE (@nPrimadesv)
	                   END
	    
	    SET @nDifPriDesVta = ROUND(@nVptirv -(@nValParVta - @calculo), 0)
	    
	    SET @nDifPriDesVta = ROUND(@nDifPriDesVta, 0)
	    
	    SET @nPrimadesv = ROUND(@nPrimadesv - @nPriDesAcum, 0)  
	    
	    SET @var1 = ROUND(@nValparvta + @nPrimadesv, 0)
	END
	ELSE
	BEGIN
	    SET @nPrimadesvo = 0  
	    
	    SET @nDifPriDesVta = 0  
	    
	    SET @var1 = ROUND(@nvalcompv + @ninteresv + @nreajustv, 0)  
	    
	    SET @var1 = CASE 
	                     WHEN @fecha_pagomañana <> @cfecpro THEN @nValorCompraPM
	                     ELSE @var1
	                END
	END
	
	
	
	IF @nvptirv > @var1
	BEGIN
	    IF @nRutemi = @nRut
	       AND @nCodigo = 20
	    BEGIN
	        SET @nutilidad = @nvptirv -(@nValparvta + @nPrimadesv) -- ( @nvalcompv + @ninteresv + @nreajustv )
	        
	        SET @nperdida = 0.0
	        
	        
	        
	        IF @nutilidad > 0
	        BEGIN
	            SET @nutilidadLetra = ROUND(@nutilidad, 0)  
	            
	            SET @nperdidaLetra = 0.0
	        END
	        ELSE
	        BEGIN
	            SET @nperdidaLetra = ROUND(@nutilidad, 0)  
	            
	            SET @nutilidadLetra = 0.0
	        END
	    END
	    ELSE
	    BEGIN
	        SET @nutilidad = ROUND(
	                @nvptirv -(@nvalcompv + @ninteresv + @nreajustv),
	                @nRedondeo
	            )  
	        
	        SET @nperdida = 0.0  
	        
	        SET @nutilidad = CASE 
	                              WHEN @fecha_pagomañana <> @cfecpro THEN ROUND(@nvptirv - @nValorCompraPM, @nRedondeo)
	                              ELSE @nutilidad
	                         END
	    END
	    
	    ----
	END
	ELSE
	BEGIN
	    IF @nRutemi = @nRut
	       AND @nCodigo = 20
	    BEGIN
	        SET @nutilidadLetra = 0.0  
	        
	        SET @nperdida = @nvptirv -(@nValparvta + @nPrimadesv)  
	        
	        IF @nperdida > 0
	        BEGIN
	            SET @nutilidadLetra = @nperdida  
	            
	            SET @nperdidaLetra = 0.0
	        END
	        ELSE
	        BEGIN
	            SET @nperdidaLetra = ROUND(@nperdida, 0)
	        END
	    END
	    ELSE
	    BEGIN
	        SET @nutilidad = 0.0  
	        
	        SET @nperdida = ROUND(
	                @nvptirv -(@nvalcompv + @ninteresv + @nreajustv),
	                @nRedondeo
	            )  
	        
	        SET @nperdida = CASE 
	                             WHEN @fecha_pagomañana <> @cfecpro THEN ROUND(@nvptirv - @nValorCompraPM, @nRedondeo)
	                             ELSE @nperdida
	                        END
	    END
	END
	
	
	
	--> Ventas AFS
	
	DECLARE @nDif NUMERIC(21, 4);	
	
	SET @nDif = CASE 
	                 WHEN @nutilidad > 0 THEN @nutilidad
	                 ELSE CASE 
	                           WHEN @nperdida < 0 THEN @nperdida
	                           ELSE (@nperdida * -1)
	                      END
	            END
	
	
	
	DECLARE @Resultado_Dif_Precio NUMERIC(21, 4);	
	SET @Resultado_Dif_Precio = 0.0
	
	DECLARE @Resultado_Dif_Mercado NUMERIC(21, 4);	
	SET @Resultado_Dif_Mercado = 0.0
	
	DECLARE @nValMercadoProporcional NUMERIC(21, 4);	
	SET @nValMercadoProporcional = 0.0
	
	
	
	EXECUTE BacTraderSuda.dbo.sp_fx_utilidad_venta 'BTR'
	
	, @nnumdocu
	
	, @ncorrela
	
	, @nnominal
	
	, @nvptirv
	
	, @nDif
	
	, @Resultado_Dif_Precio OUTPUT
	
	, @Resultado_Dif_Mercado OUTPUT
	
	--> Ventas AFS
	
	
	
	INSERT INTO MDMO
	  (
	    mofecpro,	--1
	    morutcart,	--2
	    motipcart,	--3
	    monumdocu,	--4
	    mocorrela,	--5
	    monumdocuo,	--6
	    mocorrelao,	--7
	    monumoper,	--8
	    motipoper,	--9
	    motipopero,	--10
	    moinstser,	--11
	    momascara,	--12
	    mocodigo,	--13
	    mofecemi,	--14
	    mofecven,	--15
	    momonemi,	--16
	    motasemi,	--17
	    mobasemi,	--18
	    morutemi,	--19
	    monominal,	--20
	    monumucup,	--21
	    motir,	--22
	    mopvp,	--23
	    movpar,	--24
	    motasest,	--25
	    moforpagi,	--26
	    mocondpacto,	--27
	    morutcli,	--28
	    mocodcli,	--29O
	    motipret,	--30
	    mohora,	--31
	    mousuario,	--32
	    moterminal,	--33
	    mocapitali,	--34
	    movpreseni,	--35
	    movalcomp,	--36
	    movalcomu,	--37
	    mointeres,	--38
	    moreajuste,	--39
	    moutilidad,	--40
	    moperdida,	--41
	    movalven,	--42		-->	
	    movpresen,	--43
	    moseriado,	--44
	    mocorvent,	--45
	    moclave_dcv,	--46
	    modcv,	--47
	    fecha_compra_original,
	    valor_compra_original,
	    valor_compra_um_original,
	    tir_compra_original,
	    valor_par_compra_original,
	    porcentaje_valor_par_compra_original,
	    codigo_carterasuper,
	    tipo_cartera_financiera,
	    mercado,
	    sucursal,
	    id_sIStema,
	    fecha_pagomañana,
	    laminas,
	    tipo_inversion,
	    cuenta_corriente_inicio,
	    cuenta_corriente_final,
	    sucursal_inicio,
	    sucursal_final,
	    motipoletra,
	    moobserv,
	    moprimadesc,
	    movaltasemi,
	    MtoCompraPM,
	    MtoVentaPM,
	    PagoMañana,
	    SorteoLchr,
	    id_libro,
	    movalant,
	    momtoCCE,	-- se utiliza para Perfiles de Ventas PM  
	    moTirTran,
	    moPvpTran,
	    moVPTran,
	    moDifTran_MO,
	    moDifTran_CLP,
	    Resultado_Dif_Precio,	--> Ventas AFS
	    
	    Resultado_Dif_Mercado,	--> Ventas AFS
	    
	    ValorMercado_prop --> Ventas AFS
	  )
	VALUES
	  (
	    @cfecpro,
	    @nrutcart,
	    @ntipcart,
	    @nnumdocu,
	    @ncorrela,
	    @nnumdocu,
	    @ncorrela,
	    @nnumoper,
	    'VP',
	    'CP',
	    @cinstser,
	    @cmascara,
	    @ncodigo,
	    @cfecemi,
	    @cfecven,
	    @nmonemi,
	    @ntasemi,
	    @nbasemi,
	    @nrutemi,
	    @nnominal,
	    @nnumucup,
	    @ntir,
	    @npvp,
	    @nvpar,
	    @ntasest,
	    @nforpagi,
	    ' ',
	    @nrutcli,
	    @ncodcli,
	    @cretiro,
	    CONVERT(CHAR(08), GETDATE(), 114),
	    @cusuario,
	    @cterminal,
	    @nDifPriDesVta,	--** Aqui Pones Caluclos @nDifPriDesVta para LCHR Emisi¢n Propia **-  
	    
	    @nPrimadesvo,	--** Respaldo Descuento o Prima para Anulaciones **-- 
	    
	    ISNULL(@nvalcompv, 0),
	    ISNULL(@nvalcomuv, 0),
	    ISNULL(@ninteresv, 0),
	    ISNULL(@nreajustv, 0),
	    CASE 
	         WHEN @nRutemi = @nRut AND @nCodigo = 20 THEN ISNULL(@nutilidadLetra, 0)
	         ELSE ISNULL(@nutilidad, 0)
	    END,
	    CASE 
	         WHEN @nRutemi = @nRut AND @nCodigo = 20 THEN ISNULL(@nperdidaLetra * -1, 0)
	         ELSE ISNULL(@nperdida, 0)
	    END,
	    ISNULL(@nvptirv, 0),
	    CASE 
	         WHEN @nRutemi = @nRut AND @nCodigo = 20 THEN ROUND(@nValparvta, 0)
	         ELSE ISNULL(@nvalcompv + @ninteresv + @nreajustv, 0)
	    END,
	    @cseriado,
	    @ncorrvent,
	    @clave_dcv,
	    @ctipcust,
	    @nfeccompo,
	    @nvalcompvo,
	    @nvalcomuvo,
	    @ntircompo,
	    @nvparo,
	    @npvparo,
	    @codigo_carterasuper,
	    @tipo_cartera_financiera,
	    @mercado,
	    @sucursal,
	    @id_sIStema,
	    @fecha_pagomañana,
	    @laminas,
	    @tipo_inversion,
	    '',
	    '',
	    '',
	    '',
	    @cTipoLchr,
	    @observ,
	    ROUND(@nprimadesv, 0),
	    ROUND(@nValparvta, 0),
	    CASE 
	         WHEN @cfecpro = @fecha_pagomañana THEN 0
	         ELSE 0
	    END,	-- MtoCompraPM  
	    
	    CASE 
	         WHEN @cfecpro = @fecha_pagomañana THEN CASE 
	                                                     WHEN @nRutemi = @nRut 
	                                                          AND @nCodigo = 20 THEN 
	                                                          ROUND(@nValparvta, 0)
	                                                     ELSE ISNULL(@nvalcompv + @ninteresv + @nreajustv, 0)
	                                                END -- MtoVentaPM
	         ELSE 0
	    END,
	    CASE 
	         WHEN @St = 'S' THEN 'N'
	         WHEN @cfecpro = @fecha_pagomañana THEN 'N'
	         ELSE 'S' -- PagoMañana
	    END,
	    CASE 
	         WHEN @St = 'S' THEN 'S'
	         ELSE 'N'
	    END,
	    @Codigo_Libro,
	    @nValorCompraPM,
	    @ValorPrenteT0,	-- VB+- 09/05/2009 Venta PM  
	    
	    
	    
	    @nTirTran,
	    @nPvpTran,
	    @nVpTran,
	    @nDifTran_MO,
	    @nDifTran_CLP,
	    @Resultado_Dif_Precio,	--> Ventas AFS
	    
	    @Resultado_Dif_Mercado,	--> Ventas AFS
	    
	    ISNULL(@nValMercadoProporcional, 0.0) --> Ventas AFS
	  )  
	
	
	
	
	
	INSERT INTO MDMOPM
	  (
	    mofecpro,
	    morutcart,
	    motipcart,
	    monumdocu,
	    mocorrela,
	    monumdocuo,
	    mocorrelao,
	    monumoper,
	    motipoper,
	    motipopero,
	    moinstser,
	    momascara,
	    mocodigo,
	    moseriado,
	    mofecemi,
	    mofecven,
	    momonemi,
	    motasemi,
	    mobasemi,
	    morutemi,
	    monominal,
	    movpresen,
	    momtps,
	    momtum,
	    momtum100,
	    monumucup,
	    motir,
	    mopvp,
	    movpar,
	    motasest,
	    mofecinip,
	    mofecvenp,
	    movalinip,
	    movalvenp,
	    motaspact,
	    mobaspact,
	    momonpact,
	    moforpagi,
	    moforpagv,
	    motipobono,
	    mocondpacto,
	    mopagohoy,
	    morutcli,
	    mocodcli,
	    motipret,
	    mohora,
	    mousuario,
	    moterminal,
	    mocapitali,
	    moINTeresi,
	    moreajusti,
	    movpreseni,
	    mocapitalp,
	    moINTeresp,
	    moreajustp,
	    movpresenp,
	    motasant,
	    mobasant,
	    movalant,
	    mostatreg,
	    movpressb,
	    modifsb,
	    monominalp,
	    movalcomp,
	    movalcomu,
	    moINTeres,
	    moreajuste,
	    moINTpac,
	    moreapac,
	    moutilidad,
	    moperdida,
	    movalven,
	    mocontador,
	    monsollin,
	    moobserv,
	    moobserv2,
	    movvista,
	    movviscom,
	    momtocomi,
	    mocorvent,
	    modcv,
	    moclave_dcv,
	    mocodexceso,
	    momtoPFE,
	    momtoCCE,
	    moINTermesc,
	    moreajumesc,
	    moINTermesvi,
	    moreajumesvi,
	    fecha_compra_original,
	    valor_compra_original,
	    valor_compra_um_original,
	    tir_compra_original,
	    valor_par_compra_original,
	    porcentaje_valor_par_compra_original,
	    codigo_carterasuper,
	    Tipo_Cartera_Financiera,
	    Mercado,
	    Sucursal,
	    Id_Sistema,
	    Fecha_PagoMañana,
	    Laminas,
	    Tipo_Inversion,
	    Cuenta_Corriente_Inicio,
	    Cuenta_Corriente_Final,
	    Sucursal_Inicio,
	    Sucursal_Final,
	    motipoletra,
	    moreserva_tecnica1,
	    movalvenc,
	    movaltasemi,
	    moprimadesc,
	    SwImpresion,
	    MtoCompraPM,
	    MtoVentaPM,
	    PagoMañana,
	    SorteoLCHR,
	    moid_libro,
	    Resultado_Dif_Precio --> Ventas AFS
	    ,
	    Resultado_Dif_Mercado --> Ventas AFS
	    ,
	    ValorMercado_prop
	  )
	SELECT mofecpro,
	       morutcart,
	       motipcart,
	       monumdocu,
	       mocorrela,
	       monumdocuo,
	       mocorrelao,
	       monumoper,
	       motipoper,
	       motipopero,
	       moinstser,
	       momascara,
	       mocodigo,
	       moseriado,
	       mofecemi,
	       mofecven,
	       momonemi,
	       motasemi,
	       mobasemi,
	       morutemi,
	       monominal,
	       movpresen,
	       momtps,
	       momtum,
	       momtum100,
	       monumucup,
	       motir,
	       mopvp,
	       movpar,
	       motasest,
	       mofecinip,
	       mofecvenp,
	       movalinip,
	       movalvenp,
	       motaspact,
	       mobaspact,
	       momonpact,
	       moforpagi,
	       moforpagv,
	       motipobono,
	       mocondpacto,
	       mopagohoy,
	       morutcli,
	       mocodcli,
	       motipret,
	       mohora,
	       mousuario,
	       moterminal,
	       mocapitali,
	       mointeresi,
	       moreajusti,
	       movpreseni,
	       mocapitalp,
	       mointeresp,
	       moreajustp,
	       movpresenp,
	       motasant,
	       mobasant,
	       movalant,
	       mostatreg,
	       movpressb,
	       modifsb,
	       monominalp,
	       movalcomp,
	       movalcomu,
	       mointeres,
	       moreajuste,
	       mointpac,
	       moreapac,
	       moutilidad,
	       moperdida,
	       movalven,
	       mocontador,
	       monsollin,
	       moobserv,
	       moobserv2,
	       movvista,
	       movviscom,
	       momtocomi,
	       mocorvent,
	       modcv,
	       moclave_dcv,
	       mocodexceso,
	       momtoPFE,
	       momtoCCE,
	       ISNULL(mointermesc, 0),
	       ISNULL(moreajumesc, 0),
	       ISNULL(mointermesvi, 0),
	       ISNULL(moreajumesvi, 0),
	       fecha_compra_original,
	       valor_compra_original,
	       valor_compra_um_original,
	       tir_compra_original,
	       valor_par_compra_original,
	       porcentaje_valor_par_compra_original,
	       codigo_carterasuper,
	       Tipo_Cartera_Financiera,
	       Mercado,
	       Sucursal,
	       Id_Sistema,
	       Fecha_PagoMañana,
	       Laminas,
	       Tipo_Inversion,
	       Cuenta_Corriente_Inicio,
	       Cuenta_Corriente_Final,
	       Sucursal_Inicio,
	       Sucursal_Final,
	       motipoletra,
	       moreserva_tecnica1,
	       movalvenc,
	       movaltasemi,
	       moprimadesc,
	       SwImpresion,
	       MtoCompraPM,
	       MtoVentaPM,
	       PagoMañana,
	       SorteoLchr,
	       id_libro,
	       Resultado_Dif_Precio --> Ventas AFS
	       ,
	       Resultado_Dif_Mercado --> Ventas AFS
	       ,
	       ValorMercado_prop
	FROM   MDMO
	WHERE  PagoMañana = 'S'
	       AND monumoper = @nnumoper
	       AND monumdocu = @nnumdocu
	       AND mocorrela = @ncorrela 
	
	
	
	---->
	--REQUERIMENTO LD1_035_ITAU---------------------------------------
	
	DECLARE @cRenta CHAR(01)
	DECLARE @Sirve CHAR(2)
	DECLARE @cSenala NUMERIC(9, 0)
	DECLARE @cProg CHAR(12)
	DECLARE @cGenemis CHAR(10)
	DECLARE @Rentabilidad VARCHAR(01) = ''
	DECLARE @cSerie CHAR(06)
	DECLARE @nTipoTir FLOAT
	DECLARE @dFecAnt DATETIME
	DECLARE @nMtmAyerv FLOAT
	DECLARE @nValMcdov FLOAT
	DECLARE @nUf_Hoy FLOAT
	DECLARE @nUf_Pag FLOAT
	DECLARE @nUf_comp FLOAT
	DECLARE @ValCapitalUm FLOAT
	DECLARE @nMtoCortes NUMERIC(19, 4)
	DECLARE @dFecpcup DATETIME
	DECLARE @dFecucup DATETIME
	DECLARE @numcontrato NUMERIC(10)
	DECLARE @nRutClicomp NUMERIC(09)
	--   @nvalcomp
	
	DECLARE @dFechaSalida DATETIME
	EXECUTE SP_PagoFisico @fecha_pagomañana, @nforpagi, @dFechaSalida OUTPUT
	
	SELECT @cRenta = ''
	SELECT @Sirve = ''
	
	EXECUTE dbo.sp_ver_si_sirve @cfecpro,@ntircompo,@nfeccompo,@Rentabilidad,@tipo_cartera_financiera,
	@nforpagi,@cinstser,@cSerie,@cRenta OUTPUT,@nTipoTir OUTPUT,@Sirve OUTPUT
	
	SELECT @cSenala = (CASE WHEN @nfeccompo = @cFecpro THEN -1 ELSE 3 END)
	
	
	
	
	
	SELECT @cProg = ISNULL(
	           (
	               SELECT inprog
	               FROM   view_instrumento
	               WHERE  incodigo = @ncodigo
	           ),
	           ''''
	       )
	
	
	/******************************************************************* se comenta temporalmente LD01_035	
	IF @Sirve = 'SI'
	BEGIN
	INSERT INTO TABLA_VENTAS
	(
	TIPO_LISTADO,
	RUT_CARTERA,
	TIPO_CARTERA,
	CARTERA,
	NUMDOCU,
	NUMOPER,
	CORRELA,
	INSTSER,
	FECEMIS,
	RUTEMIS,
	MONEMIS,
	TASEMIS,
	BASEEMIS,
	FECVENC,
	FECPCUP,
	NOMINAL,
	RUTCLI,
	CODCLI,
	FECCOMP,
	VALCOMP,
	TIRCOMP,
	BASECOMP,
	VALCOMU,
	TIRVENTA,
	BASETIRVENTA,
	CODIGO,
	PROG,
	VPRESEN,
	FORMAPAGOI,
	INST,
	EJECUTIVO,
	MODALIDADINVERSION,
	FECHAPAGO,
	RENTA,
	SENALA,
	FECUCUP,
	TIRHISTORICA,
	VALORPROX,
	VALVTOP,
	VALINIP,
	MASCARA,
	RUTCLICOMP,
	GENEMIS,
	VALORCONTABLE
	)
	VALUES
	(
	'T',
	@nrutcart,
	@ntipcart,
	'111',
	@nnumdocu,
	@nnumoper,
	@ncorrela,
	@cinstser,
	@cfecemi,
	@nrutemi,
	@nmonemi,
	@ntasemi,
	@nbasemi,
	@cfecven,
	@dFecpcup,
	@nnominal,
	@nrutcli,
	@ncodcli,
	@nfeccompo,
	@nvalcomp,	-- ISNULL(@nvalcompv,0)    ,
	
	@ntircompo,
	@nbasemi,
	ISNULL(@nvalcomuv, 0),
	@nTir,
	@nbasemi,
	@ncodigo,
	@cProg,
	@fvptircv,	-- @nvptirv, VMGS Se debe guardar el valor presente y no el valor de venta
	
	@nforpagi,
	@cSerie,
	ISNULL(CONVERT(CHAR(01), @Ejecutivo), ''''),
	@tipo_inversion,
	@fecha_pagomañana,
	@cRenta,
	@cSenala,
	@dFecucup,
	@nTipoTir,
	@nvptirv,
	@nvalcompv,	-- @nvalcomp, -- 0,
	
	@nvptirv,
	@cmascara,
	@nRutClicomp,
	@cGenemis,
	@nValContv
	)
	
	IF @cSenala <> -1
	INSERT INTO TABLA_VENTAS
	(
	TIPO_LISTADO,
	RUT_CARTERA,
	TIPO_CARTERA,
	CARTERA,
	NUMDOCU,
	NUMOPER,
	CORRELA,
	INSTSER,
	FECEMIS,
	RUTEMIS,
	MONEMIS,
	TASEMIS,
	BASEEMIS,
	FECVENC,
	FECPCUP,
	NOMINAL,
	RUTCLI,
	CODCLI,
	FECCOMP,
	VALCOMP,
	TIRCOMP,
	BASECOMP,
	VALCOMU,
	TIRVENTA,
	BASETIRVENTA,
	CODIGO,
	PROG,
	VPRESEN,
	FORMAPAGOI,
	INST,
	EJECUTIVO,
	MODALIDADINVERSION,
	FECHAPAGO,
	RENTA,
	SENALA,
	FECUCUP,
	TIRHISTORICA,
	VALORPROX,
	VALVTOP,
	VALINIP,
	MASCARA,
	RUTCLICOMP,
	GENEMIS,
	VALORCONTABLE
	)
	VALUES
	(
	'T',
	@nrutcart,
	@ntipcart,
	'111',
	@nnumdocu,
	@nnumoper,
	@ncorrela,
	@cinstser,
	@cfecemi,
	@nrutemi,
	@nmonemi,
	@ntasemi,
	@nbasemi,
	@cfecven,
	@dFecpcup,
	@nnominal,
	@nrutcli,
	@ncodcli,
	@nfeccompo,
	@nvalcomp,	-- ISNULL(@nvalcompv,0)    ,
	
	@ntircompo,
	@nbasemi,
	ISNULL(@nvalcomuv, 0),
	@nTir,
	@nbasemi,
	@ncodigo,
	@cProg,
	@fvptircv,	-- @nvptirv, VMGS Se debe guardar el valor presente y no el valor de venta
	
	@nforpagi,
	@cSerie,
	ISNULL(CONVERT(CHAR(01), @Ejecutivo), ''''),
	@tipo_inversion,
	@fecha_pagomañana,
	@cRenta,
	-1,
	@dFecucup,
	@nTipoTir,
	@nvptirv,
	@nvalcompv,	-- @nvalcomp, --0,
	
	@nvptirv,
	@cmascara,
	@nRutClicomp,
	@cGenemis,
	@nValContv
	)
	END
	IF @pago_hoy = 'M' AND @FechaPagoOriginal <= @cfecpro
	BEGIN
	INSERT INTO TABLA_VENTAS
	(
	TIPO_LISTADO,
	RUT_CARTERA,
	TIPO_CARTERA,
	CARTERA,
	NUMDOCU,
	NUMOPER,
	CORRELA,
	INSTSER,
	FECEMIS,
	RUTEMIS,
	MONEMIS,
	TASEMIS,
	BASEEMIS,
	FECVENC,
	FECPCUP,
	NOMINAL,
	RUTCLI,
	CODCLI,
	FECCOMP,
	VALCOMP,
	TIRCOMP,
	BASECOMP,
	VALCOMU,
	TIRVENTA,
	BASETIRVENTA,
	CODIGO,
	PROG,
	VPRESEN,
	FORMAPAGOI,
	INST,
	EJECUTIVO,
	MODALIDADINVERSION,
	FECHAPAGO,
	RENTA,
	SENALA,
	FECUCUP,
	VALORCONTABLE,
	MASCARA,
	RUTCLICOMP,
	GENEMIS
	)
	VALUES
	(
	'S',
	@nrutcart,
	@ntipcart,
	'111',
	@nnumdocu,
	@nnumoper,
	@ncorrela,
	@cinstser,
	@cfecemi,
	@nrutemi,
	@nmonemi,
	@ntasemi,
	@nbasemi,
	@cfecven,
	@dFecpcup,
	@nnominal,
	@nrutcli,
	@ncodcli,
	@nfeccompo,
	@nvalcomp,	-- ISNULL(@nvalcompv,0)    ,
	
	@ntircompo,
	@nbasemi,
	ISNULL(@nvalcomuv, 0),
	@nTir,
	@nbasemi,
	@ncodigo,
	@cProg,
	@nvptirv,
	@nforpagi,
	@cSerie,
	ISNULL(CONVERT(CHAR(01), @Ejecutivo), ''''),
	@tipo_inversion,
	@fecha_pagomañana,	--@dFecprox,
	
	@cRenta,
	0,
	@dFecucup,
	@nValContv,
	@cmascara,
	@nRutClicomp,
	@cGenemis
	)
	END
	
	-- Agrego Venta para Reportes P17 y para Reporte Tir Historica
	
	INSERT INTO TABLA_VENTAS
	(
	TIPO_LISTADO,
	RUT_CARTERA,
	TIPO_CARTERA,
	CARTERA,
	NUMDOCU,
	NUMOPER,
	CORRELA,
	INSTSER,
	FECEMIS,
	RUTEMIS,
	MONEMIS,
	TASEMIS,
	BASEEMIS,
	FECVENC,
	FECPCUP,
	NOMINAL,
	RUTCLI,
	CODCLI,
	FECCOMP,
	VALCOMP,
	TIRCOMP,
	BASECOMP,
	VALCOMU,
	TIRVENTA,
	BASETIRVENTA,
	CODIGO,
	PROG,
	VPRESEN,
	FORMAPAGOI,
	INST,
	EJECUTIVO,
	MODALIDADINVERSION,
	FECHAPAGO,
	RENTA,
	SENALA,
	FECUCUP,
	TIRHISTORICA,
	VALORPROX,
	VALVTOP,
	VALINIP,
	VENTAVALOR,
	VENTAFORPAGO,
	VENTAFECPAGO,
	VENTAFECHAREAL,
	MASCARA,
	RUTCLICOMP,
	GENEMIS,
	VALORCONTABLE
	)
	VALUES
	(
	'H',
	@nrutcart,
	@ntipcart,
	'111',
	@nnumdocu,
	@nnumoper,
	@ncorrela,
	@cinstser,
	@cfecemi,
	@nrutemi,
	@nmonemi,
	@ntasemi,
	@nbasemi,
	@cfecven,
	@dFecpcup,
	@nnominal,
	@nrutcli,
	@ncodcli,
	@nfeccompo,
	ISNULL(@nvalcompv, 0),	--@nvalcomp
	
	@ntircompo,
	@nbasemi,
	ISNULL(@nvalcomuv, 0),
	@nTir,
	@nbasemi,
	@ncodigo,
	@cProg,
	@nvptirv,
	@nforpagori,	--@nforpagi,
	
	@cSerie,
	ISNULL(CONVERT(CHAR(01), @Ejecutivo), ''''),
	@tipo_inversion,
	@FechaPagoOriginal,	-- @dFecprox,
	
	@cRenta,
	@cSenala,
	@dFecucup,
	@nTipoTir,
	@nvptirv,
	0,
	@nvptirv,
	@nvptirv,
	@nforpagi,
	@fecha_pagomañana,
	@dFechaSalida,
	@cmascara,
	@nRutClicomp,
	@cGenemis,
	@nValContv
	)
	
	**********************************************************************/ 
	
	
	
	/* Grabar cartera de ventas Historica para Interfaz de Inversiones Requerimiento de Brasil  VGS Dic/2007*/
	
	DECLARE @anno                INTEGER,
	        @dFecAnoAnt          DATETIME,
	        @nReajAnno           FLOAT,
	        @nIntAnno            FLOAT,
	        @dFecMcdo            DATETIME,
	        @ValMcdo             FLOAT,
	        @Util_Mercado        FLOAT,
	        @Perd_Mercado        FLOAT,
	        @InteresDevAno       FLOAT,
	        @ReajustesDevAno     FLOAT,
	        @DifMercano          FLOAT,
	        @ValcompAno          FLOAT
	
	SELECT @nMtmAyer = ISNULL(diferencia_mercado, 0),
	       @nValMcdo              = ISNULL(valor_mercado, 0)
	FROM   valorizacion_mercado
	WHERE  fecha_valorizacion     = @dFecAnt
	       AND rmrutcart          = @nrutcart
	       AND rmnumdocu          = @nnumdocu
	       AND rmcorrela          = @ncorrela
	       AND tipo_operacion     = 'CP'
	
	
	
	
	
	SELECT @nMtmAyerv = ROUND(@nMtmAyer -(@nMtmAyer * @ffactor), 0) -- Se calcula el proporcional de la Venta
	SELECT @nValMcdov = ROUND(@nValMcdo -(@nValMcdo * @ffactor), 0) -- Se calcula el proporcional de la Venta
	SELECT @anno = YEAR(@cfecpro)
	SELECT @dFecAnoAnt = STR(YEAR(@cfecpro) -1, 4) + '1231'
	
	
	
	SELECT @nUf_Hoy = vmvalor
	FROM   view_Valor_moneda
	WHERE  vmcodigo        = @nmonemi
	       AND Vmfecha     = @cFecpro
	
	SELECT @nUf_Pag = vmvalor
	FROM   view_Valor_moneda
	WHERE  vmcodigo        = @nmonemi
	       AND Vmfecha     = @dFecAnoAnt
	
	SELECT @nUf_comp = vmvalor
	FROM   view_Valor_moneda
	WHERE  vmcodigo        = @nmonemi
	       AND Vmfecha     = @nfeccompo
	
	
	
	IF @nmonemi = 13
	   OR @nmonemi = 999
	BEGIN
	    SELECT @nUf_Hoy = 1
	    SELECT @nUf_Pag = 1
	    SELECT @nUf_comp = 1
	END
	
	SELECT @ValCapitalUm = ROUND(@nValContv / @nUf_comp, 4)
	SELECT @nIntAnno = ROUND(
	           (
	               @ValCapitalUm * (@tasa_contrato / 36000) * DATEDIFF(dd, @dFecAnoAnt, @cFecpro)
	           ) * @nUf_Hoy,
	           0
	       )
	
	SELECT @nReajAnno = CASE 
	                         WHEN (@nmonemi <> 999 AND @nmonemi <> 13) THEN 
	                              ROUND((@nUf_Hoy - @nUf_Pag) * @ValCapitalUm, 0)
	                         ELSE 0.0
	                    END
	
	IF YEAR(@nfeccompo) = @anno
	    SELECT @dFecMcdo = @nfeccompo
	ELSE
	    SELECT @dFecMcdo = @dFecAnoAnt
	
	
	
	SELECT @ValMcdo = 0
	
	SELECT @ValMcdo = ISNULL(
	           SUM(ROUND(valor_mercado -(valor_mercado * @ffactor), 0)),
	           0
	       )
	FROM   VALORIZACION_MERCADO
	WHERE  fecha_valorizacion     = @dFecMcdo
	       AND rmrutcart          = @nrutcart
	       AND rmnumdocu          = @nnumdocu
	       AND rmcorrela          = @ncorrela
	GROUP BY
	       rmrutcart,
	       rmnumdocu,
	       rmcorrela
	
	
	
	SELECT @nMtoCortes = 0.0
	
	IF @cseriado = 'S'
	BEGIN
	    EXECUTE Sp_Descuenta_Cupones @nmonemi,@nnominal,@dFecMcdo,@cfecpro,@cmascara,
	    @cfecemi,@ncodigo,@nMtoCortes OUTPUT
	END
	
	
	
	/* Se guarda el proporcional correspondiente a la Venta*/
	
	SELECT @Util_Mercado = CASE 
	                            WHEN @nMtmAyerv > 0 THEN @nMtmAyerv
	                            ELSE 0
	                       END
	
	SELECT @Perd_Mercado = CASE 
	                            WHEN @nMtmAyerv < 0 THEN ABS(@nMtmAyerv)
	                            ELSE 0
	                       END
	
	SELECT @InteresDevAno = ROUND(@nIntAnno -(@nIntAnno * @ffactor), 0)
	SELECT @ReajustesDevAno = ROUND(@nReajAnno -(@nReajAnno * @ffactor), 0)
	SELECT @DifMercano = ISNULL((@nValMcdov -(@ValMcdo -@nMtoCortes)), 0)
	SELECT @ValcompAno = CASE 
	                          WHEN YEAR(@nfeccompo) = YEAR(@cfecpro) THEN @nvalcompv
	                          ELSE CONVERT(NUMERIC(19, 4), 0)
	                     END
	
	
	
	INSERT INTO mdvp
	VALUES
	  (
	    @nrutcart,
	    @ntipcart,
	    '111',
	    @nnumdocu,
	    @nnumoper,
	    @ncorrela,
	    @cinstser,
	    @cfecemi,
	    @nrutemi,
	    @cGenemis,
	    @nmonemi,
	    @ntasemi,
	    @nbasemi,
	    @cfecven,
	    @dFecpcup,
	    @nnominal,
	    @nrutcli,
	    @ncodcli,
	    @nfeccompo,
	    ISNULL(@nvalcompv, 0),
	    @ntircompo,
	    @nbasemi,
	    ISNULL(@nvalcomuv, 0),
	    @nTir,
	    @ncodigo,
	    @cSerie,
	    @numcontrato,
	    @tasa_contrato,
	    @fecha_pago,
	    ISNULL(@nValContv, 0),
	    @dFecucup,
	    ISNULL(@nvptirv, 0),
	    @nforpagi,
	    @fecha_pagomañana,
	    @cfecpro,
	    ISNULL(@ninteresv, 0),
	    ISNULL(@nreajustv, 0),
	    @cmascara,
	    @nRutClicomp,
	    @cseriado,
	    ISNULL(@nValMcdov, 0),
	    ISNULL(@Util_Mercado, 0),
	    ISNULL(@Perd_Mercado, 0),
	    ISNULL(@InteresDevAno, 0),
	    ISNULL(@ReajustesDevAno, 0),
	    ISNULL(@DifMercano, 0),
	    ISNULL(@ninteresv, 0),
	    ISNULL(@nutilidad, 0),
	    ISNULL(@nperdida, 0),
	    ISNULL(@ValcompAno, 0)
	  )
	
	/* Fin Grabar cartera de ventas Historica para Interfaz de Inversiones Requerimiento de Brasil  VGS Dic/2007*/
	--REQUERIMENTO LD1_035_ITAU---------------------------------------
	---->
	
	
	SET NOCOUNT OFF  
	SELECT 'OK'
END 
 
 -- Base de Datos --
GO
