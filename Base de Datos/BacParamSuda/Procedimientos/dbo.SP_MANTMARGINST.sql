USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MANTMARGINST]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MANTMARGINST]
   (   @p_accion             CHAR(01)-- I=Insertar Reg; E=Eliminar por Familia; C=Consulta
   ,   @p_Codigo_Instrumento    NUMERIC(5)   = 0
   ,   @p_Clasificacion_Riesgo  CHARACTER(3) = ''
   ,   @p_plazo_desde        NUMERIC(5,0) = 0
   ,   @p_plazo_hasta        NUMERIC(5,0) = 0
   ,   @p_margen             FLOAT        = 0
   ,   @p_Tipo_OpSoma           CHARACTER(3) = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @p_accion = 'I'--Inserta
      BEGIN

         INSERT INTO MARGEN_INSTRUMENTO_SOMA
         (   Codigo_instrumento
         ,   Clasificacion_Riesgo
         ,   Plazo_desde
         ,   Plazo_hasta
         ,   Margen
         ,   Tipo_OpSoma 
         )
         VALUES
         (   @p_codigo_instrumento
         ,   @p_Clasificacion_Riesgo
         ,   @p_plazo_desde
         ,   @p_plazo_hasta
         ,   @p_margen
         ,   @p_Tipo_OpSoma 
         )

      END
   BEGIN

      IF @p_accion = 'E'--Elimina
   BEGIN

      DECLARE @EXISTE AS INT
      SET @EXISTE = 0

	SELECT @EXISTE =1
	FROM MARGEN_INSTRUMENTO_SOMA
	WHERE Codigo_instrumento   = @p_Codigo_instrumento
	AND   Clasificacion_Riesgo = @p_Clasificacion_Riesgo
	AND   Tipo_OpSoma          = @p_Tipo_OpSoma 
	AND   Plazo_desde          = @p_plazo_desde
	AND   Plazo_hasta          = @p_plazo_hasta      
        
	IF @EXISTE =1
      BEGIN
         DELETE FROM MARGEN_INSTRUMENTO_SOMA
               WHERE Codigo_instrumento = @p_codigo_instrumento
                AND   Clasificacion_Riesgo = @p_Clasificacion_Riesgo
                AND   Tipo_OpSoma          = @p_Tipo_OpSoma 
                AND   Plazo_desde          = @p_plazo_desde
                AND   Plazo_hasta          = @p_plazo_hasta
	END
        ELSE
        IF @EXISTE =0
	BEGIN
        	SELECT -1, 'No Existen registros para Borrar'
	END        
         IF @@ERROR=0
            SELECT '000', 'GRABACIÓN EXITOSA.'
         ELSE
            SELECT '004', 'ERROR EN ELIMINACIÓN.'
      END ELSE
      BEGIN
         IF @p_accion = 'C'--Consulta
         BEGIN
            IF EXISTS(SELECT 1 FROM MARGEN_INSTRUMENTO_SOMA WHERE Codigo_instrumento = @p_Codigo_instrumento
								   AND   Clasificacion_Riesgo = @p_Clasificacion_Riesgo
								   AND   Tipo_OpSoma          = @p_Tipo_OpSoma )
            BEGIN

               SELECT Codigo_instrumento
	       ,      Clasificacion_Riesgo	
               ,      Plazo_desde
               ,      Plazo_hasta
               ,      Margen
               ,      Tipo_OpSoma
               FROM   MARGEN_INSTRUMENTO_SOMA
               WHERE  Codigo_instrumento = @p_codigo_instrumento
	       AND    Clasificacion_Riesgo = @p_Clasificacion_Riesgo
	       AND    Tipo_OpSoma          = @p_Tipo_OpSoma
               ORDER BY Codigo_instrumento, Plazo_desde, Plazo_hasta
            END ELSE
            BEGIN
               SELECT '005', 'NO EXISTE INFORMACION'
            END
         END ELSE
         BEGIN
            SELECT '001', 'ERROR EN PARAMTRO DE ACCION'
         END
      END
   END
   
END
GO
