USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_MONEDA_IDD]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_ACTUALIZA_MONEDA_IDD]	(
														 @cmodulo			VARCHAR(3)
														,@cproducto			VARCHAR(10)
														,@nOperacion		NUMERIC(9)
														,@iMoneda			NUMERIC(4)
													)
AS    
BEGIN
	
/*
NOMBRE              : dbo.SP_ACTUALIZA_MONEDA_IDD.sql
AUTOR               : Daniel Inostroza A. - VMetrix International SpA.
DESCRIPCION			: [NUEVO]-Actualiza la moneda de la operacion en las tablas Transacciones_IDD, LINEA_TRANSACCION, LINEA_TRANSACCION_DETALLE.
FECHA CREACIÓN		: 2017.10.30

HISTÓRICO DE CAMBIOS
FECHA		AUTOR		TAG
----------------------------------------------------------------------------------------------------------------------------------------
2017.10.30	DIA			CREACION SP 


IMPORTANTE
---------- 
Este SP es desarrollado debido a que en Certfiicacion nos percatamos que no se guarda la moneda de la operacion en caso de spot para Turing.
*/	

		IF EXISTS (SELECT 1 FROM Transacciones_IDD WHERE cModulo		= @cmodulo
													AND cProducto		= @cproducto
													AND nOperacion		= @nOperacion)
		BEGIN
			UPDATE ti
				SET nMoneda = @iMoneda
			FROM Transacciones_IDD ti
			WHERE
				cModulo				= @cmodulo
				AND cProducto		= @cproducto
				AND nOperacion		= @nOperacion

		END
END
GO
