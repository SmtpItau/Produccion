USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MARCA_OPE_COLATERAL]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_MARCA_OPE_COLATERAL 
CREATE PROCEDURE [dbo].[SP_MARCA_OPE_COLATERAL]
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

	if EXISTS (select 1 from Bacfwdsuda..MFCA where canumoper=@NRO_OPERACION )
	begin
		select @RUT_CLIENTE=cacodigo,@COD_CLIENTE=cacodcli from Bacfwdsuda..MFCA where canumoper=@NRO_OPERACION
		if EXISTS (select 1 from BacParamSuda..OPE_COLATERAL where id_sistema='FWD' and numero_operacion=@NRO_OPERACION )
		begin
			UPDATE BacParamSuda..OPE_COLATERAL
				set Cod_Colateral=@COLATERAL
			where id_sistema='FWD' and numero_operacion=@NRO_OPERACION
		end		
		ELSE
		begin
			INSERT INTO BacParamSuda..OPE_COLATERAL
			SELECT	@RUT_CLIENTE
			,		@COD_CLIENTE
			,		'FWD'
			,		@NRO_OPERACION
			,		@COLATERAL
		end		
	end
	
END
GO
