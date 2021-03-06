USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MD0001C]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MD0001C]
                           ( @modcal     integer          ,
                             @dfeccal    datetime         ,
                             @ncodigo    integer          ,
                             @cmascara   char(12)         ,
                             @nmonemi    integer          ,
                             @dfecemi    datetime         ,
                             @dfecven    datetime         ,
                             @ftasemi    float            ,
                             @fbasemi    float            ,
                             @ftasest    float            ,
                             @fnominal   float    OUTPUT  ,
                             @ftir       float    OUTPUT  ,
                             @fpvp       float    OUTPUT  ,
                             @fmt        float    OUTPUT  ,
                             @fmtum      float    OUTPUT  ,
                             @fmt_cien   float    OUTPUT  ,
                             @fvan       float    OUTPUT  ,
                             @fvpar      float    OUTPUT  ,
                             @nnumucup   integer  OUTPUT  ,
                             @dfecucup   datetime OUTPUT  ,
                             @fintucup   float    OUTPUT  ,
                             @famoucup   float    OUTPUT  ,
                             @fsalucup   float    OUTPUT  ,
                             @nnumpcup   integer  OUTPUT  ,
                             @dfecpcup   datetime OUTPUT  ,
                             @fintpcup   float    OUTPUT  ,
                             @famopcup   float    OUTPUT  ,
                             @fsalpcup   integer  OUTPUT  )
