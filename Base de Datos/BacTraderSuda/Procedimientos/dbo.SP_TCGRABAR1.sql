USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TCGRABAR1]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TCGRABAR1]
                  (@tccodtab1 NUMERIC(3,0), 
                   @tccodigo1 NUMERIC(5,0), 
                   @tcglosa1 CHAR(25))
As 
Begin
set nocount on
   
        IF Not (EXISTS(Select tbcodigo1 from VIEW_TABLA_GENERAL_DETALLE Where tbcateg = @tccodtab1 and CONVERT(NUMERIC(6),tbcodigo1) = @tccodigo1))
           INSERT INTO VIEW_TABLA_GENERAL_DETALLE   (   tbcateg ,   tbcodigo1,   tbglosa )
                       VALUES ( @tccodtab1, CONVERT(CHAR(6),@tccodigo1), @tcglosa1 )
        ELSE
           UPDATE VIEW_TABLA_GENERAL_DETALLE SET   tbcateg = @tccodtab1 ,
                             tbcodigo1 = CONVERT(CHAR(6),@tccodigo1) , 
                             tbglosa  = @tcglosa1
                             WHERE tbcateg = @tccodtab1
                             AND CONVERT(NUMERIC(6),tbcodigo1) = @tccodigo1
SELECT 'OK'
set nocount off
END

GO
