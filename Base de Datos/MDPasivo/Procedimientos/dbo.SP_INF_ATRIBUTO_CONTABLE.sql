USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_ATRIBUTO_CONTABLE]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INF_ATRIBUTO_CONTABLE]
AS
BEGIN

   SET DATEFORMAT dmy

   DECLARE @nRegistro         NUMERIC(5)
         , @cConsulta         CHAR(255)
         , @cCodigo           CHAR(15)
         , @cDescripcion      VARCHAR(255)

   SET NOCOUNT ON

      IF EXISTS ( SELECT 1 FROM ATRIBUTO_CONTABLE WHERE estado = 'S')
      BEGIN

         SELECT 'campo'                   = a.campo_atributo
              , 'descripcion'             = a.descripcion
              , 'orden'                   = a.orden
              , 'largo'                   = a.largo
              , 'codigo'                  = b.codigo_utilizacion
              , 'codigo_descripcion'      = b.descripcion
              , 'codigo_relacion'         = b.codigo_relacion
              , 'descripcion_realcion'    = SPACE(255)
              , 'consulta'                = a.campo_consulta
              , 'existencia_datos'        = SPACE(21)
              , 'descripcion_Tabla'       = a.descripcion_tabla
              , 'nRegistro'               = IDENTITY(INT)
           INTO #RISTRA
           FROM ATRIBUTO_CONTABLE          a         
              , ATRIBUTO_CONTABLE_DETALLE  b
          WHERE a.estado         = 'S'
            AND a.campo_atributo = b.campo_atributo

   
         SELECT @nRegistro = 1

          WHILE @nRegistro <= ( SELECT COUNT(1) FROM #RISTRA )
          BEGIN

               SELECT @cConsulta = consulta
                    , @cCodigo   = codigo_relacion
                 FROM #RISTRA 
                WHERE nRegistro  = @nRegistro

   
               EXEC SP_CON_DESCRIPCION_RELACION_ATRIBUTO @cConsulta
                                                       , @cCodigo
                                                       , @cDescripcion   OUTPUT

      
               UPDATE #RISTRA
                  SET descripcion_realcion = @cDescripcion
                WHERE nRegistro  = @nRegistro

               SELECT @nRegistro = @nRegistro +1

          END

          SELECT campo                
               , descripcion                                        
               , orden   
               , largo 
               , codigo          
               , codigo_descripcion                                 
               , codigo_relacion 
               , descripcion_realcion                                                                                                                                                                                                                                            
               , consulta                                                                                                                                                                                                                                                        
               , existencia_datos
               , descripcion_Tabla
            FROM #RISTRA
           ORDER BY
                 Orden

      END ELSE BEGIN

          SELECT 'campo'                 = ' '
               , 'descripcion'           = ' '                         
               , 'orden'                 = ' '
               , 'largo'                 = ' '
               , 'codigo'                = ' '
               , 'codigo_descripcion'    = ' '                         
               , 'codigo_relacion'       = ' '
               , 'descripcion_realcion'  = ' '                                                                                                                                                                                                                                      
               , 'consulta'              = ' '                                                                                                                                                                                                                                      
               , 'existencia_datos'      = ' '
               , 'descripcion_Tabla'     = ' '

      END


   SET NOCOUNT OFF

END

GO
