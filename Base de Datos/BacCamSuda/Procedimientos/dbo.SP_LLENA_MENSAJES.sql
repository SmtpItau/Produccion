USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_MENSAJES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LLENA_MENSAJES]
AS
BEGIN
   SET NOCOUNT ON
      SELECT DISTINCT codigo_mensaje_swift
       FROM swift_mensaje
      --WHERE id_sistema='BCC'
   SET NOCOUNT OFF
END

GO
