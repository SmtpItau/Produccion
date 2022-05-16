USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNTDOCCUSTO_CMBPRODUCTO]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MNTDOCCUSTO_CMBPRODUCTO]
AS BEGIN
 SELECT Codigo_Producto, Descripcion, Id_Sistema 
  FROM VIEW_PRODUCTO
   WHERE Codigo_Producto <> '4'
    and Id_Sistema='bfw'
  order by Descripcion
END



GO
