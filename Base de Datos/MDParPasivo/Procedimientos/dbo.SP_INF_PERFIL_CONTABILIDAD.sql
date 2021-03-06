USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_PERFIL_CONTABILIDAD]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INF_PERFIL_CONTABILIDAD]
               ( --@iid_sistema         CHAR(3)   = ' '
		 --, @icodigo_producto    CHAR(5)   = ' '
                   @icodigo_operacion   CHAR(3)   = ' '
               )
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

      IF EXISTS ( SELECT 1 FROM PARAMETRIA_CONTABLE             a
                              , CODIGO_OPERACION_CONTABLE       b
                              , CONCEPTO_CONTABLE               c
                              , CONCEPTO_PROGRAMA_CONTABLE      d
                              , MONEDA                          e
               
                          WHERE (a.codigo_operacion = @icodigo_operacion OR  @icodigo_operacion = ' ')

                            AND a.codigo_operacion   = b.codigo_operacion
                            AND a.Concepto_contable  = c.concepto_contable
                            AND a.concepto_programa = d.concepto_programa
                            AND a.moneda             = e.mncodmon
       )    BEGIN   

         SELECT 'id_sistema'             = ''
              , 'codigo_producto'        = ''
              , 'codigo_operacion'       = a.codigo_operacion
              , 'descripcion_operacion'  = b.descripcion
              , 'codigo_concepto'        = a.concepto_programa
              , 'descripcion_concepto'   = d.descripcion
              , 'numero_secuencia'       = a.numero_secuencia
              , 'codigo_moneda'          = a.moneda
              , 'moneda'                 = e.mnnemo
              , 'centro_origen'          = a.centro_origen
              , 'centro_destino'         = a.centro_destino
              , 'codigo_contable'        = a.concepto_contable
              , 'descripcion_contable'   = c.descripcion
              , 'existencia_datos'       = ' '
              , 'TITULO'                 = 'INFORME DE PARAMETRIA QH'
              , 'Tipo_monto'             = a.Tipo_monto
           FROM PARAMETRIA_CONTABLE             a
              , CODIGO_OPERACION_CONTABLE       b
              , CONCEPTO_CONTABLE               c
              , CONCEPTO_PROGRAMA_CONTABLE      d
              , MONEDA                          e
               
          WHERE  (a.codigo_operacion = @icodigo_operacion OR  @icodigo_operacion = ' ')

            AND a.codigo_operacion   = b.codigo_operacion
            AND a.Concepto_contable  = c.concepto_contable
            AND a.concepto_programa  = d.concepto_programa
            AND a.moneda             = e.mncodmon
	    and b.codigo_producto    = d.codigo_producto
	    and b.id_sistema         = d.id_sistema

          ORDER BY 
	        a.codigo_operacion
              , a.concepto_programa
              , a.numero_secuencia

   
      END ELSE BEGIN

         SELECT 'id_sistema'             = ' '
              , 'codigo_producto'        = ' '
              , 'codigo_operacion'       = ' '
              , 'descripcion_operacion'  = ' '
              , 'codigo_concepto'        = ' '
              , 'descripcion_concepto'   = ' '
              , 'numero_secuencia'       = CONVERT(INT,0)
              , 'codigo_moneda'          = ' '
              , 'moneda'                 = ' '
              , 'centro_origen'          = ' '
              , 'centro_destino'         = ' '
              , 'codigo_contable'        = ' '
              , 'descripcion_contable'   = ' '
              , 'existencia_datos'       = 'NO EXISTE INFORMACION'
              , 'TITULO'                 = 'INFORME DE PARAMETRIA QH'
              , 'Tipo_Monto'             = ' '  
      END
SET NOCOUNT OFF
END


-- dbo.SP_INF_PERFIL_CONTABILIDAD  'AAU'
GO
