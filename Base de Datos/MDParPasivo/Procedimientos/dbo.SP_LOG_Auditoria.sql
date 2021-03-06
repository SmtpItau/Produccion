USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LOG_Auditoria]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LOG_Auditoria] (
					@Entidad CHAR(2)		,
					@FechaProceso DATETIME		,
					@FechaSistema DATETIME		,
					@HoraProceso CHAR(8)		,
					@Terminal CHAR(15)		,
					@Usuario CHAR(15)		,
					@Id_Sistema CHAR(3)		,
					@CodigoMenu VARCHAR(12)		,
					@Codigo_Evento VARCHAR(2)	,
					@DetalleTransac VARCHAR(80)	,
					@TablaInvolucrada VARCHAR(50)	,
					@ValorAntiguo VARCHAR(250)	,
					@ValorNuevo VARCHAR(250)	
				   )
AS BEGIN
SET DATEFORMAT dmy

	DECLARE @FechaP 	DATETIME
	DECLARE @MENU 		VARCHAR(30)
	DECLARE @EVENTO 	VARCHAR(30)
	DECLARE @DETALLE_FINAL  VARCHAR(250)
	DECLARE @SISTEMA        VARCHAR(30)

	SELECT @FechaP = Fecha_Proceso FROM DATOS_GENERALES
	SELECT @EVENTO = descripcion   FROM LOG_EVENTO WHERE @Codigo_Evento = codigo_evento
	SELECT @MENU   = nombre_opcion FROM MENU   WHERE @CodigoMenu    = nombre_objeto AND @ID_SISTEMA = entidad

	SELECT @MENU = (ISNULL(@MENU,'MENU NO DEFINIDO '))
 	
	SELECT @SISTEMA = nombre_sistema FROM SISTEMA_CNT WHERE @ID_SISTEMA= id_sistema

	SELECT @DETALLE_FINAL = UPPER(RTRIM(@SISTEMA)) + ' ' + UPPER(RTRIM(@MENU)) + ' ' + UPPER(RTRIM(@EVENTO)) + ' ' + UPPER(RTRIM(@DetalleTransac))

	SELECT @DETALLE_FINAL

	INSERT INTO log_auditoria( 
		Entidad		,	 
		FechaProceso	,
		FechaSistema	,
		HoraProceso	,
		Terminal	,
		Usuario		,
		Id_Sistema	,
		CodigoMenu	,
		Codigo_Evento	,
		DetalleTransac	,
		TablaInvolucrada,
		ValorAntiguo	,
		ValorNuevo	
		)

	VALUES (
		@Entidad			,
		CONVERT(CHAR(10),@FECHAP,112)	,
		@FechaSistema			,
		CONVERT(CHAR(8),getdate(),108)	,
		@Terminal			,
		@Usuario			,
		@id_Sistema			,
		@CodigoMenu			,
		@Codigo_Evento			,
		@DETALLE_FINAL			,
		@TablaInvolucrada		,
		@ValorAntiguo			,
		@ValorNuevo
		)
		

END








GO
