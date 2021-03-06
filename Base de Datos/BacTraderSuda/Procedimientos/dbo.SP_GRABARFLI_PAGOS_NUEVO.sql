USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARFLI_PAGOS_NUEVO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABARFLI_PAGOS_NUEVO]
   (   @nNumdocu    NUMERIC(10,0)
   ,   @nCorrela    NUMERIC(03,0)
   ,   @nNominal    NUMERIC(19,4)
   ,   @nNumoper    NUMERIC(10,0)
   ,   @nVptirv     FLOAT
   ,   @nValInicial FLOAT
   )
AS
BEGIN

	SET NOCOUNT ON	;

	DECLARE @xFactor       		FLOAT			;

	DECLARE @nRutcart     		NUMERIC(09,0)		;

    	DECLARE @fNominal      		NUMERIC(19,4)
	,	@vinominal     		NUMERIC(19,4)
	,	@vinominaL2    		NUMERIC(19,4)
	,	@vivptirc      		NUMERIC(19,4)
	,	@vivptirc2     		NUMERIC(19,4)
	,	@vivptirv      		NUMERIC(19,4)
	,	@vivptirv2     		NUMERIC(19,4)
	,	@vivalinip     		NUMERIC(19,4)
	,	@vivalinip2    		NUMERIC(19,4)
	,	@vivalvenp    		NUMERIC(19,4)
	,	@vivalvenp2   		NUMERIC(19,4)
	,	@vivptirvi    		NUMERIC(19,4)
	,	@vivptirvi2    		NUMERIC(19,4)
	,	@vivalcomu     		NUMERIC(19,4)
	,	@vivalcomu2    		NUMERIC(19,4)
	,	@vivalcomp     		NUMERIC(19,4)
	,	@vivalcomp2    		NUMERIC(19,4)
	,	@vicapitalv    		NUMERIC(19,4)
	,	@vicapitalv2   		NUMERIC(19,4)
	,	@viinteresv    		NUMERIC(19,4)
	,	@viinteresv2   		NUMERIC(19,4)
	,	@vireajustv    		NUMERIC(19,4)
	,	@vireajustv2   		NUMERIC(19,4)
	,	@vicapitalvi   		NUMERIC(19,4)
	,	@vicapitalvi2  		NUMERIC(19,4)
	,	@viinteresvi   		NUMERIC(19,4)
	,	@viinteresvi2  		NUMERIC(19,4)
	,	@nvptirc       		NUMERIC(19,4)
	,	@vireajustvi   		NUMERIC(19,4)
	,	@vivalvent     		NUMERIC(19,4)
	,	@vivalvemu     		NUMERIC(19,4)
	,	@vireajustvi2  		NUMERIC(19,4)
	,	@nvptirci      		NUMERIC(19,4)
	,	@vivpvent      		NUMERIC(19,4)
	,	@vivalvent2    		NUMERIC(19,4)
	,	@vivalvemu2    		NUMERIC(19,4)
	,	@vivcompori    		NUMERIC(19,4)
	,	@vivalvenc     		NUMERIC(19,4)
	,	@vivpvent2     		NUMERIC(19,4)
	,	@vivalvenc2    		NUMERIC(19,4)
	,	@valor_compra_original  NUMERIC(19,4)
	,	@valor_compra_um_original  NUMERIC(19,4)
	,	@valor_compra_original2    NUMERIC(19,4)
	,	@valor_compra_um_original2 NUMERIC(19,4)	;


	SET  @nRutcart   = (SELECT acrutprop 
			       FROM MDAC WITH(NOLOCK))		;

	SET  @fNominal   = (SELECT vinominal 
			      FROM MDVI
			     WHERE virutcart = @nRutcart 
		    	       AND vinumdocu = @nNumdocu 
			       AND vicorrela = @nCorrela 
			       AND vinumoper = @nNumoper)	;

	SET @nNominal    = @fNominal - @nNominal   		;   --> Obtengo Nominal a dejar en FLI

	SET @xFactor     = (CASE  WHEN @nNominal = 0 THEN 0 ELSE (@nNominal / @fNominal) END )


	SELECT 	@vinominal   = vinominal 
	,	@vivptirc    = vivptirc 
	,	@vivptirv    = vivptirv 
	,	@vivalinip   = vivalinip 
	,	@vivalvenp   = vivalvenp 
	,	@vivptirvi   = vivptirvi 
	,	@vivalcomu   = vivalcomu 
	,	@vivalcomp   = vivalcomp 
	,	@vicapitalv  = vicapitalv 
	,	@viinteresv  = viinteresv 
	,	@vireajustv  = vireajustv 
	,	@vicapitalvi = vicapitalvi
	,	@viinteresvi = viinteresvi 
	,	@vireajustvi = vireajustvi 
	,	@vivalvent   = vivalvent  
	,	@vivalvemu   = vivalvemu  
	,	@vivpvent    = vivpvent 
	,	@vivalvenc   = vivalvenc
	,	@vivcompori  = vivcompori
	,	@valor_compra_original    = valor_compra_original 
	,	@valor_compra_um_original = valor_compra_um_original 
	  FROM  MDVI
         WHERE  virutcart= @nRutcart 
	   AND vinumdocu = @nNumdocu 
	   AND vicorrela = @nCorrela 
	   AND vinumoper = @nNumoper				;

    --> Actualizo tabla de Ventas con Pacto descontando lo vendido
	UPDATE MDVI
	   SET  vinominal   = vinominal   * @xFactor
	,	vivptirc    = vivptirc    * @xFactor
	,	vivptirv    = round(vivptirv    - @nvptirv,0)
	,	vivalinip   = round(vivalinip   - @nValInicial ,0)
	,	vivalvenp   = vivalvenp   - @nValInicial 
	,	vivptirvi   = vivptirvi   * @xFactor
	,	vivalcomu   = vivalcomu   * @xFactor
	,	vivalcomp   = vivalcomp   * @xFactor
	,	vicapitalv  = vicapitalv  * @xFactor
	,	viinteresv  = viinteresv  * @xFactor
	,	vireajustv  = vireajustv  * @xFactor
	,	vicapitalvi = vicapitalvi * @xFactor
	,	viinteresvi = viinteresvi * @xFactor
	,	vireajustvi = vireajustvi * @xFactor
	,	vivalvent   = vivalvent   * @xFactor
	,	vivalvemu   = vivalvemu   * @xFactor
	,	vivpvent    = vivpvent    * @xFactor
	,	vivalvenc  = vivalvenc    * @xFactor
	,	valor_compra_original = valor_compra_original * @xFactor
	,	valor_compra_um_original = valor_compra_um_original * @xFactor
	 WHERE  virutcart = @nRutcart 
	   AND  vinumdocu = @nNumdocu 
	   AND  vicorrela = @nCorrela 
	   AND  vinumoper = @nNumoper				;

    --> Datos los datos actualizados
	SELECT 	@vinominal2   = vinominal
	,	@vivptirc2    = vivptirc
	,	@vivptirv2    = vivptirv
	,	@vivalinip2   = vivalinip 
	,	@vivalvenp2   = vivalvenp
	,	@vivptirvi2   = vivptirvi
	,	@vivalcomu2   = vivalcomu
	,	@vivalcomp2   = vivalcomp
	,	@vicapitalv2  = vicapitalv
	,	@viinteresv2  = viinteresv
	,	@vireajustv2  = vireajustv
	,	@vicapitalvi2 = vicapitalvi
	,	@viinteresvi2 = viinteresvi
	,	@vireajustvi2 = vireajustvi
	,	@vivalvent2   = vivalvent
	,	@vivalvemu2   = vivalvemu
	,	@vivpvent2    = vivpvent
	,	@vivalvenc2   = vivalvenc
	,	@valor_compra_original2    = valor_compra_original
	,	@valor_compra_um_original2 = valor_compra_um_original
	   FROM MDVI
	  WHERE virutcart = @nRutcart 
	    AND vinumdocu = @nNumdocu 
	    AND vicorrela = @nCorrela 
	    AND vinumoper = @nNumoper				;


	SET @vinominal   = @vinominal   - @vinominal2		;
	SET @vivptirc    = @vivptirc    - @vivptirc2		;
	SET @vivptirv    = @vivptirv    - @vivptirv2 		;
	SET @vivalinip   = @vivalinip   - @vivalinip2		;
	SET @vivalvenp   = @vivalvenp   - @vivalvenp2 		;
	SET @vivptirvi   = @vivptirvi   - @vivptirvi2 		;
	SET @vivalcomu   = @vivalcomu   - @vivalcomu2 		;
	SET @vivalcomp   = @vivalcomp   - @vivalcomp2 		;
	SET @vicapitalv  = @vicapitalv  - @vicapitalv2		;
	SET @viinteresv  = @viinteresv  - @viinteresv2		;
	SET @vireajustv  = @vireajustv  - @vireajustv2		;
	SET @vicapitalvi = @vicapitalvi - @vicapitalvi2		;
	SET @viinteresvi = @viinteresvi - @viinteresvi2		;
	SET @vireajustvi = @vireajustvi - @vireajustvi2		;
	SET @vivalvent   = @vivalvent   - @vivalvent2 		;
	SET @vivalvemu   = @vivalvemu   - @vivalvemu2 		;
	SET @vivpvent    = @vivpvent    - @vivpvent2 		;
	SET @vivalvenc   = @vivalvenc   - @vivalvenc2 		;
	SET @nvptirc     = @vicapitalv + @viinteresv + @vireajustv 		;
	SET @nvptirci    = @vicapitalvi+ @viinteresvi + @vireajustvi		;
	SET @valor_compra_original = @valor_compra_original - @valor_compra_original2 		;
	SET @valor_compra_um_original = @valor_compra_um_original - @valor_compra_um_original2		;

	UPDATE  MDDI
	   SET 	dinominal  = dinominal  + @vinominal   
	,      	dicapitalc = dicapitalc + @vicapitalv    
        ,	diinteresc = diinteresc + @viinteresv    
        ,	direajustc = direajustc + @vireajustv    
	,	divptirc   = divptirc   + @nvptirc       
	,	dicapitaci = dicapitaci + @vicapitalvi    
	,	diintereci = diintereci + @viinteresvi    
	,	direajusci = direajusci + @vireajustvi    
	,	divptirci  = divptirci  + @nvptirci   
	 WHERE dirutcart=@nRutcart 
	   AND dinumdocu=@nNumdocu 
	   AND dicorrela=@nCorrela				;

	UPDATE MDCP
    	   SET 	cpnominal  = cpnominal  + ISNULL(@vinominal,0)   
	,	cpvalcomp  = cpvalcomp  + ISNULL(@vivalcomp,0)         
	,	cpvalcomu  = cpvalcomu  + ISNULL(@vivalcomu,0)         
	,	cpcapitalc = cpcapitalc + ISNULL(@vicapitalv,0)         
	,	cpinteresc = cpinteresc + ISNULL(@viinteresv,0)         
	,	cpreajustc = cpreajustc + ISNULL(@vireajustv,0)         
	,	cpvptirc   = cpvptirc   + ISNULL(@nvptirc,0)         	
	,	cpvalvenc  = cpvalvenc  + ISNULL(@vivalvenc,0)    
	,	cpvcompori = ISNULL(@vivcompori,0) 	
	,	valor_compra_um_original = valor_compra_um_original + ISNULL(@valor_compra_um_original,0)    
	,	valor_compra_original    = valor_compra_original    + ISNULL(@valor_compra_original,0)        
     	  WHERE cprutcart=@nRutcart 
	    AND cpnumdocu=@nNumdocu 
	    AND cpcorrela=@nCorrela				;

	DELETE 
	  FROM MDVI 
	 WHERE virutcart=@nRutcart 
	   AND vinumdocu=@nNumdocu 
	   AND vicorrela=@nCorrela 
	   AND vinumoper=@nNumoper
	   AND vinominal=0 					; 

END


GO
