USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDPEEliminar]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_MDPEEliminar]
AS
BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy

   /*=======================================================================*/
   /*=======================================================================*/
   DELETE PERIODO_TASA_BIDASK
SET NOCOUNT OFF
SELECT 0
END



GO
