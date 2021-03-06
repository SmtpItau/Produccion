USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RCLEERNOMBRES]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RCLEERNOMBRES]
            (@Rcnombre1 CHAR (50))
AS
BEGIN
 -- Restringe n£mero de filas a consulta
set nocount on
 SET ROWCOUNT 50
        SELECT rccodcar    ,
               rcrut       ,
               rcdv        ,
               rcnombre    ,
               rcnumoper   ,
               rctelefono  ,
               rcfax       ,
               rcdirecc   
        FROM
               VIEW_ENTIDAD
        WHERE 
               rcnombre  > @rcnombre1
        ORDER BY
               rcnombre
 -- De vuelve el valor normal 
 SET ROWCOUNT 0
set nocount off
       RETURN
END

GO
