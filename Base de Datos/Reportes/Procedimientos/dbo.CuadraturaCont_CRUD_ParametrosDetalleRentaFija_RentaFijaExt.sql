USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaCont_CRUD_ParametrosDetalleRentaFija_RentaFijaExt]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CuadraturaCont_CRUD_ParametrosDetalleRentaFija_RentaFijaExt](  @Sistema varchar(10)
																   , @IDDetalleParametros int
																   , @codIBS int
																   , @cartera char(1)
																   , @tipoInstrumento varchar(30)
																   , @moneda varchar(30)
																   , @tipoEmisor int 
																   , @tipoCriterio int 
																   )
AS
BEGIN
	IF  @IDDetalleParametros < 0 
		BEGIN		 
			INSERT INTO Parametros_Detalle_RentaFija VALUES (@Sistema, @codIBS, @cartera, @tipoInstrumento, @moneda, @tipoEmisor,@tipoCriterio)
		END

	IF  @IDDetalleParametros > 0
		BEGIN
			UPDATE Parametros_Detalle_RentaFija
			SET Cartera         = @cartera
			  , TipoInstrumento	  = @tipoInstrumento
			  , Moneda			  = @moneda
			  , TipoEmisor	      = @tipoEmisor
			  , CodIBS			  = @codIBS
			  , TipoCriterio	  = @tipoCriterio
			WHERE IDDetalleParametros = @IDDetalleParametros
			AND Sistema = @Sistema
		END
END         

GO
