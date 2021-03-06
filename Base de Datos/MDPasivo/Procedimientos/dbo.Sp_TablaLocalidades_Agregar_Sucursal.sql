USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Agregar_Sucursal]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Agregar_Sucursal] (
				  	     	     @codigo_Sucursal   varchar(5),	
						     @nombre   varchar(50) 
						   )
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

   	IF NOT EXISTS(SELECT codigo_sucursal, nombre FROM SUCURSAL
		WHERE	codigo_sucursal	= @codigo_sucursal)
  	BEGIN
		INSERT INTO SUCURSAL(codigo_sucursal,nombre)
		VALUES (@codigo_sucursal, @nombre)

	IF @@ERROR <> 0 
	   BEGIN
 
	   	SELECT 'ERROR'

	   END ELSE
	   BEGIN

		SELECT 'OK'

	   END

   END ELSE
   BEGIN
	IF EXISTS(SELECT codigo_sucursal, nombre FROM SUCURSAL
		WHERE	codigo_sucursal	= @codigo_sucursal)
  	BEGIN
		UPDATE SUCURSAL SET nombre = @nombre where  codigo_sucursal = @codigo_sucursal
	   END ELSE
	   BEGIN

	   	SELECT 'EXISTE'
	end	
	
   END

END


GO
