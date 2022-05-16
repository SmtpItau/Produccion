USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_INTERFAZ]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_INTERFAZ]
AS
      SELECT   codigo_cartera
      ,        rut_entidad
      ,        id_sistema
      ,        codigo_area
      ,        codigo_interfaz
      ,	       nombre
      ,        descripcion
      ,        ruta_acceso
      ,        tipo_interfaz
      FROM BacParamSuda..INTERFAZ



-- Base de Datos --
GO
