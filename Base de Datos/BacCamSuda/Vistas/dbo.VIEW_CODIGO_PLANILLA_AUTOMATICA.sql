USE [BacCamSuda]
GO
/****** Object:  View [dbo].[VIEW_CODIGO_PLANILLA_AUTOMATICA]    Script Date: 11-05-2022 16:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[VIEW_CODIGO_PLANILLA_AUTOMATICA]
AS
 SELECT 
  fecha                       
  ,tipo_documento 
  ,tipo_operacion_cambio 
  ,comercio 
  ,concepto 
  ,condicion  
 FROM 
  bacparamsuda..CODIGO_PLANILLA_AUTOMATICA


GO
