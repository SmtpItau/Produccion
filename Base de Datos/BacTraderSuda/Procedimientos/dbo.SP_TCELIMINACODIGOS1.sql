USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TCELIMINACODIGOS1]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TCELIMINACODIGOS1]
                  (@tccodtab1 NUMERIC(3,0))
AS
BEGIN  
set nocount on    
       DELETE VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg =  @tccodtab1
SELECT 'OK'
set nocount off
END

GO
