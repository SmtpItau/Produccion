USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_MATRIZRIESGO_BUSCA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MATRIZRIESGO_BUSCA]
               (
               @Codpro CHAR(5)
              ,@Moneda CHAR(5)
	      ,@ConMon CHAR(5)
               )
AS
BEGIN
 SET NOCOUNT ON
  SELECT Codigo_Producto
  ,      moneda
  ,      DiasDesde 
  ,      DiasHasta 
  ,      Porcentaje
  ,	 Contra_Moneda
    FROM MATRIZ_RIESGO 
   WHERE codigo_producto = @codpro
     AND moneda          = @moneda
     AND Contra_Moneda	 = @ConMon
ORDER By diasdesde

 SET NOCOUNT OFF
END
GO
