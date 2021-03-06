USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_GRABAR_OPERACION_IRF]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ACT_GRABAR_OPERACION_IRF]
                                            @ccodigo_producto                    CHAR(05)
                                         ,  @nnumero_operacion                   NUMERIC(10)
                                         ,  @nnumero_documento                   NUMERIC(10)
                                         ,  @ncorrelativo                        NUMERIC(10)
                                         ,  @ctipo_operacion                     CHAR(05)
                                         ,  @ntotal_operacion                    FLOAT
                                         ,  @imoneda_operacion                   INTEGER
                                         ,  @iplazo_operacion                    INTEGER
                                         ,  @ntasa_operacion                     FLOAT
                                         ,  @nmonto_inicial_um                   FLOAT
                                         ,  @nmonto_final_um                     FLOAT
                                         ,  @dfecha_vencimiento_operacion        CHAR(08)
                                         ,  @nrut_cliente                        NUMERIC(10)
                                         ,  @ncodigo_cliente                     NUMERIC(10)
                                         ,  @isucursal                           INTEGER
                                         ,  @iforma_pago_inicial                 INTEGER
                                         ,  @iforma_pago_final                   INTEGER
                                         ,  @ctipo_pago                          CHAR(1)
                                         ,  @cobservaciones                      VARCHAR(255)
                                         ,  @cdeskmngr_keyid                     NUMERIC(09)
                                         ,  @cdeskmngr_libro                     NUMERIC(09)
                                         ,  @cterminal                           CHAR(15)
                                         ,  @cusuario                            CHAR(15)
                                         ,  @icodigo_instrumento                 INTEGER
                                         ,  @cserie_instrumento                  CHAR(12)
                                         ,  @cgenerico_emisor                    CHAR(05)
                                         ,  @nnominal                            FLOAT
                                         ,  @ntir                                FLOAT
                                         ,  @nporcentaje_valor_par               FLOAT
                                         ,  @nvalor_presente                     FLOAT
                                         ,  @ccustodia                           CHAR(1)
                                         ,  @cclave_dcv                          CHAR(10)
                                         ,  @ntir_mercado                        FLOAT
                                         ,  @nporcentaje_valor_par_mercado       FLOAT
                                         ,  @nvalor_mercado                      FLOAT
                                         ,  @nutilidad                           FLOAT
           			         ,  @nconvexidad 	                 FLOAT
				         ,  @nduration_macauly                   FLOAT
				         ,  @nduration_modificado                FLOAT
                                         ,  @codigo_linea                        VARCHAR(05) = ' '
                                         ,  @codigo_carterasuper                 CHAR(1) = ' '
                                         ,  @tipo_cartera                        VARCHAR(01) = 1
                                         ,  @precio_transferencia                FLOAT   = 0
                                         ,  @codigo_area                         VARCHAR(05) = ''
				         ,  @corresponsal_bco                    VARCHAR(20) = ''
                                         ,  @corresponsal_cli                    VARCHAR(20) = ''
                                         ,  @nValor_inicial_pacto                FLOAT = 0
                                         ,  @nValor_final_pacto                  FLOAT = 0
					 ,  @cTipo_retiro			 CHAR(1)  ='I'
					 ,  @cLaminas				 CHAR(1)  =' '	
                                         ,  @ntir_traspaso                       FLOAT  = 0 
                                         ,  @nmonto_traspaso                     FLOAT  = 0
                                         ,  @ndiferencia_traspaso                FLOAT  = 0
                                         ,  @nlibro_origen_traspaso              FLOAT  = 0
                                         ,  @nlibro_transferencia                FLOAT  = 0
                                         ,  @ninteres_transferencia	         FLOAT  = 0
					 ,  @nNominal_FLI			 NUMERIC(22,4) = 0
                                      
AS
BEGIN

    SET TRANSACTION ISOLATION LEVEL READ COMMITTED
    SET NOCOUNT ON
    SET DATEFORMAT dmy

    DECLARE @rut_entidad             NUMERIC(10)
        ,   @fecha_proceso           DATETIME
        ,   @seriado                 CHAR(01)
        ,   @familia_instrumento     CHAR(12)
        ,   @rut_emisor              NUMERIC(10)
        ,   @moneda_instrumento      CHAR(05)
        ,   @fecha_emision           DATETIME
        ,   @fecha_vencimiento       DATETIME
        ,   @base_emision            INTEGER
        ,   @tasa_emision            FLOAT
        ,   @id_sistema              CHAR(03)
        ,   @fecha_ultimo_cupon      DATETIME
        ,   @fecha_proximo_cupon     DATETIME
        ,   @numero_ultimo_cupon     INTEGER
        ,   @numero_proximo_cupon    INTEGER
        ,   @valor_presente_base_100 FLOAT
        ,   @moneda_emision          NUMERIC(03)
        ,   @tipo_retiro             CHAR(1)
        ,   @ibase_operacion         INTEGER
        ,   @tipo_cartera_financiera CHAR(01)
        ,   @ctipo_moneda            CHAR(01)
        ,   @cNemo_moneda            CHAR(08)
        ,   @dParidad                FLOAT
        ,   @cFuerte_moneda          CHAR(01)
        ,   @dDolar_Obs              FLOAT
        ,   @nValor_inicio_Pacto     NUMERIC(19,4)

          
