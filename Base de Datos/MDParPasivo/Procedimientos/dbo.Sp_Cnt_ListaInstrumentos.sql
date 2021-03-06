USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Cnt_ListaInstrumentos]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Cnt_ListaInstrumentos]
					(
						@paresid_sistemas	CHAR(03)
					,	@tipo_operacion		CHAR(05) = ''
					)
AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON

	DECLARE	@varorginstrumentos	CHAR (60)
	,	@vardatainstrumentos	CHAR (60)
	,	@cFiltroBtr		CHAR (160)


	IF EXISTS(SELECT 1 FROM PRODUCTO_CNT WHERE id_sistema = @paresid_sistemas ) 
	BEGIN
		SELECT	@varorginstrumentos	= origen_instrumentos 
		,	@vardatainstrumentos	= datos_instrumentos
		FROM	PRODUCTO_CNT 
		WHERE	id_sistema=@paresid_sistemas

		IF @paresid_sistemas = 'PSV' 
		BEGIN 
			SELECT @cFiltroBtr = 'codigo_producto = ' + '''' + LTRIM(RTRIM(@tipo_operacion)) + ''''
		END
		IF @varorginstrumentos <> '' OR @vardatainstrumentos <> '' 
		BEGIN
			EXECUTE ('SELECT ' + @vardatainstrumentos + ' FROM ' + @varorginstrumentos + 'WHERE ' + @cFiltroBtr )
		END
	END 
	ELSE
	BEGIN
		SELECT 'NO HAY DATOS'
	END

	SET NOCOUNT OFF

END


-- 





GO
