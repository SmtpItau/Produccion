USE [BacCamSuda]
GO
/****** Object:  View [dbo].[VIEW_CAMPO_CNT]    Script Date: 11-05-2022 16:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[VIEW_CAMPO_CNT]
AS 
SELECT      id_sistema,
            tipo_movimiento,
            tipo_operacion,
            codigo_campo,  
            descripcion_campo,
            nombre_campo_tabla,
            tipo_administracion_campo,
            tabla_campo,
            campo_tabla,
            campos_tablas
       FROM bacparamsuda..CAMPO_CNT


GO
