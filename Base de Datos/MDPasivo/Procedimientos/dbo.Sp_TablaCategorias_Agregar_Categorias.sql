USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaCategorias_Agregar_Categorias]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TablaCategorias_Agregar_Categorias] (
				  	     	     @codigo_cartera   		Char  (01),	
						     @nombre_carterasuper   	varchar(20) 
						   )
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   	IF NOT EXISTS(SELECT codigo_carterasuper, nombre_carterasuper FROM CATEGORIA_CARTERASUPER
		WHERE	codigo_carterasuper	= @codigo_cartera)
  	BEGIN
		INSERT INTO CATEGORIA_CARTERASUPER(codigo_carterasuper,nombre_carterasuper)
		VALUES (@codigo_cartera, @nombre_carterasuper)

	IF @@ERROR <> 0 
	   BEGIN
 
	   	SELECT 'ERROR'

	   END ELSE
	   BEGIN

		SELECT 'OK'

	   END

   END ELSE
   BEGIN
	IF EXISTS(SELECT codigo_carterasuper, nombre_carterasuper FROM CATEGORIA_CARTERASUPER
		WHERE	codigo_carterasuper	= @codigo_cartera)
  	BEGIN
		UPDATE CATEGORIA_CARTERASUPER SET nombre_carterasuper = @nombre_carterasuper 
		WHERE  codigo_carterasuper = @codigo_cartera
	   END ELSE
	   BEGIN

	   	SELECT 'EXISTE'
	end	
	
   END

END

GO
