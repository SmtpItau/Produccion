USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaEmisores_Eliminar_Emisores]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TablaEmisores_Eliminar_Emisores](@codigo_emisores CHAR   (03))
AS 
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON


   IF EXISTS(SELECT 1 FROM EMISOR WHERE emtipo = @codigo_emisores  ) OR  EXISTS(SELECT 1 FROM PRODUCTO_CUENTA WHERE tipo_cliente = @codigo_emisores  )
      SELECT 'RELACIONADA'
   ELSE
   BEGIN
	   IF EXISTS(SELECT codigo_tipo FROM TIPO_EMISOR WHERE	codigo_tipo	= @codigo_emisores)
	   	   DELETE TIPO_EMISOR WHERE	codigo_tipo	= @codigo_emisores
	   ELSE
	   	SELECT 'NO EXISTE'
   END

END


GO
