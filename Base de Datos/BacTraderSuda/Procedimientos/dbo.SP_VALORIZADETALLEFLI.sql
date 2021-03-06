USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORIZADETALLEFLI]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_VALORIZADETALLEFLI]
   (   @modcal		INTEGER
   ,   @mascara 	CHAR(10)
   ,   @nominal	        FLOAT
   ,   @tir		FLOAT
   ,   @pvp		FLOAT
   ,   @monto		FLOAT
   ,   @feccal		CHAR(10)
   ,   @factor		FLOAT
   ,   @valorinicial	FLOAT
   ,   @usuarios	CHAR(12)
   ,   @iventana	NUMERIC(9)
   ,   @sPagoParcial	CHAR(01)      	--> Campo para evitar la valorizacion cuando es un pago
   ,   @bAjustaVPresen	CHAR(01)	--> Ajuste de CLP en Valor Inicial si viene una T corressponde a Pago Parcial
   ,   @bPantallaPago	CHAR(01)	--> Corresponde si esta pagando el FLI o esta ingresando por primera vez
   ,   @nNominalORIG	FLOAT		--> Nominal Original
   ,   @fMontoORIG	FLOAT		--> Valor Presente Original
   ,   @sCartera	VARCHAR(1)	--> Codigo de Cartera Super
   ,   @fHairCut        FLOAT      = 0
   ,   @folioSOMA       NUMERIC(9) = 0    --> PRD-6010
   ,   @CorrelaSOMA     NUMERIC(3) = 0    --> PRD-6010
   ,   @dRutEmisor      NUMERIC(10) = 0  --> Rut del Emisor que ahora participa en la agrupación
   )
AS
BEGIN

	SET NOCOUNT ON;






	DECLARE @xvasr_paso  		NUMERIC(21,4);

	SET @xvasr_paso = 0.0 ;


        DECLARE @PesosVendidos  	FLOAT
        ,	@NominalVendido 	FLOAT
        ,	@Sumatoria      	FLOAT	
	,	@jTir			FLOAT
	,	@jPVP			FLOAT
	,	@jVpresen		FLOAT
	,	@jVInicial		FLOAT	;
	
		
	SET 	@jTir		= @tir		;
	SET	@jPVP		= @pvp		;
	SET	@jVpresen	= @monto	;
	SET	@jVInicial	= @valorinicial	;
	
	IF @nominal = 0
	BEGIN
		SELECT @Mascara    AS Serie		
		,      @nominal	   AS Nominal
		,      @tir	   AS Tir
		,      @pvp	   AS PVP
		,      0.0	   AS Valor_Presente
		,      0.0         AS valorinicial
		RETURN
	END ; 


	DECLARE @cProg               CHAR(10)	,
		@iModcal             INTEGER	,
		@iCodigo             INTEGER	,
		@cInstser            CHAR(10)	,
		@iMonemi             INTEGER	,
		@dFecemi             CHAR(10)	,
		@dFecven             CHAR(10)	,
		@fTasemi             FLOAT	,
		@fBasemi             FLOAT	,
		@fTasest             FLOAT	,
		@fNominal            FLOAT	,
		@zNominal	     FLOAT 	,
		@fTir                FLOAT	,
		@fPvp                FLOAT	,
		@fMT                 FLOAT	;

	DECLARE @Usuario            VARCHAR(15)	,
		@Marca              CHAR(1)	,
		@zdocumento	    NUMERIC(9)	,
 		@zcorrelativo	    NUMERIC(9)	,
		@Documento          NUMERIC(9)	,
		@Correlativo        NUMERIC(9)	,
		@Serie              VARCHAR(20)	,
		@Moneda             CHAR(3)	,
		@Nominal_Compra     FLOAT	,
		@Tasa_Compra        FLOAT	,
		@Valor_Par          FLOAT	,
		@Valor_Presente     FLOAT	,
		@Margen             FLOAT	,
		@Valor_Inicial      FLOAT	,
		@Nominal_Venta      FLOAT	,
		@Tasa_Venta         FLOAT	,
		@vPar_Venta         FLOAT	,
		@vPresente_Venta    FLOAT	,
		@vInicial_Venta     FLOAT	,
		@plazo		    INTEGER	,	
		@Ventana            NUMERIC(9)	;

	DECLARE @Nominal_faltante   FLOAT	,
		@vInicialVenta	    FLOAT	,
		@vNominalModcal	    FLOAT	,	
		@vMT		    FLOAT	;

	DECLARE @bModulo	    CHAR(01)	;	
      -- Tabla para recibir datos de la serie	

	    SET	@bModulo	= 0		;

	DECLARE @iContadorReg	    INTEGER 
	,	@iContadorTot	    INTEGER	;		


