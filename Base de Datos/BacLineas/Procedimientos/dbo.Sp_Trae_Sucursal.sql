USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Trae_Sucursal]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_Trae_Sucursal]
 (
 @Codigo_Sucursal CHAR(5)
 )
AS
BEGIN
SET NOCOUNT ON
 SELECT Codigo_Sucursal, Nombre
 FROM sucursal 
 WHERE CODIGO_Sucursal = @CODIGO_SUCURSAL
SET NOCOUNT OFF
END






GO
