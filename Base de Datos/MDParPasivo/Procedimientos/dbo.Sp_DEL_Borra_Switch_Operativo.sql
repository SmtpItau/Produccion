USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_DEL_Borra_Switch_Operativo]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_DEL_Borra_Switch_Operativo]
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   DELETE SWITCH_OPERATIVO
   WHERE RTRIM(LTRIM(Codigo_Control))<> 'INICIO' AND RTRIM(LTRIM(Codigo_Control))<> 'BLOQUEO'
     AND RTRIM(LTRIM(Codigo_Control))<> 'CONTABILIDAD' AND RTRIM(LTRIM(Codigo_Control))<> 'FIN'

END


GO
