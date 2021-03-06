USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[CALCULO_LINEAS_UNIFICADO2]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CALCULO_LINEAS_UNIFICADO2]      
 ( @dFechaProceso DATETIME )      
AS      
BEGIN      
      
 DECLARE @iX  NUMERIC(5)      
 , @nContador NUMERIC(5)      
 , @nRut  NUMERIC(9)      
 , @iCod  NUMERIC(3)         
       
 DECLARE @sNombre VARCHAR(100)        
      
        DECLARE @HORAI  VARCHAR(08)      
 ,       @HORAF  VARCHAR(08)      
      
       
 SET @HORAI = CONVERT(varchar(8),GETDATE(),114)       
    
  
/* Esto lo hace el inicio de día de Spot  
   No sirve porque la carga de Operaciones   
   de entrega fisica e imputa líneas   
   ensuciandolas  
   Solo para Spot por no pasar el código  
   de cliente  
 */  
    
   UPDATE  BacLineas.dbo.LINEA_SISTEMA     
   SET    TotalOcupado    = 0    
   ,    TotalExceso     = 0    
   ,    TotalDisponible = TotalAsignado    
   WHERE   id_sistema      = 'BCC'    
    
   UPDATE  BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO    
   SET    TotalOcupado    = 0    
   ,    TotalExceso     = 0    
   ,    TotalDisponible = TotalAsignado    
   WHERE   id_sistema      = 'BCC'    
    
   DELETE FROM BacLineas.dbo.LINEA_TRANSACCION     
         WHERE Id_Sistema      = 'BCC'    
    
   DELETE FROM BacLineas.dbo.LINEA_TRANSACCION_DETALLE    
         WHERE Id_Sistema  = 'BCC'    
        
      
 CREATE TABLE #clientes      
 (  RUT   NUMERIC(9)      
 ,   CODIGO  NUMERIC(5)      
 , NOMBRE  CHAR(100)       
 , iOtro  INTEGER NULL DEFAULT 0 )        
      
        TRUNCATE TABLE #clientes      
      
