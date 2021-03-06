USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_MATRIZRIESGO_AYUDAPRODUCTO_SWAP]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MATRIZRIESGO_AYUDAPRODUCTO_SWAP]
AS
BEGIN

   SET NOCOUNT ON

   SELECT codigo_producto 
   ,      descripcion
   ,      id_sistema
   ,      Contra_Moneda
   ,      case when codigo_producto = 'SM' then 2
               when codigo_producto = 'ST' then 1
               when codigo_producto = 'FR' then 3
               when codigo_producto = 'SP' then 4
          end  as CodigoNumerico 
   FROM   VIEW_PRODUCTO 
   WHERE  id_Sistema = 'PCS' 
   ORDER BY codigo_producto 

END
GO
