USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TpLeer]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_TpLeer    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_TpLeer    fecha de la secuencia de comandos: 14/02/2001 09:58:31 ******/
CREATE PROCEDURE [dbo].[Sp_TpLeer]( @prcodigo1  numeric(3,0) ,
                            @prserie1   char   (12)  )
AS
BEGIN
set nocount on
 DECLARE @largo  Integer
        DECLARE @familia CHAR(10)
        SELECT @familia = instrumento.inserie from INSTRUMENTO
        where instrumento.incodigo=@prcodigo1
 
 SELECT @largo=CHARINDEX('!',msmascara) from MASCARA_INSTRUMENTO
        where msfamilia=@familia
     
        SELECT distinct prcodigo, 
  prserie, 
  prcupon, 
  prpremio  
 FROM PREMIO 
 WHERE prcodigo = @prcodigo1  
 AND prserie = SUBSTRING(@prserie1,@largo,1)
set nocount off
RETURN
END






GO
