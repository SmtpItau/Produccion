USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_CARTERA_OPCIONES]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CARGA_CARTERA_OPCIONES]    
As    
BEGIN    

--*** MIGRACION MUREX - SE DESHABILITA CARGA DE CARTERA DE OPCIONES - INI ***
   --PRINT 'SP_CARGA_CARTERA_OPCIONES - deshabilitado por MIGRACION MUREX'
   RETURN 0    

--*** MIGRACION MUREX - SE DESHABILITA CARGA DE CARTERA DE OPCIONES - FIN ***
------------
    
   SET NOCOUNT ON    
    
   DECLARE @FechaAnt    DATETIME    
    
   SELECT @FechaAnt = acfecante    
     FROM bacFwdsuda.dbo.MFAC    
	          
  delete dbo.OPTcaEncContrato  
     IF @@ERROR <> 0    
      BEGIN    
         PRINT 'Al borrar encabezado de Cartera Opciones.'    
         RETURN 1    
      END    
  
  insert into dbo.OPTcaEncContrato   
  SELECT *     
        FROM lnkopc.cbmdbopc.dbo.caenccontrato Enc  
          left join lnkopc.cbmdbopc.dbo.OpcionEstructura Estruc on Enc.CaCodEstructura = OpcEstCod  
       WHERE Estruc.OpcContabExterna = 'S'  and Enc.CaEstado <> 'C'   
    
      IF @@ERROR <> 0    
      BEGIN    
         PRINT 'Al importar encabezado de Cartera Opciones.'    
         RETURN 1    
      END    
  
     delete dbo.OPTcaDetContrato  
      IF @@ERROR <> 0    
      BEGIN    
         PRINT 'Al Borrar detalle de Cartera Opciones.'    
         RETURN 1    
      END    
  
   insert into  dbo.OPTcaDetContrato  
      SELECT *              
        FROM lnkopc.cbmdbopc.dbo.caDetContrato     
       WHERE CaNumContrato in (SELECT canumcontrato FROM OPTcaEncContrato )     
    
       IF @@ERROR <> 0    
      BEGIN    
         PRINT 'Al importar detalle de Cartera Opciones.'    
         RETURN 1    
      END    
       
    
     delete dbo.OPTcaResDetContrato    
    
      IF @@ERROR <> 0    
      BEGIN    
         PRINT 'Al eliminar detalle de ayer de Cartera Opciones Local.'    
         RETURN 1    
      END    
       
  insert into dbo.OPTcaResDetContrato  
        SELECT *    
        FROM lnkopc.cbmdbopc.dbo.caResdetcontrato     
       WHERE CaDetFechaRespaldo  = @FechaAnt     
         AND canumcontrato      IN ( SELECT canumcontrato FROM OPTcaEncContrato )    
  
      IF @@ERROR <> 0    
      BEGIN    
         PRINT 'Al importar detalle de ayer de Cartera Opciones.'    
         RETURN 1    
      END    
   
  
      delete dbo.OPTcaResEncContrato  
  
      IF @@ERROR <> 0  
      BEGIN  
         PRINT 'Al borrar detalle de ayer de Cartera Opciones Local.'  
         RETURN 1  
      END  
  
  
   -- Importacion Opciones: Detalle de cartera de ayer  
      insert into dbo.OPTcaResEncContrato  
      SELECT *   
          FROM lnkopc.cbmdbopc.dbo.caResEnccontrato   
       WHERE CaEncFechaRespaldo  = @FechaAnt   
         AND canumcontrato      IN ( SELECT canumcontrato FROM OPTcaEncContrato )  
  
      IF @@ERROR <> 0  
      BEGIN  
         PRINT 'Al importar detalle de ayer de Cartera Opciones.'  
         RETURN 1  
      END  
  
  
   -- Importacion Opciones: Movimientos del dia    
      delete dbo.OPTmoEncContrato    
    
      IF @@ERROR <> 0    
      BEGIN    
         PRINT 'Al borrar encabezado de Movimientos del dia Opciones Local.'    
         RETURN 1    
      END    
   
    
      insert into dbo.OPTmoEncContrato   
      SELECT *    
        FROM lnkopc.cbmdbopc.dbo.MoEncContrato Enc  
          left join lnkopc.cbmdbopc.dbo.OpcionEstructura Estruc on Enc.MoCodEstructura = Estruc.OpcEstCod  
       WHERE Estruc.OpcContabExterna = 'S'  and Enc.MoEstado <> 'C'   
    
      IF @@ERROR <> 0    
      BEGIN    
         PRINT 'Al importar encabezado de Movimientos del dia de Opciones.'    
         RETURN 1    
      END    
  
    
      delete dbo.OPTmoDetContrato    
    
      IF @@ERROR <> 0    
      BEGIN    
         PRINT 'Al Borrar encabezado de Movimientos del dia Opciones Local.'    
         RETURN 1    
      END    
  
    
     insert into dbo.OPTmoDetContrato  
     SELECT *     
     FROM lnkopc.cbmdbopc.dbo.MoDetContrato    
    
      IF @@ERROR <> 0    
      BEGIN    
         PRINT 'Al importar encabezado de Movimientos del dia de Opciones.'    
         RETURN 1    
      END    
  
    
      delete dbo.OPTCaCaja    
    
      IF @@ERROR <> 0    
      BEGIN    
         PRINT 'Al Borrar caja. (1) '    
         RETURN 1    
      END    
  
    
      insert into dbo.OPTCaCaja     
      SELECT *    
        FROM lnkopc.cbmdbopc.dbo.CaCaja    
    
      IF @@ERROR <> 0    
      BEGIN    
  PRINT 'Al importar Caja. (2) '    
         RETURN 1    
      END    
  
    
END 
GO
