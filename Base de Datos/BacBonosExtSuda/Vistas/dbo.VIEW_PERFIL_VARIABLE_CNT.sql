USE [BacBonosExtSuda]
GO
/****** Object:  View [dbo].[VIEW_PERFIL_VARIABLE_CNT]    Script Date: 11-05-2022 16:32:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[VIEW_PERFIL_VARIABLE_CNT]
AS  
SELECT  folio_perfil,
 correlativo_perfil,
 valor_dato_campo,
 codigo_cuenta
       
FROM BACPARAMSUDA..PERFIL_VARIABLE_CNT




GO
