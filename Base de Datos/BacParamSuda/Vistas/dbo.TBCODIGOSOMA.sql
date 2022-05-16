USE [BacParamSuda]
GO
/****** Object:  View [dbo].[TBCODIGOSOMA]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.TBCODIGOSOMA    fecha de la secuencia de comandos: 04/04/2001 13:38:50 ******/
CREATE VIEW [dbo].[TBCODIGOSOMA]
AS SELECT
      codigo_numerico,
      codigo_caracter,
      glosa,
      codigo_tabla
   FROM 
      AYUDA_PLANILLA
   WHERE
      codigo_tabla = 14 
  AND codigo_numerico > 0

GO
