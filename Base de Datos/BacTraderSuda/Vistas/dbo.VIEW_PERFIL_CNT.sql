USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_PERFIL_CNT]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_perfil_cnt    fecha de la secuencia de comandos: 05/04/2001 9:20:54 ******/
/****** Objeto:  vista dbo.view_perfil_cnt    fecha de la secuencia de comandos: 07/02/2001 11:43:18 ******/
CREATE VIEW [dbo].[VIEW_PERFIL_CNT]
AS  
SELECT  id_sistema,
 tipo_movimiento,
 tipo_operacion,
 folio_perfil,
 codigo_instrumento,
 moneda_instrumento,
 tipo_voucher,
 glosa_perfil
FROM  BACPARAMSUDA..PERFIL_CNT

GO
