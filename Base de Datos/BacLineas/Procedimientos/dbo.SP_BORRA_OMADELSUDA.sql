USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRA_OMADELSUDA]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BORRA_OMADELSUDA]( @codigo   NUMERIC(2) )
AS
BEGIN

	SET NOCOUNT ON

	DELETE 	tbomadelsuda
	WHERE	codi_opera = @codigo

	SET NOCOUNT OFF

END
GO
