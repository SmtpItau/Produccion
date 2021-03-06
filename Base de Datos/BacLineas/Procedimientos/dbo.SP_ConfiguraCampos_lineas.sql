USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ConfiguraCampos_lineas]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ConfiguraCampos_lineas]
AS
BEGIN

	SET NOCOUNT ON 

	DECLARE @fechaProc DATETIME
	SELECT @fechaProc = acfecproc FROM BacTraderSuda.dbo.mdac
/*
	CREATE TABLE #CLIENTES_DRV
	( 
	  	rutCliente NUMERIC(9,0)
	  , dvClientes CHAR(1)
	  , codigoCli  NUMERIC(9,0)
	  , ID_SISTEMA VARCHAR(10)
	  , metodologia INT
	)

 -- OBTIENE CLIENTES DRV 
	INSERT INTO #CLIENTES_DRV
	SELECT Clrut, Cldv, Clcodigo, 'DRV', ClRecMtdCod
	FROM BacParamSuda.dbo.Cliente
	WHERE ClRecMtdCod IN(3,6)
	AND Clcodigo = 1
*/
 
	DELETE from dbo.DWT_MontoLineas WHERE fecha_proceso = @fechaProc


 
 	INSERT INTO dbo.DWT_MontoLineas
	SELECT --registro ,
	  'Numero_Operacion'         = CONVERT(Numeric(7,0), SUBSTRING(registro,0,8) )   --CONVERT(NUMERIC(19,0),SUBSTRING(registro,0,8))   --7  - (registro, posoción inicio, campos a tomar)
	, 'Identificacion_Cliente'   = SUBSTRING(registro,8,11)   --11
	, 'Moneda_Origen'			 = SUBSTRING(registro,19,4)   --4
	, 'Facility'				 = SUBSTRING(registro,23,3)   --3
	, 'Moneda_Valores'			 = SUBSTRING(registro,26,4)   --4
	, 'Nocional_Origen'			 = CONVERT(NUMERIC(13,0),SUBSTRING(registro,30,13))  -- 13   -- SUBSTRING(registro,30,13) --
	, 'Monto_Articulo_84'		 = CONVERT(NUMERIC(15,0),SUBSTRING(registro,43,15))  --15
	, 'Monto_Corporativo'		 = CONVERT(NUMERIC(15,0),SUBSTRING(registro,58,15))  -- 15
	, 'Secuencia_Subcliente'	 = CONVERT(NUMERIC(9,0),SUBSTRING(registro,73,9))  --9
	, 'Rut'						 = SUBSTRING(registro,8,10)
	, 'Dv'						 = SUBSTRING(registro,18,1)--SUBSTRING(SUBSTRING(registro,8,10), SUBSTRING(registro,8,11), LEN(SUBSTRING(registro,8,11)))	
	, 'Codigo'					 = 1
	, 'NombreCliente'			 = ''
	, 'ID_SISTEMA'			     = ''
	, 'Fecha_proceso'			 = @fechaProc
    , 'Metodologia'			     = 0
	FROM dbo.IngresoDWT_BacLineas l
	WHERE fechaIngreso =  @fechaProc 

	-- Identifico operaciones DRV
/*
	UPDATE DWT_MontoLineas
	SET  ID_SISTEMA    = 'DRV'
	   , Metodologia   = cDRV.metodologia
	FROM DWT_MontoLineas l INNER JOIN  #CLIENTES_DRV cDRV ON 
		 l.Rut = cDRV.rutCliente AND l.Dv = cDRV.dvClientes 
*/

    UPDATE DWT_MontoLineas
	SET  ID_SISTEMA    = CASE WHEN cl.ClRecMtdCod IN(3,6) THEN  'DRV' ELSE '' END 
	   , Metodologia   = cl.ClRecMtdCod
	FROM DWT_MontoLineas l INNER JOIN BacParamSuda.dbo.CLIENTE cl ON 
		 l.Rut = cl.clrut AND l.Dv = cl.Cldv 

 
	

END








GO
