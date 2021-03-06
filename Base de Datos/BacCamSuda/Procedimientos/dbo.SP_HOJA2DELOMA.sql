USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HOJA2DELOMA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_HOJA2DELOMA]  
 ( @Fecha CHAR(08) )  
AS   
BEGIN   
  
 SET NOCOUNT ON                                                                          
  
 DECLARE @dFechaProceso DATETIME  
  SET @dFechaProceso = CONVERT(DATETIME, @Fecha, 112)  
  
 DECLARE @nMontoMinimo NUMERIC(21,4)  
  SET @nMontoMinimo = 499999  
  
  
 DECLARE  @Cantidad INT   
  ,@Inicial INT   
  ,@opera  CHAR(1)  
  ,@tipope CHAR(1)  
  ,@codoma NUMERIC(5)  
  ,@tipcamp NUMERIC(20,4)    
  ,@nombreemi CHAR(40)       
  ,@mercado CHAR(4)        
  ,@comercio CHAR(06)       
  ,@concepto CHAR(03)       
  ,@rutcli NUMERIC(09)  
  ,@MtoGral NUMERIC(19,4)  
  ,@Monto  NUMERIC(19,4)  
  ,@op          INT   
  ,@conse         NUMERIC(5)  
  ,@cont          INT         
  ,@contfinan     INT         
  ,@contnofinan   INT         
  
 DECLARE  @TIPOPE10  CHAR(  1)      
  ,@CODIGO10  NUMERIC( 3)    
  ,@MONTO10  NUMERIC(20,4)  
  ,@TIPCAMP10  NUMERIC(20,4)  
  ,@NOMBREEMI10  CHAR(40)       
  ,@COMERCIO10  CHAR(06)      
  ,@CONCEPTO10  CHAR(03)      
  ,@TIPOPE40  CHAR(  1)      
  ,@CODIGO40      NUMERIC( 3)    
  ,@MONTO40       NUMERIC(20,4)  
  ,@TIPCAMP40     NUMERIC(20,4)  
  ,@NOMBREEMI40   CHAR(40)   
  ,@COMERCIO40     CHAR(06)  
  ,@CONCEPTO40     CHAR(03)  
  ,@FECHA_PROCESO  CHAR(10)  
  ,@HORA   CHAR(8)   
  
        IF EXISTS(SELECT COUNT(*) FROM dbo.finan)  
      DROP TABLE dbo.finan  
  
  
 CREATE TABLE  dbo.finan  
  (   
    TIPOPE40 CHAR(  1)      
   ,CODIGO40     NUMERIC( 3)    
   ,MONTO40      NUMERIC(20,4)  
   ,TIPCAMP40    NUMERIC(20,4)  
   ,NOMBREEMI40  CHAR(60)   
   ,COMERCIO40     CHAR(06)  
   ,CONCEPTO40     CHAR(03)  
   ,FECHA_PROCESO  CHAR(10)  
   ,HORA  CHAR(8)   
  )           
  
        IF EXISTS(SELECT COUNT(*) FROM dbo.nofinan)  
      DROP TABLE dbo.nofinan  
  
  
 CREATE TABLE  dbo.nofinan  
  (   
    TIPOPE10 CHAR(  1)      
   ,CODIGO10 NUMERIC( 3)    
   ,MONTO10 NUMERIC(20,4)  
   ,TIPCAMP10 NUMERIC(20,4)  
   ,NOMBREEMI10 CHAR(60)       
   ,COMERCIO10 CHAR(06)      
   ,CONCEPTO10 CHAR(03)      
  )   
  
        IF EXISTS(SELECT COUNT(*) FROM dbo.OmaHoja2)  
    DROP TABLE dbo.OmaHoja2  
  
  
 CREATE TABLE  dbo.OmaHoja2  
  (   
    TIPOPE10 CHAR(  1)      
   ,CODIGO10 NUMERIC( 3)    
   ,MONTO10 NUMERIC(20,4)  
   ,TIPCAMP10 NUMERIC(20,4)  
   ,NOMBREEMI10 CHAR(60)       
   ,COMERCIO10 CHAR(06)      
   ,CONCEPTO10 CHAR(03)      
   ,TIPOPE40 CHAR(  1)      
   ,CODIGO40     NUMERIC( 3)    
   ,MONTO40      NUMERIC(20,4)  
   ,TIPCAMP40    NUMERIC(20,4)  
   ,NOMBREEMI40  CHAR(40)   
   ,COMERCIO40     CHAR(06)  
   ,CONCEPTO40     CHAR(03)  
   ,FECHA_PROCESO  CHAR(10)  
   ,HORA  CHAR(8)   
   ,SERIE  INT  
  )           
  
 CREATE TABLE  #HOJA2  
  (  
           MOTIPOPE  CHAR(01)  
          ,MOCODOMA  NUMERIC(03)  
          ,MOMONMO  NUMERIC(19,4)  
   ,MOMONPES  NUMERIC(19,00)  
          ,MOTICAM  NUMERIC(19,4)  
          ,MONOMCLI  CHAR(35)  
          ,CODIGO_COMERCIO CHAR(06)  
          ,CODIGO_CONCEPTO CHAR(03)   
  )  
  
  
        UPDATE memo   
           SET codigo_comercio = comercio  
          FROM codigo_planilla_automatica,view_cliente  
         WHERE motipmer = 'EMPR'                     AND  
        codigo_comercio = ' '       AND  
              (morutcli=clrut AND mocodcli=clcodigo) AND   
               motipope+'CLP'+RTRIM(LTRIM(CONVERT(CHAR(2),cltipcli))) = condicion   --> vb+-04/02/2010  
  
 SELECT  'monto' = momonmo  
               ,morutcli   
               ,motipope   
        ,monumope  
 INTO  #memopaso1   
 FROM  memo   
 WHERE  moestatus <> 'A' AND moestatus <> 'P' AND mocodmon = 'USD' AND motipmer = 'EMPR' AND momonmo > 499999  
        --GROUP BY morutcli,motipope  
  
        SELECT @Cantidad = COUNT(*) FROM #memopaso1  
  
 SELECT @Inicial = 0  
 SELECT @op = 0  
 SELECT @monto = 0   
   
