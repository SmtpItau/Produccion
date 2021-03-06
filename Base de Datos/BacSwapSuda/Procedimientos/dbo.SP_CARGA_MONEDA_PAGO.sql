USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_MONEDA_PAGO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CARGA_MONEDA_PAGO]
   (   @id_sistema        CHAR(3)
   ,   @MonedaOperacion   NUMERIC(9) = 0
   )
AS
BEGIN
   SET NOCOUNT ON

   SELECT DISTINCT Moneda_Pago , mnglosa 
   FROM   bacswapsuda..MONEDA_PAGO LEFT JOIN bacparamsuda..MONEDA ON mncodmon = Moneda_Pago
   WHERE  id_sistema = @id_sistema 
   AND   (Moneda_Operacion = @MonedaOperacion OR @MonedaOperacion = 0)

END



GO
