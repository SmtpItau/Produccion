USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPUTACION_LCR_DERIVADOS]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_IMPUTACION_LCR_DERIVADOS]	 ( @nNumoper         NUMERIC (10)  ,      --1
	                                                   @cSistema         CHAR(03)      ,      --2 
        	                                           @cProducto        CHAR(05)      ,      --3
                	                                   @Tipo_Operacion   CHAR(1)       ,      --4
                        	                           @Capital_Activo   FLOAT         ,      --5
                                	                   @Capital_Pasivo   NUMERIC(18,6) ,      --6
                                        	           @Plazo_Activo     NUMERIC(18,6) ,      --7
                                                	   @Plazo_Pasivo     NUMERIC(18,6) ,      --8 
	                                                   @Moneda_Activo    NUMERIC(5)    ,      --9 
        	                                           @Moneda_Pasivo    NUMERIC(5)    ,      --10
							   @Duration_Activo  FLOAT         ,
							   @Duration_Pasivo  FLOAT         ,
                                	                   @Fecha_Proceso    DATETIME      ,      --11
	                                	           @Monto            FLOAT         OUTPUT --12

             )

AS
BEGIN		
	SET NOCOUNT ON 

	SELECT	@Plazo_Activo	= @Plazo_Activo / 365.
	,	@Plazo_Pasivo	= @Plazo_Pasivo / 365.

        Insert  dbo.DEBUG_VALORES select @cSistema + ' ' + ltrim(@nNumoper) + '00@Capital_Activo' , @Capital_Activo, '@Moneda_Activo', @Moneda_Activo   
        Insert  dbo.DEBUG_VALORES select @cSistema + ' ' + ltrim(@nNumoper) + '00@Capital_Pasivo' , @Capital_Pasivo, '@Moneda_Pasivo', @Moneda_Pasivo   

        Insert  dbo.DEBUG_VALORES select @cSistema + ' ' + ltrim(@nNumoper) + '00PlazoActivo' , @Plazo_Activo, ' ', 0.0   
        Insert  dbo.DEBUG_VALORES select @cSistema + ' ' + ltrim(@nNumoper) + '00PlazoPasivo' , @Plazo_Pasivo, ' ', 0.0   
	-- No olvidar comprar con SP_IMPUTACION_LCR_DERIVADOS que corregirá Ruth
			
	DECLARE @Nominal                       FLOAT        ,
	@Moneda1                       NUMERIC(5)   ,
        @Moneda2                       NUMERIC(5)   ,
        @Plazo_rem                     NUMERIC(18,6),
        @Plazo_en_ano                  NUMERIC(18,6),
        @Valor_Moneda_Contrato_hoy     NUMERIC(18,6),
        @Valor_CLP_Dolar_Hoy           NUMERIC(18,6), 
        @Nominal_en_USD                FLOAT        ,
        @Ponderador_CLP                NUMERIC(18,6), 
        @Factor_UF                     NUMERIC(7,3) ,
	@CodPlazo                      NUMERIC(5)   ,
        @FactorPond_Divisa_CLP         FLOAT,
        @Nominal_Activo_CLP            NUMERIC(15)  ,
	@Nominal_Pasivo_CLP            NUMERIC(15)  ,
        @Nominal_Activo_USD            NUMERIC(18,4),
	@Nominal_Pasivo_USD            NUMERIC(18,4),
	@Valor_Moneda_Activo           NUMERIC(18,4),
	@Valor_Moneda_Pasivo           NUMERIC(18,4),
	@NocionalActivoMatriz          NUMERIC(18,4),
	@NocionalPasivoMatriz          FLOAT,                   --NUMERIC(18,4)

	@Pond_Activo_Tasa              FLOAT,
        @Pond_Pasivo_Tasa              FLOAT,
        @Pond_Activo_Divisa            FLOAT,
        @Pond_Pasivo_Divisa            FLOAT


	DECLARE @CodPlazo_Activo_Dur           NUMERIC(10),     --12,4
		@CodPlazo_Pasivo_Dur           NUMERIC(10),     --12,4
		@CodPlazo_Activo_Pla           NUMERIC(10),     --12,4
		@CodPlazo_Pasivo_Pla           NUMERIC(10),     --12,4
		@Moneda_BR                     NUMERIC(3),
		@Pond_Tasa_Activo              FLOAT,
		@Pond_Tasa_Pasivo              FLOAT,
		@Pond_Divisa_Activo            FLOAT,
		@Pond_Divisa_Pasivo            FLOAT,
		@Cor_Tasa_Activa_Tasa_Pasiva   FLOAT
         ,      @Cor_Tasa_Activa_MX_ML         FLOAT
         ,      @Cor_Tasa_Pasiva_MX_ML         FLOAT
         ,      @Cor_MX_MX                     FLOAT


	declare @Plazo_Pond_Div_CLP float
	declare @Cod_Plazo_Div_CLP numeric(10)

	SELECT   @Moneda_BR = 444

	DECLARE  @r11 FLOAT,  
	@r12 FLOAT,
	@r13 FLOAT,
	@r14 FLOAT,

	@r21 FLOAT,
	@r22 FLOAT,
	@r23 FLOAT,
	@r24 FLOAT,

	@r31 FLOAT,
	@r32 FLOAT,
	@r33 FLOAT,
	@r34 FLOAT,

	@r41 FLOAT,
	@r42 FLOAT,
	@r43 FLOAT,
	@r44 FLOAT

	SELECT  @r11  =0,  
	@r12  =0,
	@r13  =0,
	@r14  =0,

	@r21  =0,
        @r22  =0,
        @r23  =0,
        @r24  =0,

	@r31  =0,
	@r32  =0,
	@r33  =0,
	@r34  =0,

	@r41  =0,
	@r42  =0,
	@r43  =0,
	@r44  =0


	SET NOCOUNT ON
 
 	SELECT @Factor_UF = 1.0            

	/* Rescata valor dolar HOY  */
	SELECT @Valor_CLP_Dolar_Hoy = ISNULL(Vmvalor,1)
	FROM VIEW_VALOR_MONEDA 
	WHERE vmfecha  =  @Fecha_Proceso
	AND vmcodigo =  994

	SELECT @Valor_Moneda_Activo = 1
	SELECT @Valor_Moneda_Activo  = Vmvalor
	FROM VIEW_VALOR_MONEDA 
	WHERE vmfecha  =  @Fecha_Proceso
	AND vmcodigo =  ( CASE WHEN  @Moneda_Activo = 13 THEN 994 
	ELSE @Moneda_Activo 
	END ) 

	select @Valor_Moneda_Pasivo = 1
	SELECT @Valor_Moneda_Pasivo  = Vmvalor            
	FROM VIEW_VALOR_MONEDA 
	WHERE vmfecha  =  @Fecha_Proceso
	AND vmcodigo =  ( CASE WHEN @Moneda_Pasivo = 13 THEN 994 
				ELSE @Moneda_Pasivo
			END ) 
	If  @cSistema = 'BFW' AND @cProducto = 1 AND ( @moneda_Activo = 13 OR @moneda_Pasivo=13)
	BEGIN  /* Begin 1 */		
		IF @Tipo_Operacion = 'C'
		BEGIN
			SELECT @Nominal   = @Capital_Activo
			SELECT @Moneda1   = @Moneda_Activo
			SELECT @Moneda2   = @Moneda_Pasivo
			SELECT @Plazo_rem = @Plazo_Activo
		END
		ELSE
		BEGIN
			SELECT @Nominal   = @Capital_Pasivo
			SELECT @Moneda1   = @Moneda_Pasivo
			SELECT @Moneda2   = @Moneda_Activo
			SELECT @Plazo_rem = @Plazo_Pasivo
		END

		-- Rescate del valor de la moneda
		SELECT @Valor_Moneda_Contrato_hoy = Vmvalor
		FROM VIEW_VALOR_MONEDA 
		WHERE vmfecha  =  @Fecha_Proceso
		AND vmcodigo =  ( CASE WHEN @Moneda1 = 13 THEN 994 
				ELSE @Moneda1 
				END ) 
		-- select 'debug', 'Rescatar @Factor_UF de la general detalle' 
		IF  @Moneda2 = 998  SELECT @Factor_UF = 1.1

		SELECT @Plazo_en_ano    = @Plazo_rem
		SELECT @Nominal_en_USD  = (@Nominal * @Valor_Moneda_Contrato_hoy)/ @Valor_CLP_Dolar_Hoy

                EXEC DBO.SP_CON_INTERPOLACION_PONDERACIONES  999 , @Plazo_en_Ano , 'D' , @FactorPond_Divisa_CLP OUTPUT
		
		SELECT @Monto = @Nominal_en_USD * @Valor_CLP_Dolar_Hoy * @FactorPond_Divisa_CLP * @Factor_UF
		SELECT @Monto = round(@Monto,0)

                INSERT  dbo.DEBUG_VALORES SELECT @cSistema + ' ' + ltrim(@nNumoper) + '01PonDivCLP' , @FactorPond_Divisa_CLP, ' ', 0.0   


	END   /* End  1  */
	ELSE
	BEGIN 
		-- Algoritmo Matricial
		-- Cubre MX-CLP
		Declare @ProdAux char(5) 
		-- Para detectar que se está en una llamada recursiva
		Select  @ProdAux =  '99' 

		IF     @Moneda_Activo not in ( 13, 999, 998 ) and @Moneda_Pasivo in ( 999, 998 )   		-- Cubre MX-ML
			or 
			@Moneda_Activo in ( 999, 998 )  and @Moneda_Pasivo not in ( 13, 999, 998 )  		-- Cubre ML-MX
			or
			@Moneda_Pasivo not in ( 13, 999, 998 ) and @Moneda_Activo not in ( 13, 999, 998 )	-- Cubre MX1-MX2 o MX-MX
		BEGIN
			DECLARE	@Monto1			FLOAT
			,	@Capital_pasivoAux	FLOAT
			,	@Plazo_Activo_Dias	NUMERIC(18,6)
			,	@Plazo_Pasivo_Dias	NUMERIC(18,6)

			SELECT  @Monto1			= 0
			,	@Capital_pasivoAux	= @Capital_Activo * @Valor_Moneda_Activo / @Valor_CLP_Dolar_Hoy
			,	@Plazo_Activo_Dias	= @Plazo_Activo * 365.
			,	@Plazo_Pasivo_Dias	= @Plazo_Pasivo * 365.

			EXEC DBO.SP_IMPUTACION_LCR_DERIVADOS
			@nNumoper,
			@cSistema,
			@ProdAux ,
			@Tipo_Operacion, 
			@Capital_Activo, 
			@Capital_pasivoAux , 
			@Plazo_Activo_Dias	,
			@Plazo_Pasivo_Dias	, 
			@Moneda_Activo, 
			13,
			@Duration_Activo,
			@Duration_Pasivo,
			@Fecha_Proceso,
			@Monto1         OUTPUT

			DECLARE	@Monto2			FLOAT
			,	@Capital_ActivoAux	FLOAT	

			SELECT	@Monto2 = 0
			,	@Capital_ActivoAux = @Capital_Pasivo * @Valor_Moneda_Pasivo / @Valor_CLP_Dolar_Hoy

			EXEC DBO.SP_IMPUTACION_LCR_DERIVADOS
			@nNumoper,
			@cSistema,
			@ProdAux,
			@Tipo_Operacion, 
			@Capital_ActivoAux, 
			@Capital_Pasivo, 
			@Plazo_Activo_Dias	,
			@Plazo_Pasivo_Dias	, 
			13, 
			@Moneda_Pasivo,
			@Duration_Activo,
			@Duration_Pasivo,
			@Fecha_Proceso,
			@Monto2 output

			SELECT @monto = @Monto1 + @Monto2 

			SELECT  @Plazo_Pond_Div_CLP = CASE WHEN  @Plazo_Activo > @Plazo_Pasivo THEN @Plazo_Activo ELSE @Plazo_Pasivo END 

                        EXEC DBO.SP_CON_INTERPOLACION_PONDERACIONES  999 , @Plazo_Pond_Div_CLP , 'D' , @FactorPond_Divisa_CLP OUTPUT			

			IF NOT @Moneda_Activo in ( 998, 999 ) and not @Moneda_pasivo in ( 998, 999 ) AND @cProducto <> '99' 
			BEGIN					
				SELECT  @Monto = @Monto * ( @FactorPond_Divisa_CLP )
			END

			SELECT @Monto = round(@Monto,0)
		END
		ELSE
		BEGIN
			IF ( @Moneda_Activo in ( 999, 998 ) and @Moneda_pasivo in ( 999, 998 ) )        	-- Cubre ML-ML, ML1-ML2
			BEGIN
        	                SELECT @Nominal_Activo_CLP = @Capital_Activo * ISNULL(@Valor_Moneda_Activo,1)
	                        SELECT @Nominal_Pasivo_CLP = @Capital_Pasivo * ISNULL(@Valor_Moneda_Pasivo,1)
				SELECT @NocionalActivoMatriz = @Nominal_Activo_CLP
				SELECT @NocionalPasivoMatriz = @Nominal_Pasivo_CLP

			END
			ELSE 
			BEGIN
				SELECT @Nominal_Activo_USD = @Capital_Activo * ISNULL(@Valor_Moneda_Activo,1)/ @Valor_CLP_Dolar_Hoy
				SELECT @Nominal_Pasivo_USD = @Capital_Pasivo * ISNULL(@Valor_Moneda_Pasivo,1)/ @Valor_CLP_Dolar_Hoy
				SELECT @NocionalActivoMatriz = @Nominal_Activo_USD
				SELECT @NocionalPasivoMatriz = @Nominal_Pasivo_USD

			END
			SELECT @NocionalPasivoMatriz = @NocionalPasivoMatriz * -1

			Insert  dbo.DEBUG_VALORES select @cSistema + ' ' + ltrim(@nNumoper) + '02@NocionalActivoMatriz' , @NocionalActivoMatriz,  '@cSistema '+ @cSistema  , 0.0   
			Insert  dbo.DEBUG_VALORES select @cSistema + ' ' + ltrim(@nNumoper) + '02@NocionalPasivoMatriz' , @NocionalPasivoMatriz,  '@cSistema '+ @cSistema  , 0.0   

                	Insert  dbo.DEBUG_VALORES select @cSistema + ' ' + ltrim(@nNumoper) + '02@Duration_Activo' , @Duration_Activo, ' ', 0.0   
                	Insert  dbo.DEBUG_VALORES select @cSistema + ' ' + ltrim(@nNumoper) + '02@Duration_Pasivo' , @Duration_Pasivo, ' ', 0.0   

                        DECLARE @nMonActivo   NUMERIC(6,0)
                        ,       @nMonPasivo   NUMERIC(6,0)


                        SELECT   @nMonActivo = CASE WHEN @Moneda_Activo  NOT IN(999,998,13) 
                                                    THEN @Moneda_BR
                                                    ELSE @Moneda_Activo END
                        ,        @nMonPasivo = CASE WHEN @Moneda_Pasivo  NOT IN(999,998,13) 
                                                    THEN @Moneda_BR
                                                    ELSE @Moneda_Pasivo END

                        EXEC DBO.SP_CON_INTERPOLACION_PONDERACIONES  @nMonActivo , @Duration_Activo  , 'T' , @Pond_Tasa_Activo OUTPUT
                        EXEC DBO.SP_CON_INTERPOLACION_PONDERACIONES  @nMonPasivo , @Duration_Pasivo  , 'T' , @Pond_Tasa_Pasivo OUTPUT

                	Insert  dbo.DEBUG_VALORES select @cSistema + ' ' + ltrim(@nNumoper) + '03@Pond_Tasa_Activo' , @Pond_Tasa_Activo, ' ', 0.0   
                	Insert  dbo.DEBUG_VALORES select @cSistema + ' ' + ltrim(@nNumoper) + '03@Pond_Tasa_Pasivo' , @Pond_Tasa_Pasivo, ' ', 0.0   

                        SELECT   @nMonActivo = (CASE WHEN @Moneda_Activo  NOT IN (13, 6,999,142,102,72,994) 
					               THEN ( CASE WHEN @Moneda_Activo = 998 THEN 999 ELSE @Moneda_BR END )
					            WHEN @Moneda_Activo = 994 
                                                       THEN 13  
                                                    ELSE @Moneda_Activo
                                           END  )  -- ensalada
                        ,        @nMonPasivo = (CASE WHEN @Moneda_Pasivo  NOT IN (13, 6,999,142,102,72,994) 
						       THEN ( CASE WHEN @Moneda_Pasivo = 998 THEN 999 ELSE @Moneda_BR END )
					            WHEN @Moneda_Activo = 994 
                                                       THEN 13  
					            ELSE @Moneda_Pasivo
                                           END  )  -- ensalada

                        EXEC DBO.SP_CON_INTERPOLACION_PONDERACIONES  @nMonActivo , @Plazo_Activo , 'D' , @Pond_Divisa_Activo OUTPUT
                        EXEC DBO.SP_CON_INTERPOLACION_PONDERACIONES  @nMonPasivo , @Plazo_Pasivo , 'D' , @Pond_Divisa_Pasivo OUTPUT

			SELECT  @Factor_UF = 1.1
			IF @Moneda_Activo = 998 AND  @Moneda_Pasivo = 13 SELECT @Pond_Divisa_Activo = @Pond_Divisa_Activo * 1.1
	                IF @Moneda_Pasivo = 998 and  @Moneda_Activo = 13 SELECT @Pond_Divisa_Pasivo = @Pond_Divisa_Pasivo * 1.1

			-- COndicion ML-ML debe dejar ponderadores divisa en cero
			IF @Moneda_Activo in ( 998 , 999 ) and @Moneda_pasivo in ( 999, 998 ) 
			begin
				select @Pond_Divisa_Activo = 0.0
				select @Pond_Divisa_Pasivo = 0.0			
			End

                	Insert  dbo.DEBUG_VALORES select @cSistema + ' ' + ltrim(@nNumoper) + '04@Pond_Divisa_Activo' , @Pond_Divisa_Activo, ' ', 0.0   
                	Insert  dbo.DEBUG_VALORES select @cSistema + ' ' + ltrim(@nNumoper) + '04@Pond_Divisa_Pasivo' , @Pond_Divisa_Pasivo, ' ', 0.0   


                        SELECT   @Cor_Tasa_Activa_Tasa_Pasiva = NULL
      
                        SELECT   @Cor_Tasa_Activa_Tasa_Pasiva   = (CorValor /100.0)
                        FROM     TBL_CORRELACIONES_LINEAS
                        WHERE    CorMoneda1     =  (Case WHEN  @Moneda_Pasivo NOT IN (999, 998 , 13) THEN 13 ELSE @Moneda_Pasivo END )
                        AND      CorPlazoIni1   <= @Duration_Pasivo