SELECT @tipo_retiro = @ctipo_retiro

DECLARE @fecha_proceso_caracter     CHAR(10)
    ,   @fecha_vencimiento_caracter CHAR(10)
    ,   @fecha_emision_caracter     CHAR(10)
    ,   @fecha_vcto_caracter        CHAR(10)


DECLARE @valor_moneda     FLOAT
    ,   @monto_pesos      FLOAT
     
    SET @id_sistema = 'BTR'

    IF @nrut_cliente = 0 
        SELECT @nrut_cliente = clrut
              ,@ncodigo_cliente = clcodigo
                  FROM VIEW_CLIENTE
                  WHERE NumPro_PU = @ncodigo_cliente

    SELECT   @rut_entidad   = rut_entidad
        ,    @fecha_proceso = fecha_proceso
        FROM VIEW_DATOS_GENERALES

    SELECT @valor_moneda = 1 

    SELECT @valor_moneda = ISNULL(CASE WHEN mnextranj = '0' THEN 1 ELSE vmvalor END,1) 
    FROM VIEW_VALOR_MONEDA,VIEW_MONEDA
    WHERE vmcodigo = @imoneda_operacion
    AND vmfecha    = @fecha_proceso
    AND vmcodigo = mncodmon



    SET @dDolar_Obs = ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA,VIEW_DATOS_GENERALES
                                         WHERE vmcodigo = 994
                                         AND vmfecha    = fecha_proceso),1)


    SELECT @ibase_operacion = mnbase,
           @ctipo_moneda     = mnextranj,
           @cNemo_moneda    = mnnemo,
           @cFuerte_moneda = mnrrda
     FROM VIEW_MONEDA
     WHERE mncodmon = @imoneda_operacion

    SELECT @fecha_proceso_caracter = CONVERT(CHAR(10), @fecha_proceso, 112)


IF @codigo_area = ''
    SET @codigo_area = ISNULL((SELECT codigo_area FROM VIEW_USUARIO WHERE usuario = @cusuario),'')


IF @ccodigo_producto NOT IN ('IB','TD','LBC', 'FPD') BEGIN
	CREATE TABLE #TEMP_INSTRUMENTO(
            	    error		INTEGER     NULL
		,   mascara	        CHAR(12)    NULL
		,   codigo              INTEGER     NULL
		,   serie		CHAR(12)    NULL
		,   rutemi	        NUMERIC(10) NULL
		,   monemi	        NUMERIC(03) NULL
		,   tasemi	        FLOAT       NULL
		,   basemi	        NUMERIC(03) NULL
		,   fecemi	        DATETIME    NULL
		,   fecven	        DATETIME    NULL
		,   refnomi	        CHAR(1)     NULL
		,   genemi	        CHAR(05)    NULL
		,   nemmon	        CHAR(03)    NULL
		,   corte		FLOAT       NULL
		,   seriado	        CHAR(01)    NULL
		,   lecemi	        CHAR(10)    NULL
		,   fecpro	        DATETIME    NULL
                ,   tipo_moneda       CHAR(1) NULL
                ,   Decimales           NUMERIC(5)  Null
                )

        INSERT #TEMP_INSTRUMENTO
            EXEC SP_CHKINSTSER @cserie_instrumento

    SELECT @rut_emisor          = rutemi
        ,  @seriado             = seriado
        ,  @familia_instrumento = serie
        ,  @fecha_emision       = fecemi
        ,  @fecha_vencimiento   = fecven
        ,  @tasa_emision        = tasemi
        ,  @moneda_emision      = monemi
        ,  @base_emision        = basemi
        ,  @moneda_instrumento  = nemmon
        FROM #TEMP_INSTRUMENTO

    IF @seriado = 'N' BEGIN
          SELECT @rut_emisor    = emrut 
          FROM   VIEW_EMISOR
          WHERE  emgeneric = @cgenerico_emisor
    END

        CREATE TABLE #TEMP_DATOS_INSTRUMENTO(
	      	                 fError	        INTEGER  NULL
		                ,fNominal	FLOAT    NULL
		                ,fTir		FLOAT    NULL
		                ,fPvp		FLOAT    NULL
		                ,fMT		FLOAT    NULL
		                ,fMTUM		FLOAT    NULL
		                ,fMT_cien	FLOAT    NULL
		                ,fVan		FLOAT    NULL
		                ,fVpar		FLOAT    NULL
		                ,nNumucup	INTEGER  NULL
		                ,cFecucup	DATETIME NULL
		                ,fIntucup	FLOAT    NULL
		                ,fAmoucup	FLOAT    NULL
		                ,fSalucup	FLOAT    NULL
		                ,nNumpcup	INTEGER  NULL
		                ,cFecpcup	DATETIME NULL
                                ,fIntpcup	FLOAT    NULL
		                ,fAmopcup	FLOAT    NULL
		                ,fSalpcup	FLOAT    NULL
		                ,fDurat         FLOAT    NULL
		                ,fConvx	        FLOAT    NULL
		                ,fDurmo	        FLOAT    NULL
                                )

    SELECT @fecha_emision_caracter   = CONVERT(CHAR(10),@fecha_emision,112)
          ,@fecha_vcto_caracter      = CONVERT(CHAR(10),@fecha_vencimiento,112)

        INSERT #TEMP_DATOS_INSTRUMENTO
        EXEC SP_VALORIZAR_CLIENT
                                 @modcal	= 2
    				,@cFeccal	= @fecha_proceso_caracter
				,@nCodigo	= @icodigo_instrumento
				,@cMascara	= @cserie_instrumento
				,@nMonemi	= @moneda_emision
				,@cFecemi	= @fecha_emision_caracter
				,@cFecven	= @fecha_vcto_caracter
				,@fTasemi	= @tasa_emision
				,@fBasemi	= @base_emision
				,@fTasest	= 0.0
				,@fNominal	= @nnominal
				,@fTir		= @ntir
				,@fPvp		= @nporcentaje_valor_par
				,@fMT		= 0

        SELECT  @fecha_ultimo_cupon      = cFecucup
            ,   @fecha_proximo_cupon     = cFecpcup
            ,   @numero_ultimo_cupon     = nNumucup
            ,   @numero_proximo_cupon    = nNumpcup
            ,   @valor_presente_base_100 = fMT_cien
        FROM #TEMP_DATOS_INSTRUMENTO
