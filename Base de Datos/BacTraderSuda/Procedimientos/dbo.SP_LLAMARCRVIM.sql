USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLAMARCRVIM]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LLAMARCRVIM]
/*
JBH, 15-12-2009
*/
@usuario CHAR(12)
AS
BEGIN

DECLARE @fechaProceso datetime,
	@cantidadRec float,
	@cantidadRev float

SELECT 	@cantidadRec = 0.0,
	@cantidadRev = 0.0

SELECT @fechaProceso = acfecproc FROM MDAC
BEGIN TRANSACTION

SET NOCOUNT ON 
INSERT INTO tbl_movticketrtafija
(
Fecha_Operacion,		--1
Numero_Documento,		--2
Correlativo,			--3
Numero_Documento_Relacion,	--4
Correlativo_Relacion,		--5
Numero_Operacion,		--6
Correlativo_Operacion,		--7
CodCarteraOrigen,		--8
CodMesaOrigen,			--9
CodCarteraDestino,		--10
CodMesaDestino,		--11
Tipo_Operacion,			--12
Nemotecnico,			--13
Mascara,			--14
CodigoInstrumento,		--15
Fecha_Emision,			--16
Fecha_Vencimiento,		--17
Moneda_Emision,
Tasa_Emision,			--18
Seriado,				--19
Base_Emision,			--20
Rut_Emision,			--21
Valor_Nominal,			--22
Tir,				--23
pvp,				--24
vpar,				--25
Tir_Estimada,			--26
Valor_Presente,			--27
Valor_Compra,			--28
Valor_Compra_UM,		--29
Valor_Tasa_Emision,		--30
Valor_PrimaDescto,		--31
Valor_InicialPacto,		--32
Valor_VencimientoPacto,		--33
Usuario,				--34
Pagohoy,			--35
Fecha_Activacion,		--36
Estado)				--37

SELECT 
@fechaProceso,	
car.Numero_Documento,	
car.Correlativo,		
car.Numero_Documento_Relacion,	
car.Correlativo_Relacion,		
car.Numero_Operacion,		
(SELECT Correlativo_Operacion FROM tbl_movticketrtafija WHERE Numero_Operacion = car.Numero_Operacion),
car.CodCarteraOrigen,		
car.CodMesaOrigen,			
(SELECT CodCarteraDestino FROM tbl_movticketrtafija WHERE Numero_Operacion = car.Numero_Operacion),
(SELECT CodMesaDestino FROM tbl_movticketrtafija WHERE Numero_Operacion = car.Numero_Operacion),
CASE car.Tipo_Operacion WHEN 'CI' THEN 'RC' WHEN 'VI' THEN 'RV' END,
car.Nemotecnico,	
car.Mascara,	
car.CodigoInstrumento,	
(SELECT Fecha_Emision FROM tbl_movticketrtafija WHERE Numero_Operacion = car.Numero_Operacion),
car.Fecha_Vencimiento,		--17
car.Moneda,
(SELECT Tasa_Emision FROM tbl_movticketrtafija WHERE Numero_Operacion = car.Numero_Operacion),
car.Seriado,	
(SELECT Base_Emision FROM tbl_movticketrtafija WHERE Numero_Operacion = car.Numero_Operacion),
(SELECT Rut_Emision FROM tbl_movticketrtafija WHERE Numero_Operacion = car.Numero_Operacion),
car.Valor_Nominal,
car.Tir,
car.pvp,
car.vpar,
car.Tir_Estimada,
car.Valor_Presente,
car.Valor_Compra,
car.Valor_Compra_UM,
car.Valor_Tasa_Emision,
car.Valor_PrimaDescto,
car.Valor_InicialPacto,
car.Valor_VencimientoPacto,		--33
@usuario,
car.Pagohoy,
@fechaProceso,
'V'
FROM tbl_carticketrtafija car
WHERE car.Fecha_Vencimiento <= @fechaProceso
AND car.Tipo_Operacion in ('CI','VI')

IF @@error <> 0
BEGIN
	SELECT 'NO','PROBLEMAS EN GRABACION DEL ARCHIVO DE MOVIMIENTOS'
	ROLLBACK TRANSACTION
	SET NOCOUNT OFF
	RETURN
END

SELECT @cantidadRec = COUNT(*)
FROM tbl_carticketrtafija car
WHERE car.Fecha_Vencimiento <= @fechaProceso
AND car.Tipo_Operacion in ('VI')

SELECT @cantidadRev = COUNT(*)
FROM tbl_carticketrtafija car
WHERE car.Fecha_Vencimiento <= @fechaProceso
AND car.Tipo_Operacion in ('CI')

DELETE tbl_carticketrtafija
WHERE Fecha_Vencimiento <= @fechaProceso
AND Tipo_Operacion in ('CI','VI')

IF @@error <> 0
BEGIN
	SELECT 'NO','PROBLEMAS EN ELIMINACION EN TABLA CARTERA INTRAMESAS RTA. FIJA DE MOVTOS. CON PACTO'
	ROLLBACK TRANSACTION
	SET NOCOUNT OFF
	RETURN
END
SELECT 'OK','SE REALIZARON ' + RTRIM(CONVERT(CHAR(7), @cantidadRec))+' RECOMPRAS Y ' + RTRIM(CONVERT(CHAR(7), @cantidadRev)) + ' REVENTAS.'
COMMIT TRANSACTION

SET NOCOUNT OFF
END


GO
