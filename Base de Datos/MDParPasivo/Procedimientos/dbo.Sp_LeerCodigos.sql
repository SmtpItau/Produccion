USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LeerCodigos]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_LeerCodigos    fecha de la secuencia de comandos: 03/04/2001 15:18:07 ******/


/****** Objeto:  procedimiento  almacenado dbo.Sp_LeerCodigos    fecha de la secuencia de comandos: 14/02/2001 09:58:28 ******/

CREATE PROCEDURE [dbo].[Sp_LeerCodigos] (@cod_cat  NUMERIC(6))
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON
   
	SELECT  
		tbcateg	,
		tbcodigo1	,
		tbtasa	,
		tbfecha	,
		tbvalor	,
		tbglosa	,
		 nemo	
	
        FROM
        	TABLA_GENERAL_DETALLE
     	WHERE
        	tbcateg = @cod_cat
     	
	ORDER BY tbglosa
  	RETURN
END  















GO
