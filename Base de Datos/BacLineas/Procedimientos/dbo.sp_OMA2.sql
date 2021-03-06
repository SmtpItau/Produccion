USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[sp_OMA2]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE PROCEDURE [dbo].[sp_OMA2](@FechaConsulta CHAR(8))
AS                            
BEGIN
 SET NOCOUNT ON                                                                         

 CREATE TABLE  #oma2                                                                 
       ( 
        TIPOPE10    	CHAR(01)	,                        
        CODIGO10    	NUMERIC(03)	,                        
        MONTO10     	NUMERIC(20,4)   ,                         
        TIPCAMP10   	NUMERIC(20,4)   ,                        
        NOMBREEMI10 	CHAR(40)        ,
	COMERCIO10	CHAR(10)	,
        TIPOPE40    	CHAR(01)	,
        CODIGO40    	NUMERIC(03)	,                        
        MONTO40     	NUMERIC(20,4)   ,                         
        TIPCAMP40   	NUMERIC(20,4)	,
        NOMBREEMI40 	CHAR(40)	,
	COMERCIO40	CHAR(10)	,
	FECHA_PROCESO 	CHAR(10)	,
	HORA		CHAR(08)	,
        RUTBCO          NUMERIC(09)	,
	ENTIDAD		CHAR(30)	,
        RUTCLI10        NUMERIC(09)	,
        RUTCLI40        NUMERIC(09)	,
        NUMFUT10        NUMERIC(08)	,
        NUMFUT40        NUMERIC(08)	,
        MERCADO10       CHAR(04)	,
        MERCADO40       CHAR(04)	,
	MONCNV10	CHAR(03)	,
	MONCNV40	CHAR(03)	,
	TIPCLI10	NUMERIC(05)	,
	TIPCLI40	NUMERIC(05)	
       )                                                                           


 DECLARE @OP 	         INT 		,
         @CONSE          NUMERIC(05)	,
	 @CONT 	         INT		,
         @MONTO          NUMERIC(20,4)	,                        
         @NUM	         NUMERIC(10)	,
         @OPERA          CHAR(1)	,
         @CODOMA         NUMERIC(5)	,
         @TIPCAMP        NUMERIC(20,4)	,  
         @NOMBREEMI      CHAR(40)	,
	 @mercado        CHAR(04)	,    	
         @tipcli         NUMERIC(05)	,
         @comercio       CHAR(10)	, 
         @rutcli         NUMERIC(09)	,
         @numfut         NUMERIC(08)	,
         @monedacnv	 CHAR(03)

 SELECT @OP=0
 SELECT @NUM=0
 SELECT @MONTO=0 

SELECT * INTO #tmp_memo_total FROM memo
SELECT * INTO #tmp_memo_canje FROM memo WHERE motipmer = 'CANJ'

UPDATE #tmp_memo_total SET mocodoma = 27 WHERE motipmer = 'CANJ'
UPDATE #tmp_memo_canje SET mocodoma = 12 , motipope = 'V'

SELECT * INTO #tmp_memo_todos from #tmp_memo_total
INSERT INTO #tmp_memo_todos SELECT * FROM #tmp_memo_canje

DELETE #tmp_memo_todos FROM view_cliente WHERE morutcli = clrut AND cltipcli <> 4 AND motipmer = 'CANJ'
UPDATE #tmp_memo_todos SET motipmer = 'PTAS' WHERE motipmer IN( 'PTAS' , 'CANJ' )

SELECT	"monumope"=IDENTITY(SMALLINT, 100, 1)			,
	motipope						,
	codi_oma						,
	'momonmo' = SUM(moussme)				,
	'momonpe' = SUM(momonpe)				,
	'moticam' = SUM(momonpe) / SUM(moussme)			,
	monomcli						,
	motipmer						,
	cltipcli						,
	morutcli						,
	mocodcli						,
	'monumfut'= CASE WHEN monumfut <> 0 THEN 1 ELSE 0 END	,
	mocodcnv	
INTO    #tmp_memo	
FROM	#tmp_memo_todos
	,tbomadelsuda 
	,VIEW_CLIENTE 
