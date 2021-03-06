USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CREA_USUARIOS_GRABA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CREA_USUARIOS_GRABA] 
			     ( @tipo          CHAR(15)  ,
                               @usuario       CHAR(15) ,
                               @clave         CHAR(15) ,
                               @nombre        CHAR(40) ,
                               @tipo_usuario  CHAR(15) ,
                               @fecha_expira  DATETIME ,
                               @tipo_clave    CHAR(1)  ,
                               @dias_exp      NUMERIC(5),
                               @largo_clave   NUMERIC(2),  
                               @clase         CHAR(2),
			       @reset_psw     CHAR(1),
			       @shortcircuit  NUMERIC(1))
AS
BEGIN

SET NOCOUNT ON

DECLARE 	
	@i	  NUMERIC(2)	,
	@cont     NUMERIC(2)	,
	@char     CHAR(50)	,
	@rango    NUMERIC(3)	,
	@sistema  CHAR(3)	,
        @clave2   CHAR(15)	,
        @clave3   CHAR(15)	,
        @claveAnt CHAR(15)

IF @Tipo = 'B'
   SELECT nombre,
          tipo_usuario,
          CONVERT(CHAR(10), fecha_expira, 103),
          clave
     FROM USUARIO
    WHERE usuario = @usuario

IF @tipo = 'E' OR @tipo = 'G'
BEGIN 
   

                SET @claveAnt  = ISNULL((SELECT clave		FROM USUARIO WHERE usuario = @usuario),@clave)
                SET @clave2    = ISNULL((SELECT clave_anterior2 FROM USUARIO WHERE usuario = @usuario),@clave)
                SET @clave3    = ISNULL((SELECT clave_anterior3 FROM USUARIO WHERE usuario = @usuario),@clave)         

   IF @tipo <>'G' BEGIN      
	DELETE FROM MATRIZ_ATRIBUCION_INSTRUMENTO	WHERE usuario = @usuario 
	DELETE FROM MATRIZ_ATRIBUCION			WHERE usuario = @usuario 
	DELETE FROM USUARIO_ACTIVO			WHERE usuario = @usuario  
	DELETE FROM CONTROL_USUARIO			WHERE usuario = @usuario  
	DELETE USUARIO WHERE usuario = @usuario 

   END ELSE BEGIN

            IF EXISTS(SELECT 1 FROM USUARIO  WHERE usuario = @usuario) BEGIN            
            
                  UPDATE USUARIO SET 
          
                                usuario		= @usuario,
                	        nombre		= @nombre,
                       	 	tipo_usuario	= @tipo_usuario,
                      		fecha_expira	= @fecha_expira,
                        	cambio_clave	= 'S',
                                clave_anterior1 = @clave2,
                                clave_anterior2 = @clave3,
                                clave_anterior3 = @claveAnt,
                	        clave		= @clave,
                                tipo_clave	= @tipo_clave,
                                dias_expiracion = @dias_exp,
                                largo_clave 	= @largo_clave,
                                clase       	= @clase,
				reset_psw   	= @reset_psw,
				short_circuit   = @shortcircuit	

                  WHERE usuario = @usuario

            
            END 
   
      
 
   END   
   IF @@ERROR <> 0
   BEGIN
      PRINT 'ERROR_PROC FALLA BORRANDO USUARIO.'
      RETURN 1
   END     

   IF @tipo = 'E' 
   BEGIN
      DELETE GEN_PRIVILEGIOS WHERE usuario = @usuario --AND tipo_privilegio = 'U'

      IF @@ERROR <> 0
      BEGIN
         PRINT 'ERROR_PROC FALLA BORRANDO PRIVILEGIOS DE USUARIO.'
         RETURN 1
      END
   END

END

IF @Tipo = 'G'
BEGIN 

   ----DELETE FROM Control_Usuario  WHERE Usuario = @Usuario
   DELETE GEN_PRIVILEGIOS WHERE usuario = @usuario AND tipo_privilegio = 'T'

   UPDATE 	gen_privilegios
   SET 		tipo_privilegio = 'U'		,
        	habilitado  = 'N'
   FROM		usuario
   WHERE 	tipo_privilegio = 'T'		   AND		
		usuario.tipo_usuario 	= @Usuario AND
		usuario.usuario    	= gen_privilegios.usuario 

   INSERT INTO GEN_PRIVILEGIOS
   SELECT 'T',@usuario,entidad,opcion,habilitado FROM GEN_PRIVILEGIOS WHERE tipo_privilegio = 'T' AND usuario = @tipo_usuario
 
   SET @i=0   
   SET @cont = (SELECT COUNT(*) FROM SISTEMA_CNT) 
   SET @char = 'PCATESBCCBFWBTRLIMPCSSCF'   
   SET @rango= 3	   

	SET @sistema = RIGHT (RTRIM(@char),@rango)
	SET @sistema = LEFT(LTRIM(@sistema),3)



	IF NOT EXISTS(SELECT 1 FROM control_usuario  WHERE usuario = @usuario AND id_sistema = @sistema ) BEGIN	


            IF NOT EXISTS(SELECT 1 FROM USUARIO  WHERE usuario = @usuario) BEGIN            
            
               		INSERT USUARIO( usuario,
        	        nombre,
                       	 	tipo_usuario,
                      		fecha_expira,
                        	cambio_clave,
                                clave_anterior1,
     				clave_anterior2,
                             	clave_anterior3,
                	        clave,
                                tipo_clave,
                                dias_expiracion,
                                largo_clave,
                                clase,
				reset_psw,
				short_circuit	
                                  )

                	VALUES( @usuario,
                        	@nombre,
                        	@tipo_usuario, --- + LTRIM(STR(@I)),
                        	@fecha_expira,
                        	'S',
                                @clave2,
                                @clave3,
                                @claveAnt,
                        	@clave,
                                @tipo_clave,    
                                @dias_exp,      
                                @largo_clave,   
                                @clase,
				@reset_psw,
				@shortcircuit	
                                 )

                END  

             	INSERT CONTROL_USUARIO            
			      ( usuario,
	                        id_sistema,
	                        nombre,
	                        terminal,
	                        bloqueado
	                        )
	                VALUES( @usuario,
        	                @sistema,
                                @nombre,
	                        '000000',
	                        'N' )
	
	END

		 
   WHILE @i <= @cont  BEGIN           
	
	SET @sistema = RIGHT (RTRIM(@char),@rango)
	SET @sistema = LEFT(LTRIM(@sistema),3)

		
	IF (SELECT operativo FROM SISTEMA_CNT WHERE id_sistema = @sistema) = 'S' BEGIN	
	
	IF NOT EXISTS(SELECT 1 FROM CONTROL_USUARIO  WHERE usuario = @usuario AND id_sistema = @sistema ) BEGIN	

        SELECT @sistema,@i,@cont,@char,@rango,@usuario +LTRIM (STR(@i))

		INSERT CONTROL_USUARIO            
			      ( usuario,
                                id_sistema,
	                        nombre,
                   		terminal,
	                        bloqueado
	                        )
	                VALUES( @usuario, ---RTRIM(@USUARIO) + LTRIM(STR(@I)),
        	                @sistema,
        			@nombre,
	                        '000000',
	                        'N' )
	
	END
	END

		SET @i=@i +1
		SET @rango = @rango + 3
   	
   END   


   IF @@ERROR <> 0
   BEGIN
      PRINT 'ERROR_PROC FALLA AGREGANDO USUARIO.'
      RETURN 1
   END
END

RETURN 0

SET NOCOUNT OFF

END   /* FIN PROCEDIMIENTO */

GO
