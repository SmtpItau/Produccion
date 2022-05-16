USE [BacCamSuda]
GO
/****** Object:  View [dbo].[VIEW_PERFIL_DETALLE_CNT]    Script Date: 11-05-2022 16:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[VIEW_PERFIL_DETALLE_CNT]
AS  
SELECT      folio_perfil,
            codigo_campo,
            tipo_movimiento_cuenta,
            perfil_fijo,
            codigo_cuenta,
            correlativo_perfil,
            codigo_campo_variable
       FROM bacparamsuda..PERFIL_DETALLE_CNT


GO
