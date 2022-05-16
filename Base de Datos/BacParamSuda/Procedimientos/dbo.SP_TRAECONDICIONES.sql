USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAECONDICIONES]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_TRAECONDICIONES]
AS

BEGIN

  SET NOCOUNT ON
  SELECT DISTINCT codigo_campo, descripcion_campo 
  FROM CAMPO_CNT 
  WHERE id_sistema = 'BTR' AND tipo_administracion_campo = 'V'
  SET NOCOUNT OFF

END
GO
