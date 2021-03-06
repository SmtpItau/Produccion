USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_VALOR_DEFECTO_SPT]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TRAE_VALOR_DEFECTO_SPT]	(	
													@COD_PROD		CHAR(10), 
													@COD_AREA		CHAR(10) ,
													@CLIENTE		INT = 0
													)
AS
BEGIN
	SET NOCOUNT ON;

	--DECLARE @CLIENTE INT ;

	DECLARE @PROD_SPOT_INTER	SMALLINT
		SET @PROD_SPOT_INTER	= 4 ;
		 
	DECLARE @PROD_SPOT_EMPRE	SMALLINT
		SET @PROD_SPOT_EMPRE	= 5 ;

	DECLARE @PROD_SPOT_ARBI		SMALLINT
		SET @PROD_SPOT_ARBI		= 6 ;

	DECLARE @PLAT_SPOT_PTAS		SMALLINT
		SET @PLAT_SPOT_PTAS		= 4 ;
		 
	DECLARE @PLAT_SPOT_EMPRE	SMALLINT
		SET @PLAT_SPOT_EMPRE	= 5 ;

	DECLARE @PLAT_SPOT_ARBI		SMALLINT
		SET @PLAT_SPOT_ARBI		= 6 ;

	DECLARE @PLAT_SPOT_OVER		SMALLINT
		SET @PLAT_SPOT_OVER		= 7 ;



	DECLARE @idProducto			SMALLINT 
		SET @idProducto			=	CASE	WHEN @COD_PROD ='ARBI'	THEN @PROD_SPOT_ARBI
											WHEN @COD_PROD ='EMPR'	THEN @PROD_SPOT_EMPRE
											WHEN @COD_PROD ='PTAS'	THEN @PROD_SPOT_INTER
									END ;										


	DECLARE @idPlaforma			SMALLINT 
		SET @idPlaforma			=	CASE	WHEN @COD_AREA='ARBI'	THEN @PLAT_SPOT_ARBI
											WHEN @COD_AREA='EMPR'	THEN @PLAT_SPOT_EMPRE
											WHEN @COD_AREA ='PTAS'	THEN @PLAT_SPOT_PTAS
											WHEN @COD_AREA ='OVER'	THEN @PLAT_SPOT_OVER
		               			 	END;		

	

	DECLARE @idOperacionCompra	SMALLINT 
		SET @idOperacionCompra	=	1;	 


	DECLARE @idOperacionVenta	SMALLINT 
		SET @idOperacionVenta	=	2;	 


	DECLARE @ValSecBacMonitor_CompraMn_Entregamos		NUMERIC(3,0)
	DECLARE	@ValSecBacMonitor_VentaMx_Entregamos		NUMERIC(3,0)
	DECLARE @ValTokioBacMonitor_VentaMx_Entregamos		NUMERIC(3,0)
	DECLARE @ValTokioBacMonitor_CompraMn_Entregamos		NUMERIC(3,0)
	DECLARE @ValTokioBacMonitor_VentaMn_Recibimos		NUMERIC(3,0)
	
	
	DECLARE @id_sistema                 CHAR(3),
	        @codigo_producto            SMALLINT,
	        @codigo_area                SMALLINT,
	        @compra_forma_pagomn        NUMERIC(3,0),
	        @compra_forma_pagomx        NUMERIC(3,0),
	        @compra_codigo_oma          NUMERIC(3,0),
	        @compra_codigo_comercio     VARCHAR(6),
	        @compra_codigo_concepto     VARCHAR(3),
	        @venta_forma_pagomn         NUMERIC(3,0),
	        @venta_forma_pagomx         NUMERIC(3,0),
	        @venta_codigo_oma           NUMERIC(3,0),
	        @venta_codigo_comercio      VARCHAR(6),
	        @venta_codigo_concepto      VARCHAR(3),
	        @contabiliza                CHAR(1),
	        @monto_operacion            NUMERIC(19,4),
	        @codigo_moneda              NUMERIC(5,0),
	        @acuserdata                 CHAR(15),
	        @acuserbols                 CHAR(15),
	        @accoscomp                  NUMERIC(19, 4),
	        @accosvent                  NUMERIC(19, 4),
	        @Corres_Compra              NUMERIC(10,0),
	        @Corres_Venta               NUMERIC(10,0),
	        @BacMonitor_CompraMn_Entregamos NUMERIC,
	        @BacMonitor_CompraMx_Recibimos NUMERIC,
	        @BacMonitor_VentaMx_Entregamos NUMERIC,
	        @BacMonitor_VentaMn_Recibimos NUMERIC

	/* ========================================================================================================================================================================================== */ 
	-- Resultados para salida y mantener otros sistems 
	DECLARE @ValTokioBacMonitor_CompraMx_Recibimos		NUMERIC(3,0)
		SET @ValTokioBacMonitor_CompraMx_Recibimos = (		
														SELECT default_iFormaPagoMX
														  FROM bacparamsuda..CargaOperaciones_DefectoValores 
														 WHERE idcliente = 59002220 
														   AND idOperacion = @idOperacionCompra
														   AND idProducto  = @idProducto
														   AND idPlataforma= @idPlaforma 
														   
													 )		
		   
	DECLARE @ValTokioBacMonitor_VentaMx_Recibimos		NUMERIC(3,0)
		SET @ValTokioBacMonitor_VentaMx_Recibimos = (		
														SELECT default_iFormaPagoMX
														  FROM bacparamsuda..CargaOperaciones_DefectoValores 
														 WHERE idcliente = 59002220
														   AND idOperacion = @idOperacionVenta
														   AND idProducto  = @idProducto
														   AND idPlataforma= @idPlaforma 
														   
													 )		


	DECLARE @ValSecBacMonitor_CompraMx_Recibimos		NUMERIC(3,0)
		SET @ValSecBacMonitor_CompraMx_Recibimos = (		
														SELECT default_iFormaPagoMX
														  FROM bacparamsuda..CargaOperaciones_DefectoValores 
														 WHERE idcliente = 96515580 
														   AND idOperacion = @idOperacionCompra
														   AND idProducto  = @idProducto
														   AND idPlataforma= @idPlaforma 
														   
													 )		
		   
	DECLARE @ValSecBacMonitor_VentaMx_Recibimos		NUMERIC(3,0)
		SET @ValSecBacMonitor_VentaMx_Recibimos = (		
														SELECT default_iFormaPagoMX
														  FROM bacparamsuda..CargaOperaciones_DefectoValores 
														 WHERE idcliente = 96515580 
														   AND idOperacion = @idOperacionVenta
														   AND idProducto  = @idProducto
														   AND idPlataforma= @idPlaforma 
														   
													 )		

	DECLARE @ValSecBacMonitor_CompraMn_Recibimos		NUMERIC(3,0)
		SET @ValSecBacMonitor_CompraMn_Recibimos = (		
														SELECT default_iFormaPagoMN
														  FROM bacparamsuda..CargaOperaciones_DefectoValores 
														 WHERE idcliente = 96515580
														   AND idOperacion = @idOperacionCompra
														   AND idProducto  = @idProducto
														   AND idPlataforma= @idPlaforma 
														   
													 )		
		   
	DECLARE @ValSecBacMonitor_VentaMn_Recibimos		NUMERIC(3,0)
		SET @ValSecBacMonitor_VentaMn_Recibimos = (		
														SELECT default_iFormaPagoMN
														  FROM bacparamsuda..CargaOperaciones_DefectoValores 
														 WHERE idcliente = 96515580 
														   AND idOperacion = @idOperacionVenta
														   AND idProducto  = @idProducto
														   AND idPlataforma= @idPlaforma 
													   
													 )		

													 
	/* ========================================================================================================================================================================================== */ 
	
	DECLARE @iRut	INT  
	
	SELECT	@id_sistema		= 'BCC',
			@acuserdata     = acuserdata,
			@acuserbols     = acuserbols,
			@accoscomp      = accoscomp,
			@accosvent      = accosvent
	  FROM baccamsuda.dbo.MEAC
	
	
	SET @contabiliza						= 'S'
	SET @monto_operacion					= 0.0
	SET @BacMonitor_CompraMn_Entregamos		= 129
	SET @BacMonitor_CompraMx_Recibimos		= 012
	SET @BacMonitor_VentaMx_Entregamos		= 012
	SET @BacMonitor_VentaMn_Recibimos		= 129
	

	SET @iRut = 0 ;
	
	IF EXISTS(SELECT 1   
			    FROM bacparamsuda.dbo.CargaOperaciones_DefectoValores codv 
	           WHERE codv.idProducto	= @idProducto
				 AND codv.idPlataforma	= @idPlaforma 
				 AND codv.idCliente		=  @CLIENTE
			 )
					SET @iRut = @CLIENTE ; 


	
	SELECT	@venta_forma_pagomn        = Default_iFormaPagoMN,
			@venta_forma_pagomx        = Default_iFormaPagoMX,
			@venta_codigo_oma          = Default_sCodigoOMA,
			@venta_codigo_comercio     = Default_sCodigoComercio,
			@venta_codigo_concepto     = Default_sCodigoConcepto,
			@codigo_moneda             = idMoneda1,
			@Corres_Venta              = Default_iCodCorresponsal
	   FROM bacparamsuda.dbo.CargaOperaciones_DefectoValores  codv
      WHERE codv.idProducto		= @idProducto
	    AND codv.idPlataforma	= @idPlaforma 
	    AND codv.idCliente		= @iRut
	    AND codv.idOperacion	= @idOperacionVenta	
	


	SELECT	@compra_forma_pagomn        = Default_iFormaPagoMN,
			@compra_forma_pagomx        = Default_iFormaPagoMX,
			@compra_codigo_oma          = Default_sCodigoOMA,
			@compra_codigo_comercio     = Default_sCodigoComercio,
			@compra_codigo_concepto     = Default_sCodigoConcepto,
			@codigo_moneda             = idMoneda1,
				@Corres_compra              = Default_iCodCorresponsal
		   FROM bacparamsuda..CargaOperaciones_DefectoValores codv
		  WHERE codv.idProducto		= @idProducto
			AND codv.idPlataforma	= @idPlaforma 
			AND codv.idCliente		= @iRut
			AND codv.idOperacion	= @idOperacionCompra

