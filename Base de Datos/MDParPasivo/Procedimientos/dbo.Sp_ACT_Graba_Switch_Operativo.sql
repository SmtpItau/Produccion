USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ACT_Graba_Switch_Operativo]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ACT_Graba_Switch_Operativo]
		( 
			@cOpcion_Menu 		Char(30),
		  	@cSistema		Char(03)	,
			@iOrden			INTEGER		,
			@itipo			INTEGER		,
			@cDescripcion		Char(50)	,
			@iReproceso		INTEGER
		)

AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON

	
	

	IF @itipo = 1 
	BEGIN
		

 		IF EXISTS(SELECT * FROM  SWITCH_OPERATIVO WHERE RTRIM(LTRIM(Codigo_Control)) = RTRIM(LTRIM(@cOpcion_Menu)) AND RTRIM(LTRIM(Sistema)) = RTRIM(LTRIM(@cSistema)))
		BEGIN
			UPDATE  SWITCH_OPERATIVO SET
				Orden 		= @iOrden		,
				Descripcion	= @cDescripcion		,
				Reproceso	= CASE
							WHEN RTRIM(LTRIM(@cOpcion_Menu))= 'INICIO'  OR RTRIM(LTRIM(@cOpcion_Menu))= 'CONTABILIDAD' OR RTRIM(LTRIM(@cOpcion_Menu))= 'FIN' THEN Reproceso
							WHEN reproceso = 5 THEN reproceso
							ELSE @iReproceso
						  END

			FROM  SWITCH_OPERATIVO
			WHERE RTRIM(LTRIM(Codigo_Control)) = RTRIM(LTRIM(@cOpcion_Menu)) AND RTRIM(LTRIM(Sistema)) = RTRIM(LTRIM(@cSistema))

			IF RTRIM(LTRIM(@cOpcion_Menu))= 'INICIO'  OR RTRIM(LTRIM(@cOpcion_Menu))= 'CONTABILIDAD' OR RTRIM(LTRIM(@cOpcion_Menu))= 'FIN'
				UPDATE SWITCH_OPERATIVO SET  Orden =  @iOrden	WHERE   Codigo_Control = @cOpcion_Menu
					
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
							Orden_Especial		,
							Descripcion 
						)
			VALUES
						(
						  	@cSistema		,
							@cOpcion_Menu 		,
							CASE when @copcion_menu in ('Devengamiento','Opc_50200','Opc_Proc_001','Opc_50100') 
                                                        THEN 5 ELSE @iReproceso END		,
							0			,
							@iOrden			,
							0			,
							@cDescripcion				
						)

		END
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT * FROM  SWITCH_OPERATIVO WHERE RTRIM(LTRIM(Codigo_Control)) = RTRIM(LTRIM(@cOpcion_Menu)) AND RTRIM(LTRIM(Sistema)) = RTRIM(LTRIM(@cSistema)))
		BEGIN
			UPDATE  SWITCH_OPERATIVO SET
				Orden_Especial 		= @iOrden		,
				Descripcion		= @cDescripcion		,
				Reproceso	= CASE
							WHEN RTRIM(LTRIM(@cOpcion_Menu))= 'INICIO'  OR RTRIM(LTRIM(@cOpcion_Menu))= 'CONTABILIDAD' OR RTRIM(LTRIM(@cOpcion_Menu))= 'FIN' THEN Reproceso
							WHEN reproceso = 5 THEN reproceso
							ELSE @iReproceso
						  END
			FROM  SWITCH_OPERATIVO
			WHERE RTRIM(LTRIM(Codigo_Control)) = RTRIM(LTRIM(@cOpcion_Menu)) AND RTRIM(LTRIM(Sistema)) = RTRIM(LTRIM(@cSistema))

			IF RTRIM(LTRIM(@cOpcion_Menu))= 'INICIO'  OR RTRIM(LTRIM(@cOpcion_Menu))= 'CONTABILIDAD' OR RTRIM(LTRIM(@cOpcion_Menu))= 'FIN'
				UPDATE SWITCH_OPERATIVO SET  Orden_Especial =  @iOrden	WHERE   Codigo_Control = @cOpcion_Menu

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
							Orden_Especial		,
							Descripcion 
						)
			VALUES
						(
						  	@cSistema		,
							@cOpcion_Menu 		,
							CASE when @copcion_menu in ('Devengamiento','Opc_50200','Opc_Proc_001','Opc_50100') 
                                                        THEN 5 ELSE @iReproceso END		,
							0			,
							0			,
							@iOrden			,
							@cDescripcion				
						)

		END
	END	


END











GO
