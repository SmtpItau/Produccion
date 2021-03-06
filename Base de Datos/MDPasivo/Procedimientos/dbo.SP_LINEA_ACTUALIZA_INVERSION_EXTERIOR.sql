USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEA_ACTUALIZA_INVERSION_EXTERIOR]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEA_ACTUALIZA_INVERSION_EXTERIOR]
               ( @fecha_Proceso DATETIME )
AS
BEGIN

   SET DATEFORMAT dmy

   SET NOCOUNT ON

       SELECT   'Rut_Cliente'          = cacodigo
         ,      'Codigo_Cliente'       = cacodcli
         ,      'Numero_Operacion'     = canumoper
         ,      'TipodeOperacion'      = catipoper
         ,      'FechaInicio'          = cafecha
         ,      'FechaFinal'           = cafecvcto
         ,      'MontoOperacion'       = caequmon1
         ,      'Usuario'              = caoperador
         ,      'Id_Sistema'           = 'BFW'
         INTO   #TMP
         FROM    VIEW_CARTERA_FORWARD
        WHERE    cacodpos1    = 2
          and    caestado     = ' '
          and    contabiliza  = 'S'
          and    cafecvcto    > @fecha_Proceso

  INSERT INTO    #TMP                 
       SELECT   'Rut_Cliente'          = rut_cliente
         ,      'Codigo_Cliente'       = codigo_cliente
         ,      'Numero_Operacion'     = numero_operacion
         ,      'TipodeOperacion'      = tipo_operacion
         ,      'FechaInicio'          = fecha_operacion
         ,      'FechaFinal'           = fecha_vencimiento
         ,      'MontoOperacion'       = monto_pesos
         ,      'Usuario'              = ISNULL(( SELECT mooper FROM VIEW_MOVIMIENTO_CAMBIO WHERE monumope = numero_operacion ),' ')
         ,      'Id_Sistema'           = 'BCC'
        FROM    VIEW_TRANSFERENCIA_PENDIENTE
        WHERE    codigo_producto IN('ARBI','OVER','WEEK')
          AND    fecha_vencimiento     > @fecha_Proceso
          AND    estado_transferencia <> 'A'
          AND    codigo_moneda        <> 13



       DELETE FROM INVERSION_EXTERIOR_DETALLE


       UPDATE INVERSION_EXTERIOR
                             SET ArbSpo_Ocupado  = ISNULL(( SELECT SUM(montooperacion) FROM #TMP 
                                                                                      WHERE INVERSION_EXTERIOR.Rut_Cliente    = #TMP.Rut_Cliente 
                                                                                        AND INVERSION_EXTERIOR.Codigo_Cliente = #TMP.Codigo_Cliente 
                                                                                        AND #TMP.Id_Sistema                   = 'BCC'
                                                         ),0)
                               , ArbFwd_Ocupado  = ISNULL(( SELECT SUM(montooperacion) FROM #TMP 
                                                                                      WHERE INVERSION_EXTERIOR.Rut_Cliente    = #TMP.Rut_Cliente 
                                                                                        AND INVERSION_EXTERIOR.Codigo_Cliente = #TMP.Codigo_Cliente 
                                                                                        AND #TMP.Id_Sistema                   = 'BFW'
                                                         ),0)
                            FROM INVERSION_EXTERIOR



       INSERT    INTO INVERSION_EXTERIOR_DETALLE
                    ( Rut_Cliente 
                    , Codigo_Cliente 
                    , Numero_Operacion 
                    , TipodeOperacion 
                    , FechaInicio                 
                    , FechaFinal                  
                    , MontoOperacion        
                    , Usuario    
                    )
                 
               SELECT            
                      #TMP.Rut_Cliente 
                    , #TMP.Codigo_Cliente 
                    , #TMP.Numero_Operacion 
                    , #TMP.TipodeOperacion 
                    , #TMP.FechaInicio                 
                    , #TMP.FechaFinal                  
                    , #TMP.MontoOperacion        
                    , #TMP.Usuario    
                 FROM #TMP
                    , INVERSION_EXTERIOR
                WHERE #TMP.Rut_Cliente    = INVERSION_EXTERIOR.Rut_Cliente
                  AND #TMP.Codigo_Cliente = INVERSION_EXTERIOR.Codigo_Cliente

        IF @@ERROR <> 0 BEGIN

           SELECT 'ERROR'
           RETURN
        END


	UPDATE	INVERSION_EXTERIOR
	SET     ArbFwd_Disponible = 0
	  ,     ArbSpo_Disponible = 0

	UPDATE	INVERSION_EXTERIOR
	SET     InvExt_Disponible = InvExt_Total - (ArbFwd_Ocupado + ArbSpo_Ocupado)
          ,     InvExt_Ocupado    = ArbFwd_Ocupado + ArbSpo_Ocupado
          ,     ArbFwd_Disponible = ArbFwd_Total - ArbFwd_Ocupado
	  ,     ArbSpo_Disponible = ArbSpo_Total - ArbSpo_Ocupado


	UPDATE	INVERSION_EXTERIOR
	SET     InvExt_Disponible = CASE WHEN InvExt_Disponible < 0 THEN  0
                                         ELSE InvExt_Disponible 
                                         END
          ,     ArbExt_Exceso     = CASE WHEN InvExt_Disponible < 0 THEN  ABS(InvExt_Total - InvExt_Ocupado)
                                         ELSE 0   
                                         END
          ,     ArbFwd_Disponible = CASE WHEN ArbFwd_Disponible < 0 THEN  0
                                         ELSE ArbFwd_Disponible
                                         END 
          ,     ArbFwd_Exceso     = CASE WHEN ArbFwd_Disponible < 0 THEN  ABS(ArbFwd_Total - ArbFwd_Ocupado)
                                         ELSE 0
                                         END
	  ,     ArbSpo_Disponible = CASE WHEN ArbSpo_Disponible < 0 THEN  0
                                         ELSE ArbSpo_Disponible 
                                         END
	  ,     ArbSpo_Exceso     = CASE WHEN ArbSpo_Disponible < 0 THEN  ABS(ArbSpo_Total - ArbSpo_Ocupado)
                                         ELSE 0
                                         END


        SELECT 'OK'
      
   SET NOCOUNT OFF

END

GO
