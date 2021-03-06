USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAOPETKINMESA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_GRABAOPETKINMESA](
	  @Fecha_Operacion		datetime
	, @Tipo_Operacion		varchar(1)
	, @Codigo_Producto		smallint
	, @CodCarteraOrigen		smallint
	, @CodMesaOrigen		smallint
	, @CodCarteraDestino		smallint
	, @CodMesaDestino		smallint
	, @CodMoneda1			smallint
	, @MontoMoneda1			float
	, @CodMoneda2			smallint
	, @MontoMoneda2			float
	, @TipoCambio			float
	, @Precio1			float
	, @Precio2			float
	, @Paridad			float
	, @Hora				varchar(8)
	, @Usuario			varchar(10)
	, @Plazo			smallint
	, @FechaVencimiento		datetime
	, @ReferenciaMercado		smallint
	, @FechaFijRefMerc		datetime
	, @ReferenciaParidad		smallint
	, @Fecha_Fijacion_Par		datetime
	, @Fecha_Vecto_Paridad		datetime
	, @Modalidad			varchar(1)
	, @Equivalente_CLP		float
	, @Equivalente_USD		float
	, @Serie			varchar(12)
	, @Estado			varchar(1)
	, @Mto_Inicial_Mon1		float
	, @Mto_Final_Mon1		float
	, @Mto_Inicial_Mon2		float
	, @Mto_Final_Mon2		float)
