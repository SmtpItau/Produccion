USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[ANX_CAPITULO09]    Script Date: 16-05-2022 10:19:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ANX_CAPITULO09](@CFECHA DATETIME,@TIPO_SALIDA INT=0)  
AS 
BEGIN 


   SET NOCOUNT ON  
  
  
   DECLARE @NTOT1R      NUMERIC(21,4) --FLOAT  
   DECLARE @NTOT2E      NUMERIC(21,4) --FLOAT  
   DECLARE @NTOT3R      NUMERIC(21,4) --FLOAT  
   DECLARE @NTOT4E      NUMERIC(21,4) --FLOAT  
   DECLARE @NCANTOP     NUMERIC(6,0)  
   DECLARE @NTOTSWAP    NUMERIC(6,0)  
   DECLARE @NTOTOPC     NUMERIC(6,0)  
   DECLARE @CFECPROC    CHAR(10)  
   DECLARE @CCODBCCH    NUMERIC(3,0)  
   DECLARE @NCANTOPOPC  NUMERIC(6,0)  -- 21 OCT. 2009   
   DECLARE @NCANTOPSWAP NUMERIC(6,0)  -- 21 OCT. 2009   
  
   DECLARE @COMPRA_AMORTIZA  FLOAT,  
           @COMPRA_INTERES   FLOAT,   
           @VENTA_AMORTIZA   FLOAT,  
           @VENTA_INTERES    FLOAT,  
           @COMPRA_MONEDA    FLOAT,  
           @VENTA_MONEDA     FLOAT,  
           @VENTA_VALOR_TASA FLOAT  
  
  DECLARE @TOTSWAPRECIBE     FLOAT  
  DECLARE @TOTSWAPPAGA       FLOAT  
  DECLARE @TOTOPTRECIBE      FLOAT  
  DECLARE @TOTOPTPAGA        FLOAT  
  
  DECLARE @FLOATCERO         FLOAT  
  DECLARE @DOOBS      FLOAT   
  SELECT  @FLOATCERO = 0.0  
  SELECT  @DOOBS = 1.0  
  
  DECLARE @SEPARADOR		VARCHAR(1)

IF (@TIPO_SALIDA = 0)   
	 SET @SEPARADOR = ''  
ELSE  
	 SET @SEPARADOR = ';'  

  
  CREATE TABLE #SALIDA_INTERFAZ (
  	COD_INTERFAZ			VARCHAR(15),
  	TIPO_REG				VARCHAR(1),
  	REG_SALIDA				VARCHAR(300))

  
  SELECT @DOOBS = VMVALOR    
  FROM BACPARAMSUDA..VALOR_MONEDA      
  WHERE VMFECHA =@CFECHA    
  AND   VMCODIGO =994  
  
  
    SELECT VMFECHA, VMCODIGO, VMVALOR  
    INTO #VALOR_MONEDA  
    FROM BACPARAMSUDA..VALOR_MONEDA  
    WHERE VMFECHA    = @CFECHA  
  
    INSERT INTO #VALOR_MONEDA  
    SELECT @CFECHA, 999, 1.0  
  
    INSERT INTO #VALOR_MONEDA  
    SELECT @CFECHA, 13, @DOOBS  
  

  
   SELECT @NCANTOPOPC = COUNT(*)  
   FROM   CBMDBOPC.DBO.CARESENCCONTRATO A             
        ,  BACFWDSUDA.DBO.VIEW_CLIENTE D     
   WHERE  (A.CARUTCLIENTE        = D.CLRUT AND A.CACODIGO = D.CLCODIGO )   
		AND  A.CATIPOTRANSACCION <> 'ANULA'  
		AND  A.CAESTADO <> 'C'                           -- 21 OCT. 2009        
 		AND	 A.CAENCFECHARESPALDO = @CFECHA
	  
  
  
   SELECT @CFECPROC = CONVERT(CHAR(8), ACFECPROC, 112), @CCODBCCH = ACCODBCCH  
   FROM    BACFWDSUDA.DBO.MFAC  
  
 

  

