USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_Switch_Operativo]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Graba_Switch_Operativo]
		( 
			@cOpcion_Menu 		Char(20)	,
		  	@cSistema		Char(03)	,
			@iOrden			INTEGER		,
			@iOrden_Especial	INTEGER		,
			@cDescripcion		Char(50)
		)

AS
BEGIN

	SET DATEFORMAT dmy
	SET NOCOUNT ON

	DECLARE @iEstado INTEGER

	IF EXISTS(SELECT * FROM  SWITCH_OPERATIVO WHERE RTRIM(LTRIM(Codigo_Control)) = RTRIM(LTRIM(@cOpcion_Menu)) AND RTRIM(LTRIM(Sistema)) = RTRIM(LTRIM(@cSistema)))
	BEGIN
		UPDATE  SWITCH_OPERATIVO SET
			Orden 		= @iOrden		,
			Orden_Especial	= @iOrden_Especial	,
			Descripcion	= @cDescripcion

		FROM  SWITCH_OPERATIVO
		WHERE RTRIM(LTRIM(Codigo_Control)) = RTRIM(LTRIM(@cOpcion_Menu)) AND RTRIM(LTRIM(Sistema)) = RTRIM(LTRIM(@cSistema))

		SELECT @iEstado=1

	END
	ELSE
	BEGIN
		INSERT INTO SWITCH_OPERATIVO
					(
						Sistema 		,
						Codigo_Control 		,
				                Reproceso 		,
						Estado_Control 		,
						Orden 			,
						Orden_Especial 		,
						Descripcion 
					)
		VALUES
					(
					  	@cSistema		,
						@cOpcion_Menu 		,
						0			,
						0			,
						@iOrden			,
						@iOrden_Especial		,
						@cDescripcion				
					)

		SELECT @iEstado=0
	END
	
	SELECT @iEstado

END


GO
