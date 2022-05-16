USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NGINE_CARGA_PARAMETRIA_WS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_NGINE_CARGA_PARAMETRIA_WS] (@Id_Metodo numeric(3))
AS BEGIN
	SET NOCOUNT ON
		SELECT id_metodo,glosa,wsurl FROM NGINE_WSURL_ACTION
		WHERE 
			id_metodo = @Id_Metodo
	SET NOCOUNT OFF
END
GO
