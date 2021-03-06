USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTAOPERPAPEL_GRILLA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_CONSULTAOPERPAPEL_GRILLA] 

   (   @cCodigo CHAR (01)

   ,   @cTipo  CHAR (01)
   
   ,   @dfecha DATETIME

   )

AS

BEGIN



	SET NOCOUNT ON	;

	
 	SELECT DISTINCT  'numoper'    = monumoper  ,

        	          'rutcartera' = SPACE (09)  ,

                	  'tipoper'    = SPACE (05)  ,

	                  'rutcli'     = SPACE (09)  ,

	                  'nomcli'     = SPACE (40)  ,

	                  'totoper'    = SPACE (30)  ,

	                  'horat'      = SPACE (20)  ,

	                  'operador'   = SPACE (12)  ,

	                  'nomoper'    = SPACE (30)  ,

	                  'papeleta'   = CONVERT(INTEGER,1) ,

	                  'contrato'   = CONVERT(INTEGER,1) ,

	                  'estaoper'   = SPACE (01)  ,

	                  'moneda'     = CONVERT(NUMERIC (9,0),0),

	                  'tiporig'    = SPACE (05)  ,

	                  'Estado'     = mostatreg  ,

	                  'codcli'     = CONVERT(NUMERIC (9,0),0),

	                  'correla'    = CONVERT(NUMERIC (9,0),0)

	 INTO #TMP

	 FROM MDMO

	 WHERE (motipoper='CP' OR motipoper='CI' OR motipoper='VP' OR motipoper='VI' OR

	        motipoper='IB' OR motipoper='ST' OR motipoper='RCA' OR motipoper='RVA' OR

	        motipoper='IC' OR motipoper='AIC')
			
			and mofecpro = @dfecha 




	insert into #tmp

 	SELECT DISTINCT  'numoper'    = monumoper  ,

        	          'rutcartera' = SPACE (09)  ,

                	  'tipoper'    = SPACE (05)  ,

	                  'rutcli'     = SPACE (09)  ,

	                  'nomcli'     = SPACE (40)  ,

	                  'totoper'    = SPACE (30)  ,

	                  'horat'      = SPACE (20)  ,

	                  'operador'   = SPACE (12)  ,

	                  'nomoper'    = SPACE (30)  ,

	                  'papeleta'   = CONVERT(INTEGER,1) ,

	                  'contrato'   = CONVERT(INTEGER,1) ,

	                  'estaoper'   = SPACE (01)  ,

	                  'moneda'     = CONVERT(NUMERIC (9,0),0),

	                  'tiporig'    = SPACE (05)  ,

	                  'Estado'     = mostatreg  ,

	                  'codcli'     = CONVERT(NUMERIC (9,0),0),

	                  'correla'    = CONVERT(NUMERIC (9,0),0)

	 FROM MDMO

	 WHERE motipoper ='FLI' And mostatreg='A'

	 	 IF @cTipo = 'C'

	  DELETE #TMP WHERE LTRIM(RTRIM(estado)) <> ''	

	 UPDATE #TMP

		SET tipoper    = motipoper   ,

	     rutcartera = CONVERT(CHAR(09),morutcart) ,

	     rutcli     = CONVERT(CHAR(09),morutcli) ,

	     codcli     = mocodcli   ,

	     nomcli     = SPACE(40)   ,

	     totoper    = SPACE(30)   ,

	     horat      = SUBSTRING(mohora,1,8)  ,

	     nomoper    = SPACE(30)   ,

	     operador   = mousuario   ,

	     papeleta   = ISNULL(papapimp,0)  ,

	     contrato   = ISNULL(paconimp,0)  ,

	     estaoper   = mostatreg,

	     correla    = 1

	 FROM MDMO

--  REQ. 7619

--             , MDPA

            , #TMP LEFT OUTER JOIN MDPA ON numoper = panumoper

	 WHERE numoper  = monumoper 

--  REQ. 7619

