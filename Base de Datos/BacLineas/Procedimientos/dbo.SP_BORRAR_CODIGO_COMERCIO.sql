USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_CODIGO_COMERCIO]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BORRAR_CODIGO_COMERCIO](
					    @comercio CHAR(6),
					    @concepto CHAR(3),
					    @borrar   CHAR(1) = 'N',
					    @newcodigo CHAR(5)
				          )
AS
BEGIN
SET NOCOUNT ON   
---- Valida la existencia de codigos en tabla general de Planillas generadas
IF EXISTS (SELECT 1 FROM PLANILLA_SPT WHERE ltrim(codigo_comercio) = @newcodigo)
BEGIN  
     IF @borrar <> 'S'
     BEGIN
          SELECT -1,'Error: Existen Planillas relacionadas con estos códigos'
          set nocount off 
          RETURN
     END
END
BEGIN TRANSACTION 
      IF EXISTS (SELECT 1 FROM CODIGO_COMERCIO WHERE ltrim(codigo_relacion) = @newcodigo AND concepto=@concepto)
         BEGIN  
              DELETE FROM CODIGO_COMERCIO
                    WHERE ltrim(codigo_relacion) = @newcodigo 
                          AND concepto=@concepto
              IF @@ERROR<>0 BEGIN
                 ROLLBACK TRANSACTION
                 SELECT -2,'Error: No puede ser Eliminado'
                 SET NOCOUNT OFF
                 RETURN
              END
              ---- Sólo Si existe esta tabla lo elimina
              IF EXISTS (SELECT 1 FROM CODIGO_PLANILLA_AUTOMATICA WHERE (@comercio = comercio OR @newcodigo = comercio))
                 DELETE FROM CODIGO_PLANILLA_AUTOMATICA
                       WHERE (@comercio  = comercio OR @newcodigo = comercio) 
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
