USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BDatosRel]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_BDatosRel]
                             ( @rut1      NUMERIC(10),
                               @codigo1   NUMERIC( 3),
       		               @rut2      NUMERIC(10),
			       @codigo2   NUMERIC( 3)                                     
                                    ) 
AS
BEGIN
         SET NOCOUNT ON
         SET DATEFORMAT dmy  
    
     Declare @nombre_hijo       CHAR   (40), 
	     @codigo_fox_padre  NUMERIC( 6),
     	     @codigo_fox_hijo   NUMERIC( 6),
	     @porcentaje        FLOAT
                   
              
      IF EXISTS(SELECT 1 FROM CLIENTE WHERE @rut2 = clrut AND @codigo2=clcodigo)
       BEGIN         
		SELECT @nombre_hijo = clnombre FROM CLIENTE 
	        WHERE @rut2 = clrut 
		AND @codigo2=clcodigo

      		SELECT @codigo_fox_padre = ISNULL(clcodfox,0) 
		FROM CLIENTE 
		WHERE @rut1 = clrut AND @codigo1=clcodigo	
      		
		SELECT @codigo_fox_hijo = ISNULL(clcodfox,0)  
		FROM CLIENTE 
		WHERE @rut2 = clrut AND @codigo2=clcodigo		
      		
		SELECT @porcentaje = ISNULL(clporcentaje,0)   
		FROM CLIENTE_RELACIONADO 
		WHERE @rut1 = clrut_padre 
                AND @codigo1=clcodigo_padre		
		AND @rut2   = clrut_hijo  
 		AND @codigo2=clcodigo_hijo					

	        SELECT	   @porcentaje        ,		          
		           @nombre_hijo       , 
		           @codigo_fox_padre  ,
		           @codigo_fox_hijo   

	END
	ELSE

		SELECT "NO"
                SET NOCOUNT OFF
END








GO
