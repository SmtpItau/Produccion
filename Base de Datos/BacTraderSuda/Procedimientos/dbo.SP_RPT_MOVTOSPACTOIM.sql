USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RPT_MOVTOSPACTOIM]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RPT_MOVTOSPACTOIM]
@NumOper INTEGER
AS
/*
JBH, 13-11-2009.  Retorna movtos. Con Pacto de Renta Fija, Intramesas asociados al número de operación solicitado.
*/
SET NOCOUNT ON

SELECT 
Tipo_Operacion,
(CASE Tipo_Operacion WHEN 'CI' THEN 'CAPTACION' WHEN 'VI' THEN 'COLOCACION' END) AS 'Operacion',
Numero_Operacion,
(SELECT tbglosa FROM bacparamsuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1=CodCarteraOrigen AND tbcateg=204) AS 'CarteraOrigen',
(SELECT tbglosa FROM bacparamsuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1=CodCarteraDestino AND tbcateg=204) AS 'CarteraDestino',
(SELECT tbglosa FROM bacparamsuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1=CodMesaOrigen AND tbcateg=245) AS 'MesaOrigen',
(SELECT tbglosa FROM bacparamsuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1=CodMesaDestino AND tbcateg=245) AS 'MesaDestino',
(SELECT mnnemo FROM bacparamsuda..MONEDA WHERE mncodmon = Moneda_Emision) AS 'Moneda',
Valor_VencimientoPacto,
Tir,
Fecha_Vencimiento,
Fecha_Emision,
DATEDIFF(d,Fecha_Emision,Fecha_Vencimiento) AS 'Plazo',
Valor_InicialPacto
FROM TBL_MOVTicketRtaFija
WHERE Numero_Operacion = @NumOper
AND Estado = 'V'
ORDER BY Correlativo_Operacion
SET NOCOUNT OFF


GO
