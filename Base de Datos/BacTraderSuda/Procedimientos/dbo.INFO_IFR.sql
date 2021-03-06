USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[INFO_IFR]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[INFO_IFR]( @dFechaProceso    DATETIME = '')
AS
BEGIN
--   DECLARE @dFechaProceso    DATETIME
   DECLARE @dFechaMercado    DATETIME

--SET @dFechaProceso    = CONVERT(DATETIME,@cFechaProceso,112)    

IF @dFechaProceso  = ''
       SET @dFechaProceso    = (SELECT acfecproc FROM BacTraderSuda..MDAC with(nolock) )


EXEC BACPARAMSUDA..SP_FECHA_HABIL_ANTERIOR  @dFechaProceso, @dFechaMercado  output


--       SET @dFechaMercado    = (SELECT acfecante FROM BacTraderSuda..MDAC with(nolock) )

SET NOCOUNT ON

   SELECT Serie              = inserie
        , Normativa          = N.tbglosa
        , Financiera         = F.tbglosa
        , Moneda             = rsmonemi
        , Capital            = SUM( rsnominal )
        , InteresDia         = SUM( rsinteres )
        , Reajuste           = SUM( rsreajuste )
        , AVR_DifPre         = SUM( valor_mercado )
   FROM   BacTraderSuda..MDRS                              with(nolock)
          INNER JOIN BacParamSuda..INSTRUMENTO             with(nolock) ON incodigo           = rscodigo
          INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE N with(nolock) ON N.tbcateg          = 1111 AND N.tbcodigo1 = codigo_carterasuper
          INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE F with(nolock) ON F.tbcateg          = 204  AND F.tbcodigo1 = rstipcart
          INNER JOIN BacTraderSuda..VALORIZACION_MERCADO   with(nolock) ON fecha_valorizacion = @dFechaMercado and rmnumdocu  = rsnumdocu AND rmcorrela = rscorrela
   WHERE  rsfecha    = @dFechaProceso
    and   rscartera  = 111
    and   rstipoper  = 'DEV'
    and   rsnominal  > 0
   GROUP BY inserie, N.tbglosa, F.tbglosa, rsmonemi
   ORDER BY inserie, N.tbglosa, F.tbglosa, rsmonemi

   SELECT Serie              = inserie
        , Normativa          = N.tbglosa
        , Financiera         = F.tbglosa
        , Moneda             = momonemi 
        , Capital            = SUM( monominal )
        , InteresDia         = SUM( mointeres )
        , Reajuste           = SUM( moreajuste )
        , AVR                = SUM( movalcomp- movalven )
   FROM   BacTraderSuda..MDMO 
          INNER JOIN BacParamSuda..INSTRUMENTO             with(nolock) ON incodigo           = mocodigo
          INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE N with(nolock) ON N.tbcateg          = 1111 AND N.tbcodigo1 = codigo_carterasuper
          INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE F with(nolock) ON F.tbcateg          = 204  AND F.tbcodigo1 = motipcart
   WHERE  mofecpro   = @dFechaProceso
     AND  motipoper  = 'VP'
     AND  motipopero = 'CP'
   GROUP BY inserie, N.tbglosa, F.tbglosa, momonemi
   ORDER BY inserie, N.tbglosa, F.tbglosa, momonemi

SET NOCOUNT OFF

END

RETURN 0
--select top 10 * from mdmo


GO
