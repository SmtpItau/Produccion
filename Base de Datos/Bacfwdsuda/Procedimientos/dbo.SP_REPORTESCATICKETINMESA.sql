USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTESCATICKETINMESA]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_REPORTESCATICKETINMESA] 
AS 
BEGIN
   	SET NOCOUNT ON

	DECLARE @FecProceso   	DATETIME
       		SET @FecProceso = (SELECT acfecproc FROM BacFwdSuda.dbo.MFAC with(nolock))

	DECLARE @FecEmision   	CHAR(10)
       		SET @FecEmision = (SELECT  CONVERT ( CHAR(10) , GETDATE() , 103 ) )

	DECLARE @HoraEmision   	CHAR(10)
       		SET @HoraEmision= (SELECT  CONVERT ( CHAR(10) , GETDATE() , 108 ) )

	DECLARE @nValorUF	FLOAT
		SET @nValorUF 	= (SELECT vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmfecha = @FecProceso AND vmcodigo=998)

	DECLARE @nValorUsd	FLOAT
		SET @nValorUsd 	= (SELECT vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmfecha = @FecProceso AND vmcodigo=994)

	SELECT  'Numope'	= tblcar.numero_operacion
	,	'Numoperela'	= tblcar.numero_operacion_relacion
	,	'FecInicio'	= CONVERT ( CHAR(10) ,tblcar.fecha_operacion, 103 ) 
	,	'FecVcto'	= CONVERT ( CHAR(10) ,tblcar.fechavencimiento, 103 ) 
	,	'MontoUSD'	= tblcar.montomoneda1
	,	'T/C Inicio'	= tblcar.tipocambio
	,	'Monto CLP o UF'= tblcar.montomoneda2
	,	'T/C inicial'	= tblcar.precio1
	,	'Monto Cnv CLP'	= tblcar.equivalente_clp
	,	'Devengo Acum.'	= ISNULL(tblres.res_obtenido,0)
	,	'Valorizacion'	= ISNULL(tblres.valorizacion,0)
	,	'Plazo'		= DATEDIFF(dd,@FecProceso,tblcar.fechavencimiento)
	,	'FecProceso'	= @FecProceso
	,	'HoraEmision'	= @HoraEmision
	,	'Cartera Ori'	= det1.tbglosa
	,	'Portafolio'	= det2.tbglosa
	,	'Valor UF'	= @nValoruf
	,	'Valor USD'	= @nValorusd
	,	'Glosa Mda1'	= ISNULL(mda1.mnnemo,'N/D') 
	,	'Glosa Mda2'	= ISNULL(mda2.mnnemo,'N/D') 
	,	'TipoOpe'	= tblcar.Tipo_Operacion
	,	'Grupo 1'	= (CASE WHEN tblcar.Tipo_Operacion='C' THEN ' COMPRA' ELSE ' VENTA' END) +' ' + RTRIM(mda1.mnnemo) + '/' + RTRIM(mda2.mnnemo)
	FROM TBL_CARTICKETFWD tblcar 	LEFT JOIN BacFwdSuda.dbo.TBL_RESTICKETFWD 	tblres	ON tblcar.fecha_operacion = tblres.fecha
													AND tblcar.numero_operacion = tblres.numero_operacion 
													AND tblcar.numero_operacion_relacion = tblres.numero_operacion_relacion
					LEFT JOIN BacFwdSuda.dbo.VIEW_MONEDA 		mda1 	ON mda1.mncodmon = tblcar.codmoneda1
					LEFT JOIN BacFwdSuda.dbo.VIEW_MONEDA 		mda2 	ON mda2.mncodmon = tblcar.codmoneda2
					LEFT JOIN BacParamsuda..TABLA_GENERAL_DETALLE 	det1 	ON det1.tbcateg='204' AND det1.tbcodigo1 = tblcar.codcarteraorigen
					LEFT JOIN BacParamsuda..TABLA_GENERAL_DETALLE 	det2 	ON det2.tbcateg='245' AND det2.tbcodigo1 = tblcar.codmesaorigen

	WHERE codigo_producto = 1
	AND DATEDIFF(dd,@FecProceso,tblcar.fechavencimiento) > 0
	ORDER BY tblcar.Tipo_Operacion, mda1.mnnemo, mda2.mnnemo, det1.tbglosa, det2.tbglosa
	SET NOCOUNT OFF

END


GO