as
begin
      -- variables para recuperaci=n de datos.-
         declare @ftera      float
         declare @ncupones   integer
         declare @npervcup   integer
         declare @fbascup    numeric(07,01)
      -- variables auxiliares.-
         declare @fvalorum   float
         declare @fvalorml   float
         declare @nredonum   integer
         declare @nredonml   integer
         declare @fdiaaux    float
         declare @fintcup    float
         declare @fintum     float
         declare @fsalum     float
      -- variables para el c lculo de la tir.-
         declare @fta        float
         declare @ftb        float
         declare @fma        float
         declare @fme        float
         declare @ndecs      integer
         declare @nprec      integer
         declare @nveces     integer
    /*-------------------------------------------------------*
     *                                                       *
     * obtener datos de la tabla de series.-                 *
     *                                                       *
     *-------------------------------------------------------*/
         select @ncodigo   = secodigo  ,
                @ftera     = setera    ,
                @ftasemi   = setasemi  ,
                @ncupones  = secupones ,
                @dfecemi   = sefecemi  ,
                @dfecven   = sefecven  ,
                @npervcup  = sepervcup ,
                @nmonemi   = semonemi  ,
                @fbasemi   = sebasemi  ,
                @fbascup   = sebascup
                from VIEW_SERIE
                where semascara = @cmascara
    /*-------------------------------------------------------*
     *                                                       *
     * recuperar & procesar la tabla de desarrollo.-         *
     *                                                       *
     *-------------------------------------------------------*/
      -- crear archivo temporal.-
         create table #TMTD(
                tdcupon   numeric  (3,0)   null ,
                tdfecven  datetime         null ,
                tdinteres numeric  (19,10) null ,
                tdamort   numeric  (19,10) null ,
                tdflujo   numeric  (19,10) null ,
                tdsaldo   numeric  (19,10) null ,
                tdfactor  float            null
         )
      -- preparar archivo temporal.-
        insert into #TMTD
               select tdcupon   ,
                      tdfecven  ,
                      tdinteres ,
                      tdamort   ,
                      tdflujo   ,
                      tdsaldo   ,
                      tdfactor = datediff(day,@dfeccal,tdfecven)
               from VIEW_TABLA_DESARROLLO
               where tdmascara = @cmascara
    /*-------------------------------------------------------*
     *                                                       *
     * recuperar informaci=n de cupones.-                    *
     *                                                       *
     *-------------------------------------------------------*/
        -- fijar una fila de recuperaci=n.-
           set rowcount 1
        -- datos del £ltimo cup=n.-
           select @dfecucup = tdfecven  ,
                  @nnumucup = tdcupon   ,
                  @famoucup = tdamort   ,
                  @fintucup = tdinteres ,
                  @fsalucup = tdsaldo
                  from #TMTD
                  where tdfecven <= @dfeccal
                  order by tdfecven desc
        -- datos del pr=ximo cupon.-
           select @dfecpcup = tdfecven  ,
                  @nnumpcup = tdcupon   ,
                  @famopcup = tdamort   ,
                  @fintpcup = tdinteres ,
                  @fsalpcup = tdsaldo
                  from #TMTD
                  where tdfecven > @dfeccal
        -- restaurar maximo  recuperaci=n.-
           set rowcount 0
    /*-------------------------------------------------------*
     *                                                       *
     * parametros para el c lculo de la tir.-                *
     *                                                       *
     *-------------------------------------------------------*/
       select @nprec = 8
       select @ndecs = 4
       select @fta   = @ftasemi
       select @ftb   = @ftasemi
       select @fma   = 50.0
       select @fme   = 0
    /*-------------------------------------------------------*
     *                                                       *
     *   obtener:                                            *
     *           - valor de moneda de emisi=n                *
     *           - valor de moneda de local                  *
     *           - redondeo para moneda emisi=n              *
     *           - redondeo para moneda local                *
     *                                                       *
     *-------------------------------------------------------*/
       execute SP_VALUM @nmonemi,@dfeccal,@fvalorum OUTPUT
       execute SP_VALUM      999,@dfeccal,@fvalorml OUTPUT
       execute SP_DECUM @nmonemi,@nredonum OUTPUT
       execute SP_DECUM      999,@nredonml OUTPUT
    /*-------------------------------------------------------*
     *                                                       *
     *   c lcular:                                           *
     *           - valor par en base cien                    *
     *           - intereses corridos en base cien           *
     *                                                       *
     *-------------------------------------------------------*/
       select @fdiaaux = datediff( day, @dfeccal, @dfecucup)
       select @fvpar   = round( @fsalucup/@fbascup*100.0* power(1.0+@ftasemi/100.0,@fdiaaux/@fbasemi),8)
       select @fintcup = round( @fsalucup/@fbascup*100.0*(power(1.0+@ftasemi/100.0,@fdiaaux/@fbasemi)-1.0),8)
    /*-------------------------------------------------------*
     *                                                       *
     *   c lcular:                                           *
     *        - intereses corridos en base a los nominales   *
     *        - saldo capital um   en base a los nominales   *
     *                                                       *
     *-------------------------------------------------------*/
       select @fintum  = round( @fintcup  / 100.0 * @fnominal , @nredonum )
       select @fsalum  = round( @fsalucup / 100.0 * @fnominal , @nredonum )
    /*-------------------------------------------------------*
     *                                                       *
     * - procesar la modalidad de c lculo  1                 *
     *                                                       *
     *   entrada : nominal , pvp                             *
     *   salida  : tir     , mt                              *
     *                                                       *
     *-------------------------------------------------------*/
      if @modcal = 1
         begin
              /*-------------------------------------------------------*
               *                                                       *
               * c lcular el monto transado                            *
               *                                                       *
               * mt_cien = monto transado en base cien                 *
               * mtum    = monto transado en moneda emisi=n            *
               * mt      = monto transado en moneda local              *
               *                                                       *
               *-------------------------------------------------------*/
                 select @fmt_cien = 100.0 * (@fpvp/100.0) * (@fvpar/100.0)
                 select @fmtum    = round( @fnominal * (@fpvp/100.0) * @fsalucup/@fbascup, @nredonum ) + @fintum
                 select @fmt      = round( @fmtum * @fvalorum , @nredonml )
              /*-------------------------------------------------------*
               * c lcular el van & la tir                              *
               *-------------------------------------------------------*/
                 select @ftir    = 0.0
                 select @fvan    = 0.0
                 select @nveces  = 1
                 while ( @nveces < 100 )
                     begin
                           select @fvan = sum( tdflujo / power(1.0+@fta/100.0,tdfactor/@fbasemi) )
                           from #TMTD where tdfecven > @dfeccal
                           select @fvan = @fvan / @fbascup * 100.0
                           select @ftb  = round( @fta , @nprec )
                           if @fvan < @fmt_cien
                                 select @fma = @fta
                           else
                                 select @fme = @fta
                           select @fta = ( @fma + @fme ) / 2.0
                           if @ftb = round( @fta , @nprec )
                              begin
                                   select @ftir = round( @fta , @ndecs )
                                   break
                              end
                           select @nveces = @nveces + 1
                     end
         end
    /*-------------------------------------------------------*
     *                                                       *
     * - procesar la modalidad de c lculo 2                  *
     *                                                       *
     *   entrada : nominal , tir                             *
     *   salida  : pvp     , mt                              *
     *                                                       *
     *-------------------------------------------------------*/
      if @modcal = 2
         begin
              /*-------------------------------------------------------*
               *                                                       *
               * c lcular el van                                       *
               *                                                       *
               *-------------------------------------------------------*/
                 select @fvan = sum( tdflujo / power(1.0+@ftir/100.0,tdfactor/@fbasemi) )
                 from #TMTD where tdfecven > @dfeccal
              /*-------------------------------------------------------*
               *                                                       *
               * c lcular el pvp                                       *
               * c lcular el monto transado                            *
               *                                                       *
               * mt_cien = monto transado en base cien                 *
               * mtum    = monto transado en moneda emisi=n            *
               * mt      = monto transado en moneda local              *
               *                                                       *
               *-------------------------------------------------------*/
                 select @fpvp     = @fvan / @fvpar * 100.0
                 select @fmt_cien = 100.0 * (@fpvp/100.0) * (@fvpar/100.0)
                 select @fmtum    = round( @fnominal * (@fpvp/100.0) * @fsalucup/@fbascup, @nredonum ) + @fintum
                 select @fmt      = round( @fmtum * @fvalorum , @nredonml )
                 select @fpvp     = round( @fpvp , 2 )
         end
    /*-------------------------------------------------------*
     *                                                       *
     * - procesar la modalidad de c lculo 3                  *
     *                                                       *
     *   entrada : nominal , mt                              *
     *   salida  : pvp     , tir                             *
     *                                                       *
     *-------------------------------------------------------*/
      if @modcal = 3
         begin
              /*-------------------------------------------------------*
               *                                                       *
               * c lcular el monto transado                            *
               *                                                       *
               * mt_cien = monto transado en base cien                 *
               * mtum    = monto transado en moneda emisi=n            *
               *                                                       *
               *-------------------------------------------------------*/
                 execute SP_DIV @fmt, @fvalorum, @fmtum OUTPUT
                 select @fpvp     = (@fmtum-@fintum)/((@fsalucup/@fbascup)*@fnominal)
                 select @fpvp     = round( @fpvp * 100, 2 )
                 select @fmt_cien = 100.0 * (@fpvp/100.0) * (@fvpar/100.0)
              /*-------------------------------------------------------*
               * c lcular el van & la tir                              *
               *-------------------------------------------------------*/
                 select @ftir    = 0.0
                 select @fvan    = 0.0
                 select @nveces  = 1
                 while ( @nveces < 100 )
                     begin
                           select @fvan = sum( tdflujo / power(1.0+@fta/100.0,tdfactor/@fbasemi) )
                           from #TMTD where tdfecven > @dfeccal
                           select @fvan = @fvan / @fbascup * 100.0
                           select @ftb  = round( @fta , @nprec )
                           if @fvan < @fmt_cien
                                 select @fma = @fta
                           else
                                 select @fme = @fta
                           select @fta = ( @fma + @fme ) / 2.0
                           if @ftb = round( @fta , @nprec )
                              begin
                                   select @ftir = round( @fta , @ndecs )
                                   break
                              end
                           select @nveces = @nveces + 1
                     end
         end
     return 0
end

GO
