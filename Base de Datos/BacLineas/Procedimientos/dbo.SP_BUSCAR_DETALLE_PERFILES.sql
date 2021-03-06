USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_DETALLE_PERFILES]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCAR_DETALLE_PERFILES]( @numero NUMERIC(10) )
AS 
BEGIN  
set nocount on
SELECT PERFIL_DETALLE_CNT.*,
       CAMPO_CNT.descripcion_campo ,
       ISNULL(PLAN_DE_CUENTA.descripcion,'NO Existe') 
  FROM PERFIL_CNT,
       CAMPO_CNT,
	   PERFIL_DETALLE_CNT
	   RIGHT OUTER JOIN PLAN_DE_CUENTA ON PLAN_DE_CUENTA.cuenta = rtrim(ltrim(PERFIL_DETALLE_CNT.codigo_cuenta))
 WHERE PERFIL_DETALLE_CNT.folio_perfil = @numero
   AND PERFIL_CNT.folio_perfil         = @numero
   AND CAMPO_CNT.tipo_operacion        = PERFIL_CNT.tipo_operacion
   AND CAMPO_CNT.codigo_campo          = PERFIL_DETALLE_CNT.codigo_campo

 ORDER BY PERFIL_DETALLE_CNT.Correlativo_perfil
END 
GO