SELECT * INTO  #CARTERA_OPC 
FROM (
SELECT 'FECINI'  = CONVERT(CHAR(8), B.CAFECHAINICIOOPC,112)   ,  
                'FECFIN'  = CONVERT(CHAR(8), B.CAFECHAPAGOEJER,112) ,  
                'CACVOPC' = B.CACVOPC,   
                'MTOMON1' = B.CAMONTOMON1                       ,  
                'MTOMON2' = B.CAMONTOMON2                       ,  
                'RUTCLIENTE'  = ISNULL( CASE WHEN D.CLPAIS = 6 THEN A.CARUTCLIENTE ELSE D.CLRUTCLIEXTERNO END , 0 ) ,  
                'DIGCLIENTE'  = ISNULL( CASE WHEN D.CLPAIS = 6 THEN D.CLDV         ELSE D.CLDVCLIEXTERNO  END , 0 ) ,  
                'NOMCLIENTE'  = D.CLNOMBRE                      ,  
                'NUMOPE'      = RTRIM(CONVERT(CHAR(5),A.CANUMCONTRATO)) + RTRIM(CONVERT(CHAR(5),B.CANUMESTRUCTURA)),   
                'PLAZO'   = DATEDIFF(DD,B.CAFECHAINICIOOPC, B.CAFECHAPAGOEJER) ,  
                'TIPMODA'     = B.CAMODALIDAD ,   
                'CODMDAREC'   = CASE WHEN (B.CACVOPC = 'C' AND  B.CACALLPUT = 'CALL') OR (B.CACVOPC = 'V' AND  B.CACALLPUT = 'PUT')  
                                   THEN B.CACODMON1  
                                   ELSE B.CACODMON2  
                              END                             ,  
                'CODMDAENT'   = CASE WHEN (B.CACVOPC = 'C' AND  B.CACALLPUT = 'PUT') OR (B.CACVOPC = 'V' AND  B.CACALLPUT = 'CALL')  
                                   THEN B.CACODMON1  
                                   ELSE B.CACODMON2   
                              END                             ,  
                'MTORECIBE'   = CASE WHEN (B.CACVOPC = 'C' AND  B.CACALLPUT = 'CALL') OR (B.CACVOPC = 'V' AND  B.CACALLPUT = 'PUT')  
                                  THEN B.CAMONTOMON1  
                                  ELSE B.CAMONTOMON2  
                              END                             ,  
				'MTOENTREGA'  = CASE WHEN (B.CACVOPC = 'C' AND  B.CACALLPUT = 'PUT') OR (B.CACVOPC = 'V' AND  B.CACALLPUT = 'CALL')  
                                  THEN B.CAMONTOMON1  
                                  ELSE B.CAMONTOMON2   
                             END       ,  
                'CASTRIKE'  = B.CASTRIKE,    
                'PRECFUT'   = B.CASTRIKE,   
                'CODIGOBCCH'= @CCODBCCH ,  
                'CODINS'    = (CASE WHEN CACALLPUT = 'CALL' THEN '03' ELSE '04' END),        
                'SECTORECON'= D.CLACTIVIDA ,  
                'PRIMAOPC'       = ROUND(B.CAPRIMAINICIALDET,4)  ,  
                'NUMESTRUCTURA'  = B.CANUMESTRUCTURA ,  
                'DETALLEAVR'  = B.CAVRDET ,  
                'TOTALAVR'  = A.CAVR    ,  
                'MDAPRIMAOPC'    = A.CACODMONPAGPRIMA  
         FROM   CBMDBOPC.DBO.CARESENCCONTRATO A     
              , CBMDBOPC.DBO.CARESDETCONTRATO B  
              ,  BACFWDSUDA.DBO.MFAC C  
              ,  BACFWDSUDA.DBO.VIEW_CLIENTE D     
         WHERE  A.CANUMCONTRATO       =  B.CANUMCONTRATO   
           AND (A.CARUTCLIENTE        = D.CLRUT 
		   AND A.CACODIGO = D.CLCODIGO )   
           AND  A.CATIPOTRANSACCION <> 'ANULA'  
           AND  A.CAESTADO <> 'C'  
           AND  B.CAFECHAVCTO>@CFECHA
		   AND	CAENCFECHARESPALDO = @CFECHA
		   AND	CADETFECHARESPALDO = @CFECHA
		   AND  CaCodEstructura Not In (8, 13)
		   UNION
		   SELECT 'FECINI'  = CONVERT(CHAR(8), B.CAFECHAINICIOOPC,112)   ,  
                'FECFIN'  = CONVERT(CHAR(8), B.CAFECHAPAGOEJER,112) ,  
                'CACVOPC' = B.CACVOPC,   
                'MTOMON1' = B.CAMONTOMON1                       ,  
                'MTOMON2' = B.CAMONTOMON2                       ,  
                'RUTCLIENTE'  = ISNULL( CASE WHEN D.CLPAIS = 6 THEN A.CARUTCLIENTE ELSE D.CLRUTCLIEXTERNO END , 0 ) ,  
                'DIGCLIENTE'  = ISNULL( CASE WHEN D.CLPAIS = 6 THEN D.CLDV         ELSE D.CLDVCLIEXTERNO  END , 0 ) ,  
                'NOMCLIENTE'  = D.CLNOMBRE                      ,  
                'NUMOPE'      = RTRIM(CONVERT(CHAR(5),A.CANUMCONTRATO)) + RTRIM(CONVERT(CHAR(5),B.CANUMESTRUCTURA)),   
                'PLAZO'   = DATEDIFF(DD,B.CAFECHAINICIOOPC, B.CAFECHAPAGOEJER) ,  
                'TIPMODA'     = B.CAMODALIDAD ,   
                'CODMDAREC'   = CASE WHEN (B.CACVOPC = 'C' )
                                   THEN B.CACODMON1
                                   ELSE B.CACODMON2  
                              END                             ,  
                'CODMDAENT'   = CASE WHEN (B.CACVOPC = 'V')  
                                   THEN B.CACODMON1
                                   ELSE B.CACODMON2   
                              END                             ,  
                'MTORECIBE'   = CASE WHEN (B.CACVOPC = 'C' )
                                  THEN B.CAMONTOMON1  
                                  ELSE B.CAMONTOMON2  
                              END                             ,  
				'MTOENTREGA'  = CASE WHEN (B.CACVOPC = 'V')
                                  THEN B.CAMONTOMON1  
                                  ELSE B.CAMONTOMON2   
                             END       ,  
                'CASTRIKE'  = B.CASTRIKE,    
                'PRECFUT'   = B.CASTRIKE,   
                'CODIGOBCCH'= @CCODBCCH ,
                'CODINS'    = (CASE WHEN CACALLPUT = 'CALL' THEN '03' ELSE '04' END),        
                'SECTORECON'= D.CLACTIVIDA ,  
                'PRIMAOPC'       = ROUND(B.CAPRIMAINICIALDET,4)  ,  
                'NUMESTRUCTURA'  = B.CANUMESTRUCTURA ,  
                'DETALLEAVR'  = B.CAVRDET ,  
                'TOTALAVR'  = A.CAVR    ,  
                'MDAPRIMAOPC'    = A.CACODMONPAGPRIMA  
         FROM   CBMDBOPC.DBO.CARESENCCONTRATO A     
              , CBMDBOPC.DBO.CARESDETCONTRATO B  
              ,  BACFWDSUDA.DBO.MFAC C  
              ,  BACFWDSUDA.DBO.VIEW_CLIENTE D     
         WHERE  A.CANUMCONTRATO       =  B.CANUMCONTRATO   
           AND (A.CARUTCLIENTE        = D.CLRUT AND A.CACODIGO = D.CLCODIGO )   
           AND  A.CATIPOTRANSACCION <> 'ANULA'  
           AND  A.CAESTADO <> 'C'  
           AND  B.CAFECHAVCTO>@CFECHA
		   AND	CAENCFECHARESPALDO = @CFECHA
		   AND	CADETFECHARESPALDO = @CFECHA
		   AND  CaCodEstructura In (8, 13)
) CARTERA_OPC --MGM 2019-05-15
         SELECT  @TOTOPTRECIBE = 0.0  
         SELECT  @TOTOPTPAGA   = 0.0  
         SELECT  @TOTOPTRECIBE = ISNULL ( SUM ( MTORECIBE ), 0 ),    
                 @TOTOPTPAGA   = ISNULL ( SUM ( MTOENTREGA ), 0 )     
         FROM   #CARTERA_OPC  
  
  
          SELECT @NTOTOPC = COUNT(*)  
          FROM   #CARTERA_OPC  
          WHERE  NOT(MTORECIBE = 0 AND  MTOENTREGA =0)  
  
  
   IF @NTOTOPC > 0   
   BEGIN  
  
         SELECT 'CANTOPERA' = @NCANTOPOPC,-- 0,   
		 'TOTENT'          = @NTOT2E + @NTOT4E    ,  
          'TOTREC'          = @NTOT1R + @NTOT3R  ,  
          'FECHAPROC'       = @CFECHA                       ,  
           
                'RUTPROP'   = B.ACRUTPROP                     ,  
                'DIGPROP'   = B.ACDIGPROP                     ,  
                'FECHAINI'  = CONVERT(CHAR(8), A.FECINI,112)  ,  
                'FECHAFIN'  = CONVERT(CHAR(8), A.FECFIN,112)  ,  
                'CATIPOPER' = A.CACVOPC,   
                'CAMTOMON1' = A.MTOMON1                       ,  
                'CAMTOMON2' = A.MTOMON2                       ,  
                'RUTCLI'    = A.RUTCLIENTE ,  
                'DIGCLI'    = A.DIGCLIENTE ,  
                'NOMCLI'    = A.NOMCLIENTE     ,  
                'NUMOPER'   = CONVERT (NUMERIC(8),A.NUMOPE)    ,  
                'PLAZO'     = DATEDIFF(DD, A.FECINI, A.FECFIN) ,  
                'CATIPMODA' = A.TIPMODA   ,   
                 'CODMREC' = A.CODMDAREC     ,  
                'CODMENT'   = A.CODMDAENT     ,  
                'MTOREC'    = A.MTORECIBE     ,  
                'MTOENT'    = A.MTOENTREGA    ,  
                'CAPREMON1' = A.CASTRIKE      ,    
                'PRECIOFUT' = A.PRECFUT     ,   
                'CODBCCH'   = A.CODIGOBCCH    ,  
                'CODIGOINS' = A.CODINS        ,        
                'SECTORECONOMICO'= A.SECTORECON ,  
                'PRIMA'          = ROUND((C.VMVALOR * A.PRIMAOPC / @DOOBS),4) ,  
                'FLUJOS_SWAPCCS' = 0  
				  INTO   #TMP  
          FROM   #CARTERA_OPC       A  
           ,      BACFWDSUDA.DBO.MFAC               B  
           ,     #VALOR_MONEDA      C  
          WHERE NOT(A.MTORECIBE = 0 AND  A.MTOENTREGA =0)  
   AND  A.MDAPRIMAOPC  =C.VMCODIGO  
   AND  C.VMFECHA      = @CFECHA  
  
   END  
  
 /**************************************************OPCIONES*************************************************************/  
  
          UPDATE #TMP  
          SET CANTOPERA = @NCANTOP + @NTOTSWAP + @NTOTOPC   ,  
              TOTENT    = @NTOT2E + @NTOT4E + ROUND( @TOTSWAPPAGA, 4 )+ @TOTOPTPAGA  ,  
              TOTREC    = @NTOT1R + @NTOT3R + ROUND( @TOTSWAPRECIBE, 4 ) + @TOTOPTRECIBE   
     
