USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaEmisores_Agregar_Emisores]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TablaEmisores_Agregar_Emisores] (
				  	     	     @codigo_emisor   CHAR (03),	
						     @Descripcion     VARCHAR(50), 
                                                     @glosa           VARCHAR(15)
						   )
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   	IF NOT EXISTS(SELECT codigo_tipo, descripcion, glosa FROM TIPO_EMISOR
		WHERE	codigo_tipo	= @codigo_emisor)
  	BEGIN

		INSERT INTO TIPO_EMISOR(codigo_tipo,descripcion, glosa)
		VALUES (@codigo_emisor, @descripcion,@glosa)

	IF @@ERROR <> 0 
	   BEGIN
 
	   	SELECT 'ERROR'

	   END ELSE BEGIN

		SELECT 'OK'

	   END

   END ELSE BEGIN

	IF EXISTS(SELECT codigo_tipo, descripcion,glosa FROM TIPO_EMISOR
		WHERE	codigo_tipo	= @codigo_emisor)
  	BEGIN

		UPDATE TIPO_EMISOR SET descripcion = @descripcion, glosa=@glosa where  codigo_tipo = @codigo_emisor

	END ELSE BEGIN

		SELECT 'EXISTE'
	end	
	
   END

END


GO
