USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_EXTRAE_DATOS_CLIENTE]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_EXTRAE_DATOS_CLIENTE](@nrutcli     NUMERIC(9,0),   
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
                clgeneric                            
   
          FROM  CLIENTE    WHERE clrut     = @nrutcli
                         and  (cldv     = @ndigito  or  @ndigito = 0)
                         and  clcodigo  = @ncodcli
SET NOCOUNT OFF
END 
GO
