USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_EmLeerNombres]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create PROCEDURE [dbo].[Sp_EmLeerNombres]
			(
			@emnombre1 CHAR (30)
			)
AS BEGIN   
SET NOCOUNT ON
SET DATEFORMAT dmy
	--EBQ: Se solucionan problemas de Emisores
	SELECT  emcodigo  ,
        	emrut     ,
        	emdv      ,
        	emnombre  ,
        	emgeneric ,
        	emdirecc  ,
        	emcomuna  ,
        	emtipo
     	FROM
        	EMISOR
     	WHERE
        	emnombre  > @emnombre1
	AND	estado <> 'A'	
     	ORDER BY
        	emnombre
	SET ROWCOUNT 0
  	RETURN
SET NOCOUNT OFF
END

GO
