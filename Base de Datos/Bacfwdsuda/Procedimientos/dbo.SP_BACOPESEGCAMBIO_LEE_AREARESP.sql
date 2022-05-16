USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACOPESEGCAMBIO_LEE_AREARESP]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 15:53 AQUI */
CREATE PROCEDURE [dbo].[SP_BACOPESEGCAMBIO_LEE_AREARESP]
AS
BEGIN
   ----------------------------------------------
   SET NOCOUNT ON
   ----------------------------------------------
     SELECT id_sistema, 
          nombre_sistema 
     FROM VIEW_SISTEMA_CNT 
     WHERE operativo = 'S' AND gestion = 'N'
     ORDER BY nombre_sistema
   ----------------------------------------------
   SET NOCOUNT OFF
   ----------------------------------------------
END

GO
