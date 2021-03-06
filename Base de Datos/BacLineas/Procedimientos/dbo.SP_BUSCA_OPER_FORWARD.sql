USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_OPER_FORWARD]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_BUSCA_OPER_FORWARD]
	(	@nFolio		NUMERIC(10)		)
AS
BEGIN

   SET NOCOUNT ON

	-->    Control de Existencia de la Operación
   IF NOT EXISTS(SELECT 1 FROM BacFwdSuda.dbo.MFCA WHERE canumoper = @nFolio)
   BEGIN
      SELECT -1, 'Operación No se encuentra en Cartera Forward'
	  RETURN
   END

	SELECT  clnombre
		,	camtomon1
		,	mn.mnnemo
		,	cf.tbglosa
		,	'Rut' = LTRIM(RTRIM(CONVERT(CHAR(10), Clrut))) + '-' + LTRIM(RTRIM(Cldv))
		,	'Operación' = CASE WHEN catipoper = 'C' THEN 'Compra'
							ELSE 'Venta' END
		,	'Moneda'			= LTRIM(RTRIM( mn.mnnemo )) + ' / ' + LTRIM(RTRIM( mnd.mnnemo ))
		,	'Precio Futuro'		= caparmon2
		,	'Dolar Observado'	= capremon1
		,	'Fecha Cierre'		= cafecha
		,	'Fecha Inicio'		= fechaemision
		,	'Fecha Vencimiento'	= cafecvcto
		,	'Dias'				= caplazo
		,	'Pago M/N'			= CASE WHEN FP.codigo > 0 THEN FP.glosa
										ELSE 'No Aplicable' END
		,	'Pago M/X'			= CASE WHEN FP2.codigo > 0 THEN FP2.glosa
										ELSE 'No Aplicable' END
		,	'Modalidad'			= CASE WHEN catipmoda = 'C' THEN 'COMPENSACION'
										ELSE 'ENTREGA FISICA' END
		,	'Libro'				= cf3.tbglosa
		,	'Cartera Super'		= cf5.tbGlosa
		,	'Sub Cartera Super'	= cf4.tbglosa
		,	'Area Responsable'	= cf2.tbglosa
    FROM    BacFwdSuda.dbo.MFCA
			INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = cacodigo and clcodigo = cacodcli
            INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE cf ON cf.tbcateg = 204 AND cf.tbcodigo1 = cacodcart
			LEFT  JOIN BacParamSuda.dbo.MONEDA			 mn ON mn.mncodmon = cacodmon1
			LEFT  JOIN BacParamSuda.dbo.MONEDA			mnd ON mnd.mncodmon = cacodmon2
			LEFT JOIN bacparamsuda.dbo.FORMA_DE_PAGO	FP ON FP.codigo = cafpagomn
			LEFT JOIN bacparamsuda.dbo.FORMA_DE_PAGO	FP2 ON FP2.codigo = cafpagomx
			LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE cf2 ON cf2.tbcateg = 1553 AND cf2.tbcodigo1 = caArea_Responsable
			LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE cf3 ON cf3.tbcateg = 1552 AND cf3.tbcodigo1 = calibro
			LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE cf4 ON cf4.tbcateg = 1554 AND cf4.tbcodigo1 = casubcartera_normativa
			LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE cf5 ON cf5.tbcateg = 1111 AND cf5.tbcodigo1 = cacartera_normativa
    WHERE   canumoper = @nFolio

END
GO