END

/*
        SELECT @tipo_retiro = valor_caracter
        FROM VIEW_CONFIGURACION_DE_VALORES 
        WHERE codigo_sistema = @id_sistema 
        AND codigo_producto = @ccodigo_producto 
        AND UPPER(nombre_original_campo) = 'MOVAMOS'
*/
        SET @tipo_cartera_financiera = ' '
/*        
        ******  ESTO FUE COMENTARIADO PORQUE GRABABA EL CODIGO SUPER Y NO EL CODIGO DE 
        CARTERA FINANCIERA ******
        SELECT @tipo_cartera_financiera = SUBSTRING(descripcion,1,1)   
            FROM VIEW_TIPO_CARTERA
            WHERE id_sistema = @id_sistema 
              AND codigo_producto = @ccodigo_producto 
              AND codigo_cartera = @tipo_cartera
*/
      SELECT @tipo_cartera = CASE WHEN @codigo_carterasuper = 'T' THEN 1 
                                  WHEN @codigo_carterasuper = 'P' THEN 2
                                  ELSE 0 END
      SELECT @tipo_cartera_financiera = CONVERT( CHAR(1) , @tipo_cartera )


/********************************  COMPRAS PROPIAS *********************************************/
    IF @ccodigo_producto = 'CP' BEGIN

            EXEC SP_GRABARCP
			 @nrutcart	= @rut_entidad     	   -- rut de la cartera
			,@ctipcart	= @tipo_cartera            -- codigo del tipo de cartera
			,@nnumdocu	= @nnumero_documento       -- numero del documento
			,@ncorrela	= @ncorrelativo            -- correlativo de la operaci®n
			,@cmascara	= @cserie_instrumento      -- familia del instrumento
			,@cinstser	= @cserie_instrumento      -- serie
			,@cgenemi	= @cgenerico_emisor        -- generico del emisor
			,@cnemomon	= @moneda_instrumento      -- generico de la moneda
			,@nnominal	= @nnominal                -- nominles  
			,@ntir		= @ntir                    -- tir de compra 
			,@npvp		= @nporcentaje_valor_par   -- porcentaje valor presente
			,@nvpar		= 0--@nvalor_par              -- valor par
			,@nvptirc	= @nvalor_presente         -- valor presente a tir de compra
			,@nnumucup	= @numero_ultimo_cupon     -- numero del ultimo cupon vencido
			,@nrutcli	= @nrut_cliente            -- rut del cliente
                    	,@ncodcli       = @ncodigo_cliente         -- codigo de cliente
			,@cfecpro	= @fecha_proceso           -- fecha de proceso
			,@ntasest	= 0.0                      -- tasa estimada
			,@cfecemi	= @fecha_emision           -- fecha de emisi®n
			,@cfecven	= @fecha_vencimiento       -- fecha de vencimiento
			,@cmdse		= @seriado                 -- indica si es seriado o no
			,@ncodigo	= @icodigo_instrumento     -- codigo de la familia
			,@cserie	= @familia_instrumento     -- serie de la familia
			,@nmonemi	= @moneda_emision          -- moneda de emision
			,@nrutemi	= @rut_emisor              -- rut del emisor
 			,@ntasemi	= @tasa_emision            -- tasa estimada
			,@nbasemi	= @base_emision            -- base emision
			,@ctipcust	= @ccustodia               -- tipo de custodia
			,@nforpagi	= @iforma_pago_inicial     -- forma de pago
			,@cretiro	= @tipo_retiro             -- tipo de retiro
			,@cusuario	= @cusuario                -- usuario
			,@cterminal	= @cterminal               -- terminal
			,@dfecpcup	= @fecha_proximo_cupon     -- fecha de cup½n
			,@csi_dcv	= @ccustodia               -- custodia dcv
			,@cclave_dcv	= @cclave_dcv              -- clave dcv
           		,@dconvexidad 	= @nconvexidad             -- convexidad
			,@dduratmac 	= @nduration_macauly       -- durati¢n macaulay
			,@dduratmod	= @nduration_modificado    -- duration modificado
         		,@codigo_carterasuper 	= @codigo_carterasuper
			,@tipo_cartera_financiera	= @tipo_cartera_financiera
			,@mercado			= ' '
			,@sucursal			= @isucursal
			,@id_sistema			= 'BTR'
			,@fecha_pagomañana		= @fecha_proceso
			,@laminas			= @claminas --''
			,@tipo_inversion		= 'V'
                        ,@pagohoy                       = @ctipo_pago
			,@moobserv			= @cobservaciones
                        ,@valvenc                       = 0 
                        ,@Cuenta_Corriente_Inicio       = ' '
                        ,@Sucursal_Inicio               = ' '
                        ,@codigo_area                   = @codigo_area
                        ,@deskmngr_keyid                = @cdeskmngr_keyid
                        ,@deskmngr_libro                = @cdeskmngr_libro
                        ,@codigo_corresponsal_bco       = @corresponsal_bco
                        ,@codigo_corresponsal_cli       = @corresponsal_cli
                        ,@tir_traspaso                  = @ntir_traspaso 
                        ,@monto_traspaso                = @nmonto_traspaso
                        ,@diferencia_traspaso          = @ndiferencia_traspaso
                        ,@libro_origen_traspaso        = @nlibro_origen_traspaso

    END
