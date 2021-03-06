USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACINFORMACIONBASICA_LEE]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_BacInformacionBasica_Lee    fecha de la secuencia de comandos: 03/04/2001 15:17:56 ******/
CREATE PROCEDURE [dbo].[SP_BACINFORMACIONBASICA_LEE]
AS BEGIN
   SET NOCOUNT OFF
   IF EXISTS(SELECT 1 FROM CONTROL_FINANCIERO)
   BEGIN
      SELECT  
        'capitalyreserva'  = ISNULL(capitalyreserva,0),
        'capitalbasico'    = ISNULL(capitalbasico,0),
 'monedacontrol'    = ISNULL(monedacontrol,0),
 'valormoneda'      = ISNULL(valormoneda,0),
 'porcenconriesgo'  = ISNULL(porcenconriesgo,0),
 'porcensinriesgo'  = ISNULL(porcensinriesgo,0),
 'porceninvext'     = ISNULL(porceninvext,0),
 'montoconriesgo'   = ISNULL(montoconriesgo,0),
 'montosinriesgo'   = ISNULL(montosinriesgo,0),
 'invexttotal'      = ISNULL(invexttotal,0),
 'primertramo'      = ISNULL(primertramo,0),
 'segundotramo'     = ISNULL(segundotramo,0),
 'tercertramo'      = ISNULL(tercertramo,0),
 'margeninstitucion'= ISNULL(margeninstitucion,0),
 'totalcarteralchr' = ISNULL(totalcarteralchr,0),
 'totalporfolio'    = ISNULL(totalporfolio,0),
 'cajapesos'        = ISNULL(cajapesos,0),
 'cajabcch'         = ISNULL(cajabcch,0),
 'totalinversiones' = ISNULL(totalinversiones,0)
      FROM CONTROL_FINANCIERO
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
 'totalinversiones' = 0
   END
END
GO
