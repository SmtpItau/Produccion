USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDCCLeerRut]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_MDCCLeerRut](@ccrut     NUMERIC(9,0),   
    @ccrutcod     CHAR   (  1)
          )
AS
BEGIN
set nocount on
   SELECT       ccrut                               ,
         ccrutcod                            ,
                CCMONEDA       ,
  CCBANCO                             ,
         CCCUENTA                            ,
  CCCSWIFT           ,
  CCCSUC         ,
  CCCODIGO 
   
          FROM  mecc    WHERE ccrut     = @ccrut
                         and  ccrutcod  = @ccrutcod
SET NOCOUNT OFF
END 






GO
