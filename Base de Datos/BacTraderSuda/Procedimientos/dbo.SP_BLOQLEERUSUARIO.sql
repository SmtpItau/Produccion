USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BLOQLEERUSUARIO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BLOQLEERUSUARIO]
AS
BEGIN
   SELECT usuario, nombre, ISNULL( idconect, '0' ), ISNULL( idbloqueo, '0' ) FROM BACUSER
END


GO
