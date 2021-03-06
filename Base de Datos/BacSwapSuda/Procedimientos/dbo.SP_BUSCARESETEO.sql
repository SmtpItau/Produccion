USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCARESETEO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BUSCARESETEO] (@usuario CHAR(15))   
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @reset_psw	    CHAR(1)

	SELECT 	Largo_Clave,
		Tipo_Clave,
          	reset_psw

	FROM bacparamsuda..USUARIO
	WHERE usuario = @usuario

	SET NOCOUNT OFF
END
GO
