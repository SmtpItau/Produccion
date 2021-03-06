USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LeeFa]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_LeeFa] (@emnombre1 CHAR (30))
AS BEGIN   
SET DATEFORMAT dmy
SET NOCOUNT ON
	SELECT  codigo  ,
        	glosa  ,
                perfil,
                codgen,
                glosa2,
                cc2756,
            	afectacorr,   
             	diasvalor,
             	numcheque,
                ctacte
        FROM   	FORMA_DE_PAGO
     	WHERE  	glosa  > @emnombre1 AND ESTADO<>'A'
     	ORDER BY
        	glosa
  	RETURN
SET NOCOUNT OFF
END

GO
