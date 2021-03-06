USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacSwapParametros_Busca_Priv_Especiales]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_BacSwapParametros_Busca_Priv_Especiales] (
								@usuario	CHAR(15),
								@entidad	CHAR(3) )

AS
BEGIN

	SET NOCOUNT ON
        SET DATEFORMAT dmy
	
	IF EXISTS (SELECT 1 FROM PRIVILEGIO WHERE usuario = @usuario AND tipo_privilegio = "U" AND entidad=@entidad AND habilitado='S') BEGIN

		SELECT opcion,habilitado
			FROM 	PRIVILEGIO
			WHERE 	usuario = @usuario 
				AND tipo_privilegio = "U" 
				AND entidad=@entidad AND 
				habilitado='S'
	END
	ELSE BEGIN
		
		SELECT ("NO EXISTE")	


	END

	SET NOCOUNT OFF

END




GO
