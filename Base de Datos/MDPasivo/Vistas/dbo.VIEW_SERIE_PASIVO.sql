USE [MDPasivo]
GO
/****** Object:  View [dbo].[VIEW_SERIE_PASIVO]    Script Date: 16-05-2022 11:43:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_SERIE_PASIVO]
AS
	SELECT	codigo_instrumento 
	,	nombre_serie    
	,	rut_emisor  
	,	tasa_emision 
	,	codigo_base 
	,	um_serie 
	,	tasa_tera   
	,	periodo_amortizacion 
	,	numero_amortizacion 
	,	plazo 
	,	codigo_periodo	
	,	cupones 
	,	fecha_vencimiento           
	,	fecha_emision               
	,	bono_subordinado 
	,	tasa_variable 
	,	numero_decimales 
	,	fecha_primer_corte          
	FROM	MDPASIVO..SERIE_PASIVO

GO
