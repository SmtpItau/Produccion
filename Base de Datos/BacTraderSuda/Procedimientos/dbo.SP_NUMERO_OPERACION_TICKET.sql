USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NUMERO_OPERACION_TICKET]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_NUMERO_OPERACION_TICKET] 
AS 
BEGIN
	SET NOCOUNT ON ;

	DECLARE @numero_ticket NUMERIC(10)	;

	SET @numero_ticket =(SELECT acticketmesa FROM mdac) ;
	
	UPDATE MDAC 
	   SET acticketmesa = acticketmesa  + 1;

	SELECT @numero_ticket 

END	


GO