CREATE TABLE 
	#DatosSerie( 
	   	nerror      	INTEGER		,
		cmascara    	CHAR(12)	,
		codigo		INTEGER		,
		cserie      	CHAR(12)	,
		nrutemi     	NUMERIC(9,0)	,
		nmonemi     	INTEGER		,
		ftasemi     	FLOAT		,
		nbasemi     	NUMERIC(3,0)	,
		dfecemi     	CHAR(10)	,
		dfecven     	CHAR(10)	,
		crefnomi    	CHAR(1)		,
		cgenemi     	CHAR(10)	,
		cnemmon     	CHAR(5) 	,
		ncorte      	NUMERIC(21,4)	,
		cseriado    	CHAR(1)		,
		clecemi     	CHAR(6)		,
		fecpro	    	CHAR(10)	)	;

	DECLARE	@nNumucup	INTEGER		,
		@cFecucup	CHAR(10)	,
		@cFecpcup	CHAR(10)	,
		@fDurat		FLOAT		,
		@fConvx		FLOAT		,
		@fDurmo		FLOAT 		,
		@fmtRestante	FLOAT		,
		@nrutemi	NUMERIC(9)		;

	DECLARE @estado 	INTEGER			;

      -- Tabla para recibir datos de la Valorizacion
CREATE TABLE 
	 #Valorizacion(
		fError 		INTEGER 	,
		fNominal	FLOAT		,
		fTir		FLOAT		,	
		fPvp		FLOAT		,
		fMT		FLOAT		,
		fMTUM		FLOAT		,
		fMT_cien	FLOAT		,
		fVan		FLOAT		,
		fVpar		FLOAT		,
		nNumucup	INTEGER		,
		cFecucup	CHAR(10)	,
		fIntucup	FLOAT		,
		fAmoucup	FLOAT		,
		fSalucup	FLOAT		,
		nNumpcup	FLOAT		,
		cFecpcup	CHAR(10)	,
		fIntpcup	FLOAT		,
		fAmopcup	FLOAT		,
		fSalpcup	FLOAT		,
		fDurat		FLOAT		,
		fConvx		FLOAT		,
		fDurmo		FLOAT 		);
    /* ________________________________________________________________________________________________}
	Limpio marca de la venta en proceso de valorizacion 						|
	================================================================================================} */
	UPDATE detalle_fli  
	   SET Marca  ='N'	
	,      nominal_venta 	= 0
	,      vPar_Venta    	= 0
	,      Tasa_Venta    	= 0
	,      vInicial_Venta	= 0
	,      vPresente_Venta	= 0
 	 WHERE Serie  =@mascara 
	   AND Ventana=@iVentana
	   AND Usuario=@usuarios
	   AND CarteraSuper=@sCartera
           AND ( Rut_Emisor       = @dRutEmisor or @dRutEmisor = 0 )
     -- ************************************************************************************************

     /* ________________________________________________________________________________________________}
	Cargo datos de las series para poder valorizar							|
	================================================================================================} */
	INSERT INTO #DatosSerie		
	EXECUTE sp_chkinstser @mascara;

	SELECT 	@cInstser=cmascara	,
		@imonemi=nmonemi	,
		@icodigo=codigo		,
		@dFecemi=CONVERT(CHAR(10),CONVERT(DATETIME,dFecemi,103),112),
		@dFecven=CONVERT(CHAR(10),CONVERT(DATETIME,dFecven,103),112),
		@ftasemi=ftasemi	,
		@fbasemi=nbasemi	,
		@ftasest=0.0		,
		@fnominal=@nominal	,

		-- @ftir= @tir		,  -- PROD 6007
                -- en el caso de digitar la tasa @tir se utiliza @tir + HairCut
                @ftir = case when @modcal = 2 then  @tir + @fHairCut else @tir end,  -- PROD 6007
		@fpvp=@pvp		,
		@fmt=@monto		,
		@nrutemi=nrutemi	
	FROM #DatosSerie;		

     /* ________________________________________________________________________________________________
	Cargo datos de las series para poder valorizar 							| 
	21/10/2009 --> solo es para la generacion del FLI no para el Pago
	================================================================================================} */
	INSERT INTO  #Valorizacion
	EXECUTE sp_valorizar_client
		@modcal,
		@feccal,
		@iCodigo,
		@Mascara,
		@iMonemi,
		@dFecemi,
		@dFecven,
		@fTasemi,
		@fBasemi,
		@fTasest,
		@fNominal,
		@fTir,
		@fPvp,
		@fMT



	IF @bPantallaPago = 'N' --> No proviene de la pantalla de pago
	BEGIN
		SELECT 	@fmt = FMT 		,
			@fPvp= fPvp		,
			@nNumucup=nNumucup 	,
			@cFecucup=cFecucup 	,
			@cFecpcup=cFecpcup 	,
			@fDurat=fDurat		,
			@fConvx=fConvx		,
			@fDurmo=fDurmo		
		FROM    #Valorizacion;
	END ELSE
	BEGIN 
		SELECT 	@fmt = @monto		,
			@fPvp= fPvp		,
			@nNumucup=nNumucup 	,
			@cFecucup=cFecucup 	,
			@cFecpcup=cFecpcup 	,
			@fDurat=fDurat		,
			@fConvx=fConvx		,
			@fDurmo=fDurmo		
		FROM    #Valorizacion;

	END

     -- ************************************************************************************************
     -- Si asigna 	
     -- ************************************************************************************************
	IF @bAjustaVPresen = 'T' BEGIN	
		UPDATE DETALLE_FLI 
		   SET nominal_venta 	= nominal_compra
		,      marca         	= 'S'	
		,      vPar_Venta    	= Valor_Par					
		,      tasa_Venta    	= Tasa_Compra			
		,      vInicial_Venta	= Valor_Inicial		
		,      vPresente_Venta	= Valor_Presente  	
		 WHERE Serie            = @mascara 
		   AND ventana		= @iventana
		   AND usuario		= @usuarios 
		   AND CarteraSuper     = @sCartera 
                   AND ( Rut_Emisor       = @dRutEmisor or @dRutEmisor = 0 );

		SET @vInicialVenta=(SELECT SUM(vInicial_Venta) FROM DETALLE_FLI
				                              WHERE Serie  = @mascara 
				                                AND Ventana=@iVentana
				                                AND Usuario=@usuarios
							        AND CarteraSuper=@sCartera
 								AND ( Rut_Emisor       = @dRutEmisor or @dRutEmisor = 0 )
			        	                        AND Marca  ='S')


		SET @fMT=(SELECT SUM(vPresente_Venta) FROM DETALLE_FLI
				                     WHERE Serie  =@mascara 
					               AND Ventana=@iVentana
		 		                       AND Usuario=@usuarios
					   	       AND CarteraSuper=@sCartera
							AND ( Rut_Emisor       = @dRutEmisor or @dRutEmisor = 0 )
			  	               AND Marca  ='S')


		SELECT 	Serie           = @Mascara      ,
	       		Nominal         = @nominal      ,
			Tir             = @fTir         ,
			PVP             = @fPvp       ,
			Valor_Presente  = @fMT          ,
			Valor_Inicial   = @vInicialVenta 
		RETURN

	END

	SET @fmtRestante = @fmt 	;

	SELECT @PesosVendidos  = @fmt
        ,      @NominalVendido = @fNominal
	  FROM #Valorizacion		;


            SET @Sumatoria      = 0.0	;

	SELECT	Documento		,  
		Correlativo 		,
		Serie                	,
		Moneda 			,
		Nominal_Compra          ,                             
		Tasa_Compra             ,                             
		Valor_Par               ,                             
		Valor_Presente          ,                             
		Margen                  ,                             
		Valor_Inicial           ,                             
		Nominal_Venta           ,                             
		Tasa_Venta              ,                             
		vPar_Venta              ,                             
		vPresente_Venta         ,                             
		vInicial_Venta          ,                             
		Plazo                   ,
		Ventana     
	INTO #DatosCursor
	FROM  DETALLE_FLI
	WHERE Serie = @mascara 
	  AND Ventana=@iVentana
	  AND Usuario=@usuarios
          AND CarteraSuper=@sCartera
          AND ( Rut_Emisor       = @dRutEmisor or @dRutEmisor = 0 )
	  AND Marca='N'
          AND nominal_compra<>@nominal
	  AND NOT EXISTS(SELECT	1
			   FROM  DETALLE_FLI
			  WHERE  Serie = @mascara 
			    AND  Ventana=@iVentana
		            AND CarteraSuper=@sCartera  
                            AND ( Rut_Emisor       = @dRutEmisor or @dRutEmisor = 0 )
			    AND  Usuario=@usuarios
			    AND  Marca='N'
			    AND nominal_compra=@nominal)
       UNION
	SELECT	Documento		,  
		Correlativo 		,
		Serie                	,
		Moneda 			,
		Nominal_Compra          ,                             
		Tasa_Compra             ,                             
		Valor_Par               ,                             
		Valor_Presente          ,                             
		Margen                  ,                             
		Valor_Inicial           ,                             
		Nominal_Venta           ,                             
		Tasa_Venta              ,                             
		vPar_Venta              ,                          
		vPresente_Venta         ,                             
		vInicial_Venta          ,                             
		Plazo                  ,
		Ventana     
	FROM  DETALLE_FLI
	WHERE  Serie = @mascara 
	  AND  Ventana=@iVentana
	  AND  Usuario=@usuarios
	  AND  Marca='N'
	  AND CarteraSuper=@sCartera
          AND ( Rut_Emisor       = @dRutEmisor or @dRutEmisor = 0 )
          AND nominal_compra=@nominal
	ORDER BY Nominal_compra DESC ; 


	SET @iContadorReg	=  1	;
	SET @iContadorTot	= (SELECT COUNT(*) FROM #DatosCursor)	;		


	DECLARE cursor_cartera	SCROLL CURSOR FOR
	SELECT	Documento		,  
		Correlativo 		,
		Serie                	,
		Moneda 			,
		Nominal_Compra          ,                             
		Tasa_Compra             ,                             
		Valor_Par               ,                             
		Valor_Presente          ,                             
		Margen                  ,                             
		Valor_Inicial           ,                             
		Nominal_Venta           ,                             
		Tasa_Venta              ,                             
		vPar_Venta              ,                             
		vPresente_Venta         ,                             
		vInicial_Venta          ,                             
		Plazo                  	,
		Ventana     		
	FROM #DatosCursor 


	SET @Nominal_faltante=@Nominal 	;

	OPEN cursor_cartera

	FETCH FIRST FROM cursor_cartera
	INTO	@Documento		,  
		@Correlativo 		,
		@Serie                	,
		@Moneda 		,
		@Nominal_Compra         ,                             
		@Tasa_Compra		,                             
		@Valor_Par              ,      
		@Valor_Presente         ,                             
		@Margen                 ,                             
		@Valor_Inicial          ,                             
		@Nominal_Venta          ,               
		@Tasa_Venta             ,                             
		@vPar_Venta             ,                    
		@vPresente_Venta        ,              
		@vInicial_Venta         ,                             
		@Plazo                  ,
		@Ventana     

	SET @zNominal	     = 0
  
	WHILE @@fetch_status = 0 
	BEGIN

	     /* ________________________________________________________________________________________________________________________
		se realiza la asignacion de los nominales que corresponden para la asignacion 
		========================================================================================================================
	     */	
		IF @Nominal_faltante <= 0 
                   BREAK

		IF @nominal_compra <= @nominal_faltante   
                BEGIN
			SET @nominal_venta    = @nominal_compra 
			SET @nominal_faltante = @nominal_faltante - @nominal_compra 
 		END ELSE
                BEGIN
			SET @nominal_venta    = @nominal_faltante
			SET @nominal_faltante = 0
		END

		SET @zNominal = @zNominal + @nominal_venta

--select 		@nominal_faltante, @nominal_venta, @nominal_compra , @zNominal 

	     /* ________________________________________________________________________________________________________________________*/


		IF  @bPantallaPago ='N'  
		BEGIN
			IF  @modcal = 3
			BEGIN 
	
				DELETE FROM #Valorizacion		

	  		     -- Si digita el monto como primer input
 			     -- --------------------------------------------------------------------
				IF @vPresente_Venta = 0.0 
	                           SET @vPresente_Venta = @Valor_Presente
	 		     -- --------------------------------------------------------------------
	
			     -- Utiliza dato anterior
				IF @bmodulo = 0	 
	                           SET @fMT = (@vPresente_Venta * @factor)
	
	
				SET @vNominalModcal = CASE WHEN @Nominal_Compra <> @Nominal_venta THEN @Nominal_venta ELSE @Nominal_Compra END
	
	                        SET @fMT = (@vNominalModcal / @NominalVendido) * @PesosVendidos
	
	  		        INSERT INTO #Valorizacion
				EXECUTE sp_valorizar_client
					@modcal		,
					@feccal		,
					@iCodigo	,
					@Mascara	,
					@iMonemi	,
					@dFecemi	,
					@dFecven	,
					@fTasemi	,
					@fBasemi	,
					@fTasest	,
					@vNominalModcal	, 
					@fTir		,
					@fPvp		,
					@fMT
	
				SELECT 	@fTir = fTir ,
					@fPvp = fPvp , 
					@vMT  = fMT
				FROM    #Valorizacion;
	
			END ELSE  
	                BEGIN 
			        SET @vMT = ((@fMT * @nominal_venta) / @nominal)
			END
		END
		ELSE  BEGIN
	--	IF @sPagoParcial='S' BEGIN  --> PagoParcial 

			IF @bAjustaVPresen='S' 	 BEGIN
				SELECT @vMT = ( ((@valorinicial * @nominal_venta) / @nominal) / @margen) 
				SELECT @FMT = ( ((@valorinicial * @nominal_venta) / @nominal) / @margen) 
			END 
			ELSE BEGIN
				SET @vMT = ( ((@jVpresen * @nominal_venta) / @nominal))
				SET @fMT = ( ((@jVpresen * @nominal_venta) / @nominal))
			END

--			SET @fMT = ROUND(( @fMontoORIG* (@nominal_venta / @nNominalORIG)),0)
--			SET @vMT = ROUND(( @fMontoORIG* (@nominal_venta / @nNominalORIG)),0)

/*			SET @fMT = ROUND(( @fMontoORIG * (@nominal_venta / @nNominalORIG)),0)
			SET @vMT = ROUND((@jVpresen * (@nominal_venta / @nNominalORIG)),0)
*/
			SET @fTir= @jTir   
			SET @fPvp =@jPVP		 
		END

--select @jVpresen ,@nominal_venta   , @nNominalORIG, @fmt
		SET @vMT =ROUND(@vMT,0)
		SET @fMT =ROUND(@fMT,0)	


		SET @fmtRestante  =  @fmtRestante - @vMT



		UPDATE DETALLE_FLI 
		   SET nominal_venta 	= @nominal_venta			,
		       marca         	= 'S'					,
		       vPar_Venta    	= @fPvp					,
		       Tasa_Venta    	= @fTir					,	
		       vInicial_Venta	= round( @vMT * margen, 0 )		,  -- MAP, eliminar decimales al momento de vender Nª Compra
		       vPresente_Venta	= round( @vMT, 0 )  			,  -- MAP, eliminar decimales al momento de vender Nª Compra		
		       Fecha_Emision	= CONVERT(DATETIME,@dFecemi,103)	,
		       Fecha_Vence	= CONVERT(DATETIME,@dFecven,103)	,
		       Fecha_UltCup	= CONVERT(DATETIME,@cFecucup,103)	,
		       Fecha_SigCup	= CONVERT(DATETIME,@cFecpcup,103)	, 
		       Numero_Cupon	= @nnumucup				,
--		  Rut_Emisor	= @nrutemi 				,
		       Mon_Emisor	= @imonemi				,
		       Convexidad	= @fConvx				,
		       DurMod		= @fdurmo				,
		       DurMac		= @fDurat 				,
                       TasaEstimada     = @fTasest				,
                       FolioBCCH        = @folioSOMA                            ,
                       CorrelaBCCH      = @CorrelaSOMA

		 WHERE documento	= @documento
 		   AND correlativo 	= @correlativo
                   AND Serie            = @mascara 
		   AND ventana		= @iventana
		   AND usuario		= @usuarios 
		   AND CarteraSuper=@sCartera
                   AND ( Rut_Emisor       = @dRutEmisor or @dRutEmisor = 0 );

		SET @zdocumento= @documento
		SET @zCorrelativo=@Correlativo


		SET @iContadorReg = @iContadorReg +  1

		FETCH NEXT FROM cursor_cartera
		INTO	@Documento		,  
			@Correlativo 		,
			@Serie                	,
			@Moneda 		,
			@Nominal_Compra         ,                             
			@Tasa_Compra   		,                             
			@Valor_Par              ,                             
			@Valor_Presente         ,                             
			@Margen                 ,                             
			@Valor_Inicial          ,                             
			@Nominal_Venta          ,                             
			@Tasa_Venta             ,                             
			@vPar_Venta             ,                             
			@vPresente_Venta        ,                             
			@vInicial_Venta         ,                             
			@Plazo       		,           
			@Ventana     
	END


	CLOSE cursor_cartera
	DEALLOCATE cursor_cartera 

-- SELECT 'pantalla'=@bPantallaPago,'monto'= @vMT , 'restante'=@fmtRestante, @zDocumento, @zCorrelativo

--	IF  @bPantallaPago ='N'  
--	BEGIN
		IF @fmtRestante<>0 BEGIN				
			UPDATE DETALLE_FLI 
			   SET 
			       vPresente_Venta	= round( @vMT +@fmtRestante , 0) , -- MAP Eliminado los decimales 		
			       vInicial_Venta	= round( (@vMT +@fmtRestante ) * margen	, 0 ) -- MAP Eliminado los decimales	
			 WHERE documento	= @zdocumento
	 		   AND correlativo 	= @zcorrelativo
        	           AND Serie            = @mascara 
			   AND ventana		= @iventana
			  AND usuario		= @usuarios 
			   AND CarteraSuper=@sCartera 
                           AND ( Rut_Emisor       = @dRutEmisor or @dRutEmisor = 0 )
		END
--	END

  
--	IF @nominal_faltante<>0 BEGIN
--		SELECT -1, 'Problemas de cortes con el siguiente serie: '+ @mascara		
--		RETURN
--	END


	SET @vInicialVenta=(SELECT SUM(vInicial_Venta) FROM DETALLE_FLI
			                              WHERE Serie  = @mascara 
			                                AND Ventana=@iVentana
			                                AND Usuario=@usuarios
					  	        AND CarteraSuper=@sCartera
                                                        AND ( Rut_Emisor       = @dRutEmisor or @dRutEmisor = 0 )
			                                AND Marca  ='S')


	SET @fMT=(SELECT SUM(vPresente_Venta) FROM DETALLE_FLI
			                     WHERE Serie  =@mascara 
				               AND Ventana=@iVentana
		 	                       AND Usuario=@usuarios
					       AND CarteraSuper=@sCartera
                                               AND ( Rut_Emisor       = @dRutEmisor or @dRutEmisor = 0 )
			                       AND Marca  ='S')


/*	SET @estado= (SELECT SUM( ABS(nominal_venta-(CAST((nominal_venta/comtocort) AS INT)* comtocort)))
		        FROM detalle_fli INNER JOIN mdco ON conumdocu =documento AND cocorrela=correlativo
	               WHERE Serie = @mascara 
			 AND Ventana=@iVentana
			 AND Usuario=@usuarios
			 AND Marca='S')
*/

        -- PROD-6007 Aplicando Hair-Cut
        -- Se digita la @tir para
        -- inferir valor presente
        set @ftir = case when @modcal = 2 then @tir else @ftir end   -- PROD 6007

        -- PROD-6007 Aplicando Hair-Cut
        -- Se digita @Monto o  @valorinicial para
        -- inferir la tasa

        set @ftir = case when @modcal = 3 then @ftir - @fHairCut  else @ftir end   -- PROD 6007        


	IF  @bPantallaPago ='N'  	
		SELECT 	Serie           = @Mascara      ,
			Nominal         = @nominal      ,
			Tir             = @fTir         ,
			PVP             = @fPvp         ,
			Valor_Presente  = ROUND( CASE WHEN @modcal  = 3 THEN @PesosVendidos ELSE @fMT          END,0) , 
			Valor_Inicial   = ROUND( CASE WHEN @bModulo = 0 and @bAjustaVPresen ='N' THEN @vInicialVenta 
						      WHEN @bAjustaVPresen ='S' THEN @valorinicial ELSE @vInicialVenta END,0)
	ELSE 
		SELECT 	Serie           = @Mascara      ,
			Nominal         = @nominal      ,
			Tir             = @fTir    ,
			PVP             = @fPvp         ,
			Valor_Presente  = @fMT  	, 
			Valor_Inicial   = @vInicialVenta


	RETURN

END

GO
