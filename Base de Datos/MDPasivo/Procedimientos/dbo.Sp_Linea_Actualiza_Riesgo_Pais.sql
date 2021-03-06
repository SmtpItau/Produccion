USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Linea_Actualiza_Riesgo_Pais]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Linea_Actualiza_Riesgo_Pais]
               ( @fecha_Proceso DATETIME )
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT DMY 


       SELECT    'codigo_pais'          =   (SELECT Clpais FROM CLIENTE WHERE cacodigo = clrut
                                                                          AND cacodcli = clcodigo)
         ,       'numero_operacion'     =   canumoper
         ,       'fechainicio'          =   cafecha
         ,       'fechafinal'           =   cafecvcto
         ,       'montooperacion'       =   caequmon1
         ,       'usuario'              =   caoperador
         INTO    #TMP                 
         FROM    VIEW_CARTERA_FORWARD
        WHERE    cacodpos1    = 2
          and    caestado     = ' '
          and    contabiliza  = 'S'
          and    cafecvcto    > @fecha_Proceso


  INSERT INTO    #TMP                 
       SELECT    'codigo_pais'          =   codigo_pais
         ,       'numero_operacion'     =   numero_operacion
         ,       'fechainicio'          =   fecha_operacion
         ,       'fechafinal'           =   fecha_vencimiento
         ,       'montooperacion'       =   monto_pesos
         ,       'usuario'              =   ( SELECT mooper FROM VIEW_MOVIMIENTO_CAMBIO WHERE monumope = numero_operacion )
         FROM    VIEW_TRANSFERENCIA_PENDIENTE
        WHERE    codigo_producto IN('ARBI','OVER','WEEK')
          AND    fecha_operacion       = @fecha_Proceso
          AND    fecha_vencimiento     > @fecha_Proceso
          AND    estado_transferencia <> 'A'
          AND    codigo_moneda        <> 13




       DELETE FROM RIESGO_PAIS_DETALLE 
/*
         FROM RIESGO_PAIS_DETALLE 
            , #TMP
        WHERE RIESGO_PAIS_DETALLE.codigo_pais      = #TMP.codigo_pais
          AND RIESGO_PAIS_DETALLE.numero_operacion = #TMP.numero_operacion
*/



       UPDATE RIESGO_PAIS SET totalocupado  = ISNULL(( SELECT SUM(montooperacion) FROM #TMP WHERE RIESGO_PAIS.codigo_pais = #TMP.codigo_pais ),0)
                         FROM RIESGO_PAIS


       INSERT    INTO RIESGO_PAIS_DETALLE
                    ( codigo_pais 
                    , numero_operacion 
                    , fechainicio                 
                    , fechafinal                  
                    , montooperacion        
                    , usuario    
                    )
                 
               SELECT            
                      codigo_pais 
                    , numero_operacion 
                    , fechainicio                 
                    , fechafinal                  
                    , montooperacion        
                    , usuario    
                 FROM #TMP

        IF @@ERROR <> 0 BEGIN

           SELECT 'ERROR'
           RETURN
        END



	UPDATE	RIESGO_PAIS
	SET	totaldisponible = 0,
		totalexceso	= 0

	UPDATE	RIESGO_PAIS
	SET	totaldisponible	= totalasignado - totalocupado


	UPDATE	RIESGO_PAIS
	SET     totaldisponible = CASE WHEN totaldisponible < 0 THEN  0
                                         ELSE totaldisponible
                                         END
          ,     totalexceso     = CASE WHEN totaldisponible < 0 THEN  ABS(totalasignado - totalocupado)
                                         ELSE 0   
                                         END




        SELECT 'OK'
      
   SET NOCOUNT OFF

END



GO
