USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TpLeer]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TpLeer]( @prcodigo1  numeric(3,0) ,
                     	        @prserie1   char   (12)  )
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

	DECLARE @largo 	Integer
       	DECLARE @familia CHAR(10)
       	SELECT @familia = instrumento.inserie from INSTRUMENTO
       	where instrumento.incodigo=@prcodigo1
	
	SELECT @largo=CHARINDEX('!',msmascara) from MASCARA_INSTRUMENTO
       	where msfamilia=@familia
     
       	SELECT distinct	prcodigo, 
		prserie, 
		prcupon, 
		prpremio  
	FROM PREMIO 
	WHERE prcodigo = @prcodigo1  
	AND prserie = SUBSTRING(@prserie1,@largo,1)

END


GO
