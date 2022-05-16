USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_COMUNAS]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_COMUNAS]
AS
BEGIN
  SELECT nom_ciu,cod_com  FROM VIEW_CIUDAD_COMUNA WHERE cod_pai = 6 AND cod_ciu = 1 AND cod_com <> 0
END

GO
