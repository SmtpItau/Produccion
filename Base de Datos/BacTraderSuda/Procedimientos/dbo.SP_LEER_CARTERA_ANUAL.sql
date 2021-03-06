USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CARTERA_ANUAL]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_CARTERA_ANUAL]
   (   @iAño   INTEGER   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFecha         DATETIME
       SET @dFecha         = LTRIM(RTRIM(@iAño)) + '1231'

   SELECT Plazo            = CASE WHEN rscartera = 111 THEN DATEDIFF(DAY, rsfecha, rsfecvcto)
                                  WHEN rscartera = 114 THEN DATEDIFF(DAY, rsfecha, rsfecvtop)
                                  WHEN rscartera = 115 THEN DATEDIFF(DAY, rsfecha, rsfecvtop)
                                  WHEN rscartera = 121 THEN DATEDIFF(DAY, rsfecha, rsfecvtop)
                                  ELSE                      DATEDIFF(DAY, rsfecha, rsfecvtop)
                             END
   ,      CodigoCartera    = rscartera
   ,      Cartera          = CASE WHEN rscartera = 111 THEN 'CARTERA PROPIA'
                                  WHEN rscartera = 114 THEN 'CARTERA INTERMEDIADA'
                                  WHEN rscartera = 115 THEN 'VENTAS CON PACTO'
                                  WHEN rscartera = 121 THEN 'INTERBANCARIOS'
                                  ELSE                      'COMPRA CON PACTO'
                             END
   ,      Serie            = rsinstser
   ,      Documento        = rsnumdocu
   ,      Correlativo      = rscorrela
   ,      MonedaEmision    = rsmonemi
   ,      MonedaPacto      = rsmonpact
   ,      Nominal          = rsnominal
   ,      FechaCompra      = rsfeccomp
   ,      FechaVencimiento = rsfecvcto
   ,      FechaVencepacto  = rsfecvtop
   ,      vPres            = rsvppresenx
   ,      valor_mercado    = ISNULL(valor_mercado, rsvppresen)
   ,      Diferencia       = ISNULL(diferencia_mercado, 0)
   FROM   MDRS 
          LEFT JOIN BacTraderSuda..VALORIZACION_MERCADO ON fecha_valorizacion = @dFecha AND rmnumdocu = rsnumdocu and rmcorrela = rscorrela 
                                                       and tipo_operacion = CASE WHEN rscartera = 111 THEN 'CP' 
                                                                                 WHEN rscartera = 115 THEN 'VP' 
                                                                            END
   WHERE  rsfecha          = @dFecha
     AND  rstipoper        = 'DEV'
     AND  90              >= CASE WHEN rscartera = 111 THEN DATEDIFF(DAY, rsfecha, rsfecvcto)
                                  WHEN rscartera = 121 THEN DATEDIFF(DAY, rsfecha, rsfecvtop)
                                  WHEN rscartera = 114 THEN DATEDIFF(DAY, rsfecha, rsfecvtop)
                                  WHEN rscartera = 115 THEN DATEDIFF(DAY, rsfecha, rsfecvtop)
                             END
   ORDER BY Plazo

RETURN

   SET @dFecha   = ( SELECT MIN( rsfecha ) FROM MDRS WHERE rsfecha > LTRIM(RTRIM( @iAño )) + '0101' AND rsfecha < LTRIM(RTRIM( @iAño )) + '0115' )

   SELECT Año              = @iAño
        , Serie            = rsinstser
        , Documento        = rsnumdocu
        , Correlativo      = rscorrela
        , Nominal_Menor_90 = case when datediff(day, rsfeccomp, rsfecvcto ) <= 90 then rsnominal  else 0.0 end
        , Nominal_Mayor_90 = case when datediff(day, rsfeccomp, rsfecvcto )  > 90 then rsnominal  else 0.0 end
        , FechaCompra      = rsfeccomp
        , FechaVencimiento = rsfecvcto
        , Plazo            = datediff(day, rsfeccomp, rsfecvcto )
     INTO #TMP_2005
     FROM MDRS
    WHERE rsfecha             = @dFecha
     AND  rscartera           IN(111,114)
     AND  rstipoper           = 'DEV'
     AND  codigo_carterasuper IN('P', 'T')
     ORDER BY rsinstser, datediff(day, rsfeccomp, rsfecvcto)

   INSERT INTO #TMP_2005
   SELECT Año              = @iAño
        , moinstser
        , monumdocu
        , mocorrela
        , Nominal_Menor_90 = case when datediff(day, fecha_compra_original, mofecven ) <= 90 then monominal else 0.0 end
        , Nominal_Mayor_90 = case when datediff(day, fecha_compra_original, mofecven )  > 90 then monominal else 0.0 end
        , fecha_compra_original
        , mofecven
        , Plazo            = datediff(day, fecha_compra_original, mofecven ) 
     FROM MDMH
    WHERE YEAR(mofecpro)  = @iAño
      AND motipoper       = 'CP'
      AND codigo_carterasuper IN('P', 'T')
      AND mostatreg       = ''
      ORDER BY moinstser, datediff(day, fecha_compra_original, mofecven )

   SELECT Año
        , Serie
        , Documento
        , Correlativo
        , Nominal_Menor_90 = SUM(Nominal_Menor_90)
        , Nominal_Mayor_90 = SUM(Nominal_Mayor_90)
        , FechaCompra
        , FechaVencimiento
        , Plazo
     FROM #TMP_2005
   GROUP BY Año, FechaCompra, FechaVencimiento, Serie, Documento, Correlativo, Plazo
   ORDER BY Plazo

END

GO
