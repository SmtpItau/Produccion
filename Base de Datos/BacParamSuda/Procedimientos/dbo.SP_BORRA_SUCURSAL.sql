USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRA_SUCURSAL]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BORRA_SUCURSAL]
 (
 @Codigo_Sucursal NUMERIC(2)
 )
AS
BEGIN
DELETE FROM Sucursal where Codigo_Sucursal = @Codigo_Sucursal
 IF @@ERROR <> 0 
  SELECT -1, 'ERROR al eliminar datos'
END
SET NOCOUNT OFF
GO
