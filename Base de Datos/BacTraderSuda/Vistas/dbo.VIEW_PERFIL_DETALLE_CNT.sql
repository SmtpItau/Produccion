USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_PERFIL_DETALLE_CNT]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_Perfil_detalle_cnt    fecha de la secuencia de comandos: 05/04/2001 9:20:54 ******/
/****** Objeto:  vista dbo.view_Perfil_detalle_cnt    fecha de la secuencia de comandos: 07/02/2001 11:43:19 ******/
CREATE VIEW [dbo].[VIEW_PERFIL_DETALLE_CNT]
AS  
SELECT  folio_perfil,
 codigo_campo,
 tipo_movimiento_cuenta,
 perfil_fijo,
 codigo_cuenta,
 correlativo_perfil,
 codigo_campo_variable
FROM BACPARAMSUDA..PERFIL_DETALLE_CNT

GO
