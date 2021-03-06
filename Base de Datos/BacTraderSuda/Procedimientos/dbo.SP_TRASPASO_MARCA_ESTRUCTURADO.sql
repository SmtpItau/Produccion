USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRASPASO_MARCA_ESTRUCTURADO]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TRASPASO_MARCA_ESTRUCTURADO]
AS
BEGIN
   SET NOCOUNT ON
     
   /*=======================================================================*/
   /* Proceso de traspaso  de vencimientos para tabla Marca Estructurado	*/
   /*=======================================================================*/

   DECLARE @dfecante     DATETIME
         , @dfecproc     DATETIME
         , @dfecproxpro  DATETIME
   SELECT  @dfecante     = acfecante
   ,       @dfecproc     = acfecproc 
   ,       @dfecproxpro  = acfecprox
   FROM    MDAC          with (nolock)


/************************************************************************************************************/
 -- Elimina de tabla TBL_MARCA_ESTRUCTURADO_HIS los registros que se insertaron venciendo en el fin de dia  
 -- los cuales se insertaran nuevamente pero con estado vencidos, esto eslo mismmo que se realiza
 
   DELETE BacParamSuda.dbo.TBL_MARCA_ESTRUCTURADO_HIS
   FROM BacParamSuda.dbo.TBL_MARCA_ESTRUCTURADO EST
   WHERE BacParamSuda.dbo.TBL_MARCA_ESTRUCTURADO_HIS.NumDerivado = EST.NumDerivado  
     AND EST.FechaVencimiento < @dfecproc

    INSERT INTO BacParamSuda.dbo.TBL_MARCA_ESTRUCTURADO_HIS
	( FechaMarca
    , Modulo
    , NumDerivado
    , Producto_Derivado
    , FechaVencimiento  
    , MarcaRelacion
    )
    SELECT FechaMarca
    , Modulo 
    , NumDerivado
    , Producto_Derivado
    , FechaVencimiento  
    , MarcaRelacion
    FROM BacParamSuda.dbo.TBL_MARCA_ESTRUCTURADO 
    WHERE  (FechaVencimiento < @dfecproc )  

-- Rebaja registros Vencidos de TBL_MARCA_ESTRUCTURADO  
  DELETE  BacParamSuda.dbo.TBL_MARCA_ESTRUCTURADO   
  WHERE  (FechaVencimiento  < @dfecproc)  
 

/************************************************************************************************************/



     SET NOCOUNT OFF

END
GO
