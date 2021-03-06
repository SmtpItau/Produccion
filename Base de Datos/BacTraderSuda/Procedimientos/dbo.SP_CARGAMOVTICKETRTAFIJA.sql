USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGAMOVTICKETRTAFIJA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CARGAMOVTICKETRTAFIJA]
@fDesde char(8),
@fHasta char(8)
AS

SET NOCOUNT ON
DECLARE @Desde datetime,
	@Hasta datetime

SELECT 	@Desde = CONVERT(datetime, @fDesde),
	@Hasta = CONVERT(datetime, @fHasta)


CREATE TABLE #TicketRtaFijaTmp
(tFecha_Operacion datetime Null,
tnumero_operacion numeric(9) Null,
ttipoOperacion varchar(50) Null,
tveces numeric(5) Null,
tmoneda varchar(20) Null,
ttir numeric(9,4) Null,
tmonto_operacion numeric(21,4) Null,
tvalorinicialpacto numeric(21,4) null,
tvalorvencimientopacto numeric(21,4) Null,
tfecha_vencimiento datetime Null,
tMesaOrigen varchar(50) Null,
tMesaDestino varchar(50) Null,
tCarteraOrigen varchar(50) null,
tCarteraDestino varchar(50) null,
tUsuario varchar(10) null,
tHora varchar(8) Null,
numrel numeric(10) )

INSERT INTO #TicketRtaFijaTmp
(tfecha_operacion,
tnumero_operacion,
ttipoOperacion,
tveces,
ttir,
tmonto_operacion,
tMesaOrigen,
tMesaDestino,
tUsuario,
tCarteraOrigen,
tCarteraDestino,
tHora, numrel)

SELECT  fecha_operacion,
	numero_operacion,
        (SELECT tbglosa FROM bacparamsuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1=tipo_operacion AND tbcateg=8605) AS 'tipoOp',
        COUNT(correlativo_operacion) AS 'veces',
        CONVERT(NUMERIC(5),0) AS 'tir',
        SUM(valor_presente) AS 'monto_operacion',
	(SELECT distinct tbglosa FROM bacparamsuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1=CodMesaOrigen AND tbcateg=245) AS 'MesaOri',
	(SELECT distinct tbglosa FROM bacparamsuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1=CodMesaDestino AND tbcateg=245) AS 'MesaDes',
	Usuario,
	(SELECT distinct tbglosa FROM bacparamsuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1=CodCarteraOrigen AND tbcateg=204) AS 'CartOri',
	(SELECT distinct tbglosa FROM bacparamsuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1=CodCarteraDestino AND tbcateg=204) AS 'CartDes',
	substring(Hora,1,5) AS 'hora',
	numero_documento_relacion
FROM tbl_movticketrtafija
WHERE tipo_operacion in ('CP','VP')
AND Estado = 'V'
AND fecha_operacion between @Desde AND @Hasta
GROUP BY fecha_operacion, numero_operacion, tipo_operacion, CodMesaOrigen, CodMesaDestino, CodCarteraOrigen, CodCarteraDestino, Usuario, substring(Hora,1,5), numero_documento_relacion


INSERT INTO #TicketRtaFijaTmp
(tfecha_operacion,
tnumero_operacion,
ttipoOperacion,
tveces,
ttir,
tmonto_operacion,
tMesaOrigen,
tMesaDestino,
tUsuario,
tCarteraOrigen,
tCarteraDestino,
tHora,
tvalorinicialpacto,
tvalorvencimientopacto,
tfecha_vencimiento,
tmoneda, numrel)

SELECT  fecha_operacion,
	numero_operacion,
        (SELECT tbglosa FROM bacparamsuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1=tipo_operacion AND tbcateg=8605) AS 'tipoOp',
        1,
        Tir,
        valor_presente AS 'monto_operacion',
	(SELECT tbglosa FROM bacparamsuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1=CodMesaOrigen AND tbcateg=245) AS 'MesaOri',
	(SELECT tbglosa FROM bacparamsuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1=CodMesaDestino AND tbcateg=245) AS 'MesaDes',
	Usuario,
	(SELECT tbglosa FROM bacparamsuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1=CodCarteraOrigen AND tbcateg=204) AS 'CartOri',
	(SELECT tbglosa FROM bacparamsuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1=CodCarteraDestino AND tbcateg=204) AS 'CartDes',
	substring(Hora,1,5) AS 'hora',
	Valor_InicialPacto,
	Valor_VencimientoPacto,
	Fecha_Vencimiento,
	(SELECT mnnemo FROM bacparamsuda..MONEDA WHERE mncodmon=moneda_emision) AS 'Moneda',
numero_documento_relacion
FROM tbl_movticketrtafija
WHERE tipo_operacion in ('CI','VI')
AND Estado = 'V'
AND fecha_operacion between @Desde AND @Hasta

SELECT * FROM #TicketRtaFijaTmp
ORDER BY tFecha_Operacion,tnumero_operacion, ttipoOperacion, tveces
DROP TABLE #TicketRtaFijaTmp
SET NOCOUNT OFF


GO
