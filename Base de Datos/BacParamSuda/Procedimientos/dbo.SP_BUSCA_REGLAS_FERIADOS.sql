USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_REGLAS_FERIADOS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_REGLAS_FERIADOS] 
 AS
 BEGIN
 	
    SELECT * FROM TBL_ReglasFestivos
	
 END

GO