/*--------------------------------------------*/  
 DECLARE @montoT NUMERIC(19,4)  
 DECLARE @morutcli CHAR(9)  
 DECLARE @motipope CHAR(1)  
 DECLARE @monumope NUMERIC(7)   
  
 DECLARE MiCursor CURSOR FOR  
 SELECT monto,morutcli,motipope,monumope FROM #memopaso1  
 OPEN MiCursor  
 FETCH NEXT FROM MiCursor INTO @montoT,@morutcli,@motipope,@monumope  
  
 WHILE @@FETCH_STATUS = 0  
 BEGIN  
  
 IF @montoT > 499999  
  BEGIN  
    INSERT INTO #HOJA2  
   SELECT   motipope  
     ,codi_oma  
     ,momonmo  
     ,momonpe  
     ,moticam  
     ,monomcli  
     ,codigo_comercio  
     ,codigo_concepto    
   FROM memo,tbomadelsuda  
   WHERE   morutcli = @morutcli  AND   
    motipope = @motipope  AND  
                  motipmer = 'EMPR'     AND  
                 (mocodoma = codi_opera AND   
                 (codi_oma = 1      OR  
    codi_oma = 4      OR   
    codi_oma = 6      OR   
    codi_oma = 9))    AND   
    mocodmon = 'USD'  AND   
   (moestatus <> 'A'  AND moestatus <> 'P') AND  
                  monumope = @monumope  
  
  
--   ORDER BY monumope  
 END  
