USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NUMEROTICKETMESA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_NUMEROTICKETMESA]

AS 
BEGIN
	SET NOCOUNT ON;

	DECLARE @numticket NUMERIC(10,0);

	    SET @numticket =(SELECT AcTicketMesa FROM meac);

	
	UPDATE meac
	   SET AcTicketMesa = AcTicketMesa + 1;
	
	SELECT @numticket  as NumeroOperacion
END

GO
