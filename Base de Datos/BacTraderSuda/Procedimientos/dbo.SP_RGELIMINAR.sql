USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RGELIMINAR]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RGELIMINAR]
AS
BEGIN  
   set nocount on
   DELETE FROM MDRG 
   SELECT 'OK'
   set nocount off
END

GO
