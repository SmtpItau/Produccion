USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTACARTKINMESA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTACARTKINMESA]
AS 
BEGIN
   SET NOCOUNT ON

   DECLARE @dFechaProceso   DATETIME
       SET @dFechaProceso   = (SELECT fechaproc FROM SWAPGENERAL with(nolock))

	SELECT	'numero_operacion'		= numero_operacion,
		'Fecha_Inicio'			= a.Fecha_Inicio_Compra,
		'Fecha_Vcto_Ultimo_Pago'	= a.Fecha_Vcto_Ultimo_Pago,
		'Moneda_Compra'			= (SELECT MNGLOSA FROM  View_Moneda  where mncodmon = a.Moneda_Compra),
		'Valor_Nominal_Compra'		= a.Valor_Nominal_Compra,
		'Tasa_Compra'			= a.Tasa_Compra,
	        'Modalidad' 			= ISNULL((CASE Modalidad WHEN 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END),' '), 
		'CodCarteraOrigen'		= ori.tbglosa,
/*                                                   RTRIM(ISNULL((SELECT rcnombre FROM VIEW_TIPO_CARTERA
							WHERE 	rcsistema		= 'PCS'
							AND	RCCODPRO		= 'FR'
							AND	rcrut			=a.CodCarteraOrigen),'No Especificado')),*/
		'CodCarteraDestino'		= des.tbglosa,
/*                                 RTRIM(ISNULL((SELECT rcnombre FROM VIEW_TIPO_CARTERA
							WHERE 	rcsistema		= 'PCS'
							AND	RCCODPRO		= 'FR'
							AND	rcrut			=a.CodCarteraDestino),'No Especificado')),*/
		'CodMesaOrigen'			= RTRIM(ISNULL((SELECT tbglosa FROM dbo.VIEW_TABLA_MESA
						  WHERE 	tbcodigo1=a.CodMesaOrigen),'No Especificado')),
	  'CodMesaDestino'		= RTRIM(ISNULL((SELECT tbglosa FROM dbo.VIEW_TABLA_MESA WHERE tbcodigo1=a.CodMesaDestino),'No Especificado')),
		'USUARIO'			= a.USUARIO,
		'numero_operacion_relacional'	= numero_operacion_relacional
   FROM    TBL_CARTICKETSWAP a
           LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE ori ON ori.tbcateg = 204 and ori.tbcodigo1 = a.CodCarteraOrigen
           LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE des ON des.tbcateg = 204 and des.tbcodigo1 = a.CodCarteraDestino
   WHERE   A.Fecha_operacion <= @dFechaProceso
   ORDER BY numero_operacion

END
GO
