USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RECUPERAOPERACIONESENVIOBOLSA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RECUPERAOPERACIONESENVIOBOLSA]
as
BEGIN
	select 'Id'=right('0000000000'+convert(varchar,Id), 10), 
		   Tipo, 
		   'Monto' =right('000000000000'+replace(convert(varchar,Monto),'.',''),12), 
		   'Moneda'=right('000'+convert(varchar,MONEDA),3), 
		   'CotraMoneda'=right('000'+convert(varchar,CotraMoneda),3), 
		   'TipoCambio'=right('00000000'+replace(convert(varchar,TipoCambio),'.',''),8), 
		   'Paridad'=right('00000000'+replace(convert(varchar,Paridad),'.',''),8), 
		   'Precio'=right('00000000'+replace(convert(varchar,Precio),'.',''),8), 
		   'PrecioTransferencia'=right('00000000'+replace(convert(varchar, convert(numeric(19,4), PrecioTransferencia)),'.',''),8), 
		   'RutClienteFinal'=right('0000000000'+convert(varchar,RutClienteFinal), 10), 
		   DvClienteFinal, 
		   Origen, 
		   'Fecha'=convert(char(8),Fecha,112), 
		   'Entregamos'=right('000'+convert(varchar,Entregamos), 3) + Space(17), 
		   'ValutaEntregamos'=convert(char(8),ValutaEntregamos,112), 
		   'Recibimos'=right('000'+convert(varchar,Recibimos), 3) + Space(17), 
		   'ValutaRecibimos'=convert(char(8),ValutaRecibimos,112), 
		   ESTADO, 
		   TipoMercado, 
		   Filler 
		   From TxOnlineCorredora where Reserva = '*' 
END
GO
