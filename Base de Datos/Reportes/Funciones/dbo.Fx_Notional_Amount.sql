USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Notional_Amount]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Fx_Notional_Amount] 
	(  @fecha DATETIME
	  ,@moneda_compra CHAR(3)
	  ,@montoNocional NUMERIC(32,4)
	  ,@moneda_venta CHAR(3)
	  ,@BFW_rate NUMERIC(21,7)
	  ,@C_o_V CHAR(1) 
	)  RETURNS NUMERIC(32,2)	
AS 
BEGIN   
DECLARE @moneda_NatioanalA INT = 0
DECLARE @monedaNocional INT = 0
DECLARE @notionalA NUMERIC(32,2) = 0.00
DECLARE @mnrrda		   CHAR(1) = ''
        
    IF(@C_o_V = 'C')
	   BEGIN
		  /*COMPRA*/
		  IF(@moneda_compra = 'CLP')
			 BEGIN 
    				IF(@moneda_venta = 'USD')
    				    BEGIN
    					   SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    					   SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta    			 
    				    
    					   SET @mnrrda = ISNULL((SELECT m.mnrrda FROM BacParamSuda.dbo.MONEDA m WITH(NOLOCK) WHERE m.mncodmon = @monedaNocional),'')
    		  		    
    		  			   SET @notionalA = (CASE WHEN @mnrrda = 'M' THEN (@montoNocional * @BFW_rate) ELSE (@montoNocional / @BFW_rate) END)  
    				    END
    		   
    				IF(@moneda_venta = 'UF')
    				    BEGIN
    		  			   SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  			   SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta
    		  		    
    		  			   SET @mnrrda = ISNULL((SELECT m.mnrrda FROM BacParamSuda.dbo.MONEDA m WITH(NOLOCK) WHERE m.mncodmon = @monedaNocional),'')
    		  		    
    		  			   SET @notionalA = (CASE WHEN @mnrrda = 'M' THEN (@montoNocional * @BFW_rate) ELSE (@montoNocional / @BFW_rate) END) 
    				    END 
			 END
    
		  IF(@moneda_compra = 'UF')
			 BEGIN
				IF(@moneda_venta = 'CLP')
				    BEGIN
					   SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    					   SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta
    				        				   
    					   IF(@moneda_compra = 'UF')
						  BEGIN	  
							 SET @notionalA = @montoNocional * @BFW_rate
						  END 
				    END
		   	   
				IF(@moneda_venta = 'USD')
				    BEGIN
    					   SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  			   SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta
    		  		    
    		  			   SET @mnrrda = ISNULL((SELECT m.mnrrda FROM BacParamSuda.dbo.MONEDA m WITH(NOLOCK) WHERE m.mncodmon = @monedaNocional),'')
    		  		    
    		  			   SET @notionalA = (CASE WHEN @mnrrda = 'M' THEN (@montoNocional * @BFW_rate) ELSE (@montoNocional / @BFW_rate) END)    	  		  		    	  	
				    END 	 
			 END
    
		  IF(@moneda_compra = 'USD')
			 BEGIN
				IF(@moneda_venta = 'CLP')
				    BEGIN
    					   SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta
    		  			   SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  		    
					   SET @mnrrda = ISNULL((SELECT m.mnrrda FROM BacParamSuda.dbo.MONEDA m WITH(NOLOCK) WHERE m.mncodmon = @monedaNocional),'')
    		  		    
    		  			   SET @notionalA = (CASE WHEN @mnrrda = 'M' THEN (@montoNocional * @BFW_rate) ELSE (@montoNocional / @BFW_rate) END)    		  		 		  	
				    END
	   
				IF(@moneda_venta = 'UF')
				    BEGIN
    					   SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta
    		  			   SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  		    
    		  			   SET @mnrrda = ISNULL((SELECT m.mnrrda FROM BacParamSuda.dbo.MONEDA m WITH(NOLOCK) WHERE m.mncodmon = @monedaNocional),'')
    		  		    
    		  			   SET @notionalA = (CASE WHEN @mnrrda = 'M' THEN (@montoNocional * @BFW_rate) ELSE (@montoNocional / @BFW_rate) END)    		  		 		  	
				    END
	   
				IF(@moneda_venta <> 'CLP' AND @moneda_venta <> 'UF' AND @moneda_venta <> 'USD')
				    BEGIN
    					   SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  			   SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  		    
    		  			   --SET @mnrrda = ISNULL((SELECT m.mnrrda FROM BacParamSuda.dbo.MONEDA m WITH(NOLOCK) WHERE m.mncodmon = @monedaNocional),'')
    		  		    
    		  			   --SET @notionalA = (CASE WHEN @mnrrda = 'M' THEN (@montoNocional * @BFW_rate) ELSE (@montoNocional / @BFW_rate) END)  
    		  		    
    		  			   SELECT @notionalA = BacParamSuda.dbo.fx_convierte_monto(@fecha, @monedaNocional, @montonocional, @moneda_NatioanalA)			  	
				    END
			 END

		  IF(@moneda_compra <> 'USD' AND @moneda_compra <> 'CLP' AND @moneda_compra <> 'UF')
			 BEGIN
				IF(@moneda_venta = 'USD')
				    BEGIN
		  			   SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta
    		  			   SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  		    
    		  			   --SET @mnrrda = ISNULL((SELECT m.mnrrda FROM BacParamSuda.dbo.MONEDA m WITH(NOLOCK) WHERE m.mncodmon = @monedaNocional),'')
    		  		    
    		  			   --SET @notionalA = (CASE WHEN @mnrrda = 'M' THEN (@montoNocional * @BFW_rate) ELSE (@montoNocional / @BFW_rate) END)  
    		  		    
    		  			   SELECT @notionalA = BacParamSuda.dbo.fx_convierte_monto(@fecha, @monedaNocional, @montonocional, @moneda_NatioanalA)	
				    END	
			 END     
		  /*FIN COMPRA*/
	   END
    ELSE IF(@C_o_V = 'V')
	   BEGIN
		  /*VENTA*/
		  IF(@moneda_venta = 'CLP')
			 BEGIN 
    				IF(@moneda_compra = 'USD')
    				    BEGIN
    					   SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta
    					   SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra    			 
    					   --SELECT @notionalA = BacParamSuda.dbo.fx_convierte_monto(@fecha, @monedaNocional, @montonocional, @moneda_NatioanalA)
    				    
    					   --SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    					   --SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta    			 
    				    
    					   SET @mnrrda = ISNULL((SELECT m.mnrrda FROM BacParamSuda.dbo.MONEDA m WITH(NOLOCK) WHERE m.mncodmon = @monedaNocional),'')
    		  		    
    		  			   SET @notionalA = (CASE WHEN @mnrrda = 'M' THEN (@montoNocional * @BFW_rate) ELSE (@montoNocional / @BFW_rate) END)  
    				    END
    		   
    				IF(@moneda_compra = 'UF')
    				    BEGIN
    		  			   SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta
    		  			   SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  			   --SELECT @notionalA = BacParamSuda.dbo.fx_convierte_monto(@fecha, @monedaNocional, @montonocional, @moneda_NatioanalA)
    		  		    
    		  			   --SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  			   --SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta
    		  		    
    		  			   SET @mnrrda = ISNULL((SELECT m.mnrrda FROM BacParamSuda.dbo.MONEDA m WITH(NOLOCK) WHERE m.mncodmon = @monedaNocional),'')
    		  		    
    		  			   SET @notionalA = (CASE WHEN @mnrrda = 'M' THEN (@montoNocional * @BFW_rate) ELSE (@montoNocional / @BFW_rate) END) 
    				    END 
			 END
    
		  IF(@moneda_venta = 'UF')
			 BEGIN
				IF(@moneda_compra = 'CLP')
				    BEGIN
					   SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    					   SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta    			 
    					   --SELECT @notionalA = BacParamSuda.dbo.fx_convierte_monto(@fecha, @monedaNocional, @montonocional, @moneda_NatioanalA)
    				    
    					   --SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    					   --SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta
    				        				   
    					   IF(@moneda_venta = 'UF')
						  BEGIN	  
							 SET @notionalA = @montoNocional * @BFW_rate
						  END 
				    END
		   	   
				IF(@moneda_compra = 'USD')
				    BEGIN
    					   SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta
    		  			   SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  			   --SELECT @notionalA = BacParamSuda.dbo.fx_convierte_monto(@fecha, @monedaNocional, @montonocional, @moneda_NatioanalA)
    		  		    
    		  			   --SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  			   --SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta
    		  		    
    		  			   SET @mnrrda = ISNULL((SELECT m.mnrrda FROM BacParamSuda.dbo.MONEDA m WITH(NOLOCK) WHERE m.mncodmon = @monedaNocional),'')
    		  		    
    		  			   SET @notionalA = (CASE WHEN @mnrrda = 'M' THEN (@montoNocional * @BFW_rate) ELSE (@montoNocional / @BFW_rate) END)        		  		    
    		  		    		  	
				    END 	 
			 END
    
		  IF(@moneda_venta = 'USD')
			 BEGIN
				IF(@moneda_compra = 'CLP')
				    BEGIN
    					   SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  			   SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta
    		  			   --SELECT @notionalA = BacParamSuda.dbo.fx_convierte_monto(@fecha, @monedaNocional, @montonocional, @moneda_NatioanalA)
    		  		    
    		  			   --SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta
    		  			   --SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  		    
					   SET @mnrrda = ISNULL((SELECT m.mnrrda FROM BacParamSuda.dbo.MONEDA m WITH(NOLOCK) WHERE m.mncodmon = @monedaNocional),'')
    		  		    
    		  			   SET @notionalA = (CASE WHEN @mnrrda = 'M' THEN (@montoNocional * @BFW_rate) ELSE (@montoNocional / @BFW_rate) END)   
				    END
	   
				IF(@moneda_compra = 'UF')
				    BEGIN
    					   SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  			   SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta
    		  			   --SELECT @notionalA = BacParamSuda.dbo.fx_convierte_monto(@fecha, @monedaNocional, @montonocional, @moneda_NatioanalA)
    		  		    
    		  			   --SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta
    		  			   --SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  		    
    		  			   SET @mnrrda = ISNULL((SELECT m.mnrrda FROM BacParamSuda.dbo.MONEDA m WITH(NOLOCK) WHERE m.mncodmon = @monedaNocional),'')
    		  		    
    		  			   SET @notionalA = (CASE WHEN @mnrrda = 'M' THEN (@montoNocional * @BFW_rate) ELSE (@montoNocional / @BFW_rate) END)        		  		    		  	
				    END
	   
				IF(@moneda_compra <> 'CLP' AND @moneda_compra <> 'UF' AND @moneda_compra <> 'USD')
				    BEGIN
    					   SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta
    		  			   SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  			   --SELECT @notionalA = BacParamSuda.dbo.fx_convierte_monto(@fecha, @monedaNocional, @montonocional, @moneda_NatioanalA)
    		  		    
    		  			   --SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  			   --SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  		    
    		  			   --SET @mnrrda = ISNULL((SELECT m.mnrrda FROM BacParamSuda.dbo.MONEDA m WITH(NOLOCK) WHERE m.mncodmon = @monedaNocional),'')
    		  		    
    		  			   --SET @notionalA = (CASE WHEN @mnrrda = 'M' THEN (@montoNocional * @BFW_rate) ELSE (@montoNocional / @BFW_rate) END)  
    		  		    
    		  			   SELECT @notionalA = BacParamSuda.dbo.fx_convierte_monto(@fecha, @monedaNocional, @montonocional, @moneda_NatioanalA)			  	
				    END
			 END

		  IF(@moneda_venta <> 'USD' AND @moneda_venta <> 'CLP' AND @moneda_venta <> 'UF')
			 BEGIN
				IF(@moneda_compra = 'USD')
				    BEGIN
		  			   SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  			   SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta
    		  			   --SELECT @notionalA = BacParamSuda.dbo.fx_convierte_monto(@fecha, @monedaNocional, @montonocional, @moneda_NatioanalA)
    		  		    
    		  			   --SELECT @moneda_NatioanalA = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_venta
    		  			   --SELECT @monedaNocional = m.mncodmon FROM BacParamSuda.dbo.MONEDA m WHERE m.mnnemo = @moneda_compra
    		  		    
    		  			   --SET @mnrrda = ISNULL((SELECT m.mnrrda FROM BacParamSuda.dbo.MONEDA m WITH(NOLOCK) WHERE m.mncodmon = @monedaNocional),'')
    		  		    
    		  			   --SET @notionalA = (CASE WHEN @mnrrda = 'M' THEN (@montoNocional * @BFW_rate) ELSE (@montoNocional / @BFW_rate) END)  
    		  		    
    		  			   SELECT @notionalA = BacParamSuda.dbo.fx_convierte_monto(@fecha, @monedaNocional, @montonocional, @moneda_NatioanalA)
				    END	
			 END
		  /*FIN VENTA*/    	
	   END
    
    RETURN @notionalA

END
    
GO
