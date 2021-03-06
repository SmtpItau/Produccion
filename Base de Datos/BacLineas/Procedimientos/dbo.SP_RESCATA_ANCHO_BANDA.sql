USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESCATA_ANCHO_BANDA]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_RESCATA_ANCHO_BANDA]
                 (
                     @id_Sistema          CHAR   (  03)      ,
                     @Codigo_Producto     CHAR   (  05)      ,
                     @Moneda              NUMERIC( 3,0)      ,
                     @Plazo               NUMERIC( 10,0)     ,
                     @Porcentaje          NUMERIC( 1,0) OUTPUT
     
                  ) 

AS
BEGIN



   SET NOCOUNT ON
   
   DECLARE @tipomoneda CHAR(1)

   SELECT   @tipomoneda = mnrrda FROM  VIEW_MONEDA WHERE   mncodmon = @Moneda 



   IF  @Codigo_Producto =2 AND @tipomoneda ='M' 
   BEGIN
         SELECT 'Sistema' = Id_Sistema 
               ,'CodProd' = Codigo_Producto 
               ,'CodMon'  = Moneda 
               ,'%Var'    = Ancho_Banda   
         FROM  MATRIZ_DE_CONTROL
         WHERE Id_Sistema      = @id_Sistema
           AND Codigo_Producto = @Codigo_Producto
           AND Moneda          = 13
           AND Plazo_Desde     <=@Plazo  
           AND Plazo_Hasta     >=@Plazo   


   END   
   ELSE
   BEGIN

         SELECT 'Sistema' = Id_Sistema 
               ,'CodProd' = Codigo_Producto 
               ,'CodMon'  = Moneda 
               ,'%Var'    = Ancho_Banda   
         FROM  MATRIZ_DE_CONTROL
         WHERE Id_Sistema      = @id_Sistema
           AND Codigo_Producto = @Codigo_Producto
           AND Moneda          = @Moneda
           AND Plazo_Desde     <=@Plazo  
           AND Plazo_Hasta     >=@Plazo   
   END      


END
GO
