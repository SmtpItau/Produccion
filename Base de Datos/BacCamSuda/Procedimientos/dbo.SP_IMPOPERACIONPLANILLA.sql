USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPOPERACIONPLANILLA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_IMPOPERACIONPLANILLA]( @Descuadradas CHAR(1) = 'N')
AS 
BEGIN
     SET NOCOUNT ON
     ------<< Agrupa planillas generadas
     SELECT 'Numero_Operacion' = operacion_numero ,
            'Cliente'          = interesado_nombre,
            'Moneda'           = SPACE(3)         ,
            'Monto'            = CONVERT(NUMERIC(19,2), 0 ),
            'Numero_Planilla'  = planilla_numero           ,
            'Moneda_Planilla'  = ISNULL( LEFT(mnsimbol,3), CONVERT(CHAR(3), operacion_moneda)),
            'Monto_OMA'        = monto_origen         ,
            'Tipo_Operacion'   = tipo_operacion_cambio,
            'Comercio'         = codigo_comercio      ,
            'Concepto'         = concepto             ,
            'Glosa'            = SPACE(50),
            'Fecha_Proceso'    = CONVERT( CHAR(10), acfecpro, 103 ),
            'Hora'             = CONVERT( CHAR(10), GETDATE(), 108 )
       INTO #planillas
      FROM view_Planilla_SPT LEFT OUTER JOIN view_moneda ON operacion_moneda = mncodmon      ,
             meac 
      WHERE CONVERT(CHAR(8), planilla_fecha,112) = CONVERT(CHAR(8), acfecpro,112) 
        AND operacion_fecha  <> '19000101'   

/*	   REQ.7619
       FROM view_Planilla_SPT ,
            meac        ,
            view_moneda     
      WHERE operacion_moneda *= mncodmon
        AND CONVERT(CHAR(8), planilla_fecha,112) = CONVERT(CHAR(8), acfecpro,112) 
        AND operacion_fecha  <> '19000101'   -- planillas importadas
*/
     ----<< actualiza glosa de codigos de comercio
     UPDATE #planillas  SET glosa = LEFT(c.glosa,50)
                       FROM view_Codigo_Comercio c
                      WHERE #planillas.comercio = c.comercio
                        AND #planillas.concepto = c.concepto                      
     ----<< actualiza monedas de operacion en planillas
     UPDATE #planillas  SET moneda = mocodmon,
                            monto  = momonmo  
                       FROM memo
                      WHERE numero_operacion = monumope
                        AND moneda_planilla  = mocodmon
     UPDATE #planillas  SET moneda = mocodcnv,
                            monto  = moussme 
                       FROM memo
                      WHERE numero_operacion = monumope
                        AND moneda_planilla <> mocodmon
     ------<< agrega operaciones sin planilla
     --<< genera movimiento del dia
     SELECT monumope, monomcli, mocodmon, momonmo INTO #memo FROM memo WHERE moestatus <> 'R' 
                                                                         AND moestatus <> 'A' 
 
     --<< elimina operaciones ya informadas con planilla
     DELETE #memo FROM #planillas WHERE monumope = numero_operacion 
     --<< agrega moneda conversion de operaciones no informadas con planilla
     INSERT #memo SELECT o.monumope, o.monomcli, o.mocodcnv, o.moussme FROM memo o, #memo c
                                                                      WHERE o.moestatus <> 'R' 
                                                                        AND o.moestatus <> 'A' 
                                                                        AND o.motipmer  = 'ARBI'
                                                                        AND o.monumope  = c.monumope
     ----<< Agrega resultado
     IF @Descuadradas <> 'N' 
        INSERT #planillas   SELECT 0, '', '', 0, 0, '', 0, 0, '', '',  '****** FALTA GENERAR PLANILLA(S) ******',
                                  CONVERT( CHAR(10), acfecpro, 103 ), CONVERT( CHAR(12), GETDATE(), 108 )
                                  FROM meac
                                  
     IF @Descuadradas = 'S'
        DELETE #planillas   WHERE  numero_planilla <> 0
 
     ----<< Resultado
     SELECT * FROM #planillas
END

GO
