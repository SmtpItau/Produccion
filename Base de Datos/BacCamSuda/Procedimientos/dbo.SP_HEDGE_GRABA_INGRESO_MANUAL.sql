USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGE_GRABA_INGRESO_MANUAL]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_HEDGE_GRABA_INGRESO_MANUAL] (
	 @Fecha_Proceso	DATETIME		
	,@id_hedge	INTEGER			
	,@Origen	VARCHAR(50)	
	,@Concepto	VARCHAR(80)		
	,@Moneda	CHAR(3)		
	,@Monto_Compra	NUMERIC(21,4)		
	,@Monto_Venta	NUMERIC(21,4)		
)
AS BEGIN
	INSERT INTO TBL_HEDGE_INGRESO_MANUAL 
	VALUES	 (@Fecha_Proceso			
		 ,@id_hedge			
		 ,@Origen		
		 ,@Concepto			
		 ,@Moneda			
		 ,@Monto_Compra			
		 ,@Monto_Venta)

	IF @@ERROR > 0
	BEGIN
		SELECT -1,'Error: al insertar tabla TBL_HEDGE_INGRESO_MANUAL'
		RETURN -1	
	END
   RETURN 0
END

GO