/********************************  COMPRAS PROPIAS *********************************************/

/********************************  VENTAS DEFINITIVAS ******************************************/
    IF @ccodigo_producto = 'VP' BEGIN
            EXEC SP_GRABARVP
		         @nnumoper			= @nnumero_operacion      -- numero de operaci¢n de venta
			,@nrutcart			= @rut_entidad            -- rut de la cartera
			,@ntipcart			= @tipo_cartera           -- codigo del tipo de cartera
			,@nnumdocu			= @nnumero_documento      -- numero del  documento
			,@ncorrela			= @ncorrelativo           -- correlativo de la operaci¢n
			,@nnominal			= @nnominal   -- nominales vendidos
			,@ntir				= @ntir                   -- tir de venta
			,@npvp				= @nporcentaje_valor_par  -- porcentaje valor par (v)
			,@nvpar				= 0--@nvalor_par             -- valor par (v)
			,@nvptirv			= @nvalor_presente        -- valor presente a tir de venta (v)
			,@nnumucup			= @numero_ultimo_cupon    -- numero del £ltimo cup¢n vencido (v)
        	        ,@nrutcli			= @nrut_cliente           -- rut del cliente (v)
		        ,@ncodcli			= @ncodigo_cliente        -- codigo del cliente (v)
			,@cfecpro			= @fecha_proceso          -- fecha de proces o (v)
			,@ntasest			= 0.0                     -- tasa estimada (v)
			,@nmonemi			= @moneda_emision         -- moneda del emisor
			,@nrutemi			= @rut_emisor             -- rut del emisor
			,@ntasemi			= @tasa_emision           -- tasa emision
			,@nbasemi			= @base_emision           -- base emision
 			,@ctipcust			= @ccustodia              -- tipo de custodia
			,@nforpagi			= @iforma_pago_inicial    -- forma de pago
			,@cretiro			= @tipo_retiro            -- tipo de retiro
			,@cusuario			= @cusuario               -- usuario
			,@cterminal			= @cterminal              -- terminal
			,@cmascara			= @cserie_instrumento     --  familia del instrumento
			,@cinstser			= @cserie_instrumento     -- serie
			,@cgenemi			= @cgenerico_emisor       -- generico del emisor
			,@cnemomon			= @moneda_emision         -- generico de la moneda
			,@cfecemi			= @fecha_emision          -- fecha de emisi¢n
			,@cfecven			= @fecha_vencimiento      -- fecha de vencimiento
			,@ncodigo			= @icodigo_instrumento    -- codigo de la familia
			,@ncorrvent			= 0 -- correlativo de ventas
			,@clave_dcv			= @cclave_dcv             -- clave dcv		
			,@codigo_carterasuper 		= @codigo_carterasuper
			,@tipo_cartera_financiera	= @tipo_cartera_financiera
			,@mercado			= ' '
			,@sucursal			= @isucursal
			,@id_sistema			= 'BTR'
			,@fecha_pagomañana		= @fecha_proceso
			,@laminas			= @claminas--' '
			,@tipo_inversion		= 'V'
			,@observacion			= @cobservaciones
                        ,@Cuenta_Corriente_Inicio       = ' '
                        ,@Sucursal_Inicio               = ' '
                        ,@pagohoy                       = @ctipo_pago
                        ,@codigo_area                   = @codigo_area
                        ,@deskmngr_keyid                = @cdeskmngr_keyid
                        ,@deskmngr_libro                = @cdeskmngr_libro
                        ,@xmonto_traspaso                = @nmonto_traspaso
                        ,@xdiferencia_traspaso          = @ndiferencia_traspaso
                        ,@tir_traspaso                  = @ntir_traspaso 
                        ,@libro_origen_traspaso        = @nlibro_origen_traspaso


    END
