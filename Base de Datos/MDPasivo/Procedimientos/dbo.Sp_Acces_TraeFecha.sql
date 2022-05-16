USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Acces_TraeFecha]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Acces_TraeFecha]
AS
BEGIN
	
   SET DATEFORMAT dmy
   SET NOCOUNT ON

   SELECT	Fecha_Anterior,
		Fecha_Proceso,
		Fecha_Proxima

   FROM DATOS_GENERALES

END


GO