--	 AND   numoper*=panumoper	



 UPDATE #TMP

 SET tipoper  = SUBSTRING(moinstser,2,3) ,

  totoper  = CONVERT(CHAR(30),(SELECT SUM(movalinip) FROM MDMO WHERE numoper=monumoper)),

  moneda  = momonemi

 FROM MDMO

 WHERE numoper=monumoper AND motipoper='IB'



 UPDATE #TMP

   SET totoper = CONVERT(CHAR(30),(SELECT SUM(movalcomp) FROM MDMO WHERE numoper=monumoper))

  FROM MDMO

 WHERE tipoper = 'CP' OR tipoper='RC' --OR tipoper='CAP' OR tipoper='CAP'
 
 UPDATE #TMP   

    SET totoper = CONVERT(CHAR(30),(SELECT SUM(movalvenp) FROM MDMO WHERE numoper=monumoper))

   FROM MDMO   

  WHERE tipoper = 'RCA'
  
 UPDATE #TMP

 SET totoper = CONVERT(CHAR(30),(SELECT SUM(movalven) FROM MDMO WHERE numoper=monumoper))

 FROM MDMO

 WHERE tipoper='VP' OR tipoper='RV' OR tipoper='RVA' OR tipoper='ST'
 
 UPDATE #TMP

 SET totoper = CONVERT(CHAR(30),(SELECT SUM(movalinip) FROM MDMO WHERE numoper=monumoper))

 FROM MDMO

 WHERE tipoper='CI' OR tipoper='VI' 
 
 UPDATE #TMP

 SET totoper = CONVERT(CHAR(30), ROUND((SELECT SUM(movalinip) FROM MDMO WHERE numoper=monumoper),0))

 FROM MDMO

 WHERE tipoper='FLI'
 
 UPDATE #TMP

 SET totoper = convert(char(30),(select sum(movpresen) from MDMO where numoper=monumoper))

 FROM MDMO

 WHERE tipoper='IC'
 
 UPDATE  #TMP

 SET totoper = CONVERT(CHAR(30),(SELECT SUM(movpresen) FROM MDMO WHERE numoper=monumoper))

 WHERE tipoper ='AIC'


	 INSERT INTO #TMP

	SELECT  Numero_Operacion			

	,	acrutprop			

	,	Tipo_operacion				

	,	97029000			

	,	''				

	,	Total_Operacion

	,	hora				

	,	Usuario			

	,	''				

	,	1				

	,	1				

	,	''				

	,	999				

	,	''				

	,	''				

	,	1				

	,	Pago			

	FROM Resumen_Operaciones_Fli,mdac

	WHERE fecha_operacion = @dfecha	


		
 INSERT INTO #TMP

 SELECT monumoper

   ,    morutcart

   ,    'ST'

   ,    morutcli

   ,    ' '

   ,    SUM(movalven)

   ,    SUBSTRING(MIN(mohora),1,8)

   ,    SUBSTRING(MIN(mousuario),1,12)

   ,    ' '

   ,    1

   ,    1

   ,    mostatreg 

   ,    0

   ,    motipoper

   ,    mostatreg 

   ,    mocodcli

,    1

FROM   MDMOPM     

   ,    MDAC

 WHERE  mofecinip  = acfecproc

 AND    SorteoLCHR = 'S'

 GROUP BY morutcart , monumoper , motipoper , morutcli , mocodcli , mostatreg



 UPDATE #TMP

 SET    nomcli = left(clnombre,40)

 FROM   VIEW_CLIENTE

 WHERE  CONVERT(CHAR(9),clrut)=rutcli

 AND    clcodigo = codcli
 
 UPDATE #TMP

 SET nomoper = left(nombre,30)

 FROM VIEW_USUARIO

 WHERE operador=usuario
 	
 UPDATE  #TMP SET tiporig = tipoper

 UPDATE  #TMP SET tipoper = 'A' +tipoper WHERE estaoper = 'A'

 IF @ccodigo='N'

  SELECT numoper,tipoper,rutcartera,nomcli,totoper,horat,nomoper,papeleta,contrato,estaoper,moneda,rutcli,correla, codcli FROM #TMP ORDER BY numoper

 IF @ccodigo='T'

  SELECT numoper,tipoper,rutcartera,nomcli,totoper,horat,nomoper,papeleta,contrato,estaoper,moneda,rutcli,correla, codcli FROM #TMP ORDER BY tiporig,numoper

 IF @ccodigo='C'

  SELECT numoper,tipoper,rutcartera,nomcli,totoper,horat,nomoper,papeleta,contrato,estaoper,moneda,rutcli,correla, codcli FROM #TMP ORDER BY nomcli,numoper
  
 SET NOCOUNT OFF
 

END





GO
