USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_USLEER]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_USLEER]
            (@cUsuario CHAR (15))
AS
BEGIN
      SELECT usuario ,
             nombre  ,
             password,
             CONVERT(CHAR(10),fechaexp ,103),
             password2,
             tipoper
             FROM BACUSER
             WHERE usuario = @cUsuario
      RETURN
END


GO
