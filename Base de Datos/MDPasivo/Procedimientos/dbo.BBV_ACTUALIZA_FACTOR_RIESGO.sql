USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_ACTUALIZA_FACTOR_RIESGO]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BBV_ACTUALIZA_FACTOR_RIESGO]
/* PROCEDIMIENTO QUE ACTUALIZA LOS FACTORES DE RIESGO
   DE ALGUNAS OPERACIONES, SEGUN LO QUE SE ENCUENTRA 
   ALMACENADO EN LA TABLA PASO_FACTOR_RIESGO          */
AS
BEGIN

	BEGIN TRAN

	update	lineas_operacion_frp
	set		Factor_Riesgo	=	(select factor from paso_factor_riesgo where NumeroOperacion = numope and factor > 0.0001)
	where	NumeroOperacion in	(select numope from paso_factor_riesgo where factor > 0.0001)

	IF @@ROWCOUNT = 0 
	BEGIN
        ROLLBACK TRAN
		RAISERROR('¡ Error al intentar actualizar factores de riesgo.... ! ',16,6,'ERROR.')
        RETURN(1)
	END

/*	IF (@@error!=0)
	BEGIN
		RAISERROR  20002 'ERROR AL ACTUALIZAR LOS FACTORES'
        ROLLBACK TRAN
        RETURN(1)
	END*/

	COMMIT TRAN
END
GO
