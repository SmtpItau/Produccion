USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACIRFGR_LEE_AREARESP]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BACIRFGR_LEE_AREARESP]
AS
BEGIN
   ----------------------------------------------
   SET NOCOUNT ON
   ----------------------------------------------
   SELECT id_sistema, 
          nombre_sistema 
     FROM VIEW_SISTEMA_CNT
     WHERE operativo = 'S' AND gestion = 'N'
     order by nombre_sistema
   ----------------------------------------------
   SET NOCOUNT OFF
   ----------------------------------------------
END


GO
