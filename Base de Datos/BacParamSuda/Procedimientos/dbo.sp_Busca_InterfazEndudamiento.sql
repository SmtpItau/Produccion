USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_Busca_InterfazEndudamiento]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Busca_InterfazEndudamiento]
AS
BEGIN

   	--Nombre Interface : CARVIGFWD_aammdd.TXT
	SELECT acfecante, (ruta_acceso + 'CARVIGFWD_' + RIGHT(CONVERT(VARCHAR,acfecante,112),8) + '.txt') As ruta_acceso_interfaz
	FROM INTERFAZ, view_MdAc 
	where nombre = 'CARVIGFWD'

END

GO
