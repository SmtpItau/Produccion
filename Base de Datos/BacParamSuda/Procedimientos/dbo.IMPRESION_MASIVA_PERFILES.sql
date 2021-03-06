USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[IMPRESION_MASIVA_PERFILES]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[IMPRESION_MASIVA_PERFILES]
   (   @Indice       INTEGER
   ,   @Sistema      CHAR(3)    = ''
   ,   @Movimiento   VARCHAR(5) = ''
   ,   @Operacion    VARCHAR(5) = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @Indice = 1
   BEGIN
      SELECT DISTINCT s.nombre_sistema, p.id_sistema
      FROM   BacparamSuda..PERFIL_CNT p
             INNER JOIN BacParamSuda..SISTEMA_CNT s ON s.id_sistema = p.id_sistema
      ORDER BY s.nombre_sistema
   END

   IF @Indice = 2
   BEGIN
      SELECT DISTINCT glosa_movimiento, tipo_movimiento
      FROM   BacParamSuda..MOVIMIENTO_CNT 
      WHERE  id_sistema = @Sistema
   END

   IF @Indice = 3
   BEGIN
      SELECT DISTINCT glosa_operacion, tipo_operacion 
      FROM   BacParamSuda..MOVIMIENTO_CNT 
      WHERE  id_sistema      = @Sistema
      AND    tipo_movimiento = @Movimiento
   END

   IF @Indice = 4
   BEGIN
      SELECT LTRIM(RTRIM(folio_perfil)) + ' -  ' + glosa_perfil, folio_perfil, * 
      FROM   BacParamSuda..PERFIL_CNT
      WHERE  (id_sistema      = @Sistema    OR @Sistema    = '')
      AND    (tipo_movimiento = @Movimiento OR @Movimiento = '')
      AND    (tipo_operacion  = @Operacion  OR @Operacion  = '')
   END


END

GO
