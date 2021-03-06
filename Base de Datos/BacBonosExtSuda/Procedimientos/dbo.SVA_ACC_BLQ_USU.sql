USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_ACC_BLQ_USU]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_ACC_BLQ_USU]
(
				  @usuario	Char(10) ,
				  @id_sistema	Char(3)  ,
				  @fechaproceso	DateTime ,
				  @fechasistema	DateTime 
)							
AS
BEGIN

	DECLARE 
			@nombre		 CHAR(50),	
			@terminal	 CHAR(6),
			@cont		 NUMERIC(2), 
			@tmp		 CHAR(6),
			@tmp2		 CHAR(6),
			@nombre_us	 CHAR(50)	

	SET NOCOUNT ON


  		SET @tmp='111111'			
		SET @tmp2='100000'			
		--SET @cont= (SELECT COUNT(*) FROM tbtr_usr_atv WHERE usuario = @usuario) +1
		SET @cont= (SELECT COUNT(*) FROM VIEW_USUARIO_ACTIVO WHERE usuario = @usuario) +1
		
		SET @terminal = RIGHT(@tmp2,6)
		SET @terminal= RIGHT(@tmp,@cont) + @terminal		

		SET @cont = 1		

CAMBIO_TERMINAL:
		
	 
--     IF @CONT < 7 BEGIN 

     IF @cont < 15 BEGIN 

		--IF EXISTS (SELECT 1 FROM tbtr_usr_atv WHERE usuario = @usuario AND terminal = @cont) BEGIN
                IF EXISTS (SELECT 1 FROM VIEW_USUARIO_ACTIVO WHERE usuario = @usuario AND terminal = @cont) BEGIN
			SET @cont = @cont +1		
			GOTO CAMBIO_TERMINAL
				
		END

		IF EXISTS(SELECT 1 FROM VIEW_USUARIO WHERE usuario = @usuario) BEGIN	
	
			SET @nombre_us = (SELECT nombre FROM VIEW_USUARIO WHERE usuario=@usuario)

		END 
		ELSE BEGIN

			SET @nombre_us = (SELECT nombre FROM VIEW_USUARIO WHERE usuario= LEFT(@usuario,LEN(@usuario)))

		END

		INSERT INTO VIEW_USUARIO_ACTIVO (
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

			SELECT 'ERROR'
		
		END
	

    END
    ELSE BEGIN

		SELECT 'LLENO','LLENO'

    END	
	
	SET NOCOUNT OFF

END

--- Sva_Acc_blq_usu 'ADMINISTRA','BTR'

GO
