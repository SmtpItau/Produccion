USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RET_CODIGOMONEDA]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RET_CODIGOMONEDA]
(	@codTexto	VARCHAR(8)
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT mncodmon
	FROM Bacparamsuda.dbo.MONEDA
	WHERE mnnemo = @codTexto
END

GO
