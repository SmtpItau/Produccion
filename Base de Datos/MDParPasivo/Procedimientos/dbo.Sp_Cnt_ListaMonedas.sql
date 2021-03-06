USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Cnt_ListaMonedas]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Sp_Cnt_ListaMonedas] 
         			(
					@paresid_sistemas CHAR(03)
				)
AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON

	DECLARE @varorgmonedas	CHAR(60)
	,	@vardatamonedas	CHAR(60)
	,	@condmdaauc	CHAR(100)
        ,	@cond_monedas	CHAR(60)

	IF EXISTS( SELECT 1 FROM PRODUCTO_CNT WHERE id_sistema = @paresid_sistemas )
	BEGIN
		SELECT	@varorgmonedas	= origen_monedas
		,	@vardatamonedas	= datos_monedas
		,	@cond_monedas	= cond_monedas
		FROM	PRODUCTO_CNT 
		WHERE id_sistema = @paresid_sistemas

		IF RTRIM(@cond_monedas  ) <> ''
			SELECT @condmdaauc = 'WHERE (' + @cond_monedas + ') AND estado <> ' + CHAR(39) + 'A' + CHAR(39)

		IF RTRIM(@vardatamonedas) <> '' 
			EXECUTE ( 'SELECT ' + @vardatamonedas + ' FROM ' + @varorgmonedas + @condmdaauc )
	END
	ELSE
	BEGIN
		SELECT 'NO HAY DATOS' 
	END
END

GO
