USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RPT_MOVTOSDEFIM]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SP_RPT_MOVTOSDEFIM 0

CREATE PROCEDURE [dbo].[SP_RPT_MOVTOSDEFIM]
@NumOper INTEGER
AS
/*
JBH, 13-11-2009.  Retorna movtos. de Renta Fija Intramesas asociados al número de operación asociado.
*/
SET NOCOUNT ON

DECLARE @TipoOp VARCHAR(4),
	@FechaOp DATETIME,
	@Meses VARCHAR(200),
	@posMes INTEGER,
	@nombreMes VARCHAR(20),
	@sepFecha VARCHAR(10),
	@txtFecha VARCHAR(30),
	@CarteraOrigen VARCHAR(50),
	@CarteraDestino VARCHAR(50),
	@MesaOrigen VARCHAR(50),
	@MesaDestino VARCHAR(50)

SELECT 	@Meses = 'Enero     Febrero   Marzo     Abril     Mayo      Junio     Julio     Agosto    SeptiembreOctubre   Noviembre Diciembre '

SELECT TOP 1
@TipoOp = Tipo_Operacion,
@FechaOp = Fecha_Operacion,
@CarteraOrigen = (SELECT tbglosa FROM bacparamsuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1=CodCarteraOrigen AND tbcateg=204),
@CarteraDestino = (SELECT tbglosa FROM bacparamsuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1=CodCarteraDestino AND tbcateg=204),
@MesaOrigen = (SELECT tbglosa FROM bacparamsuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1=CodMesaOrigen AND tbcateg=245),
@MesaDestino = (SELECT tbglosa FROM bacparamsuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1=CodMesaDestino AND tbcateg=245)
FROM TBL_MOVTicketRtaFija
WHERE Numero_Operacion = @NumOper
AND Estado = 'V'



SELECT 	@posMes = MONTH(@FechaOp),
	@sepFecha = ' de ',
	@nombreMes = RTRIM(SUBSTRING(@Meses,(@posMes-1)*10+1,10))

SELECT	@txtFecha = CONVERT(VARCHAR(2),DAY(@FechaOp))+@sepFecha+@nombreMes+@sepFecha+CONVERT(VARCHAR(4),YEAR(@FechaOp))



declare @Datos numeric(5)
 set @Datos = (select count(*) FROM TBL_MOVTicketRtaFija
WHERE Numero_Operacion = @NumOper
AND Tipo_Operacion = @TipoOp
AND Estado = 'V')





if @Datos <> 0
begin
SELECT 
@txtFecha AS 'Fecha_Movto', 
@TipoOp AS 'Tipo_Op',
Nemotecnico,
Numero_Operacion,
Correlativo,
(SELECT mnnemo FROM bacparamsuda..MONEDA WHERE mncodmon = Moneda_Emision) AS 'Moneda',
Valor_Nominal,
Tir,
pvp,
Valor_Presente,
Fecha_Vencimiento,
@CarteraOrigen AS 'CarteraOrigen',
@CarteraDestino AS 'CarteraDestino',
@MesaOrigen AS 'MesaOrigen',
@MesaDestino AS 'MesaDestino',
'Logo_Banco' = (select bannerlargoContrato	FROM bacparamsuda..Contratos_ParametrosGenerales)
FROM TBL_MOVTicketRtaFija
WHERE Numero_Operacion = @NumOper
AND Tipo_Operacion = @TipoOp
AND Estado = 'V'
ORDER BY Correlativo_Operacion
SET NOCOUNT OFF

end
else
begin
SELECT 
	'Fecha_Movto'	= 0,
	'Tipo_Op'		= '',
	'Nemotecnico'	= '',
	'Numero_Operacion'	= 0,
	'Correlativo'		= 0,
	'Moneda'			= '',
	'Valor_Nominal'		= 0,
	'Tir'				= 0,
	'pvp'				= 0,
	'Valor_Presente'	= 0,
	'Fecha_Vencimiento'	= '',
	'CarteraOrigen'		= '',
	'CarteraDestino'	= '',
	'MesaOrigen'		= '',
	'MesaDestino'		= '',
	'Logo_Banco' = (select bannerlargoContrato	FROM bacparamsuda..Contratos_ParametrosGenerales)
--FROM TBL_MOVTicketRtaFija
--WHERE Numero_Operacion = @NumOper
--AND Tipo_Operacion = @TipoOp
--AND Estado = 'V'
--ORDER BY Correlativo_Operacion
SET NOCOUNT OFF
end

GO
