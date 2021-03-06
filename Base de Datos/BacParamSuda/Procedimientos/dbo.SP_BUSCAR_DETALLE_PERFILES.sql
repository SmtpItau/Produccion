USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_DETALLE_PERFILES]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BUSCAR_DETALLE_PERFILES]
   (   @numero    NUMERIC(10)
   ,   @sistema   CHAR(3)
   )
AS 
BEGIN  

   SET NOCOUNT ON

   SELECT pd.*
   ,      c.descripcion_campo 
   ,      ISNULL(pc.descripcion,'No Existe') 
   FROM   PERFIL_DETALLE_CNT        pd
          INNER JOIN PERFIL_CNT     p  ON pd.Folio_Perfil = p.Folio_Perfil
          INNER JOIN CAMPO_CNT      c  ON p.id_sistema = c.id_sistema AND p.tipo_movimiento = c.tipo_movimiento AND p.tipo_operacion  = c.tipo_operacion and pd.codigo_campo = c.codigo_campo
          LEFT  JOIN PLAN_DE_CUENTA pc ON pc.cuenta = pd.codigo_cuenta
   WHERE  pd.Folio_Perfil              = @numero
   ORDER  BY pd.Correlativo_perfil
   

END

GO
