USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Retorna_FechaContrato]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--CONTRATO_Condiciones_Generales_Swap 91021000,1,6865868,6865868,9853769,9853769,0,0,0,0

--91021000
--2013-11-05 00:00:00.000

--Fx_Retorna_FechaContrato 91021000 , 1

CREATE FUNCTION [dbo].[Fx_Retorna_FechaContrato]
	(	@nRutCliente		NUMERIC(11)
	,	@nCodCliente		NUMERIC(10)
	)	RETURNS				VARCHAR(40)
AS
BEGIN

	declare @cFecha datetime


	set @cFecha = ( select 'FechaFinal' = case	when Condiciones.Fecha = '19000101' then (select acfecproc from BacFwdSuda.dbo.Mfac)
								else Condiciones.Fecha
							end
	from	(	SELECT 'Fecha' = case	when  NUEVO_CCG_FIRMADO = 'S' then FECHA_FIRMA_NUEVO_CCG
										else  clFechaFirma_cond
									end
				from	bacparamsuda.dbo.cliente 
				where	clrut = @nRutCliente and Clcodigo = @nCodCliente
			)	Condiciones
			)

	return @cFecha

end
GO