--SELECT * FROM TBOMADELSUDA ORDER BY CODI_OPERA  
     FETCH NEXT FROM MiCursor INTO @montoT,@morutcli,@motipope,@monumope  
  
 END  
 CLOSE MiCursor  
 DEALLOCATE MiCursor  
  
 -->  Lee e Inserta las operaciones directamente en la Tabla de Operaciones  
 INSERT INTO #HOJA2  
 SELECT 'motipope'   = TipoTransaccion  
  , 'codi_oma'   = CASE WHEN TipoTransaccion = 'C' THEN 1 ELSE 6 END  
  , 'momonmo'   = MtoDolares  
  , 'momonpe'   = MtoPesos  
  , 'moticam'   = TipoCambio  
  , 'monomcli'   = NombreCliente  
  , 'codigo_comercio' = CodigoOMA  
  , 'codigo_concepto' = ''  
 FROM BacCamSuda.dbo.TBL_OPERACIONES_OMA_EXTERNAS  
 WHERE Fecha    = @dFechaProceso  
 AND  Estado    = ''  
 AND  MtoDolares   > @nMontoMinimo  
 -->  Lee e Inserta las operaciones directamente en la Tabla de Operaciones  
  
 SELECT  'MOTIPOPE'=MOTIPOPE,  
  'MOCODOMA'=MOCODOMA,  
         'MOMONMO'=MOMONMO,  
  'MOMONPES'=MOMONPES,  
                'MOTICAM'=MOTICAM,  
                'MONOMCLI'=MONOMCLI,  
                'CODIGO_COMERCIO'=CODIGO_COMERCIO,  
                'CODIGO_CONCEPTO'=CODIGO_CONCEPTO   
  INTO #HOJA3   
 FROM #HOJA2   
 ORDER BY motipope,monomcli     
/***  
 SELECT  'MOTIPOPE'=MOTIPOPE,  
  'MOCODOMA'=MOCODOMA,  
         'MOMONMO'=SUM(MOMONMO)  ,  
  'MOMONPES'=SUM(MOMONPES),  
                'MOTICAM'=(SUM(momonpes)/SUM(momonmo))  ,--AVG(MOTICAM),  
                'MONOMCLI'=MONOMCLI,  
                'CODIGO_COMERCIO'=CODIGO_COMERCIO,  
                'CODIGO_CONCEPTO'=CODIGO_CONCEPTO   
  INTO #HOJA3   
 FROM #HOJA2   
 GROUP BY MOTIPOPE,MOCODOMA,MONOMCLI,CODIGO_COMERCIO,CODIGO_CONCEPTO  
 ORDER BY motipope,monomcli     
***/  
 DELETE FROM #HOJA2  
 INSERT INTO #HOJA2 SELECT * FROM #HOJA3  
  
-- 10 NO FINANCIERO 40 FINANCIERO     
      SELECT @cont = COUNT(*) FROM #HOJA2  
  
 WHILE @op < @cont BEGIN  
  
  SET ROWCOUNT @op  
  
  SELECT  @opera  = motipope  
   ,@codoma = mocodoma  
   ,@monto  = momonmo  
   ,@tipcamp = moticam  
   ,@nombreemi = monomcli  
          ,@comercio = codigo_comercio  
          ,@concepto = codigo_concepto    
  FROM #HOJA2  
  
  IF @CODOMA = 1 OR @CODOMA = 6 BEGIN  -- Comercio Invisible NO Financiero  
    
   IF EXISTS(SELECT * FROM nofinan WHERE TIPOPE10=' ') BEGIN --MONTO10=0)  
    UPDATE nofinan  
    SET  CODIGO10 = @codoma  
     ,MONTO10 = @monto  
     ,TIPCAMP10 = @tipcamp  
     ,TIPOPE10 = @opera  
     ,NOMBREEMI10 = @nombreemi    
     ,COMERCIO10 = @comercio   
     ,CONCEPTO10  = @concepto  
    WHERE TIPOPE10=' '   
   END         
   ELSE BEGIN  
    INSERT nofinan  ( TIPOPE10  
      ,CODIGO10  
      ,MONTO10  
      ,TIPCAMP10  
      ,NOMBREEMI10  
      ,COMERCIO10  
      ,CONCEPTO10)   
    VALUES(  @opera  
     ,@codoma  
     ,@monto  
     ,@tipcamp  
     ,@nombreemi  
     ,@comercio  
     ,@concepto)  
   END  
  
  END  
  
  IF @CODOMA=4 OR @CODOMA=9 BEGIN   -- Comercio Invisible Financiero  
  
   IF EXISTS(SELECT * FROM finan WHERE TIPOPE40=' ' ) BEGIN --MONTO10=0)  
  
    UPDATE finan  
    SET  CODIGO40 = @codoma  
     ,MONTO40 = @monto  
     ,TIPCAMP40 = @tipcamp  
     ,TIPOPE40 = @opera  
     ,NOMBREEMI40 = @nombreemi    
     ,COMERCIO40     = @comercio  
     ,CONCEPTO40 = @concepto  
    WHERE TIPOPE40=' ' -- MONTO10=0  
    
   END         
   ELSE BEGIN  
    INSERT finan  ( TIPOPE40  
      ,CODIGO40  
      ,MONTO40  
      ,TIPCAMP40  
      ,NOMBREEMI40  
      ,COMERCIO40  
      ,CONCEPTO40)   
    VALUES(  @opera  
     ,@codoma  
     ,@monto  
     ,@tipcamp  
     ,@nombreemi  
     ,@comercio  
     ,@concepto)  
     
   END  
  
  END  
  
  SELECT @OP = @OP + 1  
  SET ROWCOUNT 0  
  
 END  
  
 UPDATE finan  
 SET FECHA_PROCESO  = CONVERT( CHAR(10) , acfecpro , 103 ),  
  HORA  = CONVERT( CHAR(8) , GETDATE(), 108 )  
 FROM  meac  
        
        SELECT @contnofinan = COUNT(*) FROM nofinan  
        SELECT @contfinan   = COUNT(*) FROM finan  
 SELECT @op = 0  
  
