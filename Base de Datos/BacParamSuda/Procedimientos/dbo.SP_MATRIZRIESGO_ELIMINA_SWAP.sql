USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MATRIZRIESGO_ELIMINA_SWAP]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MATRIZRIESGO_ELIMINA_SWAP]
 (
  @Codpro char(5),
  @ModPag char(5)
 )
 as begin
 set nocount on
  Delete matriz_riesgo_Swap where codigo_producto=@codpro                  -- and modalidad_pago=@ModPag
 set nocount off
end

GO
