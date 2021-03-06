USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_MENU_EN_SWICH]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_CARGA_MENU_EN_SWICH]
	(
		@Sistema	CHAR(3)		
	)
AS
BEGIN

SET DATEFORMAT dmy

DECLARE 	@Indice		NUMERIC(3),
	        @Nombre_opcion	CHAR(50),
	        @Nombre_objeto	CHAR(30),
	        @Posicion	NUMERIC(3)

	SET NOCOUNT ON

	IF EXISTS( SELECT * FROM SWICH_OPERATIVO WHERE SISTEMA=@SISTEMA ) BEGIN
		DELETE SWICH_OPERATIVO WHERE SISTEMA=@SISTEMA
	END	

	DECLARE Cursor_Inserta SCROLL CURSOR
	        FOR SELECT Entidad,
	                   Indice,
	                   Nombre_opcion,
	                   Nombre_objeto,
	                   Posicion
	              FROM MENU
		     WHERE Entidad=@Sistema
	             ORDER BY Entidad, Indice

	OPEN Cursor_Inserta
	
	FETCH FIRST FROM Cursor_Inserta
	            INTO @Sistema,
	                 @Indice,
	                 @Nombre_opcion,
	                 @Nombre_objeto,
	                 @Posicion

	WHILE @@FETCH_STATUS = 0
	BEGIN
		
	      INSERT SWICH_OPERATIVO( Sistema ,Codigo_Control ,Valor_Control ,Estado_Control ,Orden ,Orden_Especial )
	               VALUES( @Sistema,
	                       @Nombre_Objeto,
	                       '0',
			       '0',	
	                       0,
	                       0)

	      FETCH NEXT FROM Cursor_Inserta
	            INTO @Sistema,
	                 @Indice,
	                 @Nombre_opcion,
	                 @Nombre_objeto,
	                 @Posicion
		
	END
	
	CLOSE Cursor_Inserta	
	DEALLOCATE Cursor_Inserta

	SET NOCOUNT OFF	

END


GO
