USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaCont_CRUD_ParametrosDetallePactos]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CuadraturaCont_CRUD_ParametrosDetallePactos]( @Sistema varchar(10)
													 , @IDDetalleParametros int
													 , @Cartera int
													 , @moneda varchar(30)
													 , @Serie varchar(30)
													 , @tipoCliente int 
													 , @codIBS int
													 , @tipoCriterio int )
AS

	IF  @IDDetalleParametros < 0 
		BEGIN
			INSERT INTO Parametros_Detalle_Pactos VALUES (@Sistema, @codIBS, @Cartera, @moneda, @Serie, @tipoCliente,@tipoCriterio)
		END

	IF  @IDDetalleParametros > 0
		BEGIN
			UPDATE Parametros_Detalle_Pactos
			SET Cartera         = @Cartera
			  , Moneda	        = @moneda
			  , Serie	        = @Serie
			  , TipoCliente	    = @tipoCliente
			  , CodIBS			= @codIBS
			  , TipoCriterio    = @tipoCriterio
			WHERE IDDetalleParametros = @IDDetalleParametros
		END

GO
