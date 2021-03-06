USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CLIENTE]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_CLIENTE]
AS   
BEGIN
     SET NOCOUNT ON
     SELECT clrut                         ,  -- 1
            cldv                          ,  -- 2
            clcodigo                      ,  -- 3
            clnombre                      ,  -- 4
     --       clcodigoBCCH                  ,  -- 5
     --       clcodigoSBIF                  ,  -- 6
            cldirecc                   ,  -- 7
            clcomuna                      ,  -- 8
            clciudad                      ,  -- 10
           
            clregion                      ,  -- 12
            clpais                        ,  -- 14
            clfono                        ,  -- 16
            clfax                         ,  -- 17
            clchips     ,  -- 18
            claba                 ,  -- 19
            clswift     ,-- 20
            clctacte                      ,  -- 21
            clctausd                      ,  -- 22
      --      clnumsin                      ,  -- 23
      --      clnomsin                      ,  -- 24
            cltipcli                 ,  -- 25
      --      clgenerico                    ,  -- 26
            clmercado      ,                  -- 27
           mxcontab
     
       FROM CLIENTE  ORDER BY clnombre
--      WHERE (clrut        = @RutCli  OR @RutCli  = 0)
--        AND (clcodigo     = @CodCli  OR @CodCli  = 0)
set nocount off
END
GO
