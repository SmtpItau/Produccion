USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_SUCURSAL]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_TRAE_SUCURSAL]
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
