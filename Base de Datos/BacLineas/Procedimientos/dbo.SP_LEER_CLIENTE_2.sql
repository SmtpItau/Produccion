USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CLIENTE_2]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_CLIENTE_2]
AS   
BEGIN
     SET NOCOUNT ON
     SELECT clrut                         ,  -- 1
            cldv                          ,  -- 2
            clcodigo                      ,  -- 3
            clnombre                      ,  -- 4
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
            cltipcli                 ,  -- 25
            clmercado                        -- 27
     
       FROM CLIENTE  
       WHERE cltipcli = 1
       ORDER BY clnombre            
set nocount off
END
GO