WHERE 	mocodoma  = codi_opera 								AND
	(morutcli=clrut and clcodigo = clcodigo )					AND
	(((CODI_OMA=1 OR CODI_OMA=4 OR CODI_OMA=6 OR CODI_OMA=9) AND motipmer='EMPR') 	OR 
	((CODI_OMA=1 OR CODI_OMA=3 OR CODI_OMA=6 ) AND motipmer = 'PTAS' ) )		AND
	(MOESTATUS='M' or MOESTATUS='')
GROUP  BY motipmer,motipope,morutcli,mocodcli,codi_oma,	mocodcnv,cltipcli,monomcli,(CASE WHEN monumfut <> 0 THEN 1 ELSE 0 END	)

DELETE 	#tmp_memo
WHERE	momonmo < 500000

SELECT 	@CONT = COUNT(*)
FROM	#tmp_memo

WHILE @OP < @CONT

	BEGIN

		SET ROWCOUNT @OP
	      ----	
		SELECT 	 @OPERA     = motipope
			,@CODOMA    = codi_oma
			,@MONTO     = momonmo
			,@TIPCAMP   = moticam
			,@NOMBREEMI = monomcli
			,@mercado   = motipmer
			,@TIPCLI    = cltipcli
			,@comercio  = '' --isnull( ( select codigo_comercio + ' ' + concepto from view_planilla_spt where planilla_fecha = '20011129' AND operacion_numero = monumope ) , "")
			,@rutcli    = morutcli
			,@numfut    = monumfut
			,@monedacnv = mocodcnv
		FROM 	#tmp_memo
		ORDER BY monumope

		SET ROWCOUNT 1
