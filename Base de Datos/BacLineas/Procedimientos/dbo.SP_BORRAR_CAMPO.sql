USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_CAMPO]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_BORRAR_CAMPO    fecha de la secuencia de comandos: 03/04/2001 15:17:58 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_BORRAR_CAMPO    fecha de la secuencia de comandos: 14/02/2001 09:58:23 ******/
CREATE PROCEDURE [dbo].[SP_BORRAR_CAMPO]( 
     @id_sistema       CHAR(3),
                                   @tipo_movimiento  CHAR(3),  
                                   @tipo_operacion   CHAR(3),  
                                   @codigo_campo     NUMERIC(3)
                                 )
AS
BEGIN
     --<< Valida recepcion de datos
     IF @codigo_campo <= 0
        BEGIN
             SELECT -1, 'No se recibio Valor para ser Eliminado'
             RETURN
        END
     --<< Valida Existencia de Valor en Tabla
     IF NOT EXISTS (SELECT 1 FROM CAMPO_CNT WHERE  id_sistema          = @id_sistema
                                                   AND tipo_movimiento = @tipo_movimiento
                                                   AND tipo_operacion  = @tipo_operacion
                                                   AND codigo_campo    = @codigo_campo )
        BEGIN
             SELECT -1, 'No Existe Valor(es) para ser Eliminado'
             RETURN
        END
     --<< Valida Existencia de Valor en Perfiles
     IF EXISTS (SELECT 1 FROM PERFIL_DETALLE_CNT a, PERFIL_CNT b
                        WHERE  b.id_sistema   = @id_sistema   
                          AND  a.folio_perfil = b.folio_perfil
                          AND (a.codigo_campo = @codigo_campo OR a.codigo_campo_variable = @codigo_campo) )
        BEGIN
             SELECT -1, 'Valor NO puede ser Eliminado, ya que se encuentra registrado en pTrfil(es) contable(s)'
             RETURN
        END
     --<< Elimina 
     DELETE FROM CAMPO_CNT WHERE (id_sistema      = @id_sistema      OR @id_sistema      = '')
                                  AND (tipo_movimiento = @tipo_movimiento OR @tipo_movimiento = '')
                                  AND (tipo_operacion  = @tipo_operacion  OR @tipo_operacion  = '')
                                  AND (codigo_campo    = @codigo_campo    OR @codigo_campo    =  0)
     IF @@error <> 0
        SELECT -1, 'No se puede actualizar Valor a Tablas Contables'
END 
GO
