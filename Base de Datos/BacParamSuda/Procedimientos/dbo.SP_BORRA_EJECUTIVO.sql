USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRA_EJECUTIVO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BORRA_EJECUTIVO]
 (
 @Codigo  NUMERIC(2)
 )
AS
BEGIN
DELETE FROM EJECUTIVO WHERE Codigo=@Codigo
 if @@error <> 0
  select -1, 'Error no se puede borrar Ejecutivo'
END
SET NoCount OFF
GO
