USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarRegistros_DWT_BacLineas]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_EliminarRegistros_DWT_BacLineas](@FechaProceso  DATETIME)
AS 
BEGIN

---Eliminar registros si existen en tabla de Ingreso de registros DWT_BacLineas

IF EXISTS (SELECT * FROM IngresoDWT_BacLineas WHERE fechaIngreso = @FechaProceso)
	BEGIN
			DELETE FROM IngresoDWT_BacLineas WHERE fechaIngreso = @FechaProceso
	END

END 

GO
