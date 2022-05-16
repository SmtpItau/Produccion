USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MATRIZRIESGO_ELIMINA_BEX]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MATRIZRIESGO_ELIMINA_BEX]
	(
		@Codpro char(5),
		@ModPag char(5)
	)
 as begin

 set nocount on

	 Delete matriz_riesgo_bex where codigo = @codpro and moneda = @ModPag

 set nocount off

end

-- sp_autoriza_ejecutar 'bacuser'
-- select * from matriz_riesgo_cliente

GO
