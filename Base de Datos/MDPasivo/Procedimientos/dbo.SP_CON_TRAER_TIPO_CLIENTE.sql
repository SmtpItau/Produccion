USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_TRAER_TIPO_CLIENTE]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_TRAER_TIPO_CLIENTE]
AS
BEGIN


	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	SELECT Codigo_tipo_cliente
	        ,Descripcion
	 	,Codigo_Cliente_SBIF
		,Descripcion_Cliente_SBIF
	FROM TIPO_CLIENTE
	ORDER BY Codigo_tipo_cliente

END

GO
