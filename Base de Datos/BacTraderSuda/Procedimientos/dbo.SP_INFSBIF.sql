USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFSBIF]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFSBIF]
AS
BEGIN
  SET NOCOUNT ON
 
	SELECT  familia,
	ctabcch = convert(char(8),ctabcch),
	compinst =convert(char(8),compinst),
	moneda = (CASE WHEN LEN(moneda) = 2 THEN '0' + convert(char(3),moneda) ELSE convert(char(3),moneda) END),
	vpresente,
	vmercado,
	salnomi,
	fecpro,
	HORA = RIGHT(GETDATE(),8)
 FROM MDP17
END
  
  
   


GO
