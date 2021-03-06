USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[FUSION_SP_ActualizaDataClientes]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FUSION_SP_ActualizaDataClientes]
AS
BEGIN

	UPDATE			dbo.CLIENTE
	SET Codigo_AS400 = CONVERT(NUMERIC,exc.codAS400)
	  , Codigo_CGI   = CASE WHEN LEN(LTRIM(RTRIM(exc.codCGI))) > 0 THEN CAST(LTRIM(RTRIM(exc.codCGI)) AS NUMERIC) ELSE '0' END 
	FROM            dbo.CLIENTE AS c INNER JOIN
					dbo.FUSION_CargarDeClientes_Excel AS exc ON c.Clrut = exc.rutCliente AND c.Cldv = exc.dvCliente				
    WHERE  exc.codAS400 <> ''

END


GO
