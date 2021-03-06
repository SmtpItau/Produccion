USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProdxCampos_Grabar]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ProdxCampos_Grabar](      
		@codigo_campo   		NUMERIC(3)
      		,@evento        		VARCHAR(200)
		,@sistema			VARCHAR(10)
		,@producto			VARCHAR(10)
		,@tipo_administracion_campo	VARCHAR(1)
	
      )
--Sp_ProdxCampos_Grabar 11, 'BONOS'
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

      	INSERT INTO CAMPO_CNT ( id_sistema , tipo_movimiento , tipo_operacion , codigo_campo , descripcion_campo , nombre_campo_tabla , tipo_administracion_campo)
	SELECT 	@sistema , @evento , @producto , @codigo_campo , DESCRIPCION , NOMBRE_CAMPO_TABLA , @tipo_administracion_campo
	FROM 	campo_cnt_cabecera 
	WHERE 	codigo 			= @codigo_campo

      SET NOCOUNT OFF



END

GO
