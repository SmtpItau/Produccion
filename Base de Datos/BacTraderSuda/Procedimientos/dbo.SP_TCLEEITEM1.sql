USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TCLEEITEM1]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TCLEEITEM1]
                              ( @tccodtab1 NUMERIC(3,0),
                                @tccodigo1 NUMERIC(05)    )
AS
BEGIN      
set nocount on
 
   SELECT tbcodigo1, tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg =  @tccodtab1 AND convert(numeric(6),tbcodigo1) = @tccodigo1
set nocount off
RETURN
END

GO
