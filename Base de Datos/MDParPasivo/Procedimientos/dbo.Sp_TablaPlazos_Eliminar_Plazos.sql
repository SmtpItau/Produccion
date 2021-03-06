USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaPlazos_Eliminar_Plazos]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TablaPlazos_Eliminar_Plazos](@codigo_plazo CHAR  (03))
AS 
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

   IF EXISTS(SELECT 1 FROM PRODUCTO_CUENTA WHERE codigo_plazo = @codigo_plazo)
      SELECT 'RELACIONADA'
   ELSE
   BEGIN
	 IF EXISTS(SELECT codigo_plazo FROM PLAZO_PACTO WHERE	codigo_plazo	= @codigo_plazo)
	 	DELETE PLAZO_PACTO WHERE codigo_plazo = @codigo_plazo
	 ELSE
	   	SELECT 'NO EXISTE'
   END

END


GO
