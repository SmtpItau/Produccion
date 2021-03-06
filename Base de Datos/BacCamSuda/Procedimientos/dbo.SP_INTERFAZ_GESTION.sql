USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_GESTION]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_GESTION] ( @FechaInicio CHAR(8)
                                      ,@FechaFin    CHAR(8)
                                     )
 
AS
BEGIN
   SET NOCOUNT ON
   -- Tabla de Paso INTERFAZ_GESTION_PUNTA
   CREATE TABLE #INTERFAZ_GESTION_TOTAL
          (
           CodInsumo        CHAR(09)
          ,Filler1          CHAR(12)
          ,CantOper         NUMERIC(12)
          ,MonTotal         NUMERIC(15)
          ,CodProduc        CHAR(06)
          ,CenCosto         NUMERIC(06)
          ,Filler2          CHAR(03)
          ,Ano              CHAR(04)
          ,Mes              CHAR(02)
          ,CostoSer         CHAR(06)
          ,Filler3          CHAR(06)
          )
   -- Tabla de Paso INTERFAZ_GESTION_PUNTA
   CREATE TABLE #INTERFAZ_GESTION_FINAL
          (
           CodInsumo        CHAR(09)
          ,Filler1          CHAR(12)
          ,CantOper         NUMERIC(12)
          ,MonTotal         NUMERIC(15)
          ,CodProduc        CHAR(06)
          ,CenCosto         NUMERIC(06)
          ,Filler2          CHAR(03)
          ,Ano              CHAR(04)
          ,Mes              CHAR(02)
          ,CostoSer         CHAR(06)
          ,Filler3          CHAR(06)
          )
   INSERT INTO #INTERFAZ_GESTION_TOTAL
        SELECT  'CodInsumo' = '088888001'
               ,'Filler1'   = '000000000000'
               ,'CantOper'  = 1
               ,'MonTotal'  = momonpe
               ,'CodProduc' = '088888'
               ,'CenCosto'  = CASE WHEN clcosto = 0 THEN 7110 ELSE clcosto END
               ,'Filler2'   = '000'
               ,'Ano'       = ' '
               ,'Mes'       = ' '
               ,'CostoSer'  = '007110'
               ,'Filler3'   = '000000'
          FROM  memoh 
               ,view_cliente
      
         WHERE (motipmer = 'PTAS' OR motipmer = 'EMPR' OR motipmer = 'ARRI' ) AND
                mofech   >= @FechaInicio AND
                mofech   <= @FechaFin    AND
               (morutcli = clrut AND mocodcli = clcodigo) AND
               (moestatus <> 'A' AND moestatus <> 'P')
   INSERT INTO #INTERFAZ_GESTION_TOTAL
        SELECT  'CodInsumo' = '088888001'
               ,'Filler1'   = '000000000000'
               ,'CantOper'  = 1
               ,'MonTotal'  = (momonmo*motctra)
               ,'CodProduc' = '088888'
               ,'CenCosto'  = CASE WHEN clcosto = 0 THEN 7110 ELSE clcosto END
               ,'Filler2'   = '000'
               ,'Ano'       = ' '
               ,'Mes'       = ' '
               ,'CostoSer'  = '007110'
               ,'Filler3'   = '000000'
          FROM  memoh 
               ,view_cliente
      
         WHERE (motipmer = 'CANJ'        AND 
                motipope = 'C')          AND
                mofech   >= @FechaInicio AND
                mofech   <= @FechaFin    AND
               (morutcli = clrut AND mocodcli = clcodigo) AND
               (moestatus <> 'A' AND moestatus <> 'P')
     
   INSERT INTO #INTERFAZ_GESTION_TOTAL
        SELECT  'CodInsumo' = '088888001'
               ,'Filler1'   = '000000000000'
               ,'CantOper'  = 1
               ,'MonTotal'  = (momonmo*moticam)
               ,'CodProduc' = '088888'
               ,'CenCosto'  = CASE WHEN clcosto = 0 THEN 7110 ELSE clcosto END
               ,'Filler2'   = '000'
               ,'Ano'       = ' '
               ,'Mes'       = ' '
               ,'CostoSer'  = '007110'
               ,'Filler3'   = '000000'
          FROM  memoh 
               ,view_cliente
      
         WHERE (motipmer = 'CANJ'        AND 
                motipope = 'V' )         AND
                mofech   >= @FechaInicio AND
                mofech   <= @FechaFin    AND
               (morutcli = clrut         AND 
                mocodcli = clcodigo)     AND
               (moestatus <> 'A' AND moestatus <> 'P')
/***
    INSERT INTO #INTERFAZ_GESTION_FINAL
        SELECT  CodInsumo   
               ,Filler1       
               ,SUM(CantOper)    
               ,SUM(MonTotal)    
               ,CodProduc
               ,CenCosto  
               ,Filler2  
               ,Ano  
               ,Mes
               ,CostoSer  
               ,Filler3  
          FROM  #INTERFAZ_GESTION_TOTAL
      GROUP BY  CenCosto
               ,CodInsumo   
               ,Filler1       
               ,CodProduc
               ,Filler2  
               ,Ano  
               ,Mes
               ,CostoSer  
               ,Filler3  
***/
    INSERT INTO #INTERFAZ_GESTION_FINAL
        SELECT  CodInsumo   
               ,Filler1       
               ,CantOper    
               ,MonTotal
               ,CodProduc
               ,CenCosto  
               ,Filler2  
               ,Ano  
               ,Mes
               ,CostoSer  
               ,Filler3  
          FROM  #INTERFAZ_GESTION_TOTAL
   UPDATE #INTERFAZ_GESTION_FINAL 
      SET Ano = SUBSTRING(@FechaFin,1,4)
         ,Mes = SUBSTRING(@FechaFin,5,2)
/***   SELECT CodInsumo 
         ,Filler1 
         ,RIGHT('000000000000'+CONVERT(VARCHAR(12),CantOper),12)
         ,RIGHT('000000000000000'+CONVERT(VARCHAR(15),MonTotal),15)+'00'    
         ,CodProduc 
         ,RIGHT('000000'+CONVERT(VARCHAR(06),CenCosto),6) 
         ,Filler2 
         ,Ano  
         ,Mes 
         ,CostoSer 
         ,Filler3 
    FROM #INTERFAZ_GESTION_FINAL
***/
   SELECT CodInsumo+Filler1+RIGHT('000000000000'+CONVERT(VARCHAR(12),CantOper),12)+RIGHT('000000000000000'+CONVERT(VARCHAR(15),MonTotal),15)+'00'+CodProduc+RIGHT('000000'+CONVERT(VARCHAR(06),CenCosto),6)+Filler2+Ano+Mes+CostoSer+Filler3 
    FROM #INTERFAZ_GESTION_FINAL
   ORDER BY CENCOSTO
   DROP TABLE #INTERFAZ_GESTION_FINAL
   DROP TABLE #INTERFAZ_GESTION_TOTAL
   SET NOCOUNT OFF
END
--    sp_interfaz_gestion '20010830','20010830'



GO
