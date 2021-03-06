USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COMDER_Simulador_Lineas]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SP_COMDER_Simulador_Lineas](@UsuarioLog VARCHAR(20), @RutCliente INT,@CodCliente INT,@NumOperaciones INT, @filtro  VARCHAR(10), @Novacion BIT)
AS
BEGIN
 DECLARE @fechaProceso  DATETIME
 DECLARE @rutComDer INT
 DECLARE @dvComDer INT

 SELECT @fechaProceso = acfecproc FROM Bacfwdsuda.dbo.mfac  WITH (NOLOCK)

-- RUT COMDER
	SELECT   @rutComDer = rut_comder
		   , @dvComDer  = dv_comder 
	FROM  BDBOMESA..ComDer_Parametros

/*
-- Parametros SP
  DECLARE @UsuarioLog VARCHAR(20), @RutCliente INT,@CodCliente INT,@NumOperaciones INT, @filtro  VARCHAR(10), @Novacion BIT
  SET @UsuarioLog = 'PCONCHA'
  SET @NumOperaciones = 5
  SET @RutCliente = 76806870
*/



CREATE TABLE #tmp_UltOperaciones(
		Origen [varchar](9) NULL,
		FechaProceso [datetime] NULL,
		Cliente [varchar](50) NULL,
		NumeroOperacion [numeric](10, 0) NOT NULL,
		TipoOperacion [varchar](10) NULL,
		Producto [varchar](50) NULL,
		Fecha [datetime] NULL,
		Monto [float] NULL,
		Precio [float] NULL,
		idMoneda [int] NULL,
		Moneda [char](8) NULL,
		Operador [char](15) NULL,
		UsoLinea [float] NULL,
		Anular [bit] NOT NULL,
	)


	BEGIN
	IF @filtro IN('BILATERAL','TODAS')
	 BEGIN
		SET ROWCOUNT  @NumOperaciones

		   -- ÚLTIMAS OPERACIONES BILATERALES 
		    INSERT INTO #tmp_UltOperaciones
			SELECT    'Origen'		    = 'BILATERAL'
					, 'FechaProceso'	= @fechaProceso
					, 'Cliente'			= c.Clnombre 
					, 'NumeroOperacion' = ca.canumoper 
					, 'TipoOperacion'	= CASE WHEN ca.catipoper = 'V' THEN 'VENTA' ELSE 'COMPRA' END
					, 'Producto'	    = p.descripcion  
					, 'Fecha'		    = ca.cafecha 
					, 'Monto'		    = ca.camtomon1 
					, 'Precio'		    = ca.capremon1
					, 'idMoneda'	    = ca.cacodmon1
					, 'Moneda'		    = m.mnnemo
					, 'Operador'	    = ca.caoperador
					, 'UsoLinea'		= lin.MontoTransaccion
					, 'Anular'			= 0
			FROM    dbo.mfca AS ca WITH (NOLOCK) INNER JOIN
					BacParamSuda.dbo.CLIENTE AS c WITH (NOLOCK) ON c.Clrut = ca.cacodigo AND c.Clcodigo = ca.cacodcli INNER JOIN
					BacParamSuda.dbo.PRODUCTO AS p  WITH (NOLOCK) ON CAST(ca.cacodpos1 AS VARCHAR(10)) = p.codigo_producto INNER JOIN
					BacParamSuda.dbo.MONEDA AS m  WITH (NOLOCK) ON ca.cacodmon1 = m.mncodmon INNER JOIN
					BacLineas.dbo.LINEA_TRANSACCION_DETALLE AS lin WITH (NOLOCK) ON ca.canumoper = lin.NumeroOperacion AND c.Clrut = lin.Rut_Cliente AND 
					c.Clcodigo = lin.Codigo_Cliente 
			WHERE   (ca.cafecha  = @fechaProceso) --'2014-10-16')--
				AND (ca.cacodigo = @RutCliente)  --97004000 )
				AND (ca.cacodcli = 1) 
				AND (ca.cacodpos1 IN (1, 2, 3, 12, 14)) 
				--AND (ca.caestado <> 'P') 
				AND (ca.caantici <> 'A')
				AND (lin.Linea_Transsaccion = 'LINSIS') 
				AND (lin.Tipo_Detalle = 'C') 
				AND ca.canumoper NOT IN (SELECT nReNumOper FROM  BDBOMESA.dbo.ComDer_RelacionMarcaComder WITH (NOLOCK))
			ORDER BY ca.canumoper  DESC
		

		SET ROWCOUNT 0
	 END

	IF @filtro IN('COMDER','TODAS') AND (@Novacion = 1)
	 BEGIN   
		-- ÚLTIMAS DE LA OPERACIONES COMDER
		SET ROWCOUNT  @NumOperaciones

			INSERT INTO #tmp_UltOperaciones
			SELECT        'Origen'		    = 'COMDER'
						, 'Fecha'		    = @fechaProceso
						, 'Cliente'			= cli.Clnombre
						, 'NumeroOperacion' = ca.canumoper 
						, 'TipoOperacion'	= CASE WHEN ca.catipoper = 'V' THEN 'VENTA' ELSE 'COMPRA' END
						, 'Producto'	    = p.descripcion  
						, 'Fecha'		    = ca.cafecha 
						, 'Monto'		    = ca.camtomon1 
						, 'Precio'		    = ca.capremon1
						, 'idMoneda'	    = ca.cacodmon1
						, 'Moneda'		    = m.mnnemo
						, 'Operador'	    = ca.caoperador
						, 'UsoLinea'		= lin.MontoTransaccion
						, 'Anular'			= 0
			FROM        BDBOMESA.dbo.ComDer_RelacionMarcaComder AS mc WITH (NOLOCK) INNER JOIN
						Bacfwdsuda.dbo.mfca AS ca WITH (NOLOCK) ON mc.nReNumOper = ca.canumoper INNER JOIN
						BacParamSuda.dbo.CLIENTE AS cli WITH (NOLOCK) ON ca.cacodigo = cli.Clrut INNER JOIN
						BacParamSuda.dbo.PRODUCTO AS p WITH (NOLOCK) ON CAST(ca.cacodpos1 AS VARCHAR(10)) = p.codigo_producto INNER JOIN
						BacParamSuda.dbo.MONEDA AS m WITH (NOLOCK) ON ca.cacodmon1 = m.mncodmon INNER JOIN
						BacLineas.dbo.LINEA_TRANSACCION_DETALLE AS lin WITH (NOLOCK) ON ca.canumoper = lin.NumeroOperacion
			WHERE       (ca.cafecha  = @fechaProceso) 
					AND (mc.cReSistema = 'BFW') 
					AND (mc.vReEstado = 'V') 
					AND (mc.iReNovacion = 1) 
					AND (ca.cacodigo <> @rutComDer) 
					AND (lin.Linea_Transsaccion = 'LINSIS') 
					AND (lin.Tipo_Detalle = 'C') 
					AND (ca.cacodpos1 IN (1, 2, 3, 12, 14)) 
					--AND (ca.caestado <> 'P') 
					AND (ca.caantici <> 'A')	
					--AND (lin.Tipo_Detalle = 'L')
				    AND (lin.Rut_Cliente <> @rutComDer )
			ORDER BY ca.canumoper  DESC


		SET ROWCOUNT 0

     END

