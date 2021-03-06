USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Control_Bloq_Usuarios_Activar]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[Sp_Control_Bloq_Usuarios_Activar](
							@usuario	Char(15),
							@id_sistema	Char(3),
							@fechaproceso	DateTime,
							@fechasistema	DateTime)
							
AS
BEGIN

	DECLARE 
			@nombre		 CHAR(50),	
			@terminal	 CHAR(6),
			@cont		 NUMERIC(2), 
			@tmp		 CHAR(6),
			@tmp2		 CHAR(6),
			@nombre_us	 CHAR(50)	

	SET DATEFORMAT DMY
	SET NOCOUNT ON



  		SET @tmp='111111'			
		SET @tmp2='100000'			
		SET @cont= (SELECT COUNT(*) FROM USUARIO_ACTIVO WHERE usuario = @usuario) +1
		
		
		SET @terminal = RIGHT(@tmp2,6)
		SET @terminal= RIGHT(@tmp,@cont) + @terminal		

		SET @cont = 1		

CAMBIO_TERMINAL:
		
	 
     IF @CONT < 7 BEGIN 

		IF EXISTS (SELECT 1 FROM USUARIO_ACTIVO WHERE usuario = @usuario AND terminal = @cont) BEGIN

			SET @cont = @cont +1		
			GOTO CAMBIO_TERMINAL
				
		END

		IF EXISTS(SELECT 1 FROM USUARIO WHERE usuario = @usuario) BEGIN	
	
			SET @nombre_us = (SELECT nombre FROM USUARIO WHERE usuario=@usuario)

		END 
		ELSE BEGIN

			SET @nombre_us = (SELECT nombre FROM USUARIO WHERE usuario= LEFT(@usuario,LEN(@usuario)))

		END

		INSERT INTO USUARIO_ACTIVO (
				usuario,
				id_sistema,
				terminal,
				fechaproceso,
				fechasistema
				)
			VALUES (
				@usuario,
				@id_sistema,
				@cont,
				@fechaproceso,
				@fechasistema
				)

		SELECT @cont,@usuario		

		IF @@ERROR <> 0 BEGIN

			SELECT "ERROR"
		
		END
	

    END
    ELSE BEGIN

		SELECT "LLENO","LLENO"

    END	
	
	SET NOCOUNT OFF

END






GO
