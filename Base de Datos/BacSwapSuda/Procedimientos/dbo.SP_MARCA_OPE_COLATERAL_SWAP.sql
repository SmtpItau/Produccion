USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MARCA_OPE_COLATERAL_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_MARCA_OPE_COLATERAL_SWAP '20181031'
CREATE PROCEDURE [dbo].[SP_MARCA_OPE_COLATERAL_SWAP]
(
		@NRO_OPERACION	NUMERIC(9)
	,	@COLATERAL		VARCHAR(3)
)
AS 
BEGIN

SET NOCOUNT ON
SET DATEFORMAT YMD

DECLARE @RUT_CLIENTE		NUMERIC(9)
DECLARE @COD_CLIENTE		NUMERIC(9)

	if EXISTS (select 1 from BacSwapSuda..CARTERA where numero_operacion=@NRO_OPERACION )
	begin
		select TOP 1 @RUT_CLIENTE=rut_cliente,@COD_CLIENTE=codigo_cliente from BacSwapSuda..CARTERA where numero_operacion=@NRO_OPERACION
		if EXISTS (select 1 from BacParamSuda..OPE_COLATERAL where id_sistema='SWP' and numero_operacion=@NRO_OPERACION )
		begin
			UPDATE BacParamSuda..OPE_COLATERAL
				set Cod_Colateral=@COLATERAL
			where id_sistema='SWP' and numero_operacion=@NRO_OPERACION
		end		
		ELSE
		begin
			INSERT INTO BacParamSuda..OPE_COLATERAL
			SELECT	@RUT_CLIENTE
			,		@COD_CLIENTE
			,		'SWP'
			,		@NRO_OPERACION
			,		@COLATERAL
		end		
	end
	
END
GO
