USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDCCRut]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_MDCCRut](@nrutcli     NUMERIC(9,0),   
    @ndigito     CHAR   (  1),
           @ncodcli     NUMERIC(9,0)
          )
AS
BEGIN
set nocount on
   SELECT       clrut                                ,
                cldv                                 ,
                clcodigo                             ,
                clnombre                             ,
                clgeneric                            ,
                convert( char(10), clfecingr, 103 )  ,
                clctacte                             ,
                clnomb1                              ,
                clnomb2                              ,
                clapelpa                             ,
                clapelma                             ,
                clnemo                               ,
                clctausd                             ,
                climplic                             ,
                clswift                              ,
  clopcion                             ,
  convert(char(10),clvctolineas,103)   
   
          FROM  CLIENTE    WHERE clrut     = @nrutcli
                         and  (cldv     = @ndigito  or  @ndigito = 0)
                         and  clcodigo  = @ncodcli
SET NOCOUNT OFF
END 






GO
