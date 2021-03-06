USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CODIGO_COMERCIO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Codigo_Comercio    fecha de la secuencia de comandos: 03/04/2001 15:18:00 ******/
CREATE PROCEDURE [dbo].[SP_CODIGO_COMERCIO]
  (@gscodigo NUMERIC(5),
   @gsdigito NUMERIC(5)
  )
AS
BEGIN
 SET NOCOUNT OFF
 SELECT fecha,comercio,concepto,glosa,tipo_documento,codigo_oma
 FROM CODIGO_COMERCIO
 WHERE codigo_oma =@gscodigo
 and (tipo_documento=@gsdigito or tipo_documento=0)
 SET NOCOUNT ON
END
GO
