USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BIDASK2]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BIDASK2]
       (
         @ncodmon               NUMERIC(3,0)
       , @dfecpro               DATETIME
       , @ctipoper              CHAR(01)
       , @nplazovto             FLOAT
       , @ntasafwd              FLOAT    = 0 OUTPUT 
       , @npuntaspot            FLOAT    = 0 OUTPUT
       , @dFechaPrxProceso      CHAR(08) = '19000101' -- SE UTILIZA PARA BACK TEST 
       )
AS 
BEGIN

    -- SE MODIFICA PROCEDIMIENTO PARA RESULTADOS BACK TEST
    -- 02/04/2008

        SET NOCOUNT ON

    --- declaraciones
    DECLARE @ntasabidme    FLOAT 
          , @ntasaaskme    FLOAT 
          , @nplazome    FLOAT 
          , @ntasabidma    FLOAT 
          , @ntasaaskma    FLOAT 
          , @nplazoma    FLOAT 
          , @ndiftasabid    FLOAT 
          , @ninterpbid    FLOAT 
          , @ndiftasaask    FLOAT 
          , @ninterpask    FLOAT 
          , @ndifplazo    FLOAT 

    SET ROWCOUNT 1

    SELECT @ntasabidme  = bidcal 
         , @ntasaaskme  = askcal 
         , @nplazome    = plazocal
    FROM   VIEW_MFBIDASK
    WHERE  fecha        =  CASE WHEN @dFechaPrxProceso <> '19000101' THEN @dFechaPrxProceso ELSE @dfecpro END
    AND    moneda       =  @ncodmon  
    AND    plazocal    <= @nplazovto
    ORDER 
    BY    plazocal DESC
        
    SELECT @ntasabidma    = bidcal 
         , @ntasaaskma    = askcal 
         , @nplazoma    = plazocal
    FROM   VIEW_MFBIDASK
    WHERE  fecha        = CASE WHEN @dFechaPrxProceso <> '19000101' THEN @dFechaPrxProceso ELSE @dfecpro END
    AND    moneda        = @ncodmon  
    AND    plazocal    > @nplazovto
    ORDER 
    BY    plazocal ASC

    SET ROWCOUNT 0

    IF @ntasabidme    IS NULL SELECT @ntasabidme = 0
    IF @ntasaaskme    IS NULL SELECT @ntasaaskme = 0
    IF @nplazome    IS NULL SELECT @nplazome   = 0
    IF @ntasabidma    IS NULL SELECT @ntasabidma = @ntasabidme
    IF @ntasaaskma    IS NULL SELECT @ntasaaskma = @ntasaaskme
    IF @nplazoma    IS NULL SELECT @nplazoma   = @nplazome

    IF @nplazovto > @nplazome BEGIN
        SELECT    @ndiftasabid  = @ntasabidma - @ntasabidme
        SELECT    @ndiftasaask  = @ntasaaskma - @ntasaaskme
        SELECT    @ndifplazo    = @nplazoma   - @nplazome
                
        EXECUTE    sp_div     @ndiftasabid, @ndifplazo, @ninterpbid output
        EXECUTE    sp_div     @ndiftasaask, @ndifplazo, @ninterpask output
                
        SELECT    @ntasafwd  = ( ( @ntasaaskme + @ninterpask * ( @nplazovto - @nplazome ) ) + ( @ntasabidme + @ninterpbid * ( @nplazovto - @nplazome ) ) ) /2 
    END 
    ELSE BEGIN
        SELECT    @ntasafwd = ( @ntasabidme + @ntasaaskme ) / 2
    END
 
    SELECT @ntasafwd = ROUND(@ntasafwd,6) 
 
    SELECT    @npuntaspot    = vmptacmp 
    FROM    VIEW_VALOR_MONEDA 
    WHERE    vmcodigo    = @ncodmon 
    AND    vmfecha        = @dfecpro

        SET NOCOUNT OFF        
END

GO
