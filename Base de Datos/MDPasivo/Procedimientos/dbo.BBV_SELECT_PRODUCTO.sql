USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_PRODUCTO]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SELECT_PRODUCTO]
AS
SELECT Id_Sistema,Codigo_Producto,Descripcion,Contabiliza,Gestion
  FROM PRODUCTO
GO
