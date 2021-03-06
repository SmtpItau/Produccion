USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_Area_Producto]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Leer_Area_Producto]
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

      SELECT codigo_area,
             descripcion,
             posicion_cambio,
             posicion_futuro,
             contabilidad_btr,
             contabilidad_inv
      FROM AREA_PRODUCTO
      ORDER BY  codigo_area
SET NOCOUNT OFF
END

GO
