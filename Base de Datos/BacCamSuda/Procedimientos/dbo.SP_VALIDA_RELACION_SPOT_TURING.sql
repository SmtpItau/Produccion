USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_RELACION_SPOT_TURING]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_VALIDA_RELACION_SPOT_TURING]
   (   @nNumeroOperacion		   NUMERIC(21,5)  
   )
AS
BEGIN

	SET NOCOUNT ON

	DECLARE  @Existe INT

	SET @Existe = 0

	SELECT @Existe = 1 FROM BacFwdSuda.dbo.mfca  WHERE canumoper = @nNumeroOperacion
	
	SELECT Resultado = @Existe

END

GO
