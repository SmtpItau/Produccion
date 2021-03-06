USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_CONSULTAROPERACIONDETALLE]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LINEAS_CONSULTAROPERACIONDETALLE]  
    (  
    @dFecPro    DATETIME  ,  
    @cSistema   CHAR  (03)  ,  
    @cProducto   CHAR  (05)  ,  
    @nRutcli   NUMERIC (09,0)  ,  
    @nCodigo   NUMERIC (09,0)  ,  
    @dFeciniop   DATETIME  ,  
    @nMonto    NUMERIC (19,4)  ,  
    @fTipcambio  NUMERIC (08,4)  ,  
    @dFecvctop   DATETIME  ,  
    @cUsuario   CHAR  (15)  ,  
    @cMonedaOp   NUMERIC (05,00) ,  
    @cTipo_Riesgo   CHAR  (1)  ,  
    @mContraMoneda 	NUMERIC	(03) = 0 ,
    @nNumoper 	    NUMERIC(10)      ,      -- PRD8800
    @Resultado      FLOAT			 ,		-- PRD8800
    @MetodoLCR      NUMERIC(5)		 ,		-- PRD8800
    @Garantia       FLOAT   				-- PRD8800   

    )  
AS  
BEGIN  
  
 SET NOCOUNT ON  
  
	DECLARE @cNombre  CHAR(60) ,  
		@cNombreCMatriz CHAR(60) ,  
		@nCorrDet  INTEGER  ,  
		@cMensaje  VARCHAR(255) ,  
		@cTipoMov  VARCHAR(01) ,  
		@cTipoLinea VARCHAR(01) ,  
		@cTipoControl VARCHAR(01) ,  
		@cError  VARCHAR(01)  

	DECLARE @iFound   INTEGER  ,  
		@cCompartido  CHAR(01) ,  
		@nRutcasamatriz  NUMERIC(09,0) ,  
		@nCodigocasamatriz  NUMERIC(09,0) ,  
		@nMatrizriesgo  NUMERIC(08,4) ,  
		@nTotalasignado  NUMERIC(19,4) ,  
		@nTotalocupado  NUMERIC(19,4) ,  
		@nTotaldisponible  NUMERIC(19,4) ,  
		@nTotalexceso  NUMERIC(19,4) ,  
		@nTotaltraspaso  NUMERIC(19,4) ,  
		@nTotalrecibido  NUMERIC(19,4) ,  
		@nSinriesgoasignado  NUMERIC(19,4) ,  
		@nSinriesgoocupado  NUMERIC(19,4) ,  
		@nSinriesgodisponible  NUMERIC(19,4) ,  
		@nSinriesgoexceso  NUMERIC(19,4) ,  
		@nConriesgoasignado  NUMERIC(19,4) ,  
		@nConriesgoocupado  NUMERIC(19,4) ,  
		@nConriesgodisponible  NUMERIC(19,4) ,  
		@nConriesgoexceso  NUMERIC(19,4) ,  
		@nMonedalin  NUMERIC(05,0) ,  
		@nValmonlin  NUMERIC(10,4) ,  
		@nMontolin  NUMERIC(19,4) ,  
		@nExceso   NUMERIC(19,4) ,  
		@nDisponible  NUMERIC(19,4) ,  
		@dFecvctolinea  DATETIME ,  
		@cBloqueado  CHAR(01) ,  
		@nMontLimIni  NUMERIC(19,4) ,  
		@nMontLimVen		NUMERIC(19,4)	,


		@nmontolin_pesos   NUMERIC(19,0) ,
		@nMontoLinGen	   NUMERIC(19,4) ,
		@nMontoLinSis	   NUMERIC(19,4) , 
		@nMontoLinPro	   NUMERIC(19,4) , 
		@SubTotal 		   FLOAT         ,
		@TotalGeneral 	   FLOAT         ,
		@SoloCnvLinPro 	   NUMERIC(10,4) ,
		@Tipo_Oper         CHAR(1)       ,
		@Capital_A         FLOAT         ,
		@Capital_P         NUMERIC(18,6) ,
		@Plazo_A           NUMERIC(18,6) ,
		@Plazo_P           NUMERIC(18,6) ,
		@Moneda_A          NUMERIC(5)    ,
		@Moneda_P          NUMERIC(5)    ,
		@Duration_A        FLOAT         ,
		@Duration_P        FLOAT         ,
		@M_Durat           FLOAT		 ,
		@Serie_Valor       CHAR(12)      ,
		@Tipo_Producto     INTEGER       ,
		@Prc               FLOAT         ,
		@Utilidadlin_pesos FLOAT         ,
		@dFechaHoy         DATETIME      ,
		@incodigo          NUMERIC(05,0) ,

		-- PRD8800
		@nPlazoDesde       NUMERIC(10,0) ,   
		@nPlazoHasta       NUMERIC(10,0) ,   
		@nnPlazoProdPla    NUMERIC(9)    ,
		@Id_SistemaNetting CHAR(03)      ,
		@nMonedaLinGen     numeric(5)    ,
		@nMonedaLinSis     numeric(5)    ,
		@GarantiaLinGen    numeric(18,4) ,    
		@GarantiaLinSis    numeric(18,4) ,   
		@FactorCnvLinGen   numeric(18,4) ,
		@FactorCnvLinSis   numeric(18,4) ,
		@nDisponibleLinGen numeric(18,4) ,
		@nDisponibleLinSis numeric(18,4) ,
		@nDisponibleLinPla numeric(18,4) ,
		@nTotalAsignadoLinGen numeric(18,4),				
		@nTotalAsignadoLinSis numeric(18,4),
		@nTotalAsignadoLinPla numeric(18,4),
		@cBloqueadoLinSis  char(1),
		@cBloqueadoLinGen  char(1),
		@dFecvctolineaLinGen datetime,
		@dFecvctolineaLinSis datetime
		
		--+++CONTROL IDD, jcamposd 20170814, no debe controlar línea ni generar errores de control.
		DECLARE @controlIdd char(1)
		
		set @controlIdd = 'S'
		
		IF @controlIdd = 'S'
		BEGIN
			RETURN
		END 
		ELSE
		BEGIN	
				

		   SELECT  @Id_SistemaNetting =  CASE WHEN @MetodoLCR NOT IN (1,4) THEN Id_Grupo
											  ELSE Id_Sistema  END
		   FROM  TBL_AGRPROD
		   WHERE Id_Sistema  = @cSistema

		   -- 8800 usa solo familias tipo AFP
		   if @Id_SistemaNetting = 'DRV' and @MetodoLCR not in (1,4)  -- Metodologia Drv
		   BEGIN
			  IF EXISTS( SELECT 1 FROM CLIENTE_RELACIONADO WHERE clrut_hijo = @nRutcli AND clcodigo_hijo = @nCodigo )
			  BEGIN
				 SELECT @nRutcli      = clrut_padre		
				 ,      @nCodigo      = clcodigo_padre
				 FROM   BacLineas..CLIENTE_RELACIONADO 
				 WHERE  clrut_hijo    = @nRutcli	
				 AND    clcodigo_hijo = @nCodigo
			  END
		   END

		   
			SET @nnPlazoProdPla   = DATEDIFF(DAY, @dFecPro, @dFecvctop)    
		  
		 IF @nCodigo = 0  
		  SELECT  @cNombre = clnombre  
		   , @nCodigo = clcodigo  
		  FROM  view_cliente  
		  WHERE clrut  = @nRutcli  
		 ELSE  
			SELECT  @cNombre = clnombre  
			FROM  view_cliente  
			WHERE clrut  = @nRutcli  
			AND clcodigo = @nCodigo  
		   
		   SELECT @nCorrDet      = 0  
			  ,   @cTipoMov      = 'S'   -- S.suma R.resta  
			  ,   @cTipoLinea    = 'L'   -- L.linea  
			  ,   @cTipoControl  = 'C'   -- C.control  
		  
		 IF @fTipcambio > 0  
				SELECT @nMontolin = ROUND(@nMonto/@fTipcambio,4)  
			ELSE  
				SELECT @nMontolin = ROUND(@nMonto,4)  
		  
		 SELECT @nMatrizriesgo = 0  
		  
			SELECT  @incodigo   =  0
		  
			DECLARE @nPlazoProdPla   NUMERIC(9)
			   SET @nPlazoProdPla   = DATEDIFF(DAY, @dFecPro, @dFecvctop)

		------ IF @cSistema  = 'BFW'
		------ BEGIN
		------  SELECT @iFound  = 0
		------      SELECT @iFound         = 1  
		------         ,   @nMatrizriesgo  = porcentaje
		------  FROM MATRIZ_RIESGO_CLIENTE  with (nolock)
		------  WHERE rut_cliente  = @nRutcli
		------  AND  codigo_cliente  = @nCodigo
		------  AND codigo_producto  = @cProducto
		------  AND moneda    = @cMonedaOp
		------  AND diasdesde         <= DATEDIFF(day, @dFecPro, @dFecvctop)
		------  AND diashasta    > DATEDIFF(day, @dFecPro, @dFecvctop)
		------
		------  IF @iFound = 0
		------  BEGIN
		------   SELECT @iFound  = 0
		------         SELECT @iFound        = 1  
		------            ,   @nMatrizriesgo = porcentaje
		------   FROM MATRIZ_RIESGO with (nolock)
		------   WHERE codigo_producto  = @cProducto
		------   AND moneda    = @cMonedaOp
		------   AND diasdesde    <= DATEDIFF(day, @dFecPro, @dFecvctop)
		------   AND diashasta    > DATEDIFF(day, @dFecPro, @dFecvctop)
		------   AND Contra_Moneda = @mContraMoneda
		------  END
		------      IF @nMatrizriesgo > 0
		------         SELECT @nMontolin = ROUND(@nMontolin/100*@nMatrizriesgo,4)
		------ END
		  
		   DECLARE @xMensajeBloqueo VARCHAR(100)  
			   SET @xMensajeBloqueo = ''  
		   SET @nMonedaLinGen = 999        -- Por Si no Hubiera Linea General
		   SET @nTotalAsignadoLinGen = 0
		   SELECT @iFound           = 0  
		   SELECT @iFound           = 1     
			  ,   @nDisponibleLinGen = LINEA_GENERAL.totaldisponible   
			  ,   @nTotalAsignadoLinGen    = LINEA_GENERAL.TotalAsignado
			  ,   @cBloqueadoLinGen        = LINEA_GENERAL.bloqueado  
			  ,   @dFecvctolineaLinGen    = LINEA_GENERAL.fechavencimiento
			  ,   @xMensajeBloqueo  = isnull(cli.motivo_bloqueo, '')  
			  ,   @nMonedaLinGen    = LINEA_GENERAL.Moneda
		 FROM LINEA_GENERAL  
				  LEFT JOIN BacParamSuda.dbo.CLIENTE cli ON cli.clrut = rut_cliente AND cli.clcodigo = codigo_cliente  
		   WHERE  LINEA_GENERAL.rut_cliente       = @nRutcli  
		   AND    LINEA_GENERAL.codigo_cliente    = @nCodigo  
		  

		   SET @nMonedaLinSis = 999
		   SET @nTotalAsignadoLinSis = 0
		   SELECT @nMonedaLinSis     = LINEA_SISTEMA.Moneda
				, @cBloqueadoLinSis  = LINEA_SISTEMA.Bloqueado
				, @dFecvctolineaLinSis   = LINEA_SISTEMA.fechavencimiento
				, @nDisponibleLinSis     = LINEA_SISTEMA.totaldisponible 
			  ,   @nTotalAsignadoLinSis  = LINEA_SISTEMA.TotalAsignado
		   FROM LINEA_SISTEMA
		   WHERE  LINEA_SISTEMA.rut_cliente       = @nRutcli
		   AND    LINEA_SISTEMA.codigo_cliente    = @nCodigo
		   AND    LINEA_SISTEMA.Id_Sistema        = @Id_SistemaNetting


		   IF @cSistema  = 'BFW'  and  @MetodoLCR in (1,4)  -- PRD8800
		   BEGIN

			  SELECT @Serie_Valor    = caserie,
					 @Tipo_Oper      = catipoper,
					 @Capital_A      = (CASE WHEN cacodpos1 = 14  THEN camtomon1
											-->WHEN cacodpos1 = 10  THEN caequusd1
											WHEN catipoper = 'C' THEN camtomon1 
											WHEN catipoper = 'V' THEN camtomon1 
												 -->ELSE (CASE WHEN cacodpos1 = 10 THEN caequusd1 ELSE camtomon2 END)
									   END),
					 @Capital_P      = (CASE WHEN cacodpos1 = 14  THEN camtomon2
											 WHEN catipoper = 'C' THEN camtomon1  --> CASE WHEN cacodpos1 = 10 THEN caequusd1 ELSE camtomon2 END
											 ELSE camtomon1
									   END),
					 @Plazo_A        = (CASE WHEN DATEDIFF(DAY,@dFecPro,cafecEfectiva) < 0 THEN 0 ELSE DATEDIFF(DAY,@dFecPro,cafecEfectiva) END),
					 @Plazo_P        = (CASE WHEN DATEDIFF(DAY,@dFecPro,cafecEfectiva) < 0 THEN 0 ELSE DATEDIFF(DAY,@dFecPro,cafecEfectiva) END),
					 @Moneda_A       = (CASE WHEN cacodpos1 = 14  THEN cacodmon1 
											 WHEN catipoper = 'C' THEN cacodmon1 
											 WHEN catipoper = 'V' THEN cacodmon1
											 ELSE cacodmon1
										 --> ELSE cacodmon2 
										END),     
					 @Moneda_P       = (CASE WHEN cacodpos1 = 14  THEN cacodmon2 
											 WHEN catipoper = 'C' THEN cacodmon2 
											 WHEN catipoper = 'V' THEN cacodmon2                                         
											 ELSE cacodmon1
									   END),
					 @Duration_A     = (CASE WHEN DATEDIFF(DAY,@dFecPro,cafecEfectiva) < 0 THEN 0 ELSE ROUND(DATEDIFF(DAY,@dFecPro,cafecEfectiva) / 365.0 ,4) END),
					 @Duration_P     = (CASE WHEN DATEDIFF(DAY,@dFecPro,cafecEfectiva) < 0 THEN 0 ELSE ROUND(DATEDIFF(DAY,@dFecPro,cafecEfectiva) / 365.0 ,4) END),
					 @Tipo_Producto  = cacodpos1 ,
					 @M_Durat		= catasfwdcmp

					   		
			  FROM   BacFwdsuda..MFCA
			  WHERE  canumoper       = @nNumoper


			  IF @M_Durat = 0 AND @Tipo_Producto = 10
				 EXECUTE SP_BUSCA_DURATION  @Serie_Valor  ,   --Papel 
											@dFecPro  ,
											@M_Durat   OUTPUT

				 SET @M_Durat     = CASE WHEN @Tipo_Producto =10 THEN @M_Durat ELSE @Duration_A END

			  SELECT @Duration_A  = CASE WHEN catipoper = 'C' THEN @M_Durat    ELSE @Duration_A END
			  ,      @Duration_P  = CASE WHEN catipoper = 'C' THEN @Duration_p ELSE @M_Durat    END
			  FROM   BacFwdSuda..MFCA
			  WHERE  canumoper    = @nNumoper
			  AND    cacodpos1    IN(10,11)

				  EXECUTE SP_Riesgo_Potencial_Futuro  @nNumoper,   
													  @cSistema,
													  @cProducto,
													  @Tipo_Oper,
													  @Capital_A,
													  @Capital_P,
													  @Plazo_A,
													  @Plazo_P,
													  @Moneda_A,
													  @Moneda_P,
													  @Duration_A,
													  @Duration_P,
													  @dFecPro, 
													  @SubTotal OUTPUT,
													  @Prc      OUTPUT
						-- select 'CER SP_LCR_VRAZONABLE_NEGATIVO', @dFecPro, @cSistema, @nNumoper, @SubTotal, @Utilidadlin_pesos, @TotalGeneral OUTPUT
							  -- Esto es solo para el recálculo
							  -- EXECUTE dbo.SP_LCR_VRAZONABLE_NEGATIVO @dFecPro, @cSistema, @nNumoper, @SubTotal, @Utilidadlin_pesos, @TotalGeneral OUTPUT
					SET @TotalGeneral = @SubTotal
		   END -- IF  @cSistema  = 'BFW'  and  @MetodoLCR in (1,4)

		   IF @cSistema = 'PCS'   and  @MetodoLCR in (1,4)  -- PRD8800
		   BEGIN
			  SET @Serie_Valor  = ''
			  SET @Tipo_Oper    = ''
			  SET @Capital_A    = 0.0
			  SET @Plazo_A      = 0
			  SET @Moneda_A     = 999
			  SET @Duration_A   = 0



			  SELECT @Capital_A      = compra_capital + compra_flujo_adicional
			  ,      @Plazo_A        = CASE WHEN Compra_codigo_tasa  = 0 THEN DATEDIFF(d,@dFecPro,fecha_Termino)
											ELSE                              DATEDIFF(d,@dFecPro,fecha_vence_Flujo)
										END
			  ,      @Moneda_A        = compra_moneda
			  ,      @Duration_A      = CASE WHEN vDurMacaulActivo < 0 THEN 0.0 ELSE vDurMacaulActivo  END
			  FROM   BACSWAPSUDA..cartera
			  WHERE  numero_operacion = @nNumoper
			  AND    Tipo_flujo       = 1
			  AND   (estado_flujo     = 1
				  OR estado_Flujo     = 2 and fecha_termino = @dFecPro
					)
		               
			  SET @Capital_P    = 0.0
			  SET @Plazo_P      = 0
			  SET @Moneda_P     = 999
			  SET @Duration_P   = 0

			  SELECT @Capital_P    = venta_capital + Venta_Flujo_Adicional
			  ,      @Plazo_P      = CASE WHEN Venta_codigo_tasa  = 0 THEN DATEDIFF(d,@dFecPro,fecha_termino)
										  ELSE                             DATEDIFF(d,@dFecPro,fecha_vence_flujo)
									 END
			  ,      @Moneda_P     = venta_moneda
			  ,      @Duration_P   = CASE WHEN vDurMacaulPasivo < 0 THEN 0.0 ELSE vDurMacaulPasivo END
			  FROM   BACSWAPSUDA..cartera
			  WHERE  numero_operacion = @nNumoper
			  and    Tipo_flujo    = 2
			  and   (estado_flujo  = 1 
				  or estado_Flujo  = 2 and fecha_termino = @dFecPro 
					) 

			  EXECUTE SP_Riesgo_Potencial_Futuro  @nNumoper, 
												  @cSistema,
												  @cProducto,
												  @Tipo_Oper,
												  @Capital_A,  
												  @Capital_P,
												  @Plazo_A,
												  @Plazo_P,
												  @Moneda_A,
												  @Moneda_P,
												  @Duration_A,
												  @Duration_P,
												  @dFecPro, 
												  @SubTotal output, 	
												  @Prc      output

			  --EXECUTE dbo.SP_LCR_VRAZONABLE_NEGATIVO @dFecPro, @cSistema, @nNumoper, @SubTotal, @Utilidadlin_pesos, @TotalGeneral OUTPUT
			  IF @cProducto = 'ST' 
				 SET @cProducto = '3'

			  IF  @cProducto = 'SM' 
				 SET @cProducto = '2'

			  SET @TotalGeneral = @SubTotal

		   END -- IF @cSistema = 'PCS'   and  @MetodoLCR in (1,4)  -- PRD8800   
		  
		   if   @MetodoLCR not in (1,4)
			   SET @TotalGeneral =  @Resultado  - case when @MetodoLCR in (1,4) then 0 else @Garantia end         
			   /*
			   truncate table DEBUG_VALORES
		 
			   insert into DEBUG_VALORES -- truncate table DEBUG_VALORES  -- select * from DEBUG_VALORES
			   select  Variable01 = '@TotalGeneral'
         			  , Valor01 = @TotalGeneral
      				  , Variable02 = '@MetodoLCR'
      				  , Valor02    = @MetodoLCR
			   */


		   -- 0. Pasos de conversión segun las LCR.

		   -- 1. Calculo se genera en CLP, se registra antes de convertir
		   --    en la variable @nMontolin_pesos
		   SET @nMontolin_pesos  = ROUND(@TotalGeneral,0)

		   -- 2. Fecha con la cual se rescataran los valores 
		   --    para la conversión
		   Select @dFechaHoy = acfecante from bacTradersuda..mdac
		                                                              

		   -- 3. Conversion según moneda de la línea General
		   SET     @FactorCnvLinGen = 1
		   SET     @nMontolinGen    = @TotalGeneral
		   SELECT  @nMontolinGen 	= ROUND(@TotalGeneral / Tipo_Cambio ,4)
				 , @GarantiaLinGen  = ROUND( @Garantia / Tipo_Cambio, 4 )
				 , @FactorCnvLinGen = Tipo_Cambio 
			  FROM    BACPARAMSUDA..VALOR_MONEDA_CONTABLE
			  WHERE   fecha		= @dFechaHoy
			  AND     Codigo_Moneda = (CASE WHEN @nMonedaLinGen = 13 THEN 994 ELSE @nMonedaLinGen END)

		                                                     
		   -- 4. Conversión según moneda de la linea Sistema          
		   SET     @FactorCnvLinSis  = 1
		   SET     @nMontoLinSis    = @TotalGeneral   
		   SELECT  @nMontoLinSis	= ROUND( @TotalGeneral /  Tipo_Cambio ,4)
			  ,    @GarantiaLinSis  = ROUND( @Garantia / Tipo_Cambio, 4 )
			  ,    @SoloCnvLinPro   = Tipo_Cambio
			  ,    @FactorCnvLinSis = Tipo_Cambio
			  FROM    BACPARAMSUDA..VALOR_MONEDA_CONTABLE   
			  WHERE   fecha		    = @dFechaHoy
			  AND     Codigo_Moneda	 = (CASE WHEN @nMonedaLinSis = 13 THEN 994 ELSE @nMonedaLinSis END)

		   SET @nMontolin_pesos = @nMontolin_pesos 
		   SET @nMontolin 	    = @nMontolin       
		   SET @nMontoLinPro    = @nMontoLinSis    
		   SET @nMontoLinSis    = @nMontoLinSis    
		   SET @nMontoLinGen    = @nMontoLinGen    

		-- PRD8800

		   -- SELECT 'CER@iFound',@iFound
		 IF @iFound = 1  
		 BEGIN  
		  --*************************************  
		  --***************  
		  --*************** LINEA GENERAL  
		  --***************  
		  --*************************************  
			  IF @cBloqueadoLinGen = 'S'  --** Linea General Bloqueada para operar **--
		  BEGIN  
		  
				 SELECT @cMensaje = 'Linea General Bloqueada Para ' + ltrim(rtrim( @cNombre ))   
								 -- + ' motivo : ' + ltrim(rtrim( @xMensajeBloqueo ))
					,   @cError   = 'S'        
					,   @nExceso  = 0        
					,   @nCorrDet = @nCorrDet + 1  
		  
				 IF @cError   = 'S'   
					INSERT INTO #Tmp_Error SELECT 'LIN', @nCorrDet, @cMensaje, @nExceso  
		  END  
		   
			  IF @dFecPro > @dFecvctolineaLinGen
		  BEGIN  
				 SELECT @cMensaje = 'Linea General Vencida Para ' + @cNombre  
					,   @cError   = 'S'        
					,   @nExceso  = 0        
					,   @nCorrDet = @nCorrDet + 1  
		  
				 IF @cError   = 'S'   
					INSERT INTO #Tmp_Error SELECT 'LIN', @nCorrDet, @cMensaje, @nExceso  
		  END  
		  
			  Set @nDisponibleLinGen =  case when @MetodoLCR in (1,4) then @nDisponibleLinGen 
																	  else @nTotalAsignadoLinGen end 
										- @nMontoLinGen

			  IF @nDisponibleLinGen < 0 
				 SELECT @nExceso = @nDisponibleLinGen * (-1)
			  ELSE     
				 SELECT @nExceso = 0
		  
			  IF @nExceso > 0
				 SELECT @cMensaje = 'Limite General Exedido Para ' + @cNombre    
					,   @cError   = 'S'        
					,   @nExceso  = @nExceso 
		  ELSE  
				 SELECT @cMensaje = ''   
					,   @cError   = 'N'   
					,   @nExceso  = 0  
		  
		  SELECT @nCorrDet = @nCorrDet + 1  
		  
			  IF @cError  = 'S'  
				 INSERT INTO #Tmp_Error SELECT 'LIN', @nCorrDet, @cMensaje, @nExceso  
		  
		  --*************************************  
		  --***************   
		  --*************** LINEA SISTEMA  
		  --***************   
		  --*************************************  
		   SELECT   @nDisponible   = 0  
		   SELECT @nDisponible   = totaldisponible,  
			  @cBloqueado    = bloqueado     ,  
				  @dFecvctolinea   = fechavencimiento  
		  FROM LINEA_SISTEMA  
		  WHERE rut_cliente  = @nRutcli   
			AND codigo_cliente  = @nCodigo  
			AND id_sistema  = @cSistema  
		  
		  IF @cBloqueadoLinSis ='S'  --** Linea Sistema Bloqueada para operar **--
		  BEGIN  
			  SELECT @cMensaje = 'Linea Sistema Bloqueada Para ' + @cNombre    
				 ,   @cError   = 'S'        
				 ,   @nExceso  = 0    
				 ,   @nCorrDet = @nCorrDet + 1  
		  
			  IF @cError   = 'S'   
				 INSERT INTO #Tmp_Error SELECT 'LIN', @nCorrDet, @cMensaje, @nExceso  
		  END  
		   
			  IF @dFecPro > @dFecvctolineaLinSis
		  BEGIN  
			  SELECT @cMensaje = 'Linea Sistema Vencida Para ' + @cNombre    
				 ,   @cError   = 'S'        
				 ,   @nExceso  = 0        
				 ,   @nCorrDet = @nCorrDet + 1  
		  
			  IF @cError   = 'S'   
				 INSERT INTO #Tmp_Error SELECT 'LIN', @nCorrDet, @cMensaje, @nExceso  
		  END  
		  
			  Set @nDisponibleLinSis = case when @MetodoLCR in (1,4) then @nDisponibleLinSis 
																	  else @nTotalAsignadoLinSis end 
										- @nMontoLinSis

		 IF @nDisponibleLinSis < 0
				 SELECT @nExceso = @nDisponibleLinSis * (-1)
		   ELSE     
				 SELECT @nExceso = 0
		  
			  IF @nExceso > 0
		   SELECT  @cMensaje = 'Limite Sistema Exedido Para ' + @cNombre  ,  
			@cError   = 'S'      ,  
				 @nExceso  = @nExceso 
		  ELSE  
		   SELECT  @cMensaje = '' ,  
			@cError   = 'N' ,  
			@nExceso  = 0  
		  SELECT @nCorrDet = @nCorrDet + 1  
		  
		   IF @cError   = 'S'   
			  INSERT INTO #Tmp_Error SELECT 'LIN', @nCorrDet, @cMensaje, @nExceso  
		  

			  -- PRD8800
			  --*************************************
			  --*************************************
			  --*************** 
			  --*************** LINEA POR PLAZO
			  --*************** 
		  --*************************************  

			  SET @ndisponibleLinPla = 0
			  SET @nTotalAsignadoLinPla = 0
			  SELECT    @nPlazoDesde          = ISNULL(PlazoDesde,0)    
				 ,      @nPlazoHasta          = ISNULL(PlazoHasta,0)    
				 ,      @ndisponibleLinPla    = Totaldisponible 
				 ,      @nTotalAsignadoLinPla = TotalAsignado   
				 FROM   LINEA_PRODUCTO_POR_PLAZO    
				 WHERE  rut_cliente = @nRutcli    
				 AND    codigo_cliente = @nCodigo   
		 
				 AND    (
						   id_sistema = @cSistema    
					AND    codigo_producto = @cProducto    
					AND    incodigo = @incodigo
					AND    plazodesde     <= @nnPlazoProdPla    
					AND    plazohasta     >= @nnPlazoProdPla    
					AND    @MetodoLCR in (1,4) 
						or
						   id_sistema = @Id_SistemaNetting    
					AND    codigo_producto = @Id_SistemaNetting    
					AND    @MetodoLCR not in (1,4) 
						) 
		         
				 -- SET ROWCOUNT 0    MAP: Me parece peligroso
			/*
				 IF @nplazodesde = null    
				 BEGIN    
					EXECUTE Sp_Lineas_Actualiza    
					RETURN    
				 END    
		    
				 IF @nplazohasta = null    
				 BEGIN    
					EXECUTE Sp_Lineas_Actualiza    
					RETURN    
				 END    
			*/



				 Set @nDisponibleLinPla = case when @MetodoLCR in (1,4) then @nDisponibleLinPla
																		else @nTotalAsignadoLinPla end
										- @nMontoLinSis

				 IF @nDisponibleLinPla < 0    
					SET @nExceso = @nDisponibleLinPla * (-1)    
				 ELSE    
					SET @nExceso = 0   

				 IF @nExceso > 0    
				 BEGIN
					IF @MetodoLCR in (1,4)       
					   SELECT  @cMensaje = 'Limite Plazo desde ' + RTRIM(LTRIM((CONVERT(CHAR(06),@nplazodesde)))) + ' Hasta ' +  RTRIM(LTRIM((CONVERT(CHAR(06),@nplazohasta))))     
									  + ' Exedido Para ' + @cNombre
							   , @cError   = 'S'    
							   , @nExceso  = @nExceso      
					ELSE
					   SELECT  @cMensaje = 'Limite Plazo Exedido Para ' + @cNombre
							 , @cError   = 'S'    
							 , @nExceso  = @nExceso    
					SET @nCorrDet  = @nCorrDet + 1 
				 END
				 ELSE    
					SELECT @cMensaje = '', @cError   = 'N', @nExceso  = 0    
		      
				 IF @cError   = 'S' 
					INSERT INTO #Tmp_Error SELECT 'LIN', @nCorrDet, @cMensaje, @nExceso

		--*************************************
		-- PRD8800

		   END ELSE  
		 BEGIN  
		  RETURN  
		 END  
    END -- FIN CONTROL IDD IF <> S
END  
GO
