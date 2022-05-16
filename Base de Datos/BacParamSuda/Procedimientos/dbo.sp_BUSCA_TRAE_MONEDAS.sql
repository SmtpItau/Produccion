USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_BUSCA_TRAE_MONEDAS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_BUSCA_TRAE_MONEDAS]
AS 

BEGIN
	SET NOCOUNT ON
	
	SELECT mncodmon, mnglosa, mnsinacofi  
	  FROM moneda 
  ORDER BY mnglosa 

	SET NOCOUNT OFF
END
GO
