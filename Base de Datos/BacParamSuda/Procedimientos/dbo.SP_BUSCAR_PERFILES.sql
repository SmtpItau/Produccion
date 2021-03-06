USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_PERFILES]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BUSCAR_PERFILES]
   (   @Idsistema   CHAR(3)
   ,   @Usuario     CHAR(20)
   ,   @Numero      NUMERIC(5)
   )
AS 
BEGIN

   SET NOCOUNT ON

   SELECT @Idsistema   = id_sistema
   FROM   PERFIL_CNT 
   WHERE  folio_perfil = @Numero

   SELECT id_sistema
   ,      tipo_movimiento
   ,      tipo_operacion
   ,      folio_perfil
   ,      codigo_instrumento
   ,      moneda_instrumento
   ,      tipo_voucher
   ,      glosa_perfil
   FROM   PERFIL_CNT 
   WHERE  folio_perfil = @Numero

   DELETE PASO_CNT 
   WHERE  id_sistema  = @idsistema
   AND    usuario     = @usuario
   AND    perfil      = @numero 

   INSERT INTO PASO_CNT
   SELECT @Idsistema
   ,      @Usuario
   ,      ISNULL(correlativo_perfil,0)
   ,      ISNULL(valor_dato_campo,'')
   ,      ISNULL(codigo_cuenta,'')
   ,      ISNULL(Descripcion,'')    -- ISNULL((SELECT Descripcion FROM PLAN_DE_CUENTA WHERE RTRIM(Cuenta) = RTRIM(codigo_cuenta)),'')
   ,      ISNULL(folio_perfil,0)
   FROM   PERFIL_VARIABLE_CNT
          LEFT JOIN PLAN_DE_CUENTA ON RTRIM(Cuenta) = RTRIM(codigo_cuenta)
   WHERE  folio_perfil = @Numero  

END

GO
