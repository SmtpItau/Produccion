USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETCODIGOINSTRUMENTO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RETCODIGOINSTRUMENTO]
(	@serie	CHAR(12),
	@opcion CHAR(1)='0'
)
AS
BEGIN
	DECLARE @codigo NUMERIC(5)
	SET NOCOUNT ON
	IF @opcion = '0'
		SELECT @codigo = incodigo FROM Bacparamsuda.dbo.INSTRUMENTO
		WHERE inserie = @serie
	ELSE IF @opcion = '1'
		SELECT @codigo = secodigo FROM Bacparamsuda.dbo.SERIE
		WHERE seserie = @serie

	SELECT @codigo
END
GO
