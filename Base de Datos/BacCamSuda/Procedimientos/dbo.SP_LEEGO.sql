USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEGO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LEEGO] 
        (@EMNOMBRE1 CHAR (35))
AS
BEGIN   
set nocount on 
 SELECT  clarutcli 
               ,claglosa 
               ,cldv
               ,clnombre
               ,clcodigo  
 FROM  VIEW_ABREVIATURA_CLIENTE, VIEW_CLIENTE
      WHERE  claglosa  >= @EMNOMBRE1 AND clarutcli = clrut
        AND  clacodigo = clcodigo
        ORDER BY
         claglosa
 select 0 
   RETURN
set nocount off
END  



GO
