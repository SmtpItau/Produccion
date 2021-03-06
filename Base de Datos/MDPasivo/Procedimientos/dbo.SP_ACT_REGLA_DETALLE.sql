USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_REGLA_DETALLE]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACT_REGLA_DETALLE]
					(
					@inumero_Regla	Numeric	(10)	,
					@iopcion_menu	Char	(50)	,
					@isistema	Char	(03)	,
					@icontador	Numeric	(10)
					)
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

	IF EXISTS(SELECT 1 FROM REGLA_MENSAJE_DETALLE WHERE numero_regla = @inumero_Regla)
	BEGIN
		IF @icontador = 0
			DELETE REGLA_MENSAJE_DETALLE WHERE numero_regla = @inumero_Regla
	END

            IF (@iopcion_menu = 'INICIO'  or @iopcion_menu = 'CONTABILIDAD' or @iopcion_menu  = 'FIN'  ) AND  @iSistema = 'SCE' BEGIN

               INSERT INTO REGLA_MENSAJE_DETALLE
					(
						numero_regla	,
						id_sistema	,
						opcion_menu	
					)
		SELECT 
					
						@inumero_Regla	,
						Sistema,
						@iopcion_menu	
                FROM  SWITCH_OPERATIVO
                WHERE Codigo_Control = @iopcion_menu
					
            END ELSE BEGIN
               INSERT INTO REGLA_MENSAJE_DETALLE
					(
						numero_regla	,
						id_sistema	,
						opcion_menu	
					)
		VALUES
					(
						@inumero_Regla	,
						@isistema	,
						@iopcion_menu	
					)

           END 
END


GO