/********************************  VENTAS DEFINITIVAS ******************************************/

/********************************  SORTEO DE LETRAS*******************************************/
    IF @ccodigo_producto = 'SLH' BEGIN
    EXEC SP_GRABARST
			 @nnumoper			 = @nnumero_operacion      -- numero de operaci¢n de venta
			,@nrutcart			 = @rut_entidad            -- rut de la cartera
			,@ntipcart			 = @tipo_cartera           -- codigo del tipo de cartera
			,@nnumdocu			 = @nnumero_documento      -- numero del  documento
			,@ncorrela			 = @ncorrelativo           -- correlativo de la operaci¢n
			,@nnominal			 = @nnominal               -- nominales vendidos
			,@ntir				 = @ntir                   -- tir de venta
			,@npvp				 = @nporcentaje_valor_par  -- porcentaje valor par (v)
			,@nvpar				 = 0                       -- valor par (v)
			,@nvptirv			 = @nvalor_presente        -- valor presente a tir de venta (v)
			,@nnumucup			 = @numero_ultimo_cupon    -- numero del £ltimo cup¢n vencido (v)
        	        ,@nrutcli			 = @nrut_cliente           -- rut del cliente (v)
		        ,@ncodcli			 = @ncodigo_cliente        -- codigo del cliente (v)
			,@cfecpro			 = @fecha_proceso          -- fecha de proces o (v)
			,@ntasest			 = 0.0                     -- tasa estimada (v)
			,@nmonemi			 = @moneda_emision         -- moneda del emisor
			,@nrutemi			 = @rut_emisor             -- rut del emisor
			,@ntasemi			 = @tasa_emision           -- tasa estimada
			,@nbasemi			 = @base_emision           -- base estimada
 			,@ctipcust			 = @ccustodia              -- tipo de custodia
			,@nforpagi			 = @iforma_pago_inicial    -- forma de pago
			,@cretiro			 = @tipo_retiro            -- tipo de retiro
			,@cusuario			 = @cusuario               -- usuario
			,@cterminal			 = @cterminal              -- terminal
			,@cmascara			 = @cserie_instrumento     --  familia del instrumento
			,@cinstser			 = @cserie_instrumento     -- serie
			,@cgenemi			 = @cgenerico_emisor       -- generico del emisor
			,@cnemomon			 = @moneda_emision         -- generico de la moneda
			,@cfecemi			 = @fecha_emision          -- fecha de emisi¢n
			,@cfecven			 = @fecha_vencimiento      -- fecha de venc imiento
			,@ncodigo			 = @icodigo_instrumento    -- codigo de la familia
			,@ncorrvent			 = 0-- correlativo de ventas
			,@clave_dcv			 = @cclave_dcv             -- clave dcv		
			,@codigo_carterasuper 		 = @codigo_carterasuper
			,@tipo_cartera_financiera 	 = @tipo_cartera_financiera
			,@mercado		 	 = ' '
			,@sucursal			 = @isucursal
			,@id_sistema			 = 'BTR'
			,@fecha_pagomañana		 = @fecha_proceso
			,@laminas			 = @claminas --' '
			,@tipo_inversion		 = 'V'
			,@Observacion			 = @cobservaciones
                        ,@Cuenta_Corriente_Inicio        = ' '
                        ,@Sucursal_Inicio                = ' '
                        ,@codigo_area                    = @codigo_area
                        ,@deskmngr_keyid                = @cdeskmngr_keyid
                        ,@deskmngr_libro                = @cdeskmngr_libro

    END
/********************************  SORTEO DE LETRAS*******************************************/

