USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_CAMPO_CNT]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_Campo_cnt    fecha de la secuencia de comandos: 05/04/2001 9:20:53 ******/
/****** Objeto:  vista dbo.view_Campo_cnt    fecha de la secuencia de comandos: 07/02/2001 11:43:18 ******/
CREATE VIEW [dbo].[VIEW_CAMPO_CNT]
AS 
select id_sistema,
 tipo_movimiento,
 tipo_operacion,
 codigo_campo,  
 descripcion_campo,
 nombre_campo_tabla,
 tipo_administracion_campo,
 tabla_campo,
 campo_tabla,
 campos_tablas
FROM BACPARAMsuda..CAMPO_CNT

GO
