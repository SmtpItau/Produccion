USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRARPRIV]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BORRARPRIV] (@cUsuario CHAR(15))
AS
BEGIN
      DELETE FROM BACPRIV WHERE usuario = @cUsuario
      RETURN
END


GO
