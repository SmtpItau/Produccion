USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SEELIMINAR]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SEELIMINAR]
                  (@semascara1 CHAR (12))
AS
BEGIN
 
     DECLARE @Codigo  INTEGER
set nocount on
  
       SELECT @Codigo = 0
  
       SELECT @Codigo   = VIEW_SERIE.secodigo
             FROM   VIEW_SERIE
             WHERE  semascara = @semascara1
  
       DELETE VIEW_SERIE WHERE semascara  = @semascara1 -- Borrar la Serie 
  
       DELETE VIEW_TABLA_DESARROLLO WHERE tdmascara  = @semascara1 -- Borrar la TD
  
       DELETE MDPR WHERE prcodigo   = @codigo     -- Borrar la PR
SELECT 'OK'
set nocount off
RETURN
END

GO
