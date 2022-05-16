USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LOADPATHFILEDCV]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LOADPATHFILEDCV]
AS
BEGIN

   SET NOCOUNT ON
   
   IF NOT EXISTS( SELECT 1 FROM dbo.TBL_ARCHIVOS WHERE IdArchivo = 99 )
      INSERT INTO dbo.TBL_ARCHIVOS SELECT 99, 'Setting Source File Directory', 'TAT' , '', '', 'C:\RECEPCIONADO-DCV\'

   SELECT PathDestino, Extencion FROM TBL_ARCHIVOS WHERE IdArchivo = 99

END

GO
