USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_OPERACIONPLANILLAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEER_OPERACIONPLANILLAS]
WITH RECOMPILE
AS 
BEGIN

	
     SELECT 	'Numero Operacion' =monumope,
		'Monto'		   =momonmo, 
		'Numero Planilla'  =ISNULL(planilla_numero,0), 
		'Monto OMA' 	   =ISNULL(monto_origen,0), 
		'Tipo Operacion'   =ISNULL(tipo_operacion_cambio,0),
		'Fecha_Proceso'    = CONVERT( CHAR(10),acfecpro,103),
		'Hora'             = CONVERT( CHAR(8),GETDATE(),108),
		'NombreBanco'	   = acnombre,
		'Fecha_Planilla'   = ISNULL(CONVERT( CHAR(8),operacion_fecha,112), CONVERT( CHAR(8),acfecpro,112)) ,
		'Fecha_Hoy'   	   = CONVERT( CHAR(8),acfecpro,112)
     INTO	#tmp_planilla	
     FROM memo	LEFT OUTER JOIN view_Planilla_spt ON monumope = operacion_numero	,
	    	meac		,
	    	view_cliente
     WHERE 	(MOESTATUS = ' ' OR MOESTATUS = 'M') 
		AND ( morutcli = clrut
       	AND mocodcli = clcodigo )	
       	AND motipope IN ('C','V') 
		AND motipmer IN ( 'PTAS' , 'ARBI' , 'CANJ' , 'EMPR' )
		AND mocodcnv = 'CLP'
       	AND ( ( cltipcli > 0 AND cltipcli < 4 ) OR morutcli = acrut )


	/*REQ.7619 CASS 07-01-2011
		 FROM 	memo		,
            		view_Planilla_spt	,
	    		meac		,
	    		view_cliente
		 WHERE 	monumope *= operacion_numero  and (MOESTATUS = ' ' OR MOESTATUS = 'M') 
			AND ( morutcli = clrut
        		AND mocodcli = clcodigo )	
        		AND motipope IN ('C','V') 
			AND motipmer IN ( 'PTAS' , 'ARBI' , 'CANJ' , 'EMPR' )
			AND mocodcnv = 'CLP'
        		AND ( ( cltipcli > 0 AND cltipcli < 4 ) OR morutcli = acrut )
	*/

     DELETE	#tmp_planilla
     WHERE	CONVERT( CHAR(8) , Fecha_Planilla , 112 ) <> CONVERT( CHAR(8) , fecha_hoy , 112 )

     SELECT * FROM #tmp_planilla

END

GO
