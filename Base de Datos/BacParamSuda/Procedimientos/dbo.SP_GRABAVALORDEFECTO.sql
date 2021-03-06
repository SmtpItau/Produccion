USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAVALORDEFECTO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAVALORDEFECTO]
     ( @Sistema   		CHAR	(03)		,
       @Producto  		CHAR	(04)		,
       @Area      		CHAR	(04)		,
       @Moneda    		NUMERIC	(03)		,
       @Monto     		NUMERIC	(25)		,
       @cOMA      		NUMERIC	(03)		,
       @cComercio 		CHAR	(06)		,
       @cConcepto 		CHAR	(06)		,
       @Fprecom   		NUMERIC	(03)		,
       @Fpencom   		NUMERIC	(03)		,
       @vOMA      		NUMERIC	(03)		,
       @vComercio 		CHAR	(06)		,
       @vConcepto 		CHAR	(06)		,
       @Fpreven   		NUMERIC	(03)		,
       @Fpenven   		NUMERIC	(03)		,
       @Contabiliza 	CHAR	(01) = 'S' 	,
       @Corres_Compra   NUMERIC	(10)		,
       @Corres_Venta 	NUMERIC	(10) 		,
       @Cliente			INT=0				)
AS
BEGIN
SET NOCOUNT ON
BEGIN TRANSACTION
IF EXISTS (SELECT * FROM CargaOperaciones_DefectoValores WHERE idPlataforma = @Producto
														 AND idProducto     = @Area
														 AND idMoneda1      = @Moneda
														 AND idCliente		= @Cliente
														 AND idoperacion    = 1	)  

BEGIN
   DELETE CargaOperaciones_DefectoValores 
    WHERE idPlataforma	= @Producto
      AND idProducto    = @Area
      AND idMoneda1		= @Moneda
      AND idCliente		= @Cliente
	  AND idOperacion	= 1

	INSERT CargaOperaciones_DefectoValores (
											idProducto,
											idPlataforma,
											idOperacion,
											idMoneda1,
											idCliente,
											Default_sCodigoComercio,
											Default_sCodigoConcepto,
											Default_iFormaPagoMN,
											Default_iFormaPagoMX,
											Default_sCodigoOMA,
											Default_iCodCorresponsal
											)
	VALUES (
			@area,
			@producto,
			1,
			@Moneda,
			@Cliente,
			@cComercio,
			@cConcepto,
			@Fprecom,
			@Fpencom,
			@cOMA,
			@Corres_Compra
			)
END		

ELSE
BEGIN
	INSERT CargaOperaciones_DefectoValores (
											idProducto,
											idPlataforma,
											idOperacion,
											idMoneda1,
											idCliente,
											Default_sCodigoComercio,
											Default_sCodigoConcepto,
											Default_iFormaPagoMN,
											Default_iFormaPagoMX,
											Default_sCodigoOMA,
											Default_iCodCorresponsal
											)
	VALUES (
			@area,
			@producto,
			1,
			@Moneda,
			0,
			@cComercio,
			@cConcepto,
			@Fprecom,
			@Fpencom,
			@cOMA,
			@Corres_Compra
			)
END

IF EXISTS (SELECT * FROM CargaOperaciones_DefectoValores WHERE idPlataforma = @Producto
														 AND idProducto     = @Area
														 AND idMoneda1      = @Moneda
														 AND idCliente		= @Cliente
														 AND idoperacion    = 2	)  

BEGIN
   DELETE CargaOperaciones_DefectoValores 
    WHERE idPlataforma	= @Producto
      AND idProducto    = @Area
      AND idMoneda1		= @Moneda
      AND idCliente		= @Cliente
	  AND idOperacion	= 2

	INSERT CargaOperaciones_DefectoValores (
											idProducto,
											idPlataforma,
											idOperacion,
											idMoneda1,
											idCliente,
											Default_sCodigoComercio,
											Default_sCodigoConcepto,
											Default_iFormaPagoMN,
											Default_iFormaPagoMX,
											Default_sCodigoOMA,
											Default_iCodCorresponsal
											)
	VALUES (@Area,
			@Producto,
			2,
			@Moneda,
			@Cliente,
			@cComercio,
			@cConcepto,
			@Fpreven,
			@Fpenven,
			@cOMA,
			@Corres_Venta
			)
		
END

ELSE
BEGIN
	INSERT CargaOperaciones_DefectoValores (
											idProducto,
											idPlataforma,
											idOperacion,
											idMoneda1,
											idCliente,
											Default_sCodigoComercio,
											Default_sCodigoConcepto,
											Default_iFormaPagoMN,
											Default_iFormaPagoMX,
											Default_sCodigoOMA,
											Default_iCodCorresponsal
											)
	VALUES (@Area,
			@Producto,
			2,
			@Moneda,
			0,
			@cComercio,
			@cConcepto,
			@Fpreven,
			@Fpenven,
			@cOMA,
			@Corres_Venta
			)
END

IF @@error <> 0  BEGIN
   ROLLBACK TRANSACTION
   RETURN
END
   
COMMIT TRANSACTION
END
 
 
 
 
 
GO
