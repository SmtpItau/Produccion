USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAMBIO_CARTERA_2]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CAMBIO_CARTERA_2]
(
	@nNumOper		as numeric(10)
,	@nCodCartera	as numeric(1)
,	@sSistema		as VARCHAR(3)
,	@sSistema2		as VARCHAR(3)
)
AS
BEGIN
	
	IF @sSistema = 'PCS'
	BEGIN
		if EXISTS ( select 1 from BacSwapSuda.dbo.CARTERA where numero_operacion = @nNumOper) 
		BEGIN
			update BacSwapSuda.dbo.CARTERA
			set cartera_inversion = @nCodCartera
			where numero_operacion = @nNumOper
		END ELSE
		BEGIN
			SELECT -1, 'N° Operacion no se encuentra'
			RETURN
		END
	END
	IF @sSistema = 'BFW'
	BEGIN
		if EXISTS (SELECT 1 FROM BacFwdSuda.dbo.MFCA WHERE canumoper = @nNumOper) 
		BEGIN
			update BacFwdSuda.dbo.MFCA
			set cacodcart = @nCodCartera
			where canumoper = @nNumOper
		END ELSE
		BEGIN
			SELECT -1, 'N° Operacion no se encuentra'
			RETURN
		END
	END	
END

GO
