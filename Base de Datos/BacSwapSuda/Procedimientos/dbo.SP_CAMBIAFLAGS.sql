USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAMBIAFLAGS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CAMBIAFLAGS]  
		(	@opcion	INTEGER	,
			@valor	INTEGER
		)
AS
BEGIN

   SET NOCOUNT ON

	IF @opcion = 1 
		UPDATE SWAPGENERAL SET devengo = @valor, contabilidad = 0 , findia = 0  

	IF @opcion = 2
		UPDATE SWAPGENERAL SET contabilidad = @valor , findia = 0  

   SET NOCOUNT OFF
END

GO
