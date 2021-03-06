USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VTCORTESPARCIAL_PAGOSFLI]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VTCORTESPARCIAL_PAGOSFLI]
                     ( 
                         @nRutcart    NUMERIC  (9,0) ,
                         @nNumdocu    NUMERIC (10,0) ,
                         @nCorrela    NUMERIC  (5,0) ,
                         @nNumoper    NUMERIC (10,0) ,
                         @nCantcort   NUMERIC (21,0) ,
                         @nMontcort   NUMERIC (19,4) ,
                         @cTippago    CHAR     (1)   ,
                         @nCorPago    NUMERIC (3,0)
                     )
AS
BEGIN

	SET NOCOUNT ON	;

	DECLARE @cCorte       	NUMERIC(21,0)	
	,	@nMonto       	NUMERIC(19,4)
	,	@x            	NUMERIC(01,0)
	,	@cant_reg     	NUMERIC(03,0)
	,	@nRutcart_cv  	NUMERIC(09,0)  
        ,	@nNumdocu_cv  	NUMERIC(10,0) 
        ,	@nCorrela_cv  	NUMERIC(05,0)  
	,	@nCantcort_cv 	NUMERIC(09,0) 
	,	@nMontcort_cv 	NUMERIC(19,4) 	;

	DECLARE @ccvtipoper   	CHAR(1)    
	,	@ccvstatreg   	CHAR(1)    
	,	@ccvreproceso 	CHAR(1)		;


	SELECT @cCorte = cvcantcort
	,      @nMonto = cvmtocort
   FROM MDCV
	 WHERE cvnumoper = @nNumoper 
	   AND cvnumdocu = @nNumdocu 
	   AND cvcorrela = @nCorrela 		;

	INSERT INTO 
	CORTES_PAGOS_FLI( 
		corutcart    
	,	conumdocu    
	,	cocorrela    
	,	conumoper
	,	corrpago     
	,	cocantcort
	,	comtocort 
	,	cotipoper 
	,	costatreg 
	,	coTipoCartera
	,	coreproceso
	,	cotippago   )
VALUES   (
		@nRutcart  
	,	@nNumdocu  
        ,       @nCorrela  
        ,       @nNumoper  
        ,       ISNULL(@nCorPago,  0)
        ,       ISNULL(@nCantcort, 0)
        ,       ISNULL(@nMontcort, 0)
        ,       ''        
        ,       ''        
        ,       0         
        ,       'S'       
        ,       @cTippago )			;


 IF @nMonto <> @nMontcort
 BEGIN
   INSERT INTO CORTES_PAGOS_FLI ( corutcart    , --  1
                               	  conumdocu    , --  2
                                  cocorrela    , --  3
                                  conumoper    , --  4
                                  corrpago     ,
                                  cocantcort   , --  5
                                  comtocort    , --  6
                                  cotipoper    , --  7
                                  costatreg    , --  8
                                  coTipoCartera, --  9
                                  coreproceso  , -- 10
                                  cotippago      -- 11
                              )
                     VALUES   (
                               @nRutcart    , --  1
                               @nNumdocu    , --  2
                               @nCorrela    , --  3
                               @nNumoper    , --  4
                               ISNULL(@nCorPago, 0) , --  5
                               ISNULL(ABS(@nCantcort - @cCorte), 0)  , --  6
                               ISNULL(@nMontcort, 0)   , --  7
                               ''           , --  8
                               ''           , --  9
                               0            , --  10
                               'S'          , --  11 
                               'P'            --  12 
                              )
 END

END

GO
