USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaCont_CRUD_ParametrosDetallePasivos]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   

CREATE PROCEDURE [dbo].[CuadraturaCont_CRUD_ParametrosDetallePasivos](   @Sistema varchar(10)
																	   , @IDDetalleParametros int
																	   , @codIBS int
																	   , @nombreSerie varchar(10)
																	   , @tipo_Bono varchar(30)
																	   , @planCuenta VARCHAR(50)
																	   , @tipoCriterio	int )
AS
BEGIN

 IF  @IDDetalleParametros < 0 
		BEGIN		 
			INSERT INTO Parametros_Detalle_Pasivos VALUES (@Sistema, @codIBS,  @nombreSerie,  @tipo_Bono, @planCuenta,  @tipoCriterio)
		END
	--	select * from Parametros_Detalle_Pasivos 

	IF  @IDDetalleParametros > 0
		BEGIN

			UPDATE Parametros_Detalle_Pasivos
			SET NombreSerie 	  = @nombreSerie
			  , Tipo_Bono	      = @tipo_Bono
			  , PlanCuenta		  = @planCuenta
			  , CodIBS			  = @codIBS
			  , TipoCriterio	  = @tipoCriterio
			WHERE IDDetalleParametros = @IDDetalleParametros


		END
END    

GO
