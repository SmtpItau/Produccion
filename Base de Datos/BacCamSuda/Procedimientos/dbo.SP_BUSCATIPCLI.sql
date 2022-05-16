USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCATIPCLI]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[SP_BUSCATIPCLI]
		(	@nRut  	NUMERIC(9)	,
			@codigo	NUMERIC(9)
		)

AS BEGIN
	SET NOCOUNT ON
	DECLARE @nTipcli  INTEGER
	
	SELECT @nTipCli = (SELECT cltipcli FROM view_cliente WHERE @nrut=clrut AND clcodigo=@codigo)

        IF @nTipCli = 1
             SELECT 1
        ELSE
             SELECT 0

	SET NOCOUNT OFF

END
GO
