USE [BacParamSuda]
GO
/****** Object:  View [dbo].[view_sadp_bancos]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_sadp_bancos]
AS 
SELECT     Cod_Inst, Clnombre, Clswift, Clrut, Clcodigo, Cldv, Cldirecc
FROM         dbo.CLIENTE
WHERE     (Cltipcli = 1)
  AND	  (Clswift<>'')
  AND     clrut <>97008000

GO
