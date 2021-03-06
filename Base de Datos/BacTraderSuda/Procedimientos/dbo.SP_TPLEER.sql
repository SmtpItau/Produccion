USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TPLEER]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TPLEER]
                          ( @prcodigo1  NUMERIC(3,0) ,
                            @prserie1   CHAR   (12)  )
AS
BEGIN
set nocount on
 
DECLARE @largo  Integer
        DECLARE @familia CHAR(10)
        SELECT @Familia = view_instrumento.inserie from VIEW_INSTRUMENTO
        where view_instrumento.incodigo=@prcodigo1
 
 SELECT @Largo=CHARINDEX('!',msmascara) from VIEW_MASCARA_INSTRUMENTO
        where msfamilia=@Familia
     
        SELECT distinct prcodigo, 
  prserie, 
  prcupon, 
  prpremio  
 FROM MDPR 
 WHERE prcodigo = @prcodigo1  
 AND prserie = SUBSTRING(@prserie1,@largo,1)
set nocount off
RETURN
END

GO
