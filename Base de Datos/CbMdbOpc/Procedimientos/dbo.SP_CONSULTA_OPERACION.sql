USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_OPERACION]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_OPERACION]
								(	@NumContrato		NUMERIC(8,0)								
								 )
AS

BEGIN
     SET NOCOUNT ON  
     
	DECLARE @FechaProceso DATETIME
	SELECT  @FechaProceso = (SELECT fechaproc FROM OpcionesGeneral) 


 
	SELECT	Ca.CaNumContrato   
	,		Ca.CaNumFolio
	,		Cd.CaMontoMon1
	,		Cd.CaFechaVcto
	,		Ca.CaCodEstructura 
	,       'Total_Solicitud_V' = ISNULL((SELECT SUM(MONTO_SOLICITUD) FROM  TBL_SOLICITUD_SDA WHERE NUM_CONTRATO = @NumContrato  
										AND ESTADO_SOLICITUD IN('V')),0) 
	,		'Total_Solicitud_E' = ISNULL((SELECT SUM(MONTO_SOLICITUD) FROM  TBL_SOLICITUD_SDA WHERE NUM_CONTRATO = @NumContrato  
										AND ESTADO_SOLICITUD IN('E') AND @FechaProceso <= FECHA_ACTIVACION),0)	
	,		'Total_Solicitud_Anticipada' = ISNULL(( SELECT sum(Mdc.MoMontoMon1) FROM MoEncContrato Mec
												 INNER JOIN MoDetContrato Mdc ON Mec.MoNumFolio = Mdc.MoNumFolio
												 INNER JOIN TBL_SOLICITUD_SDA Ts ON  Mec.MoNumContrato = Ts.NUM_CONTRATO
	 											 WHERE	Mec.MoNumContrato  = @NumContrato  
												 AND	ts.FECHA_ACTIVACION = @FechaProceso 
												 AND	Mdc.MoMontoMon1 = ts.MONTO_SOLICITUD),0)													
	
	
	INTO #ConsultaOperacion	
	FROM	CaEncContrato Ca
	INNER JOIN CaDetContrato Cd ON Ca.CaNumContrato = Cd.CaNumContrato
	WHERE Ca.CaCodEstructura = 8 AND Ca.CaNumContrato = @NumContrato

	SELECT CaNumContrato   
	,	   CaNumFolio
	,	   CaMontoMon1
	,	   CaFechaVcto
	,	   CaCodEstructura 
	,	   'Total_Solicitud' = (Total_Solicitud_V + (Total_Solicitud_E - Total_Solicitud_Anticipada))
	FROM #ConsultaOperacion

END

GO
