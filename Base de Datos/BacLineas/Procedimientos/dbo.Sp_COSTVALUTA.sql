USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_COSTVALUTA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROC [dbo].[Sp_COSTVALUTA]
AS
BEGIN
SELECT GLOSA, COSTO_DE_FONDO FROM FORMA_DE_PAGO
END 






GO
