USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_POS_TICKET_SPOT]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GET_POS_TICKET_SPOT]
       (
         @Fecha DateTime,
         @CodMesa Smallint,
         @CodMoneda Smallint
       )
AS
BEGIN
	

		IF @CodMesa = -1 
		BEGIN
		
		    IF NOT EXISTS (SELECT * FROM tbl_posTicketSpot
	           	   WHERE  Fecha_Posicion =  @Fecha
		            AND   CodMoneda = @CodMoneda)
	        	   
	            BEGIN
	      
				 SELECT 'Saldo Inicial'= 0                            
					   ,'Compras' = 0                         
					   ,'Ventas' = 0                     
					   ,'Saldo Actual' = 0
					   ,'PmP Inicial'= 0                         
					   ,'PmP Compras' = 0                         
					   ,'PmP Ventas' = 0                       
					   ,'PmP Actual' = 0	   
		    END
		    ELSE
		    BEGIN



					   DECLARE @COMPRAS FLOAT
					   DECLARE @VENTAS  FLOAT
					   DECLARE @PMPCOMPRAS FLOAT
					   DECLARE @PMPVENTAS  FLOAT
					   DECLARE @PMPFIN FLOAT
					 
					   SET @COMPRAS = 0
					   SET @VENTAS  = 0
					   SET @PMPCOMPRAS = 0
					   SET @PMPVENTAS  = 0
					   SET @PMPFIN = 0

					   SELECT @COMPRAS = SUM(MontoMoneda1) + @COMPRAS
						 FROM Tbl_movTicketSpot
						WHERE Fecha_Operacion = @Fecha
						  AND codmoneda1      = @CodMoneda
						  AND Tipo_Operacion  = 'C'
						  AND   Estado_Operacion = 'V'

					   SELECT @VENTAS = SUM(MontoMoneda1)
						 FROM Tbl_movTicketSpot
						WHERE Fecha_Operacion = @Fecha
						  AND codmoneda1      = @CodMoneda
						  AND Tipo_Operacion  = 'V'
						  AND   Estado_Operacion = 'V'

					   SELECT @PMPCOMPRAS = SUM(MontoMoneda1 * TipoCambio)
					   FROM Tbl_movTicketSpot
					   WHERE Fecha_Operacion = @Fecha
						  AND codmoneda1      = @CodMoneda
						  AND Tipo_Operacion  = 'C'
						  AND   Estado_Operacion = 'V'

					  SET @PMPCOMPRAS = @PMPCOMPRAS / @COMPRAS

					   SELECT @PMPVENTAS = SUM(MontoMoneda1 * TipoCambio)
					   FROM Tbl_movTicketSpot
					   WHERE Fecha_Operacion = @Fecha
						  AND codmoneda1      = @CodMoneda
						  AND Tipo_Operacion  = 'V'
						  AND   Estado_Operacion = 'V'

					   SET @PMPVENTAS = @PMPVENTAS / @VENTAS
					   

					   SET @COMPRAS = ISNULL( @COMPRAS, 0 )
					   SET @VENTAS  = ISNULL(  @VENTAS, 0 )
					   SET @PMPCOMPRAS = ISNULL(@PMPCOMPRAS , 0)
					   SET @PMPVENTAS = ISNULL(@PMPVENTAS, 0)


					SELECT 'Saldo Inicial'= SUM(Posicion_Anterior)                            
						   ,'Compras' = SUM(Compras_Dia)                         
						   ,'Ventas' = SUM(Ventas_Dia)                       
						   ,'Saldo Actual' = SUM(Posicion_Actual)
						   ,'PmP Inicial'= ''                           
						   ,'PmP Compras' = @PMPCOMPRAS                         
						   ,'PmP Ventas' = @PMPVENTAS                       
						   ,'PmP Actual' = ((@COMPRAS * @PMPCOMPRAS)   +  (@VENTAS * @PMPVENTAS) )/ (@COMPRAS + @VENTAS)
						   FROM tbl_posticketspot
						   WHERE Fecha_Posicion = @Fecha AND CodMoneda = @CodMoneda 
			END	   


		END
		ELSE
		BEGIN

                IF NOT EXISTS (SELECT * FROM tbl_posTicketSpot
	           	   WHERE  Fecha_Posicion =  @Fecha
		            AND   CodMoneda = @CodMoneda
	        	    AND   CodMesa = @CodMesa)
	            BEGIN
	      
				 SELECT 'Saldo Inicial'= 0                            
					   ,'Compras' = 0                         
					   ,'Ventas' = 0                     
					   ,'Saldo Actual' = 0
					   ,'PmP Inicial'= 0                         
					   ,'PmP Compras' = 0                         
					   ,'PmP Ventas' = 0                       
					   ,'PmP Actual' = 0	   
				END
				ELSE
				BEGIN
				


					SELECT 'Saldo Inicial'= Posicion_Anterior                            
						   ,'Compras' = Compras_Dia                         
						   ,'Ventas' = Ventas_Dia                       
						   ,'Saldo Actual' = Posicion_Actual
						   ,'PmP Inicial'= pmpInc                     
						   ,'PmP Compras' = pmpCmps                         
						   ,'PmP Ventas' = pmpVnts                       
						   ,'PmP Actual' = pmpFin   
					FROM tbl_posticketspot
					WHERE Fecha_Posicion = @Fecha AND  CodMoneda = @CodMoneda AND CodMesa = @CodMesa 
				END	
		END	

END

GO
