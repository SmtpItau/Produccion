USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_FLUJO_BONOS]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERT_FLUJO_BONOS]
AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON

DELETE FLUJO_BONOS 

INSERT INTO FLUJO_BONOS 
			( codigo_instrumento,
			  nombre_serie,
			  numero_cupon,
			  fecha_vencimiento,
			  amortizacion,
			  interes,
			  flujo,
			  saldo
			)
			SELECT 
			   ISNULL(TDCODTD,15.0),
			   TDINSTSER,
			   TDCUPON,
			   TDFECVEN,
			   TDAMORT,
			   TDINTERES,
     			   TDFLUJO,
			   TDSALDO
			   
			
			FROM 	DESARROLLO.MDTD 
			  
END

GO
