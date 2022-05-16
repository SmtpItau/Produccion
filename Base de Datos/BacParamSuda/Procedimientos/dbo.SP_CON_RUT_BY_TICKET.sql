USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_RUT_BY_TICKET]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CON_RUT_BY_TICKET] (
	@NroTicket as int
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT rutCliente
	FROM	[dbo].[TBL_ART84_INPWSIBS]
	WHERE  [ID_TICKET] = @NroTicket

END

GO