/********************************  COMPRAS CON PACTO *******************************************/
    IF @ccodigo_producto = 'CI' BEGIN

            SET @fecha_vencimiento_caracter = CONVERT(CHAR(10),@dfecha_vencimiento_operacion,112)
            EXEC SP_GRABARCI
		         @nrutcart	                = @rut_entidad             -- rut de la cartera
		        ,@ctipcart	                = @tipo_cartera            -- codigo del tipo de cartera
		        ,@nnumdocu	                = @nnumero_documento       -- numero del documento
		        ,@ncorrela	                = @ncorrelativo            -- correlativo de la operación
		        ,@cmascara	                = @cserie_instrumento      -- familia del instrumento
		        ,@cinstser	                = @cserie_instrumento      -- serie                      
		        ,@cgenemi	                = @cgenerico_emisor        -- generico del emisor
		        ,@cnemomon	                = @moneda_instrumento      -- generico de la moneda
		        ,@nnominal	                = @nnominal                -- nominales	 
		        ,@ntir		                = @ntir                    -- tir de compra
		        ,@npvp		                = @nporcentaje_valor_par   -- porcentaje valor par
		        ,@nvptirc	                = @nvalor_presente         -- valor presente a tir de compra
		        ,@nvp100		        = @valor_presente_base_100 -- valor presente en base 100
		        ,@ntasest	                = 0.0                      -- tasa estimada
		        ,@nvpar		                = 0--@nvalor_par              -- valor par
		        ,@nnumucup	                = @numero_ultimo_cupon     -- numero del último cupón vencido
		        ,@ntirmcd	                = @ntir_mercado            -- tir de mercado
		        ,@npvpmcd	                = @nporcentaje_valor_par_mercado -- %vc a mercado
		        ,@nvpmcd		        = @nvalor_mercado          -- valor presente a mercado
		        ,@nvpmcd100	                = @valor_presente_base_100 -- valor presente a mercado en base 100
		        ,@cseriado	                = @seriado                 -- indica si es seriado o no
		        ,@ncodigo	                = @icodigo_instrumento     -- codigo de la familia
		        ,@cserie		        = @familia_instrumento     -- serie de la familia
		        ,@cfecemi	                = @fecha_emision_caracter  -- fecha de emisión
		        ,@cfecven	                = @fecha_vcto_caracter     -- fecha de vencimiento
		        ,@nmonemi	                = @moneda_emision          -- moneda del emisor
		        ,@nrutemi	                = @rut_emisor              -- rut del emisor
		        ,@ntasemi	                = @tasa_emision            -- tasa emision
		        ,@nbasemi	                = @base_emision            -- base emision
		        ,@nrutcli	                = @nrut_cliente             -- rut del cliente        
                        ,@ncodcli                       = @ncodigo_cliente         -- codigo del cliente        
		        ,@nforpagi	                = @iforma_pago_inicial     -- forma de pago al inicio
		        ,@nforpagv	                = @iforma_pago_final       -- forma de pago al vencimiento
		        ,@ctipcust	                = @ccustodia               -- tipo de custodia
		        ,@cretiro	                = @tipo_retiro             -- tipo de retiro
		        ,@cusuario	                = @cusuario                -- usuario
		        ,@cterminal	                = @cterminal               -- terminal
		        ,@cfecvtop	                = @fecha_vencimiento_caracter -- fecha de vencimiento del pacto
		        ,@nmonpact	                = @imoneda_operacion       -- moneda del pacto
		        ,@ntaspact	                = @ntasa_operacion         -- tasa del pacto
		        ,@nbaspact	                = @ibase_operacion         -- base del pacto 
		        ,@nvalinip	                = @nValor_inicial_pacto--@nValor_inicio_Pacto     -- valor inicial del pacto en moneda del pacto
		        ,@nvalvtop	                = @nValor_final_pacto         -- valor vencimiento del pacto en moneda del pacto
		        ,@dfecpcup	                = @fecha_proximo_cupon     -- fecha proximo cupon
		        ,@ccustodia	                = @ccustodia               -- custodia 
		        ,@cclave_dcv	                = @cclave_dcv              -- clave dcv
		        ,@dconvexidad 	                = @nconvexidad             -- convexidad
		        ,@dduratmac 	                = @nduration_macauly       -- durati¢n macaulay
		        ,@dduratmod	                = @nduration_modificado    -- duration modificado
		        ,@ftotalpfe	                = 0
		        ,@ftotalcce	                = 0
		        ,@codigo_carterasuper		= @codigo_carterasuper
		        ,@tipo_cartera_financiera	= @tipo_cartera_financiera
		        ,@mercado			= ' '
		        ,@sucursal			= @isucursal
		        ,@id_sistema			= 'BTR'
		        ,@fecha_pagomañana		= @fecha_proceso
		        ,@laminas			= @claminas--' '
		        ,@tipo_inversion		= 'V'
		        ,@cuenta_corriente_inicio	= ' '
		        ,@sucursal_inicio		= ' '
		        ,@cuenta_corriente_final	= ' '
		        ,@sucursal_final		= ' '
		        ,@observacion			= @cobservaciones
                        ,@valvenc                       = @nutilidad
                        ,@precio_transferencia          = @precio_transferencia
                        ,@codigo_area                   = @codigo_area
                        ,@codigo_corresponsal_bco       = @corresponsal_bco
                        ,@codigo_corresponsal_cli       = @corresponsal_cli
                        ,@deskmngr_keyid                = @cdeskmngr_keyid
                        ,@deskmngr_libro                = @cdeskmngr_libro
                        ,@libro_transferencia          = @nlibro_transferencia
                        ,@interes_transferencia       = @ninteres_transferencia
                        

    END
