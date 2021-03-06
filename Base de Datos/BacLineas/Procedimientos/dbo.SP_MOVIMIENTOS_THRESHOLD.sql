USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_MOVIMIENTOS_THRESHOLD]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MOVIMIENTOS_THRESHOLD] 
	(	@idsistema	CHAR(3)         = ''
	,	@nproducto	CHAR(5)         = ''
	,	@dfecha		DATETIME     	= ''	
	,	@rutcliente	NUMERIC(9) 	= 0
	,	@codcliente	NUMERIC(9) 	= 0
	,	@coperador 	VARCHAR(50)     = ''
	)
AS
BEGIN

	--> Si la Fecha es =  a la fecha de proceso se busca en MOVIMIENTO
	--> Si NO en tabla Movimiento historico
	--> Forward 	:	MFMO o MFMOH 			Campo : Mofecha 	(cafecha)
	--> Swap	:	MovDiario o MovHistorico	Campo : fecha_cierre	(fecha_cierre)

	SET NOCOUNT ON

	DECLARE @dFechaEmision	CHAR(10)
	    SET @dFechaEmision  = CONVERT(CHAR(10), GETDATE(), 103)

	DECLARE @HoraEmision	CHAR(10)
	    SET @HoraEmision	= CONVERT(CHAR(10), GETDATE(), 108)

	DECLARE @FecProceso 	CHAR(10)
	    SET @FecProceso 	= (SELECT CONVERT(CHAR(10), acfecproc, 103) FROM BacFwdSuda..MFAC with(nolock))

        CREATE TABLE #TMP_RETORNO_MOVIMIENTO

         (   /*01*/ operador         VARCHAR(15)
         ,   /*02*/ sistema          CHAR(3)
         ,   /*03*/ producto         VARCHAR(50)
         ,   /*04*/ rutcliente       NUMERIC(10)
         ,   /*05*/ nombre           VARCHAR(50)
         ,   /*06*/ numcontrato      INTEGER
         ,   /*07*/ bloqueado        VARCHAR(12)
         ,   /*08*/ motbloque        VARCHAR(2000)
         ,   /*09*/ desc_prod        VARCHAR(50)
         ,   /*10*/ tipo_oper        VARCHAR(6)
         ,   /*11*/ fecha            CHAR(10)
         ,   /*12*/ fec_vcto         CHAR(10) 
         ,   /*13*/ pzores           NUMERIC(9)
         ,   /*14*/ camtomon1        NUMERIC(21,4)
         ,   /*15*/ catipcam         NUMERIC(21,4)
         ,   /*16*/ nmtm             NUMERIC(21,4)
         ,   /*17*/ mtothreshold     FLOAT
         ,   /*18*/ excesos          FLOAT
         ,   /*19*/ garantiatotal    NUMERIC(14)
         ,   /*20*/ fecemision       CHAR(10)
         ,   /*21*/ fecproceso       CHAR(10)
         ,   /*22*/ horaemision      CHAR(10)
         )

        CREATE INDEX #Ix_TMP_RETORNO_MOV ON #TMP_RETORNO_MOVIMIENTO (RutCliente, Nombre, Sistema, Producto)

	IF @IdSistema = 'BFW' OR @IdSistema =''
	BEGIN
		SELECT @nProducto = CAST(@nProducto AS INTEGER)
       
		INSERT INTO #TMP_RETORNO_MOVIMIENTO
		SELECT /*01*/'operador' 	= @cOperador
		,      /*02*/'sistema'		= prod.id_sistema
		,      /*03*/'productoA'	= substring(prod.descripcion,1,25)
		,      /*04*/'RutCliente'	= cli.clrut
		,      /*05*/'Nombre'		= substring(cli.clnombre,1, 50)
		,      /*06*/'NumContrato'	= mfca.canumoper
		,      /*07*/'Bloqueado' 	= CASE WHEN LTRIM(RTRIM(lingral.bloqueado))='' THEN 'DESBLOQUEADO' ELSE 'BLOQUEADO' END
		,      /*08*/'motivoBloq'	= cli.motivo_bloqueo
		,      /*09*/'Descripcion'	= prod.descripcion
		,      /*10*/'CaTipOper' 	= CASE WHEN mfca.catipoper = 'C' THEN 'COMPRA' ELSE 'VENTA' END
		,      /*11*/'fecha'		= CONVERT(CHAR(10), mfca.cafecha, 103)																		
		,      /*12*/'CaFecVcto'	= CONVERT(CHAR(10), mfca.cafecvcto, 103) 																		
		,      /*13*/'PzoRes' 		= DATEDIFF(day,@fecproceso,mfca.cafecefectiva) 													
		,      /*14*/'CaMtoMon1'	= mfca.camtomon1																	
		,      /*15*/'CaTipCam'		= CONVERT(NUMERIC(15,9), mfca.catipcam) 	
		,      /*16*/'nMTM' 		= ISNULL(CONVERT(NUMERIC(21,2), ROUND(mfca.fres_obtenido, 2)),0)
		,      /*17*/'nMtoThresHold'  	= ISNULL(threshold.threshold_aplicado, 0.0)
		,      /*18*/'Excesos' 		= ISNULL(mfca.fres_obtenido, 0.0) - ISNULL(threshold.threshold_aplicado, 0.0)
		,      /*19*/'GarantiaTotal'	= cli.garantiatotal
		,      /*20*/'FechaEmision'   	= @dfechaemision 
		,      /*21*/'FechaProceso'   	= @fecproceso 
		,      /*22*/'HoraEmision'    	= @horaemision 
		FROM 	BacFwdSuda..MFCA mfca
			INNER JOIN BacParamSuda.dbo.CLIENTE   	      		    cli ON cli.clrut = mfca.cacodigo 		AND cli.clcodigo = mfca.cacodcli     
			INNER JOIN BacParamSuda.dbo.PRODUCTO 	     		   prod ON prod.id_sistema = 'BFW' 		AND prod.codigo_producto = mfca.cacodpos1
			LEFT  JOIN BacLineas.dbo.LINEA_GENERAL 	      		lingral ON lingral.rut_cliente = mfca.cacodigo  AND lingral.codigo_cliente = mfca.cacodcli
			LEFT  JOIN BacParamSuda.dbo.TBL_THRESHOLD_OPERACION   threshold ON threshold.sistema = 'BFW' 		AND threshold.producto = mfca.cacodpos1 AND threshold.numero_operacion = mfca.canumoper 
		WHERE    mfca.cafecha    = @dFecha
		AND     (mfca.cacodigo 	 = @RutCliente OR @RutCliente = 0) 
		AND     (mfca.cacodcli   = @CodCliente OR @CodCliente = 0)
		AND     (mfca.cacodpos1  = @nProducto  OR @nProducto  = 0) 


		UNION

		SELECT 'operador' 	= @cOperador
		,      'sistema'	= prod.id_sistema
		,      'productoA'	= substring(prod.descripcion,1,25)
		,      'RutCliente'	= cli.Clrut
		,      'Nombre'		= substring(cli.clnombre,1, 50)
		,      'NumContrato'	= carhis.canumoper
		,      'Bloqueado' 	= CASE WHEN LinGral.Bloqueado='' THEN 'DESBLOQUEADO' ELSE 'BLOQUEADO' END
		,      'motivoBloq'	= cli.Motivo_Bloqueo
		,      'Descripcion'	= prod.Descripcion
		,      'CaTipOper' 	= CASE WHEN carhis.caTipOper='C' THEN 'COMPRA' ELSE 'VENTA' END
		,      'fecha'		= CONVERT(CHAR(10), carhis.caFecha, 103)																			
		,      'CaFecVcto'	= CONVERT(CHAR(10), carhis.caFecVcto, 103) 																		
		,      'PzoRes' 	= DATEDIFF(day,@FecProceso,carhis.caFecEfectiva) 													
		,      'CaMtoMon1'	= carhis.caMtoMon1																	
		,      'CaTipCam'	= carhis.caTipCam																	
		,      'nMTM' 		= isnull(carhis.fres_obtenido, 0.0)
		,      'nMtoThresHold'  = isnull(Threshold.Threshold_Aplicado, 0.0)
		,      'Excesos' 	= isnull(carhis.fres_obtenido, 0.0) 
					- isnull(Threshold.Threshold_Aplicado, 0.0)
		,      'GarantiaTotal'	= cli.garantiatotal
		,      'FechaEmision'   = @dFechaEmision 
		,      'FechaProceso'   = @FecProceso 
		,      'HoraEmision'    = @HoraEmision 
		FROM    BacFwdSuda.dbo.MFCARES 		     			carhis 
			INNER JOIN BacParamSuda.dbo.CLIENTE   	      		  cli   ON cli.clrut = carhis.cacodigo AND cli.Clcodigo = carhis.cacodCli     
			INNER JOIN BacParamSuda.dbo.PRODUCTO 	     		 prod   ON prod.id_sistema = 'BFW' AND prod.codigo_producto = carhis.cacodpos1
			LEFT  JOIN BacLineas.dbo.LINEA_GENERAL 	      		lingral ON LinGral.rut_cliente = carhis.cacodigo  AND LinGral.Codigo_Cliente = carhis.cacodCli
			LEFT  JOIN BacParamSuda.dbo.TBL_THRESHOLD_OPERACION threshold   ON Threshold.Sistema = 'BFW' AND Threshold.Producto = carhis.cacodpos1 AND Threshold.Numero_Operacion = carhis.canumoper 
		WHERE 	carhis.cafechaproceso = @dFecha
		AND    (carhis.cacodigo  = @RutCliente OR @RutCliente = 0) 
		AND    (carhis.cacodcli  = @CodCliente OR @CodCliente = 0)
		AND    (carhis.cacodpos1 = @nProducto  OR @nProducto  = 0) 
		ORDER  BY  cli.Clrut

	END


	IF @IdSistema = 'PCS' OR @IdSistema =''
	BEGIN
		DECLARE @nProdSwap INTEGER
		    SET @nProdSwap = CASE WHEN @nProducto = 'ST' THEN 1 
					  WHEN @nProducto = 'SM' THEN 2
					  WHEN @nProducto = 'FR' THEN 3
					  WHEN @nProducto = 'SP' THEN 4
				     END

		SELECT @nProducto = CAST(@nProducto AS INTEGER)

                INSERT INTO #TMP_RETORNO_MOVIMIENTO

		SELECT 'operador' 	= @cOperador
		,      'sistema'	= prod.id_sistema
		,      'productoA'	= SUBSTRING(prod.descripcion,1,25)
		,      'RutCliente'	= cli.Clrut
		,      'Nombre'		= SUBSTRING(cli.clnombre,1, 50)
		,      'NumContrato'	= swap.numero_operacion
		,      'Bloqueado' 	= CASE WHEN LinGral.Bloqueado='' THEN 'DESBLOQUEADO' ELSE 'BLOQUEADO' END
		,      'motivoBloq'	= cli.Motivo_Bloqueo
		,      'Descripcion'	= prod.Descripcion
		,      'CaTipOper' 	= CASE WHEN swap.tipo_operacion='C' THEN 'COMPRA' ELSE 'VENTA' END
		,      'fecha'		= CONVERT(CHAR(10),swap.fecha_inicio, 103)																	
		,      'CaFecVcto'	= CONVERT(CHAR(10),swap.fecha_termino, 103)																	
		,      'PzoRes' 	= DATEDIFF(DAY,@FecProceso,swap.fecha_termino) 													
		,      'CaMtoMon1'	= swap.compra_capital																	
		,      'CaTipCam'	= swap.Tasa_Compra_Curva																
		,      'nMTM' 		= CONVERT(NUMERIC(21,2), ROUND(swap.Valor_RazonableCLP, 2)) 											
		,      'nMtoThresHold'  = ISNULL(CONVERT(NUMERIC(21,2), ROUND(Threshold.Threshold_Aplicado, 2)), 0.0)								
		,      'Excesos' 	= ISNULL(CASE	 WHEN swap.Valor_RazonableCLP > Threshold.Threshold_Aplicado    THEN (swap.Valor_RazonableCLP - Threshold.Threshold_Aplicado) 
					       		 WHEN swap.Valor_RazonableCLP <= Threshold.Threshold_Aplicado  THEN 0  								
	 			               		 END, 0.0)
		,      'GarantiaTotal'	= cli.garantiatotal
		,      'FechaEmision'   = @dFechaEmision 
		,      'FechaProceso'   = @FecProceso 
		,      'HoraEmision'    = @HoraEmision 
		FROM   BacSwapSuda.dbo.CARTERA swap
		       INNER JOIN BacParamSuda.dbo.CLIENTE   cli ON cli.clrut 	      = swap.Rut_cliente AND cli.Clcodigo = swap.codigo_cliente
		       INNER JOIN BacParamSuda.dbo.PRODUCTO prod ON prod.id_sistema   = 'PCS' AND prod.codigo_producto 	= CASE WHEN swap.tipo_swap  = 1 THEN 'ST'
															       WHEN swap.tipo_swap  = 2 THEN 'SM'	
															       WHEN swap.tipo_swap  = 3 THEN 'FR'	
															       WHEN swap.tipo_swap  = 4 THEN 'SP'	
															  END
		       LEFT JOIN BacLineas.dbo.LINEA_GENERAL LinGral	     ON LinGral.Rut_Cliente = swap.rut_cliente AND LinGral.Codigo_Cliente = swap.codigo_cliente
		       LEFT JOIN BacParamSuda.dbo.TBL_THRESHOLD_OPERACION Threshold ON Threshold.Sistema   = 'PCS' AND Threshold.Numero_Operacion  = swap.numero_operacion
		WHERE  swap.fecha_inicio 	= @dFecha  
		AND    swap.tipo_flujo   	= 1
		AND    swap.numero_flujo 	= (SELECT MIN(numero_flujo) FROM bacswapsuda..cartera WHERE tipo_flujo = 1 AND numero_operacion = swap.numero_operacion)
		AND   (swap.rut_cliente      	= @RutCliente OR @RutCliente  = 0 ) 
		AND   (swap.codigo_cliente   	= @CodCliente OR @CodCliente  = 0 )
		AND   (swap.tipo_swap   	= @nProdSwap OR @nProducto    = 0  )

		UNION

		SELECT 'operador' 	= @cOperador
		,      'sistema'	= prod.id_sistema
		,      'productoA'	= substring(prod.descripcion,1,25)
		,      'RutCliente'	= cli.Clrut
		,      'Nombre'		= substring(cli.clnombre,1, 50)
		,      'NumContrato'	= swap.numero_operacion
		,      'Bloqueado' 	= CASE WHEN LinGral.Bloqueado='' THEN 'DESBLOQUEADO' ELSE 'BLOQUEADO' END
		,      'motivoBloq'	= cli.Motivo_Bloqueo
		,      'Descripcion'	= prod.Descripcion
		,      'CaTipOper' 	= CASE WHEN swap.tipo_operacion='C' THEN 'COMPRA' ELSE 'VENTA' END
		,      'fecha'		= CONVERT(CHAR(10),swap.fecha_inicio, 103)
		,      'CaFecVcto'	= CONVERT(CHAR(10),swap.fecha_termino, 103)																	
		,      'PzoRes' 	= DATEDIFF(day,@fecproceso,swap.fecha_termino) 													
		,      'CaMtoMon1'	= swap.compra_capital																	
		,      'CaTipCam'	= swap.Tasa_Compra_Curva																
		,      'nMTM' 		= CONVERT(NUMERIC(21,2), ROUND(swap.Valor_RazonableCLP, 2)) 											
		,      'nMtoThresHold'  = ISNULL(CONVERT(NUMERIC(21,2), ROUND(Threshold.Threshold_Aplicado, 2)), 0.0)								
		,      'Excesos' 	= ISNULL(CASE	 WHEN swap.Valor_RazonableCLP > Threshold.Threshold_Aplicado   THEN (swap.Valor_RazonableCLP - Threshold.Threshold_Aplicado) 
					       		 WHEN swap.Valor_RazonableCLP <= Threshold.Threshold_Aplicado  THEN 0  								
	 			               		 END, 0.0)
		,      'GarantiaTotal'	= cli.garantiatotal
		,      'FechaEmision'   = @dFechaEmision 
		,      'FechaProceso'   = @FecProceso 
		,      'HoraEmision'    = @HoraEmision 
		FROM   BacSwapSuda.dbo.CARTERARES swap 
		       INNER JOIN BacParamSuda.dbo.CLIENTE   cli ON cli.Clrut = swap.Rut_cliente AND cli.Clcodigo = swap.Codigo_Cliente
		       INNER JOIN BacParamSuda.dbo.PRODUCTO prod ON prod.id_sistema = 'PCS' and prod.codigo_producto = CASE WHEN swap.tipo_swap  = 1 THEN 'ST'
															    WHEN swap.tipo_swap  = 2 THEN 'SM'
															    WHEN swap.tipo_swap  = 3 THEN 'FR'
															    WHEN swap.tipo_swap  = 4 THEN 'SP'
														       END
			LEFT 	JOIN BacLineas.dbo.LINEA_GENERAL LinGral 	 		ON    LinGral.Rut_Cliente  = swap.rut_cliente AND LinGral.Codigo_Cliente = swap.codigo_cliente
			LEFT  	JOIN BacParamSuda.dbo.TBL_THRESHOLD_OPERACION Threshold 	ON     Threshold.Sistema = 'PCS'  AND  Threshold.Numero_Operacion  = swap.numero_operacion 		
		WHERE  swap.fecha_inicio   = @dFecha
		AND    swap.tipo_flujo     = 1
		AND    swap.numero_flujo   = (SELECT MIN(numero_flujo) FROM bacswapsuda..cartera WHERE tipo_flujo = 1 AND  numero_operacion= swap.numero_operacion)
		AND   (swap.rut_cliente    = @RutCliente OR @RutCliente  = 0 ) 
		AND   (swap.codigo_cliente = @CodCliente OR @CodCliente  = 0 )
		AND   (swap.tipo_swap      = @nProdSwap OR @nProducto  	 = 0  )

	END

         SELECT 
             /*01*/ Operador         
         ,   /*02*/ Sistema          
         ,   /*03*/ Producto         
         ,   /*04*/ RutCliente       
         ,   /*05*/ Nombre           
         ,   /*06*/ NumContrato      
         ,   /*07*/ bloqueado        
         ,   /*08*/ motbloque        
         ,   /*09*/ desc_prod        
         ,   /*10*/ tipo_oper        
         ,   /*11*/ Fecha            
         ,   /*12*/ fec_vcto         
         ,   /*13*/ PzoRes           
         ,   /*14*/ camtomon1        
         ,   /*15*/ catipcam         
         ,   /*16*/ nMTM             
         ,   /*17*/ MtoThresHold     
         ,   /*18*/ Excesos          
         ,   /*19*/ garantiatotal    
         ,   /*20*/ FecEmision       
         ,   /*21*/ FecProceso       
         ,   /*22*/ HoraEmision      
         FROM #TMP_RETORNO_MOVIMIENTO
END
GO