-- PRINT '--------------------------------------------------------------------------'      
-- PRINT 'INCIO PROCESO DE RECALCULO DE SWAP       '      
-- PRINT '--------------------------------------------------------------------------'      
      
 INSERT INTO #clientes --> (rut,codigo,nombre)      
 EXECUTE bacswapsuda.dbo.SP_LEER_CLIENTES_LINEAS        
      
 -- PROD-13828 No se puede repetir el Rut   
 select distinct Rut, Codigo = Codigo, Nombre = 'NO ES NECESARIO'    
 into #CliSwap from #Clientes     
 -- PROD-13828 No se puede repetir el Rut  
  
 SELECT *,'nReg'= IDENTITY(NUMERIC(10))       
   INTO #cli1       
   FROM #CliSwap -- PROD-13828 No se puede repetir el Rut --#clientes           
      
      
    SET @iX        = 0           
      
    SET @nContador = (SELECT MAX(Nreg) FROM #cli1)       
      
  WHILE @iX<@nContador  -- PROD-13828  
  BEGIN      
             SET @iX                = @iX + 1        
      
  SELECT  @nRut   = RUT      
  , @iCod  = codigo      
  , @sNombre = nombre      
          FROM #cli1      
         WHERE Nreg               = @iX          
      
--  PRINT '--------------------------------------------------------------------------'      
--  PRINT 'Procesando Cliente de SWAP ' + @sNombre + ' RUT ' + CONVERT(CHAR(12),@nRut) + ' COD ' + CONVERT(CHAR(3),@iCod)        
--  PRINT '--------------------------------------------------------------------------'      
  EXECUTE bacswapsuda.dbo.sp_recalculo_lineas_swap_otro @nRut, @iCod      
 END      
      
 DROP TABLE  #cli1      
      
-- PRINT '--------------------------------------------------------------------------'      
-- PRINT 'PROCESO DE RECALCULO DE SWAP FINALIZADO      '      
-- PRINT '--------------------------------------------------------------------------'      
      
      
-- PRINT '--------------------------------------------------------------------------'      
-- PRINT 'INCIO PROCESO DE RECALCULO DE FORWARD       '      
-- PRINT '--------------------------------------------------------------------------'      
      
 TRUNCATE TABLE #clientes      
 INSERT INTO #clientes      
 EXECUTE bacfwdsuda.dbo.SP_LEER_CLIENTES_LINEAS_BFW       
      
 -- PROD-13828 No se puede repetir el Rut   
 select distinct Rut, Codigo = Codigo, Nombre = 'NO ES NECESARIO'    
 into #CliFwd from #Clientes    
 -- PROD-13828 No se puede repetir el Rut     
  
 SELECT *,'nReg'= IDENTITY(NUMERIC(10))       
   INTO #cli2       
   FROM #CliFwd  -- PROD-13828 No se puede repetir el Rut --#clientes           
      
      
    SET @iX        = 0           
      
    SET @nContador = (SELECT MAX(Nreg) FROM #cli2)       
      
  WHILE @iX<@nContador         -- PROD-13828  
  BEGIN      
             SET @iX                = @iX + 1        
      
  SELECT  @nRut   = RUT      
  , @iCod  = codigo      
  , @sNombre = nombre      
          FROM #cli2      
         WHERE Nreg               = @iX          
      
--  PRINT '--------------------------------------------------------------------------'      
--  PRINT 'Procesando Cliente de FORWARD ' + @sNombre + ' RUT ' + CONVERT(CHAR(12),@nRut) + ' COD ' + CONVERT(CHAR(3),@iCod)        
--  PRINT '--------------------------------------------------------------------------'      
  EXECUTE bacfwdsuda.dbo.SP_NUEVO_RECALCULO_LINEAS_otro 'BFW', @nRut, @iCod      
 END      
      
 DROP TABLE  #cli2      
-- PRINT '--------------------------------------------------------------------------'      
-- PRINT 'PROCESO DE RECALCULO DE FORWARD FINALIZADO      '      
-- PRINT '--------------------------------------------------------------------------'      
      
       
-- PRINT '--------------------------------------------------------------------------'      
-- PRINT 'INCIO PROCESO DE RECALCULO DE SPOT       '      
-- PRINT '--------------------------------------------------------------------------'      
      
 -- PROD-13828 Limpiar las lineas retenidas ya liberadas  
 DELETE baclineas..lineas_retenidas where estado_liberacion = 'S'   
     
 TRUNCATE TABLE #clientes      
 INSERT INTO #clientes(rut,codigo,nombre)      
 EXECUTE baccamsuda.dbo.sp_leer_clientes_lineas         
      
 -- PROD-13828 No se puede repetir el Rut   
 select distinct Rut, Codigo = 1, Nombre = 'NO ES NECESARIO'    
 into #CliSpot from #Clientes    
 -- PROD-13828 No se puede repetir el Rut     
      
 SELECT *,'nReg'= IDENTITY(NUMERIC(10))       
   INTO #cli3       
   FROM #CliSpot -- PROD-13828 No se puede repetir el Rut --#clientes           
      
      
    SET @iX        = 0           
      
    SET @nContador = (SELECT MAX(Nreg) FROM #cli3)       
      
  WHILE @iX<@nContador       -- PROD-13828  
  BEGIN      
             SET @iX                = @iX + 1        
      
  SELECT  @nRut   = RUT      
  , @iCod  = codigo      
  , @sNombre = nombre      
          FROM #cli3      
         WHERE Nreg        = @iX          
      
--  PRINT '--------------------------------------------------------------------------'      
--  PRINT 'Procesando Cliente de SPOT  ' + @sNombre + ' RUT ' + CONVERT(CHAR(12),@nRut) + ' COD ' + CONVERT(CHAR(3),@iCod)        
--  PRINT '--------------------------------------------------------------------------'      
  EXECUTE baccamsuda.dbo.SP_RECALCALCULO_LINEAS_SPOT_otro @nrut      
 END      
      
-- PRINT '--------------------------------------------------------------------------'      
-- PRINT 'PROCESO DE RECALCULO DE SPOT FINALIZADO      '      
-- PRINT '--------------------------------------------------------------------------'      
      
 DROP TABLE  #cli3      
      
      
-- PRINT '--------------------------------------------------------------------------'      
-- PRINT 'PROCESO DE RECALCULO DE RENTA FIJA INICIALIZADO     '      
-- PRINT '--------------------------------------------------------------------------'      
      
      
 EXECUTE bactradersuda.dbo.SP_LINEAS_ACTUALIZARMONTOS_otro @dFechaProceso ,'BTR'      
      
 EXECUTE baclineas.dbo.SP_CARGA_LINEAS_RETENIDAS_otro @dFechaProceso       
      
-- PRINT '--------------------------------------------------------------------------'      
-- PRINT 'PROCESO DE RECALCULO DE RENTA FIJA FINALIZADO     '      
-- PRINT '--------------------------------------------------------------------------'      
      
-- SET @HORAF = CONVERT(varchar(8),GETDATE(),114)       
      
-- SELECT 'HORA INICIO => ' + @HORAI + '  HORA TERMINO => ' + @HORAF      
      
   -- PROD-13898  
   EXECUTE BacLineas.dbo.SP_RECALCULA_GENERAL  
   EXECUTE BACLINEAS..SP_LINEAS_ACTUALIZA    
  
  
  
END    
-- DBMS: no se requiere permisos adicionales
GO
