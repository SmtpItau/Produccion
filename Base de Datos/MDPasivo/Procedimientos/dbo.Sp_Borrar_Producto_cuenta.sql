USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Borrar_Producto_cuenta]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC  [dbo].[Sp_Borrar_Producto_cuenta]
AS
BEGIN
  SET NOCOUNT ON
  SET DATEFORMAT dmy
  DELETE PRODUCTO_CUENTA
END




GO
