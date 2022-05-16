USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MOSTRAR_PAIS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_MOSTRAR_PAIS] ( @codigo_pais CHAR(5)='')
AS
BEGIN
	IF @codigo_pais ='' BEGIN
		SELECT codigo_pais, nombre, cod_bcch, cod_swift FROM pais ORDER BY nombre
	END
	ELSE BEGIN
		SELECT codigo_pais, nombre, cod_bcch, cod_swift FROM pais
		 WHERE codigo_pais = @codigo_pais
		 ORDER BY nombre
	END
END

-- sp_autoriza_ejecutar 'bacuser'

GO
