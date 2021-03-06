USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MODIFOPETKINMESA]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MODIFOPETKINMESA](
	  @Num_Producto			numeric(10,0)		
	, @MontoMoneda2			float
	, @TipoCambio			float
	, @Precio1			float
	, @Precio2			float
	, @Paridad			float
	, @Hora				varchar(8)
	, @Plazo			smallint
	, @FechaVencimiento		datetime
	, @Modalidad			varchar(1)
	, @Equivalente_CLP		float
	, @Equivalente_USD		float
	, @Serie			varchar(12)
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

	BEGIN TRANSACTION

		UPDATE TBL_CARTICKETFWD
		SET	FechaVencimiento	= @FechaVencimiento,
			MontoMoneda2		= @MontoMoneda2,
			Equivalente_CLP		= @Equivalente_CLP,
			Equivalente_USD		= @Equivalente_USD,
			TipoCambio		= @TipoCambio,
			Precio1			= @Precio1,
			Precio2			= @Precio2,
			Paridad			= @Paridad,
			Mto_Inicial_Mon1	= @Mto_Inicial_Mon1,
			Mto_Final_Mon1		= @Mto_Final_Mon1,
			Mto_Inicial_Mon2	= @Mto_Inicial_Mon2,
			Mto_Final_Mon2		= @Mto_Final_Mon2,
			Modalidad		= @Modalidad,
			Anticipo		= 'S'
		WHERE	Numero_Operacion	= @Num_Producto


		UPDATE TBL_CARTICKETFWD
		SET	FechaVencimiento	= @FechaVencimiento,
			MontoMoneda2		= @MontoMoneda2,
			Equivalente_CLP		= @Equivalente_CLP,
			Equivalente_USD		= @Equivalente_USD,
			TipoCambio		= @TipoCambio,
			Precio1			= @Precio1,
			Precio2			= @Precio2,
			Paridad			= @Paridad,
			Mto_Inicial_Mon1	= @Mto_Inicial_Mon1,
			Mto_Final_Mon1		= @Mto_Final_Mon1,
			Mto_Inicial_Mon2	= @Mto_Inicial_Mon2,
			Mto_Final_Mon2		= @Mto_Final_Mon2,
			Modalidad		= @Modalidad,
			Anticipo		= 'S'
		WHERE	Numero_Operacion_Relacion	 = @Num_Producto

	IF @@error <> 0
	BEGIN
		ROLLBACK TRANSACTION
		SELECT -1, 'NO SE PUEDE INGRESAR LOS DATOS'
		RETURN
	END
	ELSE
		COMMIT

END

GO
