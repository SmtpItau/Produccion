USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProdxCampos_Eliminar]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ProdxCampos_Eliminar](
		@evento		varchar(25)
		,@codigo	Numeric(05)
		,@administracion varchar(1)
)
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON
	DELETE FROM campo_cnt 
	WHERE 	tipo_movimiento 		= @evento
		AND codigo_campo		= @codigo
		AND tipo_administracion_campo 	= @administracion
	
END
GO
