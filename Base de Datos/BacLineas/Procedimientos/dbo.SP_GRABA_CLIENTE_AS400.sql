USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_CLIENTE_AS400]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABA_CLIENTE_AS400] ( @nClRut     NUMERIC ( 9 ) ,--Rut Cliente
                                          @cClDv      CHAR    (   1 ) ,--Digito Verificador Cliente  
                                          @cClNombre   CHAR    ( 70 ) ,--Nombre
                                          @cClDirecc  CHAR    (  40 ) )--Dirección

                                    			
AS
BEGIN 

     	SET NOCOUNT ON

	PRINT  'AGREGUE UNO NUEVO'
	INSERT  cliente    ( 
		    clrut    ,
                    cldv     ,	        
                    clnombre  ,	        
                    cldirecc ,
		    clcodigo)               
   	VALUES    ( @nClRut     ,
	            @cClDv      ,        
	            @cClNombre   ,
              	    @cClDirecc  ,
		    1		)

	IF @@error <>  0 
 	   SELECT -1, ' Problemas al Grabar Cliente '

     	SET NOCOUNT OFF

END
--==========================================
GO
