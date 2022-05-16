USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_IMPUESTO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABA_IMPUESTO]( @valor NUMERIC(19,04) )
AS
BEGIN

	SET NOCOUNT ON
	
	UPDATE 	tabla_general_detalle
	SET	tbvalor = @valor
	WHERE 	tbcateg = 1005

	SET NOCOUNT OFF

END
GO
