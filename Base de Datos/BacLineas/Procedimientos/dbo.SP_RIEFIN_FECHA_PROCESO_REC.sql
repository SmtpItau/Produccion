USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_FECHA_PROCESO_REC]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_RIEFIN_FECHA_PROCESO_REC]
AS 
BEGIN
    SET NOCOUNT ON
	select acfecante from BacTraderSuda..mdac
END
GO