/*
			,tbomadelsuda
			,VIEW_CLIENTE 
		WHERE 	mocodoma  = codi_opera And
			(morutcli=clrut and clcodigo = 1) and
			(((CODI_OMA=1 OR CODI_OMA=4 OR CODI_OMA=6 OR CODI_OMA=9) AND motipmer='EMPR') or 
			 ((CODI_OMA=1 OR CODI_OMA=3 OR CODI_OMA=6 ) AND motipmer='PTAS'))AND
			momonmo  > 499999  AND
			(MOESTATUS='M' or MOESTATUS='')
		ORDER BY monumope
*/
    -----------------------------------------------------------------------------------------------------
	IF @CODOMA=1 AND @mercado = 'PTAS' 
	BEGIN 

		IF EXISTS(SELECT * FROM #oma2 WHERE TIPOPE10=' ') --MONTO10=0)
			BEGIN
				UPDATE 	#oma2  
				SET   	CODIGO10    = @CODOMA		,
					MONTO10     = @MONTO		,
					TIPCAMP10   = @TIPCAMP		,
					TIPOPE10    = @OPERA		,
					NOMBREEMI10 = @NOMBREEMI	,
					COMERCIO10  = @comercio		,
					RUTCLI10    = @rutcli		,
					NUMFUT10    = @numfut		,
					MERCADO10   = @mercado		,
					MONCNV10    = @monedacnv	,
					TIPCLI10    = @TIPCLI
				WHERE 	TIPOPE10=' ' -- MONTO10=0

			END
		ELSE 

			BEGIN
				INSERT	#oma2(	TIPOPE10	,
						CODIGO10	,
						MONTO10		,
						TIPCAMP10	,
						NOMBREEMI10	,
						COMERCIO10	,
						TIPOPE40	,
						CODIGO40	,
						MONTO40		,
						TIPCAMP40	,
						NOMBREEMI40	,
						COMERCIO40	, 
						RUTCLI10	,
						NUMFUT10	, 
						MERCADO10	,
						MONCNV10	,
						TIPCLI10	)
				VALUES(	"C"		,
					@CODOMA		,
					@MONTO		,
					@TIPCAMP	,
					@NOMBREEMI	,
					@COMERCIO	,
					" "		,
					0		,
					0		,
					0		,
					""		,
					""		,
					@rutcli		,
					@numfut		,
					@mercado	,
					@monedacnv	,
					@TIPCLI		)

			END

	END

    -----------------------------------------------------------------------------------------------------
	IF @CODOMA=1 AND @mercado = 'EMPR' AND @tipcli > 4 
	BEGIN
  
		IF EXISTS(SELECT * FROM #oma2 WHERE TIPOPE40=' ') --MONTO10=0)
			BEGIN      
				UPDATE 	#oma2  
				SET   	CODIGO40    = @CODOMA		,
					MONTO40     = @MONTO		,
					TIPCAMP40   = @TIPCAMP		,
					TIPOPE40    = @OPERA		,
					NOMBREEMI40 = @NOMBREEMI	,
					COMERCIO40  = @comercio		,
					RUTCLI40    = @rutcli		,
					NUMFUT40    = @numfut		,
					MERCADO40   = @mercado		,
					MONCNV40    = @monedacnv	,
					TIPCLI40    = @TIPCLI
				WHERE TIPOPE40=' ' -- MONTO10=0

			END       
       ELSE 
		BEGIN
			INSERT 	#oma2(	TIPOPE40	,
					CODIGO40	,
					MONTO40		,
					TIPCAMP40	,
					NOMBREEMI40	,
					COMERCIO40	,
					TIPOPE10	,
					CODIGO10	,
					MONTO10		,
					TIPCAMP10	,
					NOMBREEMI10	,
					COMERCIO10	,
					RUTCLI40	,
					NUMFUT40	,
					MERCADO40	,
					MONCNV40	,
					TIPCLI40	)

			VALUES(	"C"		,
				@CODOMA		,
				@MONTO		,
				@TIPCAMP	,
				@NOMBREEMI	,
				@comercio	,
				" "		,
				0		,
				0		,
				0		,
				""		,
				""        	,
				@rutcli   	,
				@numfut   	,
				@mercado  	,
				@monedacnv	,
				@TIPCLI		)

		END
	END
 
    -----------------------------------------------------------------------------------------------------
	IF @CODOMA=1 AND @mercado = 'EMPR' AND @tipcli < 5 BEGIN
       
		IF EXISTS(SELECT * FROM #oma2 WHERE TIPOPE10=' ') --MONTO10=0)
			BEGIN      
				UPDATE 	#oma2  
				SET   	CODIGO10    = @CODOMA		,
					MONTO10     = @MONTO		,
					TIPCAMP10   = @TIPCAMP		,
					TIPOPE10    = @OPERA		,
					NOMBREEMI10 = @NOMBREEMI	,
					COMERCIO10  = @comercio		,
					RUTCLI10    = @rutcli		,
					NUMFUT10    = @numfut		,
					MERCADO10   = @mercado		,
					MONCNV10    = @monedacnv	,
					TIPCLI10    = @TIPCLI
				WHERE 	TIPOPE10=' ' -- MONTO10=0

			END       
       ELSE 
		BEGIN
			INSERT #oma2(	TIPOPE10	,
					CODIGO10	,
					MONTO10		,
					TIPCAMP10	,
					NOMBREEMI10	,
					COMERCIO10	,
					TIPOPE40	,
					CODIGO40	,
					MONTO40		,
					TIPCAMP40	,
					NOMBREEMI40	,
					COMERCIO40	,
					RUTCLI10	,
					NUMFUT10	,
					MERCADO10	,
					MONCNV10	,
					TIPCLI10	)
			VALUES(	"C"		,
				@CODOMA		,
				@MONTO		,
				@TIPCAMP	,
				@NOMBREEMI	,
				@comercio	,
				" "		,
				0		,
				0		,
				0		,
				""		,
				""		,
				@rutcli		,
				@numfut		,
				@mercado	,
				@monedacnv	,
				@TIPCLI		)

		END
	END
   
    -----------------------------------------------------------------------------------------------------
    IF @CODOMA=3 
	BEGIN  
		IF EXISTS(SELECT * FROM #oma2 WHERE TIPOPE10=' ') --MONTO10=0)
			BEGIN
      				UPDATE	#oma2  
				SET   	CODIGO10    = @CODOMA		,
					MONTO10     = @MONTO		,
					TIPCAMP10   = @TIPCAMP		,
					TIPOPE10    = @OPERA		,
					NOMBREEMI10 = @NOMBREEMI	,
					COMERCIO10  = @comercio		,
					RUTCLI10    = @rutcli		,
					NUMFUT10    = @numfut		,
					MERCADO10   = @mercado		,
					MONCNV10    = @monedacnv	,
					TIPCLI10    = @TIPCLI
				WHERE 	TIPOPE10=' ' -- MONTO10=0

			END       
		ELSE 
			BEGIN
				INSERT	#oma2(	TIPOPE10	,
						CODIGO10	,
						MONTO10		,
						TIPCAMP10	,
						NOMBREEMI10	,
						COMERCIO10	,
						TIPOPE40	,
						CODIGO40	,
						MONTO40		,
						TIPCAMP40	,
						NOMBREEMI40	,
						COMERCIO40	,
						RUTCLI10	,
						NUMFUT10	,
						MERCADO10	,
						MONCNV10	,
						TIPCLI10	)
				VALUES(	"C",
					@CODOMA,
					@MONTO,
					@TIPCAMP,
					@NOMBREEMI,
					@comercio,
					" ",
					0,
					0,
					0,
					"",
					"",
					@rutcli,
					@numfut,
					@mercado,
					@monedacnv,
					@TIPCLI)

			END

	END

    -----------------------------------------------------------------------------------------------------
    IF @CODOMA=4 
	BEGIN
  
		IF EXISTS(SELECT * FROM #oma2 WHERE TIPOPE40=' ') --MONTO40=0 )
			BEGIN         
				UPDATE	#oma2  
				SET    	CODIGO40    = @CODOMA		,
					MONTO40     = @MONTO		,
					TIPCAMP40   = @TIPCAMP		,
					TIPOPE40    = @OPERA		,
					NOMBREEMI40 = @NOMBREEMI	,
					COMERCIO40  = @comercio		,
					RUTCLI40    = @rutcli		,
					NUMFUT40    = @numfut		,
					MERCADO40   = @mercado		,
					MONCNV40    = @monedacnv	,
					TIPCLI40    = @TIPCLI
				WHERE  	TIPOPE40=' ' --MONTO40=0
             
			END
		ELSE 
			BEGIN
				INSERT	#oma2(	TIPOPE40	,
						CODIGO40	,
						MONTO40		,
						TIPCAMP40	,
						NOMBREEMI40	,
						COMERCIO40	,
						TIPOPE10	,
						CODIGO10	,	
						MONTO10		,
						TIPCAMP10	,
						NOMBREEMI10	,
						COMERCIO10	,
						RUTCLI40	,
						NUMFUT40	,
						MERCADO40	,
						MONCNV40	,
						TIPCLI40	)
				VALUES(	"C"		,
					@CODOMA		,
					@MONTO		,
					@TIPCAMP	,
					@NOMBREEMI	,
					@comercio	,
					" "		,
					0		,
					0		,
					0		,
					""		,
					""		,
					@rutcli		,
					@numfut		,
					@mercado	,
					@monedacnv	,
					@TIPCLI		)

			END
	END

    -----------------------------------------------------------------------------------------------------
    IF @CODOMA=6 AND @mercado = 'PTAS' 
	BEGIN

		IF EXISTS(SELECT * FROM #oma2 WHERE TIPOPE10=' ') --MONTO10=0)
			BEGIN      
				UPDATE 	#oma2  
				SET    	CODIGO10    = @CODOMA		,
					MONTO10     = @MONTO		,
					TIPCAMP10   = @TIPCAMP		,
					TIPOPE10    = @OPERA		,
					NOMBREEMI10 = @NOMBREEMI	,
					COMERCIO10  = @comercio		,
					RUTCLI10    = @rutcli		,
					NUMFUT10    = @numfut		,
					MERCADO10   = @mercado		,
					MONCNV10    = @monedacnv	,
					TIPCLI10    = @TIPCLI
				WHERE  	TIPOPE10=' ' --MONTO10=0
      
			END
		ELSE 
			BEGIN
				INSERT	#oma2(	TIPOPE10	,
						CODIGO10	,
						MONTO10		,
						TIPCAMP10	,
						NOMBREEMI10	,
						COMERCIO10	,
						TIPOPE40	,
						CODIGO40	,
						MONTO40		,
						TIPCAMP40	,
						NOMBREEMI40	,
						COMERCIO40	,
						RUTCLI10	,    
						NUMFUT10	,
						MERCADO10	,
						MONCNV10	,
						TIPCLI10	)
				VALUES(	"V"		,
					@CODOMA		,
					@MONTO		,
					@TIPCAMP	,
					@NOMBREEMI	,
					@comercio	,
					" "		,
					0		,
					0		,
					0		,
					""		,
					""		,
					@rutcli		,
					@numfut		,
					@mercado	,
					@monedacnv	,
					@TIPCLI		)

			END
	END

    -----------------------------------------------------------------------------------------------------
    IF @CODOMA=6 AND @mercado = 'EMPR' AND @tipcli > 4 
	BEGIN

		IF EXISTS(SELECT * FROM #oma2 WHERE TIPOPE40=' ') --MONTO10=0)
			BEGIN      
				UPDATE	#oma2  
				SET    	CODIGO40    = @CODOMA		,
					MONTO40     = @MONTO		,
					TIPCAMP40   = @TIPCAMP		,
					TIPOPE40    = @OPERA		,
					NOMBREEMI40 = @NOMBREEMI	,
					COMERCIO40  = @comercio		,
					RUTCLI40    = @rutcli		,
					NUMFUT40    = @numfut		,
					MERCADO40   = @mercado		,
					MONCNV40    = @monedacnv	,
					TIPCLI40    = @TIPCLI
				WHERE  	TIPOPE40=' ' --MONTO10=0
      
			END
		ELSE 
			BEGIN
				INSERT	#oma2(	TIPOPE40	,
						CODIGO40	,
						MONTO40		,
						TIPCAMP40	,
						NOMBREEMI40	,
						COMERCIO40	,
						TIPOPE10	,
						CODIGO10	,
						MONTO10		,
						TIPCAMP10	,
						NOMBREEMI10	,
						COMERCIO10	,
						RUTCLI40	, 
						NUMFUT40	,
						MERCADO40	,
						MONCNV40	,
						TIPCLI40	)
				VALUES(	"V"		,
					@CODOMA		,
					@MONTO		,
					@TIPCAMP	,
					@NOMBREEMI	,
					@comercio	,
					" "		,
					0		,
					0		,
					0		,
					""		,
					""		,
					@rutcli		,
					@numfut		,
					@mercado	,
					@monedacnv	,
					@TIPCLI		)

			END
	END
 
    -----------------------------------------------------------------------------------------------------
    IF @CODOMA=6 AND @mercado = 'EMPR' AND @tipcli < 5 
	BEGIN

		IF EXISTS(SELECT * FROM #oma2 WHERE TIPOPE10=' ') --MONTO10=0)
			BEGIN      
				UPDATE 	#oma2  
				SET    	CODIGO10    = @CODOMA		,
					MONTO10     = @MONTO		,
					TIPCAMP10   = @TIPCAMP		,
					TIPOPE10    = @OPERA		,
					NOMBREEMI10 = @NOMBREEMI	,
					COMERCIO10  = @comercio		,
					RUTCLI10    = @rutcli		,
					NUMFUT10    = @numfut		,
					MERCADO10   = @mercado		,
					MONCNV10    = @monedacnv	,
					TIPCLI10    = @TIPCLI
				WHERE  	TIPOPE10=' ' --MONTO10=0
      
			END
		ELSE 
			BEGIN
				INSERT	#oma2(	TIPOPE10	,
						CODIGO10	,
						MONTO10		,
						TIPCAMP10	,
						NOMBREEMI10	,
						COMERCIO10	,
						TIPOPE40	,
						CODIGO40	,
						MONTO40		,
						TIPCAMP40	,
						NOMBREEMI40	,
						COMERCIO40	,
						RUTCLI10	,
						NUMFUT10	,
						MERCADO10	,
						MONCNV10	,
						TIPCLI10	)
				VALUES(	"V"		,
					@CODOMA		,
					@MONTO		,
					@TIPCAMP	,
					@NOMBREEMI	,
					@comercio	,
					" "		,
					0		,
					0		,
					0		,
					""		,
					""		,
					@rutcli		,
					@numfut		,
					@mercado	,
					@monedacnv	,
					@TIPCLI		)

			END
	END

    -----------------------------------------------------------------------------------------------------
    IF @CODOMA=9 
	BEGIN

		IF EXISTS(SELECT * FROM #oma2 WHERE  TIPOPE40=' ')  --MONTO40=0)
			BEGIN      

				UPDATE	#oma2  
				SET    	CODIGO40    = @CODOMA		,
					MONTO40     = @MONTO		,
					TIPCAMP40   = @TIPCAMP		,
					TIPOPE40    = @OPERA		,
					NOMBREEMI40 = @NOMBREEMI	,
					COMERCIO40  = @comercio		,
					RUTCLI40    = @rutcli		,
					NUMFUT40    = @numfut		,
					MERCADO40   = @mercado		,
					MONCNV40    = @monedacnv	,
					TIPCLI40    = @TIPCLI
				WHERE  	TIPOPE40=' '  --MONTO40=0
      
			END
		ELSE 
			BEGIN
				INSERT	#oma2(	TIPOPE40	,
						CODIGO40	,
						MONTO40		,
						TIPCAMP40	,
						NOMBREEMI40	,
						COMERCIO40	,
						TIPOPE10	,
						CODIGO10	,
						MONTO10		,
						TIPCAMP10	,
						NOMBREEMI10	,
						COMERCIO10	,
						RUTCLI40	,
						NUMFUT40	,
						MERCADO40	,
						MONCNV40	,
						TIPCLI40	)
				VALUES(	"V"		,
					@CODOMA		,
					@MONTO		,
					@TIPCAMP	,
					@NOMBREEMI	,
					@comercio	,
					" "		,
					0		,
					0		,
					0		,
					""		,
					""		,
					@rutcli		,
					@numfut		,
					@mercado	,
					@monedacnv	,
					@TIPCLI		)

			END
	END

    -----------------------------------------------------------------------------------------------------
    SELECT @OP = @OP + 1
    SET ROWCOUNT 0
