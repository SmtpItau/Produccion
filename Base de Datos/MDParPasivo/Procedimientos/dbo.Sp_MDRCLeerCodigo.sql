USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDRCLeerCodigo]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_MDRCLeerCodigo] 
       (
        @Id_Sistema CHAR(3),
        @Producto   CHAR(10)
       )
AS
BEGIN
SET NOCOUNT ON 
SET DATEFORMAT dmy
   SELECT       TC.codigo_cartera,
		TC.Descripcion,
                TC.clasificacion_Qh,
		TGC.Descripcion
          FROM  TIPO_CARTERA TC, TIPO_GRUPO_CARTERA TGC
          WHERE TC.Id_Sistema = @Id_Sistema
          AND   TC.codigo_producto = @producto
	  AND	TGC.Codigo_Grupo_Cartera =* TC.Codigo_Grupo_Cartera
SET NOCOUNT OFF
END

GO
