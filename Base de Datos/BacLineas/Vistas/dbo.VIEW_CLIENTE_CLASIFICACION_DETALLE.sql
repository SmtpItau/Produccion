USE [BacLineas]
GO
/****** Object:  View [dbo].[VIEW_CLIENTE_CLASIFICACION_DETALLE]    Script Date: 13-05-2022 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE VIEW [dbo].[VIEW_CLIENTE_CLASIFICACION_DETALLE]
AS
  SELECT codigo_clasificacion 
  ,      codigo_clasificacion_detalle 
  ,      descripcion
    FROM bacparamsuda..CLIENTE_CLASIFICACION_DETALLE




GO