/********************************  COMPRAS CON PACTO *******************************************/

/********************************  VENTAS CON PACTO ********************************************/
    IF @ccodigo_producto IN ('VI','FLI','FLP','RP') BEGIN

        SET @fecha_vencimiento_caracter = CONVERT(CHAR(10),@dfecha_vencimiento_operacion,112)

            EXEC SP_GRABARVI
			 @nNumoper	                  = @nnumero_operacion        -- numero de operaci«n de venta
			,@nRutcart	                  = @rut_entidad              -- rut de la cartera
			,@cTipcart	                  = @tipo_cartera             -- codigo del tipo de cartera
			,@nNumdocu	                  = @nnumero_documento        -- numero del documento
			,@nCorrela	                  = @ncorrelativo             -- correlativo de la operaci«n
			,@nNominal	                  = @nnominal                 -- nominales vENDidos
			,@nTir		                  = @ntir                     -- tir de venta
			,@nPvp		                  = @nporcentaje_valor_par    -- porcentaje valor par (v)
			,@nVptirv	                  = @nvalor_presente          -- valor presente a tir de venta(v)
			,@nVp100		          = @valor_presente_base_100  -- valor presente venta en base 100 (v)
			,@nTasest	                  = 0.0                       -- tasa estimada (v)
			,@nVpar		                  = 0--@nvalor_par               -- valor par (v)          
			,@nNumucup	                  = @numero_ultimo_cupon      -- numero del oltimo cup«n vencido (v)
			,@nRutcli	     		  = @nrut_cliente              -- rut del cliente (v)
			,@nCodcli	                  = @ncodigo_cliente          -- codigo del cliente (v)
			,@cTipcust	                  = @ccustodia                -- tipo de custodia
			,@nForpagi	                  = @iforma_pago_inicial      -- forma de pago al inicio
			,@nForpagv	                  = @iforma_pago_final        -- forma de pago al vencimiento
			,@cRetiro	                  = @tipo_retiro              -- tipo de retiro
			,@cUsuario	                  = @cusuario                 -- usuario
			,@cTerminal	                  = @cterminal                -- terminal
			,@cFecvtop	                  = @fecha_vencimiento_caracter    -- fecha de vencimiento del pacto
			,@nMonpact	                  = @imoneda_operacion        -- moneda del pacto 
			,@nTaspact	                  = @ntasa_operacion          -- tasa del pacto
			,@nBaspact	                  = @ibase_operacion          -- base del pacto
			,@nValinip	                  = @nValor_inicial_Pacto --@nvalor_presente          -- valor inicial del pacto en moneda del pacto
			,@nValvtop	                  = @nValor_Final_Pacto           -- valor vencimiento del pacto en moneda del pacto*
			,@cInstser	                  = @cserie_instrumento       -- serie
			,@nRutemi	                  = @rut_emisor               -- rut del emisor
			,@nMonemi	                  = @moneda_emision           -- moneda de emisi«n
			,@dFecemi	                  = @fecha_emision            -- fecha de emisi«n  *
			,@dFecven	                  = @fecha_vencimiento        -- feeeeeeeeeeeecha de vcto. *
			,@nCorrvent	                  = @nutilidad--0-- correlativo venta con pacto
			,@dFecpcup	                  = @fecha_proximo_cupon      -- fecha de proximo cupon 	*
			,@dConvex	                  = @nconvexidad
			,@dDurmod	                  = @nduration_modificado
			,@dDurmac	                  = @nduration_macauly
			,@cCustodia	                  = @ccustodia
			,@cClavedcv	                  = @cclave_dcv
			,@fTotalpfe	                  = 0
			,@fTotalcce	                  = 0
			,@codigo_carterasuper		  = @codigo_carterasuper
			,@tipo_cartera_financiera	  = @tipo_cartera_financiera
			,@mercado			  = ' '
			,@sucursal			  = @isucursal
			,@id_sistema			  = @id_sistema
			,@fecha_pagomañana		  = @fecha_proceso
			,@laminas			  = @claminas--' '
			,@tipo_inversion		  = 'V'
			,@cuenta_corriente_inicio	  = ' '
			,@sucursal_inicio		  = ' '
			,@cuenta_corriente_final	  = ' '
			,@sucursal_final		  = ' '
			,@observacion			  = @cobservaciones
                        ,@precio_transferencia            = @precio_transferencia
                        ,@codigo_area                     = @codigo_area
                        ,@codigo_corresponsal_bco         = @corresponsal_bco
                        ,@codigo_corresponsal_cli         = @corresponsal_cli
                        ,@deskmngr_keyid                = @cdeskmngr_keyid
                        ,@deskmngr_libro                = @cdeskmngr_libro
                        ,@libro_transferencia          = @nlibro_transferencia
                        ,@interes_transferencia       = @ninteres_transferencia
			,@nNominal_FLI			= @nNominal_FLI
			,@ctipo_operacion		= @ctipo_operacion

    END
