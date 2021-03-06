USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESPALDOFINDIAPAE]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RESPALDOFINDIAPAE]  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @dfecproc  DATETIME  
   DECLARE @dfecprox  DATETIME  
  
   SELECT @dfecproc   = acfecproc  
      ,   @dfecprox   = acfecprox  
   FROM   MDAC        with (nolock)  
  
 /*=======================================================================*/  
 /* RESPALDO PRESTAMOS IBS                                                */  
 /*=======================================================================*/  
  
     
   DELETE FROM dbo.TBL_PRESTAMOS_IBS_RES  
         WHERE FechaProceso = @dfecproc    
  
   IF @@ERROR <> 0   
   BEGIN  
      SET NOCOUNT OFF  
      --> SELECT -1, 'Error: Problemas al borrar Foto TBL_PRESTAMOS_IBS_RES de hoy'  
      RETURN  
   END  
  
   INSERT INTO dbo.TBL_PRESTAMOS_IBS_RES  
           ( FechaProceso  
   ,NumPrestamo  
   ,CodigoProducto  
   ,CodigoFamilia  
   ,NumDerivado  
   ,Tipo  
   ,FechaInicio  
   ,FechaVencimiento  
   ,Monto  
   ,CodigoTasa  
   ,TipoTasa  
   ,TasaCliente  
   ,Spread  
   ,MonedaPrestamo  
   ,RutCliente  
   ,TipoPlazo  
   ,Plazo  
   ,EstadoOperacion  
           )  
  
          SELECT @dfecproc  
       ,NumPrestamo  
       ,CodigoProducto  
       ,CodigoFamilia  
       ,NumDerivado  
       ,Tipo  
       ,FechaInicio  
       ,FechaVencimiento  
       ,Monto  
       ,CodigoTasa  
       ,TipoTasa  
       ,TasaCliente  
       ,Spread  
       ,MonedaPrestamo  
       ,RutCliente  
       ,TipoPlazo  
       ,Plazo  
       ,EstadoOperacion              
          FROM dbo.TBL_PRESTAMOS_IBS  
  
   IF @@ERROR <> 0   
   BEGIN  
      SET NOCOUNT OFF  
      --> SELECT -1, 'Error: Problemas al grabar Foto TBL_PRESTAMOS_IBS en TBL_PRESTAMOS_IBS_RES'  
      RETURN  
   END  
  
  
 /*=======================================================================*/  
 /* RESPALDO ANTICIPOS IBS                                                */  
 /*=======================================================================*/  
  
  
   DELETE FROM dbo.TBL_ANTICIPOS_IBS_RES  
         WHERE FechaProceso = @dfecproc    
  
   IF @@ERROR <> 0   
   BEGIN  
      SET NOCOUNT OFF  
      --> SELECT -1, 'Error: Problemas al borrar Foto TBL_ANTICIPOS_IBS_RES de hoy'  
      RETURN  
   END  
  
   INSERT INTO dbo.TBL_ANTICIPOS_IBS_RES  
           (  FechaProceso  
    ,NumPrestamo  
    ,CodigoProducto  
    ,CodigoFamilia  
    ,NumDerivado  
    ,TipoDRV  
    ,TipoAnticipo  
    ,Monto  
    ,FechaAnticipo  
    ,RutCliente  
           )  
  
          SELECT @dfecproc  
        ,NumPrestamo  
        ,CodigoProducto  
        ,CodigoFamilia  
        ,NumDerivado  
        ,TipoDRV  
        ,TipoAnticipo  
        ,Monto  
        ,FechaAnticipo  
         ,RutCliente  
          FROM dbo.TBL_ANTICIPOS_IBS  
  
   IF @@ERROR <> 0   
   BEGIN  
      SET NOCOUNT OFF  
      --> SELECT -1, 'Error: Problemas al grabar Foto TBL_ANTICIPOS_IBS en TBL_ANTICIPOS_IBS_RES'  
      RETURN  
   END  
  
  
 /*=======================================================================*/  
 /* RESPALDO ERRORES RELACION PAE IBS/DRV                                 */  
 /*=======================================================================*/  
  
  
   DELETE FROM dbo.TBL_ERRORES_RELACION_PAE_RES  
         WHERE FechaProceso = @dfecproc    
  
   IF @@ERROR <> 0   
   BEGIN  
      SET NOCOUNT OFF  
      --> SELECT -1, 'Error: Problemas al borrar Foto TBL_ERRORES_RELACION_PAE_RES de hoy'  
      RETURN  
   END  
  
   INSERT INTO dbo.TBL_ERRORES_RELACION_PAE_RES  
           (   FechaProceso  
     ,Modulo  
              ,NumPrestamo  
              ,NumDerivado  
              ,Mensaje  
              ,Evento  
           )  
  
          SELECT @dfecproc  
     ,Modulo  
              ,NumPrestamo  
              ,NumDerivado  
              ,Mensaje  
              ,Evento  
          FROM dbo.TBL_ERRORES_RELACION_PAE  
  
   IF @@ERROR <> 0   
   BEGIN  
      SET NOCOUNT OFF  
      --> SELECT -1, 'Error: Problemas al grabar Foto TBL_ERRORES_RELACION_PAE en TBL_ERRORES_RELACION_PAE_RES'  
      RETURN  
   END  
  
  
 /*=======================================================================*/  
 /* RESPALDO MARCA ESTRUCTURADO                                           */  
 /*=======================================================================*/  
  
  
      DELETE BacParamSuda.dbo.TBL_MARCA_ESTRUCTURADO_RES  WHERE FechaProceso = @dfecproc    
  
      IF @@ERROR <> 0   
      BEGIN  
         SET NOCOUNT OFF  
         --> SELECT -1, 'Error: Problemas al borrar Foto TBL_MARCA_ESTRUCTURADO_RES de hoy'  
         RETURN  
      END  
  
    INSERT INTO BacParamSuda.dbo.TBL_MARCA_ESTRUCTURADO_RES  
  ( FechaProceso  
        , FechaMarca  
        , Modulo  
     , NumDerivado  
     , Producto_Derivado  
     , FechaVencimiento    
     , MarcaRelacion  
     )  
     SELECT @dfecproc  
        , FechaMarca  
        , Modulo  
     , NumDerivado  
     , Producto_Derivado  
  , FechaVencimiento    
  , MarcaRelacion  
  FROM BacParamSuda.dbo.TBL_MARCA_ESTRUCTURADO   
  
      IF @@ERROR <> 0   
      BEGIN  
         SET NOCOUNT OFF  
         --> SELECT -1, 'Error: Problemas al grabar Foto TBL_MARCA_ESTRUCTURADO en TBL_MARCA_ESTRUCTURADO_RES'  
         RETURN  
      END  
  
 /*=======================================================================*/  
 /* RESPALDO MARCA ESTRUCTURADO                                           */  
 /*=======================================================================*/  
  
  
   SET NOCOUNT OFF  
   --> SELECT 0  
  
END
GO
