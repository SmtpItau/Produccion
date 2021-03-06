USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Mostrar_Linea_BCCH]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Mostrar_Linea_BCCH]
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON
	SELECT	id_sistema		,
		codigo_linea		,
		descripcion		,
		fechaasignacion		,
		fechavencimiento	,
		fechafinContrato	,
		bloqueado		,
		totalasignado		,
		totalocupado		,
		totaldisponible		,
		totalexceso
	FROM linea_credito_bcch 
SET NOCOUNT OFF
END

GO
