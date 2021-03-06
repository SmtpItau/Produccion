USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SIID_LISTAR]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SIID_LISTAR](
		  @sSistema			Char(3)
		 ,@sTipoOperacion	Char(1)
		 ,@sUsuario			Char(15)
		 ,@dFechaDesde		Date
 )
AS 
BEGIN
		SET NOCOUNT ON
		SET DATEFORMAT DMY
		DECLARE @OPERACIONES TABLE (			[Sistema]			VARCHAR(15)
											,	[Producto]			VARCHAR(50)
											,	[Tipo Operacion]	VARCHAR(16)
											,	[Numero Contrato]	NUMERIC(10)
											,	[Fecha Contrato]	DATETIME
											,	[Fecha Vencimiento]	DATETIME
											,	[Moneda]			VARCHAR(05)
											,	[Monto Operacion]	NUMERIC(21,0)
											,	[Monto CLP]			NUMERIC(21,0)
											,	[Nombre Cliente]	VARCHAR(100)
											,   [Trader]		    VARCHAR(40)
											
											,	[Rut Cliente]		numeric(9)
											,   [Modalidad]			Varchar(20)
											,	[Fecha]				DATETIME
									
											)

DECLARE @dFecha_Proceso  DATETIME
SELECT  @dFecha_Proceso =   CONVERT(CHAR(8),acfecproc ,112)   FROM BACTRADERSUDA..mdac


---Criterio que determina el sistema(s) para listar las operaciones por sistema. 
---si viene vacío se listan todas las operaciones.
SET @sSistema		=	NULLIF(@sSistema,'')
set @sTipoOperacion	=	NULLIF(@sTipoOperacion,'')
SET @sUsuario		=	NULLIF(@sUsuario,'')
SET @dFechaDesde	=	NULLIF(@dFechaDesde,'')

IF (@dFechaDesde IS NULL)
	SET @dFechaDesde	 = @dFecha_Proceso


--FORWARD
INSERT INTO @OPERACIONES
SELECT 
		'BFW',																		--	[Sistema]
		p.descripcion,																--	[Producto]
		CASE WHEN c.catipoper = 'C' THEN 'COMPRA ' ELSE 'VENTA ' END,				--	[Tipo Operacion]
		c.canumoper,																--	[Numero Contrato]
		c.cafecha,																	--	[Fecha Operacion]
		c.cafecvcto,																--	[Fecha Vencimiento]
		m.mnnemo AS [Moneda],															--	[Moneda]									
		camtomon1,																	--	[Monto Operacion]
		camtomon2,																	--	[Equivalente CLP]
		CLNOMBRE,																	--	[Nombre Cliente]	
		caOPERADOR,																	--  [Trader]
		CLRUT,																		--	[Rut Cliente]
		CASE WHEN c.catipmoda = 'C' THEN 'Compensación' ELSE 'Entrega Física' END,	--	[Modalidad]
		@dFecha_Proceso
FROM	
	    Bacfwdsuda..mfca c 
		INNER JOIN BacParamSuda..cliente ON CLRUT = c.cacodigo AND CLCODIGO = c.cacodcli
		INNER JOIN BacParamSuda..moneda m ON MNCODMON = c.cacodmon1
		INNER JOIN Bacfwdsuda..VIEW_PRODUCTO p ON  c.cacodpos1 = p.codigo_producto and p.id_sistema='BFW'
WHERE	 
		cafecvcto >=@dFecha_Proceso and caestado!='A' 


--SWAP
INSERT INTO @OPERACIONES
SELECT 
'PCS' AS [Sistema], 
CASE WHEN tipo_swap = 1 THEN 'INTEREST RATE SWAP'
     WHEN tipo_swap = 2 THEN 'CROSS CURRENCY SWAP'
	 WHEN tipo_swap	= 4 THEN 'INDICE PROMEDIO CAMARA'
 END AS [Producto]
,'COMPENSACIÓN'
, numero_operacion AS [Numero Contrato]
, fecha_cierre AS [Fecha Operacion]
, fecha_termino AS [Fecha Vencimiento]
, mnnemo AS [Moneda]
, compra_capital AS [Monto Operacion]
, compra_capital AS [Monto Operacion]
, CLNOMBRE
, OPERADOR
, CLRUT																								--	[Rut Cliente]
, CASE WHEN modalidad_pago = 'C' THEN 'Compensación' ELSE 'Entrega Física' END						--	[Modalidad]			
, @dFecha_Proceso																							--	[Segmento Cliente]	
FROM BacSwapSuda..cartera h with (nolock)
INNER JOIN BacParamSuda..cliente ON CLRUT = rut_cliente AND CLCODIGO = codigo_cliente
INNER JOIN BacParamSuda..moneda ON MNCODMON = compra_moneda
WHERE 
	fecha_termino>=@dFecha_Proceso  and Tipo_Flujo != 2  AND estado != 'A'