--  SELECT * FROM #tmp_UltOperaciones
--	SELECT * FROM COMDER_Simulador_Lineas ORDER BY NumeroOperacion DESC

-- //**********************************************************************************************************************************
-- //************************ INGRESO NUEVAS OPERACIONES*******************************************************************************
	
	-- OBTIENE LAS OPERACIONES ACTUALES DEL SIMULADOR
		SELECT   NumeroOperacion
			   , Origen
			   , UsuarioLog
		INTO #tmpSimuladorLineas
		FROM   COMDER_Simulador_Lineas WITH (NOLOCK)
		WHERE Anular = 1 AND UsuarioLog = @UsuarioLog


		-- ELIMINA LAS OPERACIONES DEL SIMULADOR
		DELETE COMDER_Simulador_Lineas WHERE UsuarioLog = @UsuarioLog


		-- INSERTA LAS NUEVAS OPERACIONES
		INSERT INTO COMDER_Simulador_Lineas 
		SELECT Origen, FechaProceso, Cliente, NumeroOperacion
			 , TipoOperacion, Producto, Fecha, Monto
			 , Precio, idMoneda, Moneda, Operador, UsoLinea, Anular, @UsuarioLog
		 FROM #tmp_UltOperaciones WITH (NOLOCK) 

		-- ACTUALIZA LAS OPERACIONES Q FUERON CHECKEADAS ANTERIORMENTE
		UPDATE COMDER_Simulador_Lineas
		SET Anular = 1
		FROM COMDER_Simulador_Lineas sl WITH (NOLOCK)  INNER JOIN 
			 #tmpSimuladorLineas old_sl ON sl.Origen =  old_sl.Origen AND sl.UsuarioLog = old_sl.UsuarioLog 
			 AND sl.NumeroOperacion = old_sl.NumeroOperacion
   END

-- //**********************************************************************************************************************************
-- //************************ VISTA DE DATOS NUEVOS PARA EL SIMULADOR  ****************************************************************
	
	SELECT 'Origen'		    =  Origen
		  ,'Fecha'		    =  FechaProceso
		  ,'Cliente'	    =  Cliente
		  ,'NumeroOperacion' = NumeroOperacion
		  ,'TipoOperacion'	=  TipoOperacion
		  ,'Producto'	    =  Producto
		  ,'Fecha'		    =  Fecha
		  ,'Monto'		    =  Monto
		  ,'Precio'		    =  Precio
		  ,'idMoneda'	    =  idMoneda
		  ,'Moneda'		    =  Moneda
		  ,'Operador'	    =  Operador
		  ,'UsoLinea'		=  UsoLinea
		  ,'Anular'			=  Anular
		 -- ,'UsuarioLog'		=  UsuarioLog
	FROM COMDER_Simulador_Lineas  WITH (NOLOCK)
	WHERE UsuarioLog = @UsuarioLog 
	AND  FechaProceso = @fechaProceso

END

GO
