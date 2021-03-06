USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_PERFIL_CONTABILIDAD]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_ACT_PERFIL_CONTABILIDAD]
               ( @isistema           CHAR(3)
               , @icodigo_producto   CHAR(5)
               , @icodigo_operacion  CHAR(3)
               , @icodigo_concepto   CHAR(5)
               , @inumero_secuencia  NUMERIC(2)
               , @imoneda            NUMERIC(3)
               , @icentro_origen     CHAR(5)
               , @icentro_destino    CHAR(5)
               , @icodigo_contable   CHAR(5)
               , @iTipo_Monto        CHAR(1)
               )
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy
/*
   IF NOT EXISTS (SELECT 1 FROM PARAMETRIA_CONTABLE   WHERE id_sistema       = @isistema 
                                                      AND codigo_producto    = @icodigo_producto
                                                      AND codigo_operacion   = @icodigo_operacion
                                                      AND concepto_programa   = @icodigo_concepto
                                                      AND numero_secuencia   = @inumero_secuencia
                 )
   
      INSERT INTO PARAMETRIA_CONTABLE 
                ( id_sistema
                , codigo_producto
                , codigo_operacion
                , concepto_programa  
                , numero_secuencia
                , moneda
                , centro_origen
                , centro_destino
                , Concepto_contable
                , Tipo_monto
                )
           VALUES
                ( @isistema
                , @icodigo_producto
                , @icodigo_operacion
                , @icodigo_concepto
                , @inumero_secuencia
                , @imoneda
                , @icentro_origen
                , @icentro_destino
                , @icodigo_contable
                , @iTipo_Monto
                )
               

   ELSE
*/
    DECLARE @iContador              INTEGER
        ,   @iTotal                 INTEGER
        ,   @cMensaje               VARCHAR(1000)
        ,   @cCodigo_Operacion      VARCHAR(10)


    SELECT DISTINCT PAR.concepto_programa INTO #TEMP_CONCEPTO FROM PARAMETRIA_CONTABLE PAR
            WHERE 
                  codigo_operacion   = @icodigo_operacion
             AND  NOT EXISTS(SELECT 1 FROM CONCEPTO_PROGRAMA_CONTABLE CON WHERE CON.id_sistema        = @isistema
                                                                            AND CON.codigo_producto   = @icodigo_producto
                                                                            AND PAR.concepto_programa = CON.concepto_programa)

   SELECT @iTotal = COUNT(1) FROM #TEMP_CONCEPTO
   SELECT @iContador = 1

    SET @cMensaje = ''

    WHILE @iContador <= @iTotal
    BEGIN
        SET ROWCOUNT @iContador
            SELECT @cCodigo_Operacion = concepto_programa
                FROM #TEMP_CONCEPTO
        
        SET ROWCOUNT 0
        SET @iContador = @iContador + 1

        SET @cMensaje = LTRIM(RTRIM(@cMensaje)) + '- ' + RTRIM(LTRIM(@cCodigo_Operacion)) + CHAR(10)

    END

    IF @cMensaje <> '' BEGIN
        SELECT 'NO','No existen los siguientes conceptos programas a donde quiere traspasar la parametria : ' + CHAR(10) + CHAR(10) + @cMensaje
        RETURN
    END  

    IF NOT EXISTS(SELECT 1 FROM CODIGO_OPERACION_CONTABLE 
                  WHERE CODIGO_OPERACION = @icodigo_operacion
                  AND  id_sistema =  @isistema
                  AND  codigo_producto = @icodigo_producto) BEGIN

        SELECT 'NO','No existe código de operación asociado a este Producto y Sistema'
        RETURN
        
    END
   IF NOT EXISTS(SELECT 1 FROM RESULTADO_CONTABLE WHERE codigo_operacion = @icodigo_operacion AND id_sistema         = @isistema)
       IF EXISTS( SELECT 1 FROM PARAMETRIA_CONTABLE 
                           WHERE       codigo_operacion   = @icodigo_operacion
                                AND    id_sistema         = @isistema
                                AND    codigo_producto    = @icodigo_producto
                                AND    numero_secuencia   = @inumero_secuencia
                                AND    concepto_programa  = @icodigo_concepto
                ) BEGIN
                  UPDATE PARAMETRIA_CONTABLE 
                     SET id_sistema         = @isistema
                       , codigo_producto    = @icodigo_producto
                  WHERE       codigo_operacion   = @icodigo_operacion
                       AND    id_sistema         = @isistema
                       AND    codigo_producto    = @icodigo_producto
                       AND    numero_secuencia   = @inumero_secuencia

        END ELSE BEGIN

                  INSERT INTO PARAMETRIA_CONTABLE 
                    ( id_sistema
                    , codigo_producto
                    , codigo_operacion
                    , concepto_programa  
                    , numero_secuencia
                    , moneda
                    , centro_origen
                    , centro_destino
                    , Concepto_contable
                    , Tipo_monto
                    )
                   VALUES
                    ( @isistema
                    , @icodigo_producto
                    , @icodigo_operacion
                    , @icodigo_concepto
                    , @inumero_secuencia
                    , @imoneda
                    , @icentro_origen
                    , @icentro_destino
                    , @icodigo_contable
                    , @iTipo_Monto
                    )

        END

    ELSE
        SELECT 'NO','Codigo de operacion ya tiene registros asociados no se puede modificar'

   SET NOCOUNT OFF

END



GO