--OPCIONES
INSERT INTO @OPERACIONES  
SELECT 
'OPT' AS [SISTEMA] 
, UPPER(E.OPCESTDSC) AS [PRODUCTO]
, (CASE WHEN H.CACVESTRUCTURA = 'C' THEN 'COMPRA' ELSE 'VENTA' END)
, H.CANUMCONTRATO AS [NUMERO CONTRATO]
, H.CAFECHACONTRATO AS [FECHA OPERACION]
, D.CAFECHAVCTO  AS [FECHA VENCIMIENTO]
, M.mnnemo -- D.MoCodMon1
, d.CAMontoMon1
, d.CAMontoMon2 
, CLNOMBRE
, CAOPERADOR
, CLRUT																								--	[Rut Cliente]
, CASE WHEN CAModalidad = 'C'  THEN 'Compensación' ELSE 'Entrega Física' END						    --	[Modalidad]			
, @dFecha_Proceso																					--	[Fecha]
FROM 
	cbmdbopc..CAENCCONTRATO H with(nolock)
	INNER JOIN cbmdbopc..CADETCONTRATO D	with(nolock)				ON  D.CaNumContrato = H.CaNumContrato and canumestructura=1
	INNER JOIN bacparamsuda.dbo.View_ClienteParaOpc		with(nolock)	ON  CLRUT  = H.CARutCliente   AND ClCodigo      = H.CACodigo   
	INNER JOIN bacparamsuda.dbo.Moneda	M			with(nolock)		ON  M.mncodmon   = D.CACodMon1
	LEFT JOIN cbmdbopc..OPCIONESTRUCTURA  E			with(nolock)		ON  E.OPCESTCOD  = D.CANUMESTRUCTURA 
WHERE 
	CAFECHAVCTO >=@dFecha_Proceso AND H.CATIPOTRANSACCION = 'CREACION'	 

SELECT distinct  
		 o.[Sistema],[Producto],[Numero Contrato]
		 ,[Tipo Operacion],[Fecha Contrato],[Fecha Vencimiento]	
		,[Rut Cliente],[Nombre Cliente]	
		,[Modalidad],[Moneda],[Monto Operacion]	
	    ,[Trader]
		,isnull(s.[Rut_Cedente],'')				[Rut Cedente]
		,isnull(s.[Rut_Intermediario],'')		[Rut Intermediario]
		,isnull(UPPER(s.[Adquisicion_PorCesion]),'No')	[Adquisición por cesión] -- Adquisicion_PorCesion,  Comprension_Cartera,  Fecha,  Operacion,  Plataforma,  Rut_Cedente,  Rut_Intermediario,  Sistema,  Termino_Anticipado,  Termino_Cesion,  Tipo_Modificacion,  Usuario
		,CASE WHEN s.[Tipo_Modificacion] ='1' THEN '1 Recouponing'
			  WHEN s.[Tipo_Modificacion] ='2' THEN '2 Modificación de contraparte por cesión'
			  WHEN s.[Tipo_Modificacion] ='3' THEN '3 Otras modificaciones'
			  WHEN s.[Tipo_Modificacion] ='4' THEN '4 Corrección de reporte'
			  ELSE '5 N/A'
		  END									[Tipo de Modificación]			--isnull(s.[Tipo_Modificacion],'5')		[Tipo de Modificación]
		,isnull(UPPER(s.[Termino_Cesion]),'No')		[Termino Cesión]
		,isnull(UPPER(s.[Termino_Anticipado]),'NOT')   [Cláusula de Término Anticipado]
		,isnull(UPPER(s.[Comprension_Cartera]),'No')   [Compresión de Cartera]
		,isnull(UPPER(s.[Plataforma]),'OTC')			[Plataforma de Negociación]
		,isnull(s.[Fecha],o.[Fecha])			[Fecha]

FROM 
		@OPERACIONES O 
left join BacLineas..SIID s with(nolock) on o.[Numero Contrato]=s.Operacion 
WHERE 
O.[Sistema]			=	ISNULL(@sSistema,O.[Sistema])				AND
--O.[Tipo Operacion]	=	ISNULL(@sTipoOperacion,O.[Tipo Operacion])--	AND
O.[Trader]			=	ISNULL(@sUsuario,O.[Trader])	AND
O.[Fecha Contrato] BETWEEN @dFechaDesde AND @dFecha_Proceso

order by 1,3


END
GO
