USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MD0004C]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MD0004C]
                           (  @modcal     integer          ,
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
     -- variables de trabajo.-
        declare @fvalorum   float
        declare @fvalorml   float
        declare @nredonum   integer
        declare @nredonml   integer
        declare @fint       float
        declare @fintum     float
        declare @fsalum     float
        declare @fnomiven   float
     -- datos de la moneda emisi=n.-
        execute Sp_Valum @nmonemi,@fvalorum OUTPUT
        execute Sp_Decum @nmonemi,@nredonum OUTPUT
     -- datos de la moneda local.-
        execute Sp_Valum      999,@fvalorml OUTPUT
        execute Sp_Decum      999,@nredonml OUTPUT
     -- calcula el nominal de vencimiento del cd.-
        execute Sp_Calcvto @fnominal ,
                           @ftasemi  ,
                           @fbasemi  ,
                           @dfecemi  ,
                           @dfecven  ,
                           @fnomiven OUTPUT
     -- calcula el valor par del cd.-
        execute Sp_Calcvto @fnominal ,
                           @ftasemi  ,
                           @fbasemi  ,
                           @dfecemi  ,
                           @dfeccal  ,
                           @fvpar    OUTPUT
     -- calcula los intereses corridos del cd.-
        select @fint   = @fvpar - @fnominal
        select @fintum = round( @fnomiven , @nredonum ) - @fnominal
        select @fsalum = @fnominal
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
                select  @fvan  = @fvpar * ( @fpvp * 100.0 )
                execute Sp_Calctas @fvan     ,
                                   @fnomiven ,
                                   @fbasemi  ,
                                   @dfeccal  ,
                                   @dfecven  ,
                             @ftir     OUTPUT
                select  @ftir  = round( @ftir  , 4 )
                select  @fmtum = round( @fvan  , @nredonum )
                select  @fmt   = round( @fmtum * @fvalorum , @nredonml )
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
                execute Sp_Calcini @fnomiven ,
                                   @ftir     ,
                                   @fbasemi  ,
                                   @dfeccal  ,
                                   @dfecven  ,
                                   @fvan     OUTPUT
                select  @fpvp  = round( @fvan / @fvpar * 100.0 , 2 )
                select  @fmtum = round( @fvan  , @nredonum )
                select  @fmt   = round( @fmtum * @fvalorum , @nredonml )
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
                execute Sp_Div @fmt , @fvalorum, @fvan OUTPUT
                execute Sp_Div @fvan,   @fvpar , @fpvp OUTPUT
                select  @fpvp  = round( @fpvp * 100.0 , 2       )
                select  @fmtum = round( @fvan         , @nredonum )
                execute Sp_Calctas @fvan     ,
                                   @fnomiven ,
                                   @fbasemi  ,
                                   @dfeccal  ,
                                   @dfecven  ,
                                   @ftir     OUTPUT
           end
    /*-------------------------------------------------------*
     *                                                       *
     * - procesar la modalidad de c lculo 3                  *
     *                                                       *
     *   entrada : nominal , mtum                            *
     *   salida  : pvp     , tir                             *
     *                                                       *
     *-------------------------------------------------------*/
        if @modcal = 4
           begin
                select  @fmt   = @fmtum
                select  @fvan  = @fmtum
                execute Sp_Div @fvan, @fvpar , @fpvp OUTPUT
                select  @fpvp  = round( @fpvp * 100.0 , 2       )
                execute Sp_Calctas @fvan     ,
                                   @fnomiven ,
                                   @fbasemi  ,
                                   @dfeccal  ,
                                   @dfecven  ,
                                   @ftir     OUTPUT
           end
     -- ajustes a base 100.-
        select @fint     =  @fint   / @fnominal * 100.0
        select @fvpar    =  @fvpar  / @fnominal * 100.0
        select @fmt_cien =  @fmtum  / @fnominal * 100.0
     -- datos del £ltimo cup=n.-
        select @nnumucup = 0
        select @dfecucup = @dfecemi
        select @famoucup = 0.0
        select @fintucup = 0.0
        select @fsalucup = 100.0
     -- datos del pr=ximo cup=n.-
        select @nnumpcup = 1
        select @dfecpcup = @dfecven
        select @famopcup = 100.00
        select @fintpcup = @fint
        select @fsalpcup = 0.0
end

GO
