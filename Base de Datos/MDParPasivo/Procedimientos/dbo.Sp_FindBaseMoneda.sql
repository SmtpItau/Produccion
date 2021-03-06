USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_FindBaseMoneda]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_FindBaseMoneda] --998
               ( @parcodmoneda	NUMERIC(03) )
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON
	SELECT 	
		'Base' = ISNULL(mnbase,0)
	FROM	
		MONEDA
	WHERE 
		ISNULL(mnmx,' ')<> 'C'
          	AND 	mncodmon = @parcodmoneda
                AND   ESTADO<>'A'
SET NOCOUNT OFF
END

GO