CREATE TABLE #TEST_VD
		( id_sistema				CHAR(3)
	       ,codigo_producto			CHAR(4)
	       ,codigo_area				char(4)		
	       ,compra_forma_pagomn		NUMERIC(3,0)
	       ,compra_forma_pagomx		NUMERIC(3,0)
	       ,compra_codigo_oma		NUMERIC(3,0)
	       ,compra_codigo_comercio  char(5)
	       ,compra_codigo_concepto	char(5)
	       ,venta_forma_pagomn		NUMERIC(3,0)
	       ,venta_forma_pagomx	    NUMERIC(3,0)
	       ,venta_codigo_oma		NUMERIC(3,0)
	       ,venta_codigo_comercio	CHAR(3)
	       ,venta_codigo_concepto	CHAR(3)
	       ,contabiliza				CHAR(1)
	       ,monto_operacion			NUMERIC(19,4)
	       ,codigo_moneda			NUMERIC(3,0)
	       ,acuserdata				CHAR(15)
	       ,acuserbols				CHAR(15)
	       ,accoscomp				NUMERIC(19,4)
	       ,accosvent				NUMERIC(19,4)
	       ,Corres_Compra			NUMERIC(10,0)
	       ,Corres_Venta			NUMERIC(10,0)
	       ,BacMonitor_CompraMn_Entregamos	int
	       ,BacMonitor_CompraMx_Recibimos	int
	       ,BacMonitor_VentaMx_Entregamos	int
	       ,BacMonitor_VentaMn_Recibimos	int
	       
	       ,ValSecBacMonitor_CompraMn_Entregamos	NUMERIC(3,0)
	       ,ValSecBacMonitor_CompraMx_Recibimos		NUMERIC(3,0)
	       ,ValSecBacMonitor_VentaMx_Entregamos		NUMERIC(3,0)
	       ,ValSecBacMonitor_VentaMn_Recibimos		NUMERIC(3,0)
	       
	       ,ValTokioBacMonitor_CompraMn_Entregamos	int 		
	       ,ValTokioBacMonitor_CompraMx_Recibimos  NUMERIC(3,0)	
	       ,ValTokioBacMonitor_VentaMx_Entregamos	NUMERIC(3,0)
	       ,ValTokioBacMonitor_VentaMn_Recibimos 	int			
	       )
		    

	INSERT INTO #TEST_VD
	(
		id_sistema,
		codigo_producto,
		codigo_area,
		compra_forma_pagomn,
		compra_forma_pagomx,
		compra_codigo_oma,
		compra_codigo_comercio,
		compra_codigo_concepto,
		venta_forma_pagomn,
		venta_forma_pagomx,
		venta_codigo_oma,
		venta_codigo_comercio,
		venta_codigo_concepto,
		contabiliza,
		monto_operacion,
		codigo_moneda,
		acuserdata,
		acuserbols,
		accoscomp,
		accosvent,
		Corres_Compra,
		Corres_Venta,
		BacMonitor_CompraMn_Entregamos,
		BacMonitor_CompraMx_Recibimos,
		BacMonitor_VentaMx_Entregamos,
		BacMonitor_VentaMn_Recibimos,
		ValSecBacMonitor_CompraMn_Entregamos,
		ValSecBacMonitor_CompraMx_Recibimos,
		ValSecBacMonitor_VentaMx_Entregamos,
		ValSecBacMonitor_VentaMn_Recibimos,
		ValTokioBacMonitor_CompraMn_Entregamos,
		ValTokioBacMonitor_CompraMx_Recibimos,
		ValTokioBacMonitor_VentaMx_Entregamos,
		ValTokioBacMonitor_VentaMn_Recibimos
	)
	
	SELECT  id_sistema='BCC'															--  1 
	       ,codigo_producto=@COD_PROD															--  2
	       ,codigo_area=@COD_AREA																--  3	
	       ,compra_forma_pagomn=CONVERT(NUMERIC(3,0), ISNULL(@compra_forma_pagomn,0))			--  4
	       ,compra_forma_pagomx=CONVERT(NUMERIC(3,0), ISNULL(@compra_forma_pagomx,0))			--  5
	       ,compra_codigo_oma=CONVERT(NUMERIC(3,0),ISNULL(@compra_codigo_oma,0))				--  6
	       ,compra_codigo_comercio=isnull(@compra_codigo_comercio,'')							--  7
	       ,compra_codigo_concepto=isnull(@compra_codigo_concepto,'')							--  8 
	       ,venta_forma_pagomn=CONVERT(NUMERIC(3,0),ISNULL(@venta_forma_pagomn ,0))				--  9	
	       ,venta_forma_pagomx=CONVERT(NUMERIC(3,0),ISNULL(@venta_forma_pagomx ,0))				-- 10
	       ,venta_codigo_oma=CONVERT(NUMERIC(3,0),ISNULL(@venta_codigo_oma,0))					-- 11
	       ,venta_codigo_comercio=ISNULL(@venta_codigo_comercio,'')								-- 12
	       ,venta_codigo_concepto=ISNULL(@venta_codigo_concepto ,'')							-- 13
	       ,contabiliza = CONVERT(CHAR(1),'S')																	-- 14
	       ,monto_operacion  =CONVERT(NUMERIC(19,4),0)											-- 15 
	       ,codigo_moneda  =convert(numeric(3,0),13)																	-- 16
	       ,acuserdata=@acuserdata																-- 17
	       ,acuserbols=@acuserbols																-- 18 
	       ,accoscomp=@accoscomp																-- 19 
	       ,accosvent=@accosvent																-- 20 
	       ,Corres_Compra=CONVERT(NUMERIC(10,0),ISNULL(@Corres_Compra,0))						-- 21 
	       ,Corres_Venta=CONVERT(NUMERIC(10,0),ISNULL(@Corres_Venta ,0))						-- 22
	       
	       ------- N O   C A M B I A R  -------
	       ,BacMonitor_CompraMn_Entregamos = CONVERT(int,ISNULL(@BacMonitor_CompraMn_Entregamos,0))			-- 23
	       ,BacMonitor_CompraMx_Recibimos = CONVERT(int,ISNULL(@BacMonitor_CompraMx_Recibimos ,0))			-- 24
	       ,BacMonitor_VentaMx_Entregamos = CONVERT(int,ISNULL(@BacMonitor_VentaMx_Entregamos,0))			-- 25
	       ,BacMonitor_VentaMn_Recibimos = CONVERT(int,ISNULL(@BacMonitor_VentaMn_Recibimos,0))			-- 26
	       
	       ,ValSecBacMonitor_CompraMn_Entregamos = CONVERT(NUMERIC(3,0),ISNULL(@ValSecBacMonitor_CompraMn_Recibimos,0))	-- 27
	       ,ValSecBacMonitor_CompraMx_Recibimos = CONVERT(NUMERIC(3,0),ISNULL(@ValSecBacMonitor_CompraMx_Recibimos ,0))	-- 28
	       ,ValSecBacMonitor_VentaMx_Entregamos = CONVERT(NUMERIC(3,0),ISNULL(@ValSecBacMonitor_VentaMx_Recibimos  ,0))	-- 29
	       ,ValSecBacMonitor_VentaMn_Recibimos =  CONVERT(NUMERIC(3,0),ISNULL(@ValSecBacMonitor_VentaMn_Recibimos  ,0))	-- 30
	       
	       ,ValTokioBacMonitor_CompraMn_Entregamos =CONVERT(int, 129) 											-- 31
	       ,ValTokioBacMonitor_CompraMx_Recibimos = CONVERT(NUMERIC(3,0),ISNULL(@ValTokioBacMonitor_CompraMx_Recibimos,0))	-- 32
	       ,ValTokioBacMonitor_VentaMx_Entregamos = CONVERT(NUMERIC(3,0),ISNULL(@ValTokioBacMonitor_VentaMx_Recibimos,0))		-- 33
	       ,ValTokioBacMonitor_VentaMn_Recibimos = CONVERT(int,129)													-- 34 
	       
	
	SELECT * FROM  #TEST_VD tv
   
   SET NOCOUNT OFF

END

GO
