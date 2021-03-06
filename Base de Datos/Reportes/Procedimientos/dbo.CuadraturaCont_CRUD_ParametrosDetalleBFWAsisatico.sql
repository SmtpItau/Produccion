USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaCont_CRUD_ParametrosDetalleBFWAsisatico]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CuadraturaCont_CRUD_ParametrosDetalleBFWAsisatico](  @Sistema varchar(10)
																   , @IDDetalleParametros int
																   , @codIBS int
																   , @carteraNormativa varchar(10)
																   , @estructuraCod varchar(30)
																   , @CompraVenta varchar(30) 
																   , @tipoCriterio	int
																   )
AS
BEGIN

--    , @estadoCod varchar(30)
--    , @callPut varchar(30)

select * from Parametros_Detalle_BFWAsisatico 

	IF  @IDDetalleParametros < 0 
		BEGIN		 
			INSERT INTO Parametros_Detalle_BFWAsisatico VALUES (@Sistema, @codIBS,  @estructuraCod,  @compraVenta, @carteraNormativa,  @tipoCriterio)
		END

	IF  @IDDetalleParametros > 0
		BEGIN
			UPDATE Parametros_Detalle_BFWAsisatico
			SET  EstructuraCod	  = @estructuraCod
			  , CarteraNormativa  = @carteraNormativa
			  , CompraVenta	      = @compraVenta
			  , CodIBS			  = @codIBS
			  , TipoCriterio	  = @tipoCriterio
			WHERE IDDetalleParametros = @IDDetalleParametros


		END
END         

GO
