USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaCont_CRUD_ParametrosDetalleSWAP]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CuadraturaCont_CRUD_ParametrosDetalleSWAP](  @Sistema varchar(10)
														  , @IDDetalleParametros int
														  , @monedaActiva varchar(30)
														  , @monedaPasiva varchar(30)
														  , @tipoSwap varchar(30) 
														  , @carteraNormativa varchar(30)
														  , @codIBS int
														  , @TipoCriterio int)
AS
BEGIN
	IF  @IDDetalleParametros < 0 
		BEGIN		 
			INSERT INTO Parametros_Detalle_Swap VALUES (@Sistema, @codIBS, @tipoSwap, @monedaActiva, @monedaPasiva, @carteraNormativa, @TipoCriterio)
		
		END



		select * from Parametros_Detalle_Swap 
	IF  @IDDetalleParametros > 0
		BEGIN
			UPDATE Parametros_Detalle_Swap
			SET --TipoFlujo         = @tipoFlujo,
			    MonedaActiva	  = @monedaActiva
			  , MonedaPasiva	  = @monedaPasiva
			  , TipoSwap	      = @tipoSwap
			  , CarteraNormativa  = @carteraNormativa
			  , CodIBS			  = @codIBS
			  , TipoCriterio	  = @TipoCriterio
			WHERE IDDetalleParametros = @IDDetalleParametros
		END
END

GO
