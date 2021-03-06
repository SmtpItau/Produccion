USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Borra_Switch_Operativo]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Borra_Switch_Operativo]
		( 
			@cOpcion_Menu 	Char(20)	,
		  	@cSistema	Char(03)	
		)

AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   DECLARE @iEstado INTEGER

   SELECT @iEstado = 1

   IF EXISTS(SELECT 1 FROM  SWITCH_OPERATIVO
             WHERE RTRIM(LTRIM(Codigo_Control)) = RTRIM(LTRIM(@cOpcion_Menu)) AND RTRIM(LTRIM(Sistema)) = RTRIM(LTRIM(@cSistema)))

      DELETE  SWITCH_OPERATIVO
      WHERE RTRIM(LTRIM(Codigo_Control)) = RTRIM(LTRIM(@cOpcion_Menu)) AND RTRIM(LTRIM(Sistema)) = RTRIM(LTRIM(@cSistema))
		
   ELSE

      SELECT @iEstado = 0

   SELECT @iEstado

END


GO
