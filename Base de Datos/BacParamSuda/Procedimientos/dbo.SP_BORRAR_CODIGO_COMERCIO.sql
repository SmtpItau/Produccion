USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_CODIGO_COMERCIO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Borrar_Codigo_Comercio    fecha de la secuencia de comandos: 03/04/2001 15:17:58 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Borrar_Codigo_Comercio    fecha de la secuencia de comandos: 14/02/2001 09:58:23 ******/
CREATE PROCEDURE [dbo].[SP_BORRAR_CODIGO_COMERCIO](
        @comercio CHAR(6),
        @concepto CHAR(3),
                                           @borrar   CHAR(1) = 'N'
             )
AS
BEGIN
SET NOCOUNT ON
---- Valida la existencia de codigos en tabla general de Planillas generadas
IF EXISTS (SELECT 1 FROM PLANILLA_SPT 
                   WHERE codigo_comercio = @comercio AND concepto = @concepto)
BEGIN   
     IF @borrar <> 'S'
     BEGIN
          SELECT -1,'Error: Existen Planillas relacionadas con estos códigos'
          set nocount off 
          RETURN
     END
END
BEGIN TRANSACTION
      IF EXISTS (SELECT 1 FROM CODIGO_COMERCIO
                         WHERE @comercio = codigo_relacion AND @concepto = concepto)
         BEGIN
            DELETE FROM CODIGO_COMERCIO WHERE @comercio = codigo_relacion AND @concepto = concepto
            IF @@ERROR<>0
               BEGIN
                  ROLLBACK TRANSACTION
                  SELECT -2,'Error: No puede ser Eliminado'
                  SET NOCOUNT OFF
                  RETURN
               END
            ---- Sólo Si existe esta tabla lo elimina
            IF EXISTS (SELECT 1 FROM CODIGO_PLANILLA_AUTOMATICA
                               WHERE @comercio = comercio AND @concepto = concepto)
               DELETE FROM CODIGO_PLANILLA_AUTOMATICA
               WHERE @comercio = comercio AND @concepto = concepto
         END
      ELSE
          BEGIN
             ROLLBACK TRANSACTION
             SELECT -3,'Error: No Existen Códigos'
             SET NOCOUNT OFF
             RETURN
          END
      COMMIT TRANSACTION
      SELECT 0,'OK'
      SET NOCOUNT OFF
END
GO