-- INI COMDER
IF EXISTS(SELECT 1 FROM BDBOMESA.DBO.COMDER_RELACIONMARCACOMDER A, #TMP B WHERE A.NRENUMOPER = B.NUMOPER AND A.IRENOVACION = 1 AND A.VREESTADO = 'V' AND CONVERT(CHAR(8),A.DREFECHA,112)= @CFECHA )
BEGIN
	UPDATE #TMP
	SET	NOMCLI	= B.CLNOMBRE
		,DIGCLI	= B.CLDV
		,RUTCLI	= B.CLRUT
		,SECTORECONOMICO = B.CLACTIVIDA
   FROM		BDBOMESA.DBO.COMDER_RELACIONMARCACOMDER A,  BACFWDSUDA.DBO.VIEW_CLIENTE B  
   WHERE	A.NRENUMOPER = #TMP.NUMOPER
   AND		#TMP.RUTCLI = (SELECT ACRUTCOMDER FROM  BACFWDSUDA.DBO.MFAC)  
   AND		(A.NRERUTCLIENTE = B.CLRUT AND A.NRECODCLIENTE=B.CLCODIGO )
   AND		A.IRENOVACION = 1 
   AND		A.VREESTADO = 'V' 
   AND		CONVERT(CHAR(8),A.DREFECHA,112)= @CFECHA
      
END
-- FIN COMDER

DECLARE @TOTREC	NUMERIC(19,4)
DECLARE @TOTENT	NUMERIC(19,4)
SET @TOTREC= CONVERT(NUMERIC(19,4),((@NTOT1R + @NTOT3R + ROUND( @TOTSWAPRECIBE, 4 ) + @TOTOPTRECIBE)))
SET @TOTENT= CONVERT(NUMERIC(19,4), (@NTOT2E + @NTOT4E + ROUND( @TOTSWAPPAGA, 4 )+ @TOTOPTPAGA))

   
IF (@TIPO_SALIDA = 0)   
	 SET @SEPARADOR = ''  
ELSE  
	 SET @SEPARADOR = ';'  


IF (@TIPO_SALIDA = 1)   
BEGIN
   IF (SELECT COUNT(*) FROM #TMP) > 0  
   BEGIN
      SELECT	FECHAPROC 
	  ,			RUTPROP
	  ,			DIGPROP
	  ,			FECHAINI
	  ,			FECHAFIN
	  ,			CATIPOPER
	  ,			CAMTOMON1
	  ,			CAMTOMON2
	  ,			RUTCLI
	  ,			DIGCLI
	  ,			NOMCLI
	  ,			NUMOPER
	  ,			PLAZO
	  ,			CATIPMODA
	  ,			CODMREC
	  ,			CODMENT
	  ,			MTOREC
	  ,			MTOENT
	  ,			CAPREMON1
	  ,			PRECIOFUT
	  ,			CODBCCH
	  ,			CODIGOINS
	  ,			SECTORECONOMICO
	  ,			PRIMA
	  ,			FLUJOS_SWAPCCS
	  FROM #TMP WHERE CAMTOMON1 <> 0 ORDER BY   FLUJOS_SWAPCCS, CODIGOINS, NUMOPER, FECHAFIN     
   END
END
ELSE
BEGIN
	INSERT INTO #SALIDA_INTERFAZ 
	SELECT 'CAPIX','2',
	  @SEPARADOR + RIGHT(REPLICATE('0',9) + RTRIM(RUTCLI),9)  
	+ @SEPARADOR + DIGCLI
	+ @SEPARADOR + LEFT(NOMCLI + SPACE(50),50) 
	+ @SEPARADOR + RIGHT(REPLICATE('0',12) + RTRIM(NUMOPER),12)  
	+ @SEPARADOR + FECHAINI
	+ @SEPARADOR + FECHAFIN
	+ @SEPARADOR + RIGHT(REPLICATE('0',5) + RTRIM(PLAZO),5)  
	+ @SEPARADOR + CATIPMODA
	+ @SEPARADOR + RIGHT(REPLICATE('0',4) + RTRIM(CODMREC),4)  
	+ @SEPARADOR + CASE WHEN MTOREC < 0 THEN '-' ELSE '0' END
	+ @SEPARADOR + RIGHT(REPLICATE('0',17)+REPLACE(CONVERT(NUMERIC(17,4),ABS(MTOREC)),'.',''),17)
	+ @SEPARADOR + RIGHT(REPLICATE('0',4) + RTRIM(CODMENT),4)  
	+ @SEPARADOR + CASE WHEN MTOENT < 0 THEN '-' ELSE '0' END
	+ @SEPARADOR + RIGHT(REPLICATE('0',17)+REPLACE(CONVERT(NUMERIC(17,4),ABS(MTOENT)),'.',''),17)
	+ @SEPARADOR + RIGHT(REPLICATE('0',9)+REPLACE(CONVERT(NUMERIC(12,4),CAPREMON1),'.',''),9)
	+ @SEPARADOR + CASE WHEN PRECIOFUT < 0 THEN '-' ELSE '0' END
	+ @SEPARADOR + RIGHT(REPLICATE('0',8)+REPLACE(CONVERT(NUMERIC(12,4),ABS(PRECIOFUT)),'.',''),8)
	+ @SEPARADOR + CODIGOINS
	+ @SEPARADOR + RIGHT(REPLICATE('0',3) + RTRIM(SECTORECONOMICO),3)  
	+ @SEPARADOR + CASE WHEN PRIMA < 0 THEN '-' ELSE '0' END
	+ @SEPARADOR + RIGHT(REPLICATE('0',13)+REPLACE(CONVERT(NUMERIC(12,4),ABS(PRIMA)),'.',''),13)
	FROM #TMP WHERE CAMTOMON1 <> 0 ORDER BY   FLUJOS_SWAPCCS, CODIGOINS, NUMOPER, FECHAFIN     


	SELECT REG_SALIDA FROM #SALIDA_INTERFAZ WHERE COD_INTERFAZ='CAPIX' ORDER BY TIPO_REG

END
  
DROP TABLE #SALIDA_INTERFAZ
DROP TABLE #VALOR_MONEDA
DROP TABLE #TMP
DROP TABLE #CARTERA_OPC
    
END 
GO
