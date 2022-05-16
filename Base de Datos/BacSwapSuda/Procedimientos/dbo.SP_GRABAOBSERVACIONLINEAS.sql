USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAOBSERVACIONLINEAS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABAOBSERVACIONLINEAS]( @numoper   NUMERIC(10) ,    
         @Mensaje_lin  CHAR(255) ,  
	 @Mensaje_lim 	CHAR(255)	,
	 @Error_LCR		CHAR(255) = ''	
       )  
AS  
BEGIN  
  
 SET NOCOUNT ON  
 DECLARE @cadena  CHAR(2) ,  
  @cadena1 CHAR(1)   
  
 SELECT  @cadena = ( CHAR(13) + CHAR(10) )  
 SELECT  @cadena1 = CHAR(1)    
  
 --SELECT @Mensaje_lin   
 --SELECT @Mensaje_lim   
  
  SELECT @Mensaje_lin = REPLACE( @Mensaje_lin , @cadena , ' ' ) --@cadena1 )     
  SELECT @Mensaje_lim = REPLACE( @Mensaje_lim , @cadena , ' ' ) --@cadena1 )     
  SELECT @Mensaje_lin = REPLACE( @Mensaje_lin , CHAR(13), '' )     
  SELECT @Mensaje_lim = REPLACE( @Mensaje_lim , CHAR(13), '' )     
  SELECT @Mensaje_lin = REPLACE( @Mensaje_lin , CHAR(10), '' )     
  SELECT @Mensaje_lim = REPLACE( @Mensaje_lim , CHAR(10), '' )     
  
 --SELECT @Mensaje_lin   
 --SELECT @Mensaje_lim   
	DECLARE @MensajeGeneral CHAR(1000)
	SET @MensajeGeneral = @Mensaje_lin
  
 UPDATE cartera  
 SET observacion_lineas  = @Mensaje_lin ,  
  observacion_limites = @Mensaje_lim   
 WHERE @numoper = numero_operacion  
  
	IF @Error_LCR <> ''
	BEGIN
		SET @MensajeGeneral =rtrim(ltrim(@MensajeGeneral)) + ' '+  rtrim(ltrim(@Error_LCR))	
				
		IF  Len(@MensajeGeneral)> 255
			BEGIN	
			SET @Error_LCR =''				
			SET @Error_LCR = 'Error en Calculo REC.'	
			SET @MensajeGeneral = 'Error en Calculo REC.' +  substring(rtrim(ltrim(@MensajeGeneral)),1, 255 - len( @Error_LCR ) - 1 ) 		
		END 
		
		UPDATE	cartera
		SET	observacion_lineas  = @MensajeGeneral--rtrim(ltrim(observacion_lineas)) + ' '+  rtrim(ltrim(@Error_LCR))
		WHERE	@numoper = numero_operacion
	
	END 
	
 SET NOCOUNT OFF  
  
END  
GO
