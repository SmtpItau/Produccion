USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_MOVIMIENTO_CNT]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_Movimiento_cnt    fecha de la secuencia de comandos: 05/04/2001 9:20:54 ******/
/****** Objeto:  vista dbo.view_Movimiento_cnt    fecha de la secuencia de comandos: 07/02/2001 11:43:18 ******/
CREATE VIEW [dbo].[VIEW_MOVIMIENTO_CNT]
AS 
SELECT
 id_sistema,
 tipo_movimiento,
 glosa_movimiento,
 tipo_operacion,
 glosa_operacion,
 tipo_voucher_contab,
 tipo_movimiento_caja,
 control_instrumento,
 control_moneda,
 genera_docto
FROM BACPARAMSUDA..MOVIMIENTO_CNT

GO
