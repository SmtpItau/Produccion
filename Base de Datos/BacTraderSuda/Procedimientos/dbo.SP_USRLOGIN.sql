USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_USRLOGIN]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_USRLOGIN]
   (@cUsuario CHAR (15) )
AS
BEGIN
 DECLARE @cPassword CHAR (15) ,
  @dFechaexp DATETIME ,
  @dFechapro DATETIME ,
  @cCodoper CHAR (02) ,
  @cUsername CHAR (40)
 SELECT @cPassword = password  ,
  @dFechaexp = fechaexp  ,
  @cCodoper = ISNULL(codoper,'') ,
  @cUsername = nombre
 FROM BACUSER
 WHERE usuario=@cUsuario
 IF @@ROWCOUNT = 0
 BEGIN
  SELECT 'ERROR ' = 10 , '','',''
  RETURN
 END
 SELECT @dFechapro = acfecproc FROM MDAC
 IF DATEDIFF(DAY,@dFechapro, @dFechaexp)<0
 BEGIN
  SELECT 'Error ' = 20,'','',''
  RETURN
 END
 SELECT 'Error ' = 0  ,
  'Password' = @cPassword ,
  'Codoper' = @cCodoper ,
  'Username' = @cUsername
END

GO
