USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_AYUDACLIENTEB]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_AYUDACLIENTEB]
AS BEGIN
 SET NOCOUNT ON
 SELECT 'RUT'=STR(clrut) + '-' + cldv, clcodigo,clnombre , STR(clrut),cldv  FROM CLIENTE WHERE cltipcli = 1 Order By clnombre
 SET NOCOUNT OFF
END
GO