-- SELECT * FROM nofinan  
--- SELECT * FROM finan  
   
 IF @contfinan > @contnofinan BEGIN  
-- TRASPASO DE FINAN  
  
  WHILE @op < @contfinan BEGIN  
  
   SET ROWCOUNT @op  
  
   SELECT   @TIPOPE40 = TIPOPE40   
    ,@CODIGO40     = CODIGO40  
    ,@MONTO40      = MONTO40  
    ,@TIPCAMP40    = TIPCAMP40  
    ,@NOMBREEMI40  = NOMBREEMI40  
    ,@COMERCIO40    = COMERCIO40  
    ,@CONCEPTO40    = CONCEPTO40  
    ,@FECHA_PROCESO = FECHA_PROCESO  
    ,@HORA  = HORA  
   FROM  finan  
   ORDER BY TIPOPE40  
  
   INSERT INTO OmaHoja2(TIPOPE10,CODIGO10,MONTO10,TIPCAMP10,NOMBREEMI10,COMERCIO10,CONCEPTO10,TIPOPE40,CODIGO40,MONTO40,TIPCAMP40,NOMBREEMI40,COMERCIO40,CONCEPTO40,FECHA_PROCESO,HORA,SERIE)  
   VALUES ('',0,0,0,'','','',@TIPOPE40,@CODIGO40,@MONTO40,@TIPCAMP40,@NOMBREEMI40,@COMERCIO40,@CONCEPTO40,@FECHA_PROCESO,@HORA,@op)  
  
   SELECT @OP = @OP + 1  
   SET ROWCOUNT 0  
  
  END  
  
-- TRASPASO DE NOFINAN  
  SELECT @op = 0  
  WHILE @op < @contnofinan BEGIN  
   SET ROWCOUNT @op  
  
   SELECT   @TIPOPE10 = TIPOPE10   
    ,@CODIGO10     = CODIGO10  
    ,@MONTO10      = MONTO10  
    ,@TIPCAMP10    = TIPCAMP10  
    ,@NOMBREEMI10  = NOMBREEMI10  
    ,@COMERCIO10    = COMERCIO10  
    ,@CONCEPTO10    = CONCEPTO10  
   FROM  nofinan  
   ORDER BY TIPOPE10  
  
   UPDATE OmaHoja2 SET TIPOPE10 = @TIPOPE10  
              ,CODIGO10 = @CODIGO10  
                                           ,MONTO10 = @MONTO10  
                                           ,TIPCAMP10 = @TIPCAMP10  
                                           ,NOMBREEMI10 = @NOMBREEMI10  
                                           ,COMERCIO10 = @COMERCIO10  
                                           ,CONCEPTO10 = @CONCEPTO10  
   WHERE SERIE = @op  
  
   SELECT @OP = @OP + 1  
   SET ROWCOUNT 0  
  
  END  
  
 END  
 ELSE BEGIN  
  
