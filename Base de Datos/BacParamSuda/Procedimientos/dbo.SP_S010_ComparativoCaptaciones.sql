USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_S010_ComparativoCaptaciones]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_S010_ComparativoCaptaciones]
   (   @fecha_desde       DATETIME
   ,   @fecha_hasta       DATETIME
   )
as
begin

----	SP_S010_ComparativoCaptaciones '2013-01-01', '2013-12-01'

	SET NOCOUNT ON
	
	DECLARE	@Fecha_Extraccion	DATETIME
	SELECT	@Fecha_Extraccion = GETDATE()
	
	SELECT	fec_1_apertura							AS	'Fecha'
	,		LTRIM(RTRIM(STR(rut_cliente)))
	+		dv_cliente								AS	'Rut_Cliente'
	,		CASE WHEN Mon_Nemo  = 'PES'	THEN SUM(cap_inicio	)	ELSE 0	END AS	'Monto_CLP_CLP'
	,		CASE WHEN Mon_Nemo  = 'UF'	THEN SUM(cap_inicio	)	ELSE 0	END AS	'Monto_UF_CLP'
	,		CASE WHEN Mon_Nemo  = 'US$'	THEN SUM(cap_inicio	)	ELSE 0	END AS	'Monto_USD_CLP'
	FROM	BANCO..CAPTA	
	WHERE	fec_1_apertura >= @fecha_desde
	AND		fec_1_apertura  <= @fecha_hasta
	GROUP BY	Fec_1_Apertura
	,			rut_cliente
	,			mon_nemo
	,			dv_cliente
			
END

GO
