USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaCont_CRUD_ParametrosDetalleFWD]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CuadraturaCont_CRUD_ParametrosDetalleFWD]( @Sistema varchar(10)
													 , @IDDetalleParametros int
													 , @producto varchar(30)
													 , @monedaActiva varchar(30)
													 , @monedaPasiva varchar(30)
													 , @tipoOperacion varchar(30) 
													 , @carteraNormativa varchar(30)
													 , @codIBS int
													 , @tipoCriterio int )
AS

	IF  @IDDetalleParametros < 0 
		BEGIN
			INSERT INTO Parametros_Detalle_Forwards VALUES (@Sistema, @codIBS, @producto, @monedaActiva, @monedaPasiva, @tipoOperacion,@carteraNormativa,@tipoCriterio)
		END

	IF  @IDDetalleParametros > 0
		BEGIN
			UPDATE Parametros_Detalle_Forwards
			SET Producto          = @producto
			  , MonedaActiva	  = @monedaActiva
			  , MonedaPasiva	  = @monedaPasiva
			  , TipoOperacion	  = @tipoOperacion
			  , CarteraNormativa  = @carteraNormativa
			  , CodIBS			  = @codIBS
			  , TipoCriterio      = @tipoCriterio
			WHERE IDDetalleParametros = @IDDetalleParametros
		END

GO
