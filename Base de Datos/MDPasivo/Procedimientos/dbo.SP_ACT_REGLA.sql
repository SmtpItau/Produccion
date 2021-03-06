USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_REGLA]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACT_REGLA]
					(
					@inumero_Regla	Numeric	(10)	,
					@inombre_Regla	Char	(100)	,
					@ipara		Char	(255)	,
					@icc		Char	(255)	,
					@iotros		Char	(255)	,
					@iasunto	Char	(255)	,
					@iestado	Char	(01)	
					)
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

	DECLARE @cmensaje CHAR(15)

	IF EXISTS(SELECT * FROM REGLA_MENSAJE WHERE numero_regla = @inumero_Regla)
	BEGIN
		UPDATE REGLA_MENSAJE SET
					nombre_regla	=	@inombre_Regla	,
					para		=	@ipara		,
					cc		=	@icc		,
					otros		=	@iotros		,
					asunto		=	@iasunto
		WHERE numero_regla = @inumero_Regla
		
		SELECT @cmensaje = 'Modificada'
	END
	ELSE
	BEGIN
		SELECT @inumero_Regla = ISNULL((SELECT MAX(numero_regla)FROM REGLA_MENSAJE),0) + 1

		INSERT INTO REGLA_MENSAJE
					(
						numero_regla	,
						nombre_regla	,
						para		,
						cc		,
						otros		,
						asunto		,
						estado		
					)
		VALUES
					(
						@inumero_Regla	,
						@inombre_Regla	,
						@ipara		,
						@icc		,
						@iotros		,
						@iasunto	,
						@iestado	
					)

				SELECT @cmensaje = 'Grabada'
	END

	SELECT @inumero_Regla, @cmensaje
END


GO
