USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_NOVACIONES]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_NOVACIONES] (@MODULO		VARCHAR(3) 
									     ,@RUT			NUMERIC(9)=0
										 ,@CODIGO		NUMERIC(9)=0)	
AS
BEGIN
	
	/*
	SP_BUSCA_NOVACIONES 'BFW', 97030000, 0
	SP_BUSCA_NOVACIONES 'BFW', 0, 0
	SP_BUSCA_NOVACIONES 'OPT', 0, 0  -- Pendiente , no retorna datos.
	*/
	declare @CorteFecMod datetime
	select  @CorteFecMod = dateAdd( dd, -60, acfecproc ) from BacFwdSuda.dbo.mfac

	IF @MODULO = 'BFW'  --forward
	
	BEGIN
		SELECT OpMod.cafecmod,
			   OpMod.canumoper,
			   Cliente_Origen = ISNULL(CliOrigen.Clnombre, 'SIN NOMBRE'),
			   Cliente_Origen_Rut = ISNULL(CONVERT(VARCHAR(13), CliOrigen.ClRut) + '-' + CliOrigen.ClDv,'0-0'),
			   Cliente_Origen_Codigo = ISNULL(OpMod.CaCodCli,''),
			   Cliente_destino = ISNULL(CliDestino2.ClNombre, CliDestino1.ClNombre),
			   Cliente_Destino_Rut = CONVERT(VARCHAR(13), ISNULL(CliDestino2.ClRut, CliDestino1.ClRut)) + '-' + ISNULL(CliDestino2.ClDv, CliDestino1.ClDv),
			   Cliente_Destino_Codigo = ISNULL(Carhoy2.CaCodCli, Carhoy1.CaCodCli)
		FROM   BacFwdSuda.dbo.mfca_log OpMod			-- Valores antes de la modificación
       
			   LEFT JOIN bacfwdSuda.dbo.mfach fechas
					ON  fechas.acfecproc = OpMod.cafecmod
            
			   LEFT JOIN bacfwdsuda.dbo.mfcah CarHoy1
					ON  CarHoy1.canumoper = OpMod.Canumoper
            
			   LEFT JOIN bacfwdsuda.dbo.mfca CarHoy2
					ON  CarHoy2.canumoper = OpMod.Canumoper
            
			   LEFT JOIN BacParamSuda.dbo.Cliente CliOrigen
					ON  CliOrigen.Clrut = OpMod.CaCodigo
					AND CliOrigen.ClCodigo = OpMod.CaCodCli
            
			   LEFT JOIN BacParamSuda.dbo.Cliente CliDestino1
					ON  CliDestino1.Clrut = CarHoy1.CaCodigo
					AND CliDestino1.ClCodigo = CarHoy1.CaCodCli
            
			   LEFT JOIN BacParamSuda.dbo.Cliente CliDestino2
					ON  CliDestino2.Clrut = CarHoy2.CaCodigo
					AND CliDestino2.ClCodigo = CarHoy2.CaCodCli
            
		WHERE  OpMod.caEstado = 'M'
			   AND (CliOrigen.ClRut	= @Rut		OR @Rut = 0)
			   AND (OpMod.canumoper	= @Codigo	OR @Codigo = 0)
			   AND ( 
			         (OpMod.Cacodigo <> CarHoy1.CaCodigo OR CarHoy1.CaCodCli <> OpMod.CaCodCli)
			     OR  (OpMod.Cacodigo <> CarHoy2.CaCodigo OR CarHoy2.CaCodCli <> OpMod.CaCodCli)
				 )
		   	   and OpMod.cafecmod >= @CorteFecMod
		ORDER BY
			   OpMod.cafecmod DESC,
			   opMod.CaNumoper 
       
	END
	
	IF @MODULO = 'OPT' 
	BEGIN
	
		  /* Lista de operaciones Modificadas en SAO(OPT):*/

		SELECT fecha_Mod = CONVERT(DATETIME, CONVERT(VARCHAR(8), OpMod.moFechaCreacionRegistro, 112)),
			   MoNumContrato,
			   Cliente_Origen = ISNULL(CliOrigen.ClNombre, 'SIN NOMBRE'),
			   Cliente_Origen_Rut = ISNULL(CliOrigen.Clrut,'0-0'),
			   Cliente_Origen_Codigo = ISNULL(CliOrigen.ClCodigo,''),
			   Cliente_destino = ISNULL(CliDestino.ClNombre,''),
			   Cliente_destino_Rut = CliDestino.Clrut,
			   Cliente_Destino_Codigo = CliDestino.ClCodigo
		FROM   lnkOpc.Cbmdbopc.dbo.MoHisEncContrato OpMod
			   LEFT JOIN BacParamSuda.dbo.cliente CliDestino
					ON  CliDestino.ClRut = OpMod.MoRutCliente
					AND CliDestino.ClCodigo = OpMod.MoCodigo
			   LEFT JOIN lnkOpc.Cbmdbopc.dbo.OpcionesResGeneral fechas
					ON  fechas.fechaProc = CONVERT(VARCHAR(8), OpMod.moFechaCreacionRegistro, 112)
			   LEFT JOIN lnkOpc.CbMdbOpc.dbo.CaResEncContrato CarRes
					ON  CarRes.CaEncFechaRespaldo = fechas.fechaant
					AND carRes.CanumContrato = Opmod.MonumContrato
			   LEFT JOIN BacParamSuda.dbo.cliente CliOrigen
					ON  CliOrigen.ClRut = CarRes.CaRutCliente
					AND CliOrigen.ClCodigo = CarRes.CaCodigo
		WHERE  MoTipoTransaccion = 'MODIFICA'
			   AND (OpMod.MoRutCliente <> CarRes.CaRutCliente OR CarRes.CaCodigo <> OpMod.MoCodigo)
   
		UNION
		SELECT fecha_Mod = CONVERT(DATETIME,CONVERT(VARCHAR(8), OpMod.moFechaCreacionRegistro, 112)),
			   MoNumContrato,
			   Cliente_Origen = ISNULL(CliOrigen.ClNombre,'SIN NOMBRE'),
			   Cliente_Origen_Rut = ISNULL(CliOrigen.Clrut,'0-0'),
			   Cliente_Origen_Codigo = ISNULL(CliOrigen.ClCodigo,''),
			   Cliente_destino = ISNULL(CliDestino.ClNombre,''),
			   Cliente_destino_Rut = CliDestino.Clrut,
			   Cliente_Destino_Codigo = CliDestino.ClCodigo
		FROM   lnkOpc.Cbmdbopc.dbo.MoEncContrato OpMod
			   LEFT JOIN BacParamSuda.dbo.cliente CliDestino
					ON  CliDestino.ClRut = OpMod.MoRutCliente
					AND CliDestino.ClCodigo = OpMod.MoCodigo
			   LEFT JOIN lnkOpc.Cbmdbopc.dbo.OpcionesGeneral fechas
					ON  fechas.fechaProc = CONVERT(VARCHAR(8), OpMod.moFechaCreacionRegistro, 112)
			   LEFT JOIN lnkOpc.CbMdbOpc.dbo.CaResEncContrato CarRes
					ON  CarRes.CaEncFechaRespaldo = fechas.fechaant
					AND carRes.CanumContrato = Opmod.MonumContrato
			   LEFT JOIN BacParamSuda.dbo.cliente CliOrigen
					ON  CliOrigen.ClRut = CarRes.CaRutCliente
					AND CliOrigen.ClCodigo = CarRes.CaCodigo
		WHERE  MoTipoTransaccion = 'MODIFICA'
			   AND (OpMod.MoRutCliente <> CarRes.CaRutCliente OR CarRes.CaCodigo <> OpMod.MoCodigo)
		ORDER BY
			   CONVERT(DATETIME,CONVERT(VARCHAR(8), OpMod.moFechaCreacionRegistro, 112)) DESC,
			   OpMod.MoNumContrato  
		   
	END 
END

GO