AS 
BEGIN
   SET NOCOUNT ON
	DECLARE	@nNumProducto   numeric(10,0),
		@nNumProdRela   numeric(10,0),
		@sTipoOpContr	varchar(1),
		@horaF          CHAR(8)
	
	 SET @horaF         = CONVERT(CHAR(08),GETDATE(),108)

	SELECT @nNumProducto = AcTicketMesa
	FROM	MFAC

	UPDATE MFAC
	SET AcTicketMesa = AcTicketMesa + 1

	SET @nNumProdRela = 0

	IF @CodMoneda1 = 994  
		SET @CodMoneda1 =13

	IF @CodMoneda2 = 994
		SET @CodMoneda2=13

	BEGIN TRANSACTION

	INSERT INTO TBL_MOV_TICKETFWD	(	Fecha_Operacion
						, Numero_Operacion
						, Numero_Operacion_Relacion
						, Tipo_Operacion
						, Codigo_Producto
						, CodCarteraOrigen
						, CodMesaOrigen
						, CodCarteraDestino
						, CodMesaDestino
						, CodMoneda1
						, MontoMoneda1
						, CodMoneda2
						, MontoMoneda2
						, TipoCambio
						, Precio1
						, Precio2
						, Paridad
						, Hora
						, Usuario
						, Plazo
						, FechaVencimiento
						, ReferenciaMercado
						, FechaFijRefMerc
						, ReferenciaParidad
						, Fecha_Fijacion_Par
						, Fecha_Vecto_Paridad
						, Modalidad
						, Equivalente_CLP
						, Equivalente_USD
						, Serie
						, Estado)
					VALUES	( @Fecha_Operacion
						, @nNumProducto
						, @nNumProdRela
						, @Tipo_Operacion
						, @Codigo_Producto
						, @CodCarteraOrigen
						, @CodMesaOrigen
						, @CodCarteraDestino
						, @CodMesaDestino
						, @CodMoneda1
						, @MontoMoneda1
						, @CodMoneda2
						, @MontoMoneda2
						, @TipoCambio
						, @Precio1
						, @Precio2
						, @Paridad
						, @horaF
						, @Usuario
						, @Plazo
						, @FechaVencimiento
						, @ReferenciaMercado
						, @FechaFijRefMerc
						, @ReferenciaParidad
						, @Fecha_Fijacion_Par
						, @Fecha_Vecto_Paridad
						, @Modalidad
						, @Equivalente_CLP
						, @Equivalente_USD
						, @Serie
						, 'V')


	INSERT INTO TBL_CARTICKETFWD	(	Fecha_Operacion
						, Numero_Operacion
						, Numero_Operacion_Relacion
						, Tipo_Operacion
						, Codigo_Producto
						, CodCarteraOrigen
						, CodMesaOrigen
						, CodCarteraDestino
						, CodMesaDestino
						, CodMoneda1
						, MontoMoneda1
						, CodMoneda2
						, MontoMoneda2
						, TipoCambio
						, Precio1
						, Precio2
						, Paridad
						, Hora
						, Usuario
						, Plazo
						, FechaVencimiento
						, ReferenciaMercado
						, FechaFijRefMerc
						, ReferenciaParidad
						, Fecha_Fijacion_Par
						, Fecha_Vecto_Paridad
						, Modalidad
						, Equivalente_CLP
						, Equivalente_USD
						, Mto_Inicial_Mon1
						, Mto_Final_Mon1
						, Mto_Inicial_Mon2
						, Mto_Final_Mon2
						, Serie)
					VALUES	( @Fecha_Operacion
						, @nNumProducto
						, @nNumProdRela
						, @Tipo_Operacion
						, @Codigo_Producto
						, @CodCarteraOrigen
						, @CodMesaOrigen
						, @CodCarteraDestino
						, @CodMesaDestino
						, @CodMoneda1
						, @MontoMoneda1
						, @CodMoneda2
						, @MontoMoneda2
						, @TipoCambio
						, @Precio1
						, @Precio2
						, @Paridad
						, @horaF
						, @Usuario
						, @Plazo
						, @FechaVencimiento
						, @ReferenciaMercado
						, @FechaFijRefMerc
						, @ReferenciaParidad
						, @Fecha_Fijacion_Par
						, @Fecha_Vecto_Paridad
						, @Modalidad
						, @Equivalente_CLP
						, @Equivalente_USD
						, @Mto_Inicial_Mon1
						, @Mto_Final_Mon1
						, @Mto_Inicial_Mon2
						, @Mto_Final_Mon2
						, @Serie)


	SET @nNumProdRela= @nNumProducto
	SELECT @nNumProducto = AcTicketMesa
	FROM	MFAC

	UPDATE MFAC SET AcTicketMesa = AcTicketMesa +1

	SET @sTipoOpContr = 'C'

	IF @Tipo_Operacion = 'C' 
		SET @sTipoOpContr='V'
	-- INSERTA LA 

	INSERT INTO TBL_MOV_TICKETFWD	(	Fecha_Operacion
						, Numero_Operacion
						, Numero_Operacion_Relacion
						, Tipo_Operacion
						, Codigo_Producto
						, CodCarteraOrigen
						, CodMesaOrigen
						, CodCarteraDestino
						, CodMesaDestino
						, CodMoneda1
						, MontoMoneda1
						, CodMoneda2
						, MontoMoneda2
						, TipoCambio
						, Precio1
						, Precio2
						, Paridad
						, Hora
						, Usuario
						, Plazo
						, FechaVencimiento
						, ReferenciaMercado
						, FechaFijRefMerc
						, ReferenciaParidad
						, Fecha_Fijacion_Par
						, Fecha_Vecto_Paridad
						, Modalidad
						, Equivalente_CLP
						, Equivalente_USD
						, Serie
						, Estado)
					VALUES	( @Fecha_Operacion
						, @nNumProducto
						, @nNumProdRela
						, @sTipoOpContr
						, @Codigo_Producto
						, @CodCarteraDestino
						, @CodMesaDestino
						, @CodCarteraOrigen
						, @CodMesaOrigen
						, @CodMoneda1   -- Las Monedas se Mantienen para las transacciones Ticket Intramesa
						, @MontoMoneda1 -- Solo debe cambiar el tipo de operacion
						, @CodMoneda2   -- Dado que los datos son los mismos
						, @MontoMoneda2 -- para ambas transacciones
						, @TipoCambio
						, @Precio1
						, @Precio2
						, @Paridad
						, @horaF
						, @Usuario
						, @Plazo
						, @FechaVencimiento
						, @ReferenciaMercado
						, @FechaFijRefMerc
						, @ReferenciaParidad
						, @Fecha_Fijacion_Par
						, @Fecha_Vecto_Paridad
						, @Modalidad
						, @Equivalente_CLP
						, @Equivalente_USD
						, @Serie
						, 'V')


	INSERT INTO TBL_CARTICKETFWD	(	Fecha_Operacion
						, Numero_Operacion
						, Numero_Operacion_Relacion
						, Tipo_Operacion
						, Codigo_Producto
						, CodCarteraOrigen
						, CodMesaOrigen
						, CodCarteraDestino
						, CodMesaDestino
						, CodMoneda1
						, MontoMoneda1
						, CodMoneda2
						, MontoMoneda2
						, TipoCambio
						, Precio1
						, Precio2
						, Paridad
						, Hora
						, Usuario
						, Plazo
						, FechaVencimiento
						, ReferenciaMercado
						, FechaFijRefMerc
						, ReferenciaParidad
						, Fecha_Fijacion_Par
						, Fecha_Vecto_Paridad
						, Modalidad
						, Equivalente_CLP
						, Equivalente_USD
						, Mto_Inicial_Mon1
						, Mto_Final_Mon1
						, Mto_Inicial_Mon2
						, Mto_Final_Mon2
						, Serie)
					VALUES	( @Fecha_Operacion
						, @nNumProducto
						, @nNumProdRela
						, @sTipoOpContr
						, @Codigo_Producto
						, @CodCarteraDestino
						, @CodMesaDestino
						, @CodCarteraOrigen
						, @CodMesaOrigen
						, @CodMoneda1 		  -- Debe Mantener las monedas
						, @MontoMoneda1		  -- y los montos
						, @CodMoneda2
						, @MontoMoneda2
						, @TipoCambio
						, @Precio1
						, @Precio2
						, @Paridad
						, @horaF
						, @Usuario
						, @Plazo
						, @FechaVencimiento
						, @ReferenciaMercado
						, @FechaFijRefMerc
						, @ReferenciaParidad
						, @Fecha_Fijacion_Par
						, @Fecha_Vecto_Paridad
						, @Modalidad
						, @Equivalente_CLP
						, @Equivalente_USD
						, @Mto_Inicial_Mon1
						, @Mto_Final_Mon1
						, @Mto_Inicial_Mon2
						, @Mto_Final_Mon2
						, @Serie)


	IF @@error <> 0
	BEGIN
		ROLLBACK TRANSACTION
		SELECT -1, 'NO SE PUEDE INGRESAR LOS DATOS'
		RETURN
	END
	ELSE
		COMMIT

	SELECT @nNumProdRela,@nNumProducto
END

GO
