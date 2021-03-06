USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_SISTEMAS_CF]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCAR_SISTEMAS_CF] (@check INT = 0)
AS
BEGIN
	
	/*
	SP_BUSCAR_SISTEMAS_CF 1
	SP_BUSCAR_SISTEMAS_CF 0
	*/
	
	IF @check = 0	
	BEGIN
	   SELECT id_sistema
			 ,nombre_sistema 
		 FROM bacparamsuda..SISTEMA_CNT 
		WHERE operativo = 'S'
		  and gestion   = 'N'
			and id_sistema in ('PCS', 'BFW')
	END

	IF @check = 1	
	BEGIN
	   SELECT id_sistema
			 ,nombre_sistema 
		 FROM bacparamsuda..SISTEMA_CNT 
		WHERE operativo = 'S'
		  and gestion   = 'N'
			and id_sistema in ('PCS', 'BFW', 'OPT')
	END

END
GO
