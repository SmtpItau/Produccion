USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_CODIGOCORRESPONSAL]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_CODIGOCORRESPONSAL](
      @Codigo_Moneda  NUMERIC(10)  ,
      @Codigo_Corresp_Compra NUMERIC(10)  ,
      @Codigo_Corresp_Venta NUMERIC(10)  )
AS
  UPDATE bacparamsuda..MONEDA SET mncodcorrespC = @Codigo_Corresp_Compra ,
      mncodcorrespV = @Codigo_Corresp_Venta
     WHERE mncodmon = @Codigo_Moneda
GO
