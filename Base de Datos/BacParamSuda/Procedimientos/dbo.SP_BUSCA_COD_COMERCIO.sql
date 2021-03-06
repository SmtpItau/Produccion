USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_COD_COMERCIO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Busca_Cod_Comercio    fecha de la secuencia de comandos: 03/04/2001 15:17:59 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Busca_Cod_Comercio    fecha de la secuencia de comandos: 14/02/2001 09:58:23 ******/
CREATE PROCEDURE [dbo].[SP_BUSCA_COD_COMERCIO](@codi   CHAR(6),
                                       @conce  char(6))
AS 
BEGIN
SET NOCOUNT ON
 
 SELECT 'fecha' = CONVERT(CHAR(8),fecha,112), comercio, concepto, glosa, tipo_documento, codigo_oma
 FROM CODIGO_COMERCIO
 WHERE (@codi = '' OR @codi = comercio)
 and    (@conce = '' OR @conce = concepto)
SET NOCOUNT OFF
END 
GO