/********************************  VENTAS CON PACTO ********************************************/

/********************************  INTERBANCARIOS **********************************************/

    SET @monto_pesos = CASE WHEN @ctipo_moneda = '0' or @imoneda_operacion = 999 THEN @nmonto_inicial_um 
                       ELSE ROUND(@nmonto_inicial_um * @valor_moneda,0) END

    SELECT @fecha_vencimiento_caracter = CONVERT(CHAR(10), @dfecha_vencimiento_operacion, 112)

    IF @ccodigo_producto IN('IB','FPD')  BEGIN
                EXEC SP_GRABAINTERBANCARIOIB
                         @nnumoper                        = @nnumero_operacion
			,@dfecpro	                  = @fecha_proceso_caracter
			,@nrutcar	                  = @rut_entidad
			,@ntipcar	                  = @tipo_cartera
			,@stipope	                  = @ctipo_operacion
			,@dfecven	                  = @fecha_vencimiento_caracter
			,@nmtoini	                  = @nmonto_inicial_um
			,@nvalmon	                  = @valor_moneda
			,@ntasa		                  = @ntasa_operacion
			,@nmtofin	                  = @nmonto_final_um
			,@nbase		                  = @ibase_operacion
			,@ncodmon	                  = @imoneda_operacion
			,@nforpai	                  = @iforma_pago_inicial
			,@nforpav	                  = @iforma_pago_final
			,@spago		                  = @ctipo_pago
			,@nrutcli	                  = @nrut_cliente
			,@ncodcli	                  = @ncodigo_cliente
			,@stipret	                  = @tipo_retiro
			,@susuari	                  = @cusuario
			,@mntpeso   	                  = @monto_pesos
			,@Observaciones	                  = @cobservaciones
                        ,@codigo_area                     = @codigo_area
                        ,@codigo_corresponsal_bco         = @corresponsal_bco
                        ,@codigo_corresponsal_cli         = @corresponsal_cli
                        ,@deskmngr_keyid                = @cdeskmngr_keyid
                        ,@deskmngr_libro                = @cdeskmngr_libro
                        ,@libro_transferencia          = @nlibro_transferencia
                        ,@interes_transferencia       = @ninteres_transferencia
                        ,@nprecio_Transferencia         = @precio_Transferencia   
			,@codigo_subproducto		= @ccodigo_producto

    END

    IF @ccodigo_producto = 'LBC' BEGIN
                EXEC SP_GRABAINTERBANCARIO
                         @numoper                         = @nnumero_operacion
                        ,@correlativo                     = @ncorrelativo
			,@dfecpro	                  = @fecha_proceso_caracter
			,@nrutcar	                  = @rut_entidad
			,@ntipcar	                  = @tipo_cartera
			,@stipope	                  = @ctipo_operacion
			,@dfecven	                  = @fecha_vencimiento_caracter
			,@nmtoini	                  = @nmonto_inicial_um
			,@nvalmon	                  = @valor_moneda
			,@ntasa		                  = @ntasa_operacion
			,@nmtofin	                  = @nmonto_final_um
			,@nbase		                = @ibase_operacion
			,@ncodmon	                  = @imoneda_operacion
			,@nforpai	                  = @iforma_pago_inicial
			,@nforpav	                  = @iforma_pago_final
			,@spago		                  = @ctipo_pago
			,@nrutcli	                  = @nrut_cliente
			,@ncodcli	                  = @ncodigo_cliente
			,@stipret	                  = @tipo_retiro
			,@susuari	                  = @cusuario
                        ,@codigo_linea                    = @codigo_linea
			,@Observaciones	                  = @cobservaciones
                        ,@codigo_area         = @codigo_area
                        ,@deskmngr_keyid                = @cdeskmngr_keyid
                        ,@deskmngr_libro                = @cdeskmngr_libro
                        ,@interes_transferencia       = @ninteres_transferencia
                        ,@nprecio_Transferencia         = @precio_Transferencia   

    END

/********************************  INTERBANCARIOS **********************************************/

END





GO
