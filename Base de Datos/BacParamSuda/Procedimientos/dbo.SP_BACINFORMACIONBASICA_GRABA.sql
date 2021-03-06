USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACINFORMACIONBASICA_GRABA]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_BacInformacionBasica_Graba    fecha de la secuencia de comandos: 03/04/2001 15:17:56 ******/
CREATE PROCEDURE [dbo].[SP_BACINFORMACIONBASICA_GRABA]
 
       (
 @capitalyreserva NUMERIC(19,4),
        @capitalbasico  NUMERIC(19,4),
 @monedacontrol  NUMERIC(5,0),
 @valormoneda  NUMERIC(10,4),
 @porcenconriesgo NUMERIC(10,4),
 @porcensinriesgo NUMERIC(10,4),
 @porceninvext  NUMERIC(10,4),
 @montoconriesgo  NUMERIC(19,4),
 @montosinriesgo  NUMERIC(19,4),
 @invexttotal  NUMERIC(19,4),
 @primertramo  NUMERIC(19,4),
 @segundotramo  NUMERIC(19,4),
 @tercertramo  NUMERIC(19,4),
 @margeninstitucion NUMERIC(19,4),
 @totalcarteralchr NUMERIC(19,4),
 @totalporfolio  NUMERIC(19,4),
 @cajapesos  NUMERIC(19,4),
 @cajabcch  NUMERIC(19,4),
 @totalinversiones NUMERIC(19,4))
AS BEGIN
 SET NOCOUNT OFF
        SET ROWCOUNT 0
 IF EXISTS(SELECT 1 FROM CONTROL_FINANCIERO)
 BEGIN
  SELECT 'MODIFICA'  
  UPDATE CONTROL_FINANCIERO SET
  
   capitalyreserva  = @capitalyreserva,
   capitalbasico  = @capitalbasico,
   monedacontrol  = @monedacontrol,
   valormoneda  = @valormoneda,
   porcenconriesgo  = @porcenconriesgo,
   porcensinriesgo  = @porcensinriesgo,
   porceninvext  = @porceninvext,
   montoconriesgo  = @montoconriesgo,
   montosinriesgo  = @montosinriesgo,
   invexttotal  = @invexttotal,
   primertramo  = @primertramo,
   segundotramo  = @segundotramo,
   tercertramo  = @tercertramo,
   margeninstitucion = @margeninstitucion,
   totalcarteralchr = @totalcarteralchr,
   totalporfolio  = @totalporfolio,
   cajapesos  = @cajapesos,
   cajabcch  = @cajabcch,
   totalinversiones = @totalinversiones
         SELECT 'MODIFICA'
         END ELSE BEGIN
 
  SELECT 'NUEVO'  
  INSERT INTO CONTROL_FINANCIERO
         (
   capitalyreserva,
   capitalbasico,
   monedacontrol,
   valormoneda,
   numerotraspaso,
   porcenconriesgo,
   porcensinriesgo,
   porceninvext,
   montoconriesgo,
   montosinriesgo,
   invexttotal,
   invextocupado,
   invextdisponible,
   invextexceso,
   primertramo,
   segundotramo,
   tercertramo,
   margeninstitucion,
   totalcarteralchr,
   totalporfolio,
   cajapesos,
   cajabcch,
   totalinversiones
   )
  
   VALUES
         (
   @capitalyreserva,
   @capitalbasico,
   @monedacontrol,
   @valormoneda,
   0,--@numerotraspaso,
   @porcenconriesgo,
   @porcensinriesgo,
   @porceninvext,
   @montoconriesgo,
   @montosinriesgo,
   @invexttotal,
   0,--@invextocupado,
   0,--@invextdisponible,
   0,--@invextexceso,
   @primertramo,
   @segundotramo,
   @tercertramo,
   @margeninstitucion,
   @totalcarteralchr,
   @totalporfolio,
   @cajapesos,
   @cajabcch,
   @totalinversiones
   )
  SELECT 'GRABA'
        END
END
GO
