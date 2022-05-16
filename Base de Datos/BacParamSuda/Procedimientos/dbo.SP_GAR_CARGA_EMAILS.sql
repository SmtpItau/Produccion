USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_CARGA_EMAILS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_CARGA_EMAILS]
AS
BEGIN

	SELECT NombreDestinatario
	,      tbglosa
	,      direccionEmail	  	 
	,      tipoDestinatario
	  FROM dbo.tbl_Gar_DireccionEmail
	 INNER
	  JOIN BacparamSuda.dbo.TABLA_GENERAL_DETALLE TGD 
	    ON tbcateg = 7209
	   AND tbcodigo1= TipoDestinatario;
	


END
GO
