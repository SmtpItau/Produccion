USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_INFORME_CARGAS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_INFORME_CARGAS]
	(	@fecha		DATETIME
	,	@usuario	CHAR(15)
	,	@titulo		VARCHAR(255) = ''
	)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @fechaProc		DATETIME
		SET @fechaProc		= (SELECT dfechaproceso FROM SADP_Control with(nolock) )
	
	CREATE TABLE #acMDLBTR
		(	codSistema		CHAR(5)
		,	nomSistema		VARCHAR(30)
		,	fechaCarga		DATETIME
		,	cantAbonos		NUMERIC(15)
		,	sumAbonos		NUMERIC(21,4)
		,	cantCargos		NUMERIC(15)
		,	sumCargos		NUMERIC(21,4)
		,	codMonedaA		CHAR(8)
		,	codMonedaC		CHAR(8)
		,	usuario			CHAR(15)
		,	nomUsuario		CHAR(40)
		,	usuarioRpt		CHAR(15)
		,	tituloRpt		VARCHAR(255)
		,	fechaProc		DATETIME
	)
	
	INSERT INTO #acMDLBTR
	SELECT	md.sistema
		,	mex.Descripcion
		,	md.fecha
		,	COUNT(md.Tipo_Movimiento)
		,	SUM(md.monto_operacion)
		,	0
		,	0.0
		,	mo.mnnemo
		,	''
		,	dp.sUsuario
		,	usu.nombre
		,	@usuario
		,	@titulo
		,	@fechaproc
	FROM	BacParamsuda..MDLBTR md
			INNER JOIN BacParamsuda..SADP_MODULOS_EXTERNOS mex ON md.Sistema = mex.Nemo AND md.fecha = @fecha AND md.Tipo_Movimiento = 'A' 
			INNER JOIN BacParamsuda..MONEDA					mo ON md.moneda = mo.mncodmon 
			INNER JOIN BacParamSuda..SADP_DETALLE_PAGOS		dp ON md.Sistema = dp.cModulo AND md.numero_operacion = dp.nContrato AND md.moneda = dp.iMoneda 
			INNER JOIN BacParamsuda..USUARIO			   usu ON usu.usuario = dp.sUsuario 
	GROUP BY md.fecha, dp.sUsuario, usu.nombre, md.sistema, mex.Descripcion, md.Tipo_Movimiento, mo.mnnemo
	
	INSERT INTO #acMDLBTR
	SELECT	md.sistema
		,	mex.Descripcion
		,	md.fecha
		,	0
		,	0.0
		,	COUNT(md.Tipo_Movimiento)
		,	SUM(md.monto_operacion)
		,	''
		,	mo.mnnemo
		,	dp.sUsuario
		,	usu.nombre
		,	@usuario
		,	@titulo
		,	@fechaproc
	FROM	BacParamsuda..MDLBTR md
			INNER JOIN BacParamsuda..SADP_MODULOS_EXTERNOS mex ON md.Sistema = mex.Nemo AND md.fecha = @fecha AND md.Tipo_Movimiento = 'C' 
			INNER JOIN BacParamsuda..MONEDA					mo ON md.moneda = mo.mncodmon 
			INNER JOIN BacParamSuda..SADP_DETALLE_PAGOS		dp ON md.Sistema = dp.cModulo AND md.numero_operacion = dp.nContrato AND md.moneda = dp.iMoneda 
			INNER JOIN BacParamsuda..USUARIO			   usu ON usu.usuario = dp.sUsuario 
	GROUP BY md.fecha, md.sistema, dp.sUsuario, usu.nombre, mex.Descripcion, md.Tipo_Movimiento, mo.mnnemo
	
	SELECT * FROM #acMDLBTR

	DROP TABLE #acMDLBTR
	
END
GO
