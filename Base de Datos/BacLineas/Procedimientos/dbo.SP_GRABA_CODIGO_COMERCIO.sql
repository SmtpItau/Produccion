USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_CODIGO_COMERCIO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABA_CODIGO_COMERCIO](
				           @newcodigo      CHAR(5)     ,
				           @comercio       CHAR(6)     ,
				           @concepto       CHAR(3)     ,
					   @glosa          VARCHAR( 60),
                                           @tipo_documento NUMERIC(3)  ,
                                           @codigo_OMA     NUMERIC(3)  ,
                                           @estadistica    CHAR(1)     ,
                                           @ventanas       CHAR(10)    ,
                                           @paisBCCH       CHAR(1)     ,
                                           @rutBCCH        CHAR(1)     
			                 )
AS
BEGIN
   SET NOCOUNT ON
   BEGIN TRANSACTION
   IF NOT EXISTS (SELECT codigo_relacion FROM CODIGO_COMERCIO WHERE codigo_relacion = @newcodigo)
      BEGIN       -- Agregando
        PRINT 'INSERTANDO ...'
        INSERT CODIGO_COMERCIO( codigo_oma, comercio, concepto, tipo_documento,codigo_relacion)  
                        VALUES(@codigo_OMA,@comercio,@concepto,@tipo_documento,@newcodigo)
          IF @@error<>0
             BEGIN
                 ROLLBACK TRANSACTION
                 SELECT 'NO INSERT'
                 RETURN
             END
      END
   PRINT 'ACTUALIZANDO ...'
   UPDATE CODIGO_COMERCIO
      SET fecha          = GETDATE(),
          glosa          = (CASE WHEN @glosa          = '' THEN glosa          ELSE @glosa          END),
          tipo_documento = (CASE WHEN @tipo_documento =  0 THEN tipo_documento ELSE @tipo_documento END),
          codigo_OMA     = (CASE WHEN @codigo_OMA     =  0 THEN codigo_OMA     ELSE @codigo_OMA     END),
          estadistica    = (CASE WHEN @estadistica    = '' THEN estadistica    ELSE @estadistica    END),
          ventanas       = (CASE WHEN @ventanas       = '' THEN ventanas       ELSE @ventanas       END),
          pais_remesa    = (CASE WHEN @paisBCCH       = '' THEN pais_remesa    ELSE @paisBCCH       END),
          rut_BCCH       = (CASE WHEN @rutBCCH        = '' THEN rut_BCCH       ELSE @rutBCCH        END)
    WHERE @newcodigo = codigo_relacion 
          IF @@error<>0
            BEGIN
                ROLLBACK TRANSACTION
                SELECT 'NO UPDATE'
                RETURN
            END
    COMMIT TRANSACTION
    SELECT 'OK'
END
GO