-- TRASPASO DE NOFINAN  
  SELECT @op = 0  
  WHILE @op < @contnofinan BEGIN  
   SET ROWCOUNT @op  
  
   SELECT   @TIPOPE10 = TIPOPE10   
    ,@CODIGO10     = CODIGO10  
    ,@MONTO10      = MONTO10  
    ,@TIPCAMP10    = TIPCAMP10  
    ,@NOMBREEMI10  = NOMBREEMI10  
    ,@COMERCIO10    = COMERCIO10  
    ,@CONCEPTO10    = CONCEPTO10  
   FROM  nofinan  
   ORDER BY TIPOPE10  
  
   INSERT INTO OmaHoja2(TIPOPE10,CODIGO10,MONTO10,TIPCAMP10,NOMBREEMI10,COMERCIO10,CONCEPTO10,TIPOPE40,CODIGO40,MONTO40,TIPCAMP40,NOMBREEMI40,COMERCIO40,CONCEPTO40,FECHA_PROCESO,HORA,SERIE)  
   VALUES (@TIPOPE10,@CODIGO10,@MONTO10,@TIPCAMP10,@NOMBREEMI10,@COMERCIO10,@CONCEPTO10,'',0,0,0,'','','','','',@op)  
  
   SELECT @OP = @OP + 1  
   SET ROWCOUNT 0  
  
  END  
  
-- TRASPASO DE FINAN  
  SELECT @op = 0  
  WHILE @op < @contfinan BEGIN  
   SET ROWCOUNT @op  
  
   SELECT  @TIPOPE40 = TIPOPE40   
    ,@CODIGO40     = CODIGO40  
    ,@MONTO40      = MONTO40  
    ,@TIPCAMP40    = TIPCAMP40  
    ,@NOMBREEMI40  = NOMBREEMI40  
    ,@COMERCIO40    = COMERCIO40  
    ,@CONCEPTO40    = CONCEPTO40  
    ,@FECHA_PROCESO = FECHA_PROCESO  
    ,@HORA  = HORA  
   FROM  finan  
   ORDER BY TIPOPE40  
     
   SELECT  @TIPOPE10 = TIPOPE10  
   FROM OmaHoja2   
   WHERE   SERIE = @op  
  
   IF @TIPOPE10 = @TIPOPE40  
    BEGIN  
     UPDATE OmaHoja2   
     SET  TIPOPE40   = @TIPOPE40  
      ,CODIGO40   = @CODIGO40  
      ,MONTO40   = @MONTO40  
      ,TIPCAMP40   = @TIPCAMP40  
      ,NOMBREEMI40   = @NOMBREEMI40  
      ,COMERCIO40   = @COMERCIO40  
      ,CONCEPTO40   = @CONCEPTO40  
      ,FECHA_PROCESO = @FECHA_PROCESO  
      ,HORA   = @HORA  
     WHERE   SERIE = @op  
    END  
   ELSE  
    BEGIN  
     INSERT INTO OmaHoja2(TIPOPE10,CODIGO10,MONTO10,TIPCAMP10,NOMBREEMI10,COMERCIO10,CONCEPTO10,TIPOPE40,CODIGO40,MONTO40,TIPCAMP40,NOMBREEMI40,COMERCIO40,CONCEPTO40,FECHA_PROCESO,HORA,SERIE)  
     VALUES ('',0,0,0,'','','',@TIPOPE40,@CODIGO40,@MONTO40,@TIPCAMP40,@NOMBREEMI40,@COMERCIO40,@CONCEPTO40,@FECHA_PROCESO,@HORA,@op)  
  
    END  
  
   SELECT @OP = @OP + 1  
   SET ROWCOUNT 0  
  
  END  
  
 END  
    
 DROP TABLE #HOJA2  
 DROP TABLE #memopaso1  
  
 UPDATE OmaHoja2  
 SET FECHA_PROCESO  = CONVERT( CHAR(10) , acfecpro , 103 ),  
  HORA  = CONVERT( CHAR(8) , GETDATE(), 108 )  
 FROM  meac  
  
 UPDATE OmaHoja2 SET TIPOPE10='Z' WHERE TIPOPE10=' '   
 UPDATE OmaHoja2 SET TIPOPE40='Z' WHERE TIPOPE40=' '   
 UPDATE OmaHoja2 SET TIPOPE10=TIPOPE40 WHERE TIPOPE10='z' AND TIPOPE40<>'z'  
  
  
 SELECT * FROM OmaHoja2 ORDER BY TIPOPE10,SERIE  
          
  SET NOCOUNT OFF  
  
END  
GO
