USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRELIMINAR]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRELIMINAR]
               ( @Fecha DATETIME, @Emisor NUMERIC(10) )
AS
BEGIN  
set nocount on  
 DELETE FROM MDTR
 WHERE trfecha  = @Fecha
   AND (tremisor = @Emisor OR @Emisor = 0)
 
SELECT 'OK'
set nocount off
   RETURN
END


GO
