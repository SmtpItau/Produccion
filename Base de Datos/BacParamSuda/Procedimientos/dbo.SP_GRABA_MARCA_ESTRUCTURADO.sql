USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_MARCA_ESTRUCTURADO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GRABA_MARCA_ESTRUCTURADO]
   (   @Modulo_Derivado     CHAR(3)   
   ,   @Numero_Derivado     NUMERIC(9)
   ,   @Producto_Derivado   NUMERIC(5)
   ,   @FechaVcto           DATETIME 
   ,   @MarcaRelacion       VARCHAR(1)      
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Mensaje        VARCHAR(1000)

   DECLARE @Fecha_Marca DATETIME
       SET @Fecha_Marca = ( SELECT acfecproc FROM BacTraderSuda.dbo.MDAC with(nolock) )

   
   IF EXISTS( SELECT 1 FROM BacParamSuda.dbo.TBL_MARCA_ESTRUCTURADO
                      WHERE NumDerivado       = @Numero_Derivado 
                        AND Modulo            = @Modulo_Derivado
                        AND Producto_Derivado = @Producto_Derivado )
   BEGIN

      IF @MarcaRelacion = 0 
           DELETE dbo.TBL_MARCA_ESTRUCTURADO           
           WHERE NumDerivado       = @Numero_Derivado 
             AND Modulo            = @Modulo_Derivado
             AND Producto_Derivado = @Producto_Derivado

      UPDATE dbo.TBL_MARCA_ESTRUCTURADO
         SET MarcaRelacion     = @MarcaRelacion
       WHERE NumDerivado       = @Numero_Derivado 
         AND Modulo            = @Modulo_Derivado
         AND Producto_Derivado = @Producto_Derivado

   END ELSE
   BEGIN

      INSERT INTO dbo.TBL_MARCA_ESTRUCTURADO
      (   FechaMarca
      ,   Modulo
      ,   NumDerivado
      ,   Producto_Derivado
      ,   FechaVencimiento
      ,   MarcaRelacion     
      )
      VALUES
      (   @Fecha_Marca
      ,   @Modulo_Derivado   
      ,   @Numero_Derivado
      ,   @Producto_Derivado
      ,   @FechaVcto
      ,   @MarcaRelacion      
      )

   END
   
END
GO