--                        AND      CorPlazoFin1   <  @Duration_Pasivo
                        AND      CorPlazoFin1   >  @Duration_Pasivo

                        AND      CorMoneda2     = (Case WHEN  @Moneda_Activo NOT IN (999, 998 , 13) THEN 13 ELSE @Moneda_Activo END )
                        AND      CorPlazoIni2   <= @Duration_Activo
                        AND      CorPlazoFin2   >  @Duration_Activo                                     
   
                        IF @Cor_Tasa_Activa_Tasa_Pasiva IS NULL BEGIN 			   
                           SELECT   @Cor_Tasa_Activa_Tasa_Pasiva   = (CorValor /100.0)
                           FROM     TBL_CORRELACIONES_LINEAS
                           WHERE    CorMoneda1     = (Case WHEN  @Moneda_Activo NOT IN (999, 998 , 13) THEN 13 ELSE @Moneda_Activo END )
                           AND      CorPlazoIni1   <= @Duration_Activo

--                           AND      CorPlazoFin1   <  @Duration_Activo
                           AND      CorPlazoFin1   >  @Duration_Activo

                           AND      CorMoneda2     = (Case WHEN  @Moneda_Pasivo NOT IN (999, 998 , 13) THEN 13 ELSE @Moneda_Pasivo END )
                           AND      CorPlazoIni2   <= @Duration_Pasivo
                           AND      CorPlazoFin2   > @Duration_Pasivo
                        END

                        IF @Cor_Tasa_Activa_Tasa_Pasiva IS NULL BEGIN 
                           SELECT @Cor_Tasa_Activa_Tasa_Pasiva = 0
                        END                       

                        SELECT   @Cor_Tasa_Activa_MX_ML   = 0
                        ,        @Cor_Tasa_Pasiva_MX_ML   = 0
                        ,        @Cor_MX_MX               = 0

                        SELECT   @Cor_Tasa_Activa_MX_ML   = (CorValor /100.0)
                        FROM     TBL_CORRELACIONES_LINEAS
                        WHERE    CorMoneda1     = 999999
                        AND      CorPlazoIni1   = 999999
                        AND      CorPlazoFin1   = 999999
                        AND      CorMoneda2     = (CASE WHEN  @Moneda_Activo NOT IN (999, 998 , 13) THEN 13 ELSE @Moneda_Activo END )
                        AND      CorPlazoIni2   <= @Plazo_Activo
                        AND      CorPlazoFin2   >  @Plazo_Activo

                        SELECT   @Cor_Tasa_Pasiva_MX_ML   = (CorValor /100.0)
                        FROM     TBL_CORRELACIONES_LINEAS
                        WHERE    CorMoneda1     = 999999
                        AND      CorPlazoIni1   = 999999
                        AND      CorPlazoFin1   = 999999
                        AND      CorMoneda2     = (CASE WHEN  @Moneda_Pasivo NOT IN (999, 998 , 13) THEN 13 ELSE @Moneda_Pasivo END )
                        AND      CorPlazoIni2   <= @Plazo_Pasivo
                        AND      CorPlazoFin2   >  @Plazo_Pasivo

                        SELECT   @Cor_Tasa_Pasiva_MX_ML   = (CorValor /100.0)
                        FROM     TBL_CORRELACIONES_LINEAS
                        WHERE    CorMoneda1     = 999999
                        AND      CorPlazoIni1   = 999999
                        AND      CorPlazoFin1   = 999999
                        AND      CorMoneda2     = 999999
                        AND      CorPlazoIni2   = 999999
                        AND      CorPlazoFin2   = 999999

                	INSERT  dbo.DEBUG_VALORES SELECT @cSistema + ' ' + ltrim(@nNumoper) + '05@Cor_Tasa_Activa_Tasa_Pasiva' , @Cor_Tasa_Activa_Tasa_Pasiva, ' ', 0.0   

			EXECUTE SP_PROD_4x4_4x4  @Pond_Tasa_Activo,@Pond_Tasa_Pasivo,@Pond_Divisa_Activo, @Pond_Divisa_Pasivo,
			0,0,0,0,
			0,0,0,0,
			0,0,0,0,

			@NocionalActivoMatriz,0,0,0,
			0,@NocionalPasivoMatriz,0,0,
			0,0,@NocionalActivoMatriz,0,
			0,0,0,@NocionalPasivoMatriz,

			@r11 Output,@r12 Output,@r13 Output,@r14 Output,
			@r21 Output,@r22 Output,@r23 Output,@r24 Output,
			@r31 Output,@r32 Output,@r33 Output,@r34 Output,
			@r41 Output,@r42 Output,@r43 Output,@r44 Output

			EXECUTE SP_PROD_4x4_4x4 @r11,@r12, @r13, @r14 ,
			0,0,0,0,
			0,0,0,0,
			0,0,0,0,

			1,@Cor_Tasa_Activa_Tasa_Pasiva,@Cor_Tasa_Activa_MX_ML,@Cor_Tasa_Activa_MX_ML,
			@Cor_Tasa_Activa_Tasa_Pasiva,1,@Cor_Tasa_Pasiva_MX_ML,@Cor_Tasa_Pasiva_MX_ML,
			@Cor_Tasa_Activa_MX_ML,@Cor_Tasa_Pasiva_MX_ML,1,@Cor_MX_MX,
                        @Cor_Tasa_Activa_MX_ML,@Cor_Tasa_Pasiva_MX_ML,@Cor_MX_MX,1,
			@r11 Output,@r12 Output,@r13 Output,@r14 Output,
			@r21 Output,@r22 Output,@r23 Output,@r24 Output,
			@r31 Output,@r32 Output,@r33 Output,@r34 Output,
			@r41 Output,@r42 Output,@r43 Output,@r44 Output

			EXECUTE SP_PROD_4x4_4x4 @r11,@r12, @r13, @r14 ,
			0,0,0,0,
			0,0,0,0,
			0,0,0,0,

			@NocionalActivoMatriz,0,0,0,
			0,@NocionalPasivoMatriz,0,0,
			0,0,@NocionalActivoMatriz,0,
			0,0,0,@NocionalPasivoMatriz ,

			@r11 Output,@r12 Output,@r13 Output,@r14 Output,
			@r21 Output,@r22 Output,@r23 Output,@r24 Output,
			@r31 Output,@r32 Output,@r33 Output,@r34 Output,
			@r41 Output,@r42 Output,@r43 Output,@r44 Output


			EXECUTE SP_PROD_4x4_4x4 @r11,@r12, @r13, @r14 ,
			0,0,0,0,
			0,0,0,0,
			0,0,0,0,

			@Pond_Tasa_Activo,0,0,0,
			@Pond_Tasa_Pasivo,0,0,0,
			@Pond_Divisa_Activo,0,0,0,
			@Pond_Divisa_Pasivo,0,0,0,

			@r11 Output,@r12 Output,@r13 Output,@r14 Output,
			@r21 Output,@r22 Output,@r23 Output,@r24 Output,
			@r31 Output,@r32 Output,@r33 Output,@r34 Output,
			@r41 Output,@r42 Output,@r43 Output,@r44 Output  
 
	                SELECT @Monto = POWER(@r11,0.5)

			IF    @Moneda_Activo in ( 13 ) or @Moneda_Pasivo in (13)  
			begin -- operacion con USD

                           SELECT   @Plazo_Pond_Div_CLP      = CASE WHEN  @Plazo_Activo > @Plazo_Pasivo THEN @Plazo_Activo ELSE @Plazo_Pasivo END 
                           SELECT   @FactorPond_Divisa_CLP   = 0

                           EXEC DBO.SP_CON_INTERPOLACION_PONDERACIONES  999 , @Plazo_Pond_Div_CLP , 'D' , @FactorPond_Divisa_CLP OUTPUT

				SELECT @Monto = @Monto * @Valor_CLP_Dolar_Hoy 

				if	not @Moneda_Activo in ( 998, 999 ) and not @Moneda_pasivo in ( 998, 999 ) and @cProducto <> '99' 
				begin
					select  @Monto = @Monto * ( @FactorPond_Divisa_CLP )
					Insert  dbo.DEBUG_VALORES select @cSistema + ' ' + ltrim(@nNumoper) + '05@FactorPond_Divisa_CLP' , @FactorPond_Divisa_CLP,  '@cSistema '+ @cSistema  , 0.0   
				end
				SELECT @Monto = round(@Monto,0)
 	   		END
		END
	END  -- Algoritmo Matricial	
	Insert  dbo.DEBUG_VALORES select @cSistema + ' ' + ltrim(@nNumoper) + '06@Monto' , @Monto,  '@cSistema '+ @cSistema  , 0.0   
END
GO
