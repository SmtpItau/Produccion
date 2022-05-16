USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PREGRABADO_PACTOS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_PREGRABADO_PACTOS]
   (   @Usuario   VARCHAR(15)
   ,   @Ventana   NUMERIC(9)
   )
AS
BEGIN

   SET NOCOUNT ON
   SELECT Documento           = Documento
      ,   Correlativo         = Correlativo
      ,   NominalVenta        = Nominal_Venta
      ,   TasaVenta           = Tasa_Venta
      ,   PvpPar              = 0
      ,   ValorVenta          = vPresente_Venta
      ,   TasaEstimada        = TasaEstimada
      ,   vParVenta           = vPar_Venta
      ,   NumUltCup           = Numero_Cupon
      ,   InstSer             = Serie
      ,   RutEmisor           = Rut_Emisor
      ,   MonedaEmision       = Mon_Emisor
      ,   FechaEmision        = Fecha_Emision
      ,   FechaVencimiento    = Fecha_Vence
      ,   FecProxCupon        = Fecha_SigCup
      ,   Convexidad          = Convexidad
      ,   DurationModificado  = DurMod
      ,   DurationMacaulay    = DurMac
      ,   custodia            = cCustodia 
      ,   ClaveDCV            = cClave 
      ,   CarteraSuper        = codigo_carterasuper
      ,   DiasDisponibles     = Plazo
      ,   Margen              = Margen
      ,   ValorInicial        = vInicial_Venta
      ,   CarteraSuper	     
      ,   HairCut             = HairCut         						 -- PRD-6007
      ,   FolioBCCH           = FolioBCCH       						 -- PRD-6010
      ,   CorrelaBCCH         = CorrelaBCCH     						 -- PRD-6010
      ,   inCodigo            = inCodigo     							 -- PRD-6006 CASS 10-12-2010
      ,   MarcaVta	      = CASE WHEN Nominal_Compra > Nominal_Venta THEN 'P' ELSE 'V' END	 -- PRD-6006 CASS 10-12-2010
      ,   id_libro	      = id_libro
   FROM dbo.DETALLE_VTAS_CON_PCTO
    	  INNER JOIN dbo.MDCP ON cpnumdocu = Documento AND cpcorrela = Correlativo
   WHERE  Usuario             = @Usuario
   AND    Ventana             = @Ventana
   AND 	  Marca               = 'S'		
   UNION
   SELECT Documento           = Documento
      ,   Correlativo         = Correlativo
      ,   NominalVenta        = Nominal_Venta
      ,   TasaVenta           = Tasa_Venta
      ,   PvpPar              = 0
      ,   ValorVenta          = vPresente_Venta
      ,   TasaEstimada        = TasaEstimada
      ,   vParVenta           = vPar_Venta
      ,   NumUltCup           = Numero_Cupon
      ,   InstSer             = Serie
      ,   RutEmisor           = Rut_Emisor
      ,   MonedaEmision       = Mon_Emisor
      ,   FechaEmision        = Fecha_Emision
      ,   FechaVencimiento    = Fecha_Vence
      ,   FecProxCupon        = Fecha_SigCup
      ,   Convexidad          = Convexidad
      ,   DurationModificado  = DurMod
      ,   DurationMacaulay    = DurMac
      ,   custodia            = cCustodia 
      ,   ClaveDCV            = cClave 
      ,   CarteraSuper        = codigo_carterasuper
      ,   DiasDisponibles     = Plazo
      ,   Margen              = Margen
      ,   ValorInicial        = vInicial_Venta
      ,   CarteraSuper	     
      ,   HairCut             = HairCut         						 -- PRD-6007
      ,   FolioBCCH           = FolioBCCH       						 -- PRD-6010
      ,   CorrelaBCCH         = CorrelaBCCH     						 -- PRD-6010
      ,   inCodigo            = inCodigo     							 -- PRD-6006 CASS 10-12-2010
      ,   MarcaVta	      = CASE WHEN Nominal_Compra > Nominal_Venta THEN 'P' ELSE 'V' END	 -- PRD-6006 CASS 10-12-2010
      ,   id_libro	      = id_libro
   FROM dbo.DETALLE_VTAS_CON_PCTO
    	  INNER JOIN dbo.MDCI ON cinumdocu = Documento AND cicorrela = Correlativo
   WHERE  Usuario             = @Usuario
   AND    Ventana             = @Ventana
   AND 	  Marca               = 'S'	


END

GO
