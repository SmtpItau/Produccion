USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacInformacionBasica_Lee]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_BacInformacionBasica_Lee]
AS BEGIN

   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
   SET NOCOUNT ON
   SET DATEFORMAT dmy


   UPDATE DATOS_GENERALES WITH (ROWLOCK)
   SET    DATOS_GENERALES.Total_Cartera_Lchr               = DATOS_LIMITES.Total_Cartera_Lchr,
          DATOS_GENERALES.Limite_Inversion_Cartera_Ocupado = DATOS_LIMITES.Limite_Inversion_Cartera_Ocupado
   FROM   DATOS_LIMITES WITH (NOLOCK)

   IF EXISTS(SELECT 1 FROM DATOS_GENERALES WITH (NOLOCK)) BEGIN

      SELECT  

        'capitalyreserva'  = ISNULL(capital_reserva,0),
        'capitalbasico'    = ISNULL(capital_basico,0),
	'monedacontrol'    = ISNULL(moneda_control,0),
	'valormoneda'      = ISNULL(valor_moneda,0),
	'porcenconriesgo'  = ISNULL(porcen_con_riesgo,0),
	'porcensinriesgo'  = ISNULL(porcen_sin_riesgo,0),
	'porceninvext'     = ISNULL(porcen_invext,0),
	'montoconriesgo'   = ISNULL(monto_con_riesgo,0),
	'montosinriesgo'   = ISNULL(monto_sin_riesgo,0),
	'invexttotal'      = ISNULL(invext_total,0),
	'primertramo'      = ISNULL(primer_tramo,0),
	'segundotramo'     = ISNULL(segundo_tramo,0),
	'tercertramo'      = ISNULL(tercer_tramo,0),
	'margeninstitucion'= ISNULL(margen_institucion,0),
	'totalcarteralchr' = ISNULL(total_cartera_lchr,0),
	'totalporfolio'    = ISNULL(total_por_folio,0),
	'cajapesos'        = ISNULL(caja_pesos,0),
	'cajabcch'         = ISNULL(caja_bcch,0),
	'totalinversiones' = ISNULL(total_inversiones,0),
       	'LimiteInvAsignado'= ISNULL(Limite_Inversion_Cartera_Asignado,0),
       	'LimiteInvOcupado' = ISNULL(Limite_Inversion_Cartera_Ocupado,0),
       	'LimiteLchr'       = ISNULL(Total_Cartera_Lchr,0),
	'FFMMDiasMaximo'=isnull(FFMMDiasMaximo,0)
      FROM DATOS_GENERALES WITH (NOLOCK)


   END ELSE BEGIN

      SELECT  
        'capitalyreserva'  = 'SIN DATOS',
        'capitalbasico'    = 0,
	'monedacontrol'    = 0,
	'valormoneda'      = 0,
	'porcenconriesgo'  = 0,
	'porcensinriesgo'  = 0,
	'porceninvext'     = 0,
	'montoconriesgo'   = 0,
	'montosinriesgo'   = 0,
	'invexttotal'      = 0,
	'primertramo'      = 0,
	'segundotramo'     = 0,
	'tercertramo'      = 0,
	'margeninstitucion'= 0,
	'totalcarteralchr' = 0,
	'totalporfolio'    = 0,
	'cajapesos'        = 0,
	'cajabcch'         = 0,
	'totalinversiones' = 0,
       	'LimiteInvAsignado'= 0,
       	'LimiteInvOcupado' = 0,
       	'LimiteLchr'       = 0,
	'FFMMDiasMaximo'=0

   END

END
GO
