USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SIID_LISTAR_BROKER]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SIID_LISTAR_BROKER]
AS
BEGIN
	SELECT tbglosa,nemo FROM BacParamSuda..TABLA_GENERAL_DETALLE  WHERE tbcateg=1203 and nemo!=''
END 
GO
