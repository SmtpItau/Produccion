USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_USELIMINAR]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_USELIMINAR]
                             (@usuario1   CHAR(15))
AS 
BEGIN 
set nocount on
      DELETE
         BACUSER
      WHERE
         usuario = @usuario1
select 'OK'
set nocount off
RETURN
END

GO
