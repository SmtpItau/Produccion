USE [BacParamSuda]
GO
/****** Object:  View [dbo].[View_FamiliasBonEx]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[View_FamiliasBonEx]
AS
SELECT  Cod_familia	,
	Nom_Familia	,
	Descrip_familia	,
	Base_calculo 	
 
FROM BACBonosExtSuda..text_fml_inm



GO
