USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_SOLICITUD_SDA]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_VALIDA_SOLICITUD_SDA]
									(	@NumContrato		NUMERIC(8,0),
										@FechaActivacion    DATETIME ,
										@NumFolio			NUMERIC(8,0)  
								    )																				                                        
AS
BEGIN
     SET NOCOUNT ON  
     
    DECLARE @FechaProceso DATETIME
	SELECT  @FechaProceso = (SELECT fechaproc FROM OpcionesGeneral)  
     

	SELECT  CaEnc.CaNumContrato
	,		Cadet.CaFechaVcto
	,		Cadet.CaMontoMon1
	,		'FechaVencSolicitud' = ISNULL((SELECT FECHA_ACTIVACION FROM TBL_SOLICITUD_SDA WHERE NUM_CONTRATO = @NumContrato 
										   AND FECHA_ACTIVACION = @FechaActivacion AND ESTADO_SOLICITUD = 'V' AND NUM_SOLICITUD <> @NumFolio),'')
	,		'TotalSolicitud_V'   = ISNULL((SELECT SUM(MONTO_SOLICITUD) FROM  TBL_SOLICITUD_SDA WHERE NUM_CONTRATO = @NumContrato  
										   AND ESTADO_SOLICITUD IN('V') AND NUM_SOLICITUD <> @NumFolio AND @FechaActivacion <= Cadet.CaFechaVcto),0)

	,		'TotalSolicitud_E'   = ISNULL((SELECT SUM(MONTO_SOLICITUD) FROM  TBL_SOLICITUD_SDA WHERE NUM_CONTRATO = @NumContrato  
											AND ESTADO_SOLICITUD IN('E') AND NUM_SOLICITUD <> @NumFolio AND @FechaActivacion <= Cadet.CaFechaVcto
											AND @FechaProceso <= FECHA_ACTIVACION),0)
											
	,		'Total_Solicitud_Anticipada' =ISNULL(( SELECT sum(Mdc.MoMontoMon1) FROM MoEncContrato Mec
										        INNER JOIN MoDetContrato Mdc ON Mec.MoNumFolio = Mdc.MoNumFolio
										        INNER JOIN TBL_SOLICITUD_SDA Ts ON  Mec.MoNumContrato = Ts.NUM_CONTRATO
	 		                                    WHERE	Mec.MoNumContrato  = @NumContrato  
										        AND		ts.FECHA_ACTIVACION = @FechaProceso 
										        AND		Mdc.MoMontoMon1 = ts.MONTO_SOLICITUD),0)											
    ,		'Fecha_Activacion' = ISNULL((SELECT FECHA_ACTIVACION FROM TBL_SOLICITUD_SDA  
     		                             WHERE NUM_CONTRATO = @NumContrato	AND NUM_SOLICITUD = @NumFolio),0)										
											
	INTO    #ValidaOperacion	
	FROM	CaEncContrato CaEnc
			INNER JOIN  CaDetContrato Cadet ON CaEnc.CaNumContrato = Cadet.CaNumContrato 
	WHERE	CaEnc.CaNumContrato  = @NumContrato 
	AND		CaEnc.CaCodEstructura = 8
	
	
	SELECT CaNumContrato
	,	   CaFechaVcto
	,	   CaMontoMon1
	,	   FechaVencSolicitud
	,	   'TotalSolicitud' = (TotalSolicitud_V + (TotalSolicitud_E - Total_Solicitud_Anticipada))				
	,	   Fecha_Activacion				
	FROM #ValidaOperacion
END		   					
GO
