USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaCont_CRUD_ParametrosDetalleOpciones]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CuadraturaCont_CRUD_ParametrosDetalleOpciones](  @Sistema varchar(10)
															   , @IDDetalleParametros int
															   , @codIBS int
															   , @estadoCod varchar(30)
															   , @estructuraCod varchar(30)
															   , @callPut varchar(30)
															   , @CompraVenta varchar(30)
															   , @tipoCriterio int 
															   )
AS
BEGIN
	IF  @IDDetalleParametros < 0 
		BEGIN		 
			INSERT INTO Parametros_Detalle_Opciones VALUES (@Sistema, @codIBS, @estadoCod, @estructuraCod, @callPut, @compraVenta, @tipoCriterio)
		END

	IF  @IDDetalleParametros > 0
		BEGIN
			UPDATE Parametros_Detalle_Opciones
			SET EstadoCod         = @estadoCod
			  , EstructuraCod	  = @estructuraCod
			  , CallPut			  = @CallPut
			  , CompraVenta	      = @compraVenta
			  , CodIBS			  = @codIBS
			  , TipoCriterio	  = @tipoCriterio
			WHERE IDDetalleParametros = @IDDetalleParametros
		END
END         

GO
