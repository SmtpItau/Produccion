USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_AYUDACLIENTEB]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_AYUDACLIENTEB]
AS 
BEGIN
 SET NOCOUNT ON

    SELECT 'RUT'  = STR(clrut) + '-' + cldv
    ,      clcodigo
    ,      clnombre
    ,      STR(clrut)
    ,      cldv  
      FROM VIEW_CLIENTE 
     WHERE cltipcli = 1 
  ORDER BY clnombre

 SET NOCOUNT OFF
END
GO
