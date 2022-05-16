USE [BacBonosExtSuda]
GO
/****** Object:  View [dbo].[VIEW_PERFIL_CNT]    Script Date: 11-05-2022 16:32:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



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
