USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_LOG_AUDITORIA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_LOG_AUDITORIA]
                                   (
            	                     @ENTIDAD                  	CHAR 	 (2)
                                    ,@FECHA_PROCESO            	DATETIME
                                    ,@TERMINAL                 	CHAR	(15)
                                    ,@USUARIO                  	CHAR	(15)
                                    ,@ID_SISTEMA		CHAR 	 (3)		
                                    ,@CODIGO_MENU		CHAR 	(12)
                                    ,@Codigo_EVENTO		VARCHAR (60)
                                    ,@DETALLE_TRANSAC 		VARCHAR(250)
                                    ,@TABLAINVOLUCRADA		VARCHAR (50)	
                                    ,@VALOR_ANTIGUO		VARCHAR(250)
                                    ,@VALOR_NUEVO		VARCHAR(250)
                                   )                 




AS
BEGIN
	SET NOCOUNT ON
	--BEGIN TRANSACTION 

	INSERT INTO LOG_AUDITORIA (	
        	        	     entidad
                		    ,fechaproceso
                	    	    ,fechasistema
                	            ,horaproceso
                    		    ,terminal
                                    ,usuario
                                    ,id_sistema
                  	            ,codigomenu
                  	            ,codigo_evento
                  	            ,detalletransac
                  	            ,tablainvolucrada
                              	    ,valorantiguo
                  	            ,valornuevo
                               )
	
            	VALUES	      (	     @ENTIDAD
                                    ,@FECHA_PROCESO
                                    ,getdate()                             -------- FECHA SISTEMA
                                    ,convert(CHAR(8),getdate(),108)       -------- HORA
                                    ,@TERMINAL
                                    ,@USUARIO
                                    ,@ID_SISTEMA
                                    ,@CODIGO_MENU
                                    ,@Codigo_EVENTO
                                    ,@DETALLE_TRANSAC
                                    ,@TABLAINVOLUCRADA
                                    ,@VALOR_ANTIGUO
                                    ,@VALOR_NUEVO
                              )                 
                                     
    IF @@ERROR <> 0 
        BEGIN
        --ROLLBACK TRANSACTION
	SELECT 'NO'          
	SET NOCOUNT OFF
	RETURN	
    END
                     
    --COMMIT TRANSACTION   
    SELECT 'SI'
    SET NOCOUNT OFF
END
GO