-- Dentro del While	

 END

  UPDATE #oma2
  SET	 FECHA_PROCESO 	= CONVERT( CHAR(10) , acfecpro , 103 ),
	 HORA		= CONVERT( CHAR(08) , GETDATE(), 108 ),
         RUTBCO         = acrut,
	 ENTIDAD 	= acnombre 
  FROM 	 meac

	SELECT * FROM	#oma2

  SET NOCOUNT OFF

END

-- sp_OMA2 '20011203' SELECT MOFECH,MOCODOMA,MOESTATUS,* FROM MEMO WHERE MOCODMON='USD' and motipmer='empr' update memo set moestatus=''
-- sp_OMA2 '20011219'

/*

SELECT * FROM MEAC
DROP TABLE #tmp_memo	
SELECT	"monumope"=IDENTITY(smallint, 100, 1)			,
	motipope						,
	codi_oma						,
	'momonmo' = SUM(moussme)				,
	'momonpe' = SUM(momonpe)				,
	'moticam' = SUM(momonpe) / SUM(moussme)			,
	monomcli						,
	motipmer						,
	cltipcli						,
	morutcli						,
	mocodcli						,
	'monumfut'= CASE WHEN monumfut <> 0 THEN 1 ELSE 0 END	,
	mocodcnv	
INTO    #tmp_memo	
FROM	memo
	,tbomadelsuda 
	,VIEW_CLIENTE 
WHERE 	mocodoma  = codi_opera 								AND
	(morutcli=clrut and clcodigo = clcodigo )					AND
	(((CODI_OMA=1 OR CODI_OMA=4 OR CODI_OMA=6 OR CODI_OMA=9) AND motipmer='EMPR') 	OR 
	((CODI_OMA=1 OR CODI_OMA=3 OR CODI_OMA=6 ) AND motipmer='PTAS'))		AND
	(MOESTATUS='M' or MOESTATUS='')
GROUP  BY motipmer,motipope,morutcli,mocodcli,codi_oma,	mocodcnv,cltipcli,monomcli,(CASE WHEN monumfut <> 0 THEN 1 ELSE 0 END	)

select * from #tmp_memo	

*/








GO
