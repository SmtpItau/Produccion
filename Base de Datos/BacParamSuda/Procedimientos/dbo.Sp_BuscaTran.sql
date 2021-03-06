USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BuscaTran]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_BuscaTran] (@nCodTr Numeric(10))
AS

BEGIN
  IF EXISTS(SELECT * FROM Perfil_Cnt WHERE Id_sistema = 'BTR' And Folio_Perfil = @nCodTr)
     SELECT 'SI', glosa_perfil FROM Perfil_Cnt WHERE Id_sistema = 'BTR' And Folio_Perfil = @nCodTr
  ELSE
     SELECT 'NO'
END


GO
