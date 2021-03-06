USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_LOG_ADMIN]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORME_LOG_ADMIN]
   ( @fecha1 datetime  ,
    @fecha2 datetime  
   )
AS
BEGIN
SELECT 
  logsistema  ,
  loguser     ,
  logfecha        ,
  logfechaapp     ,
  loghora   ,  
  logevento ,
  'acnomoprop' = (SELECT acnomprop from VIEW_MDAC),
  'HORA'= CONVERT(CHAR(10),GETDATE(),108)
    FROM LOG_USUARIO 
      WHERE logfecha >= @FECHA1 
    AND logfecha <= @FECHA2
END
GO
