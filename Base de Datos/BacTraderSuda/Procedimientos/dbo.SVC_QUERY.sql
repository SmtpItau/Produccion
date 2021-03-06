USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_QUERY]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SVC_QUERY]
as
begin


        SELECT  VALORIZACION_MERCADO.tipo_operacion, VALORIZACION_MERCADO.codigo_carterasuper, SUM(diferencia_mercado)
      	FROM 	VALORIZACION_MERCADO
	,	VIEW_MONEDA
	,	VIEW_EMISOR
	,	VIEW_INSTRUMENTO 
	,	MDCP0630
	WHERE	VALORIZACION_MERCADO.id_sistema		= 'BTR' 
	AND	VALORIZACION_MERCADO.fecha_valorizacion	= '20100630' --> @FechaBusquedaValorizacion --@dfecfmes1
	AND	VIEW_MONEDA.mncodmon			= VALORIZACION_MERCADO.moneda_emision
	AND	VIEW_INSTRUMENTO.incodigo		= VALORIZACION_MERCADO.rmcodigo 
	AND	emrut					=   rut_emisor
	AND     VALORIZACION_MERCADO.rut_emisor		<>  97023000   
	AND     VALORIZACION_MERCADO.rmnumdocu		= cpnumdocu 
	AND	VALORIZACION_MERCADO.rmcorrela		= cpcorrela
	AND     VALORIZACION_MERCADO.valor_nominal	> 0 
	AND	rmrutcart				> 0
        AND     rminstser                               LIKE 'BCP%'
--      AND     VALORIZACION_MERCADO.tipo_operacion     = 'CP'
--      AND     VALORIZACION_MERCADO.codigo_carterasuper = 'P'
        GROUP BY VALORIZACION_MERCADO.tipo_operacion
         ,       VALORIZACION_MERCADO.codigo_carterasuper


end

GO
