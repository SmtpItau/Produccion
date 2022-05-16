USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NGINE_BUSCA_GENERIC]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_NGINE_BUSCA_GENERIC] (@clrut numeric(9))
AS
BEGIN
	SELECT TOP 1 isnull(clgeneric,'') 
	FROM bacparamsuda..cliente cl WHERE clrut=@clrut
END
GO
