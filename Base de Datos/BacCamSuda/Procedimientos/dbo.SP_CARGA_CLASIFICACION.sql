USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_CLASIFICACION]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CARGA_CLASIFICACION] --'06'
      (
          @COD_CLA   VARCHAR(5) 
      )
AS
BEGIN
 SELECT descripcion ,codigo_clasificacion_detalle,codigo_clasificacion
   FROM VIEW_CLIENTE_CLASIFICACION_DETALLE
  WHERE codigo_clasificacion = @COD_CLA
END
--         delete view_usuario_activo
-- SELECT descripcion ,codigo_clasificacion_detalle,codigo_clasificacion FROM CLIENTE_CLASIFICACION_DETALLE



GO
