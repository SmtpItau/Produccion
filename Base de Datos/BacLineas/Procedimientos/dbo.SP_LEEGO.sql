USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEGO]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEEGO] (@emnombre1 CHAR (35) = '')
AS
BEGIN   
      set nocount on 
 SELECT  clarutcli ,claglosa ,cldv,clnombre,clcodigo  
      FROM  ABREVIATURA_CLIENTE , CLIENTE
       WHERE  (claglosa  >= @emnombre1 OR @emnombre1 = '')
           AND clarutcli=clrut
         AND  clacodigo=clcodigo
         ORDER  BY  claglosa
END  
GO
