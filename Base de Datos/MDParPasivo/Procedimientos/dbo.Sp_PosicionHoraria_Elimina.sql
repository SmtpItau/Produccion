USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_PosicionHoraria_Elimina]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_PosicionHoraria_Elimina]
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

		DELETE  FROM POSICION_GRUPO

SET NOCOUNT OFF
END











GO
