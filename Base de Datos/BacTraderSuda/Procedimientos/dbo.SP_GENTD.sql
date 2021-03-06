USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENTD]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GENTD]( @cmascara    char     (12)    ,
                           @ntasemi     numeric  (9,4)   ,
                           @nbasemi     numeric  (9,4)   ,
                           @dfecemi     datetime         ,
                           @dfecven     datetime         ,
                           @ncupones    numeric  (3,0)   ,
                           @nnumamort   numeric  (3,0)   ,
                           @ctipvcup    char     (1)     ,
                           @npervcup    numeric  (9,4)   ,
                           @cffijos     char     (1)     ,
                           @nbascup     numeric  (5,0)   ,
                           @ndecs       numeric  (2,0)   )
as
begin
-- variables de trabajo.-
   declare @finteres  float
   declare @famort    float
   declare @fflujo    float
   declare @fsaldo    float
   declare @fperiodo  float
   declare @fbascup   float
   declare @fnumamort float
   declare @ftasemi   float
   declare @fbasemi   float
   declare @ftasefe   float
   declare @fdias     float
   declare @fcuota    float
   declare @icupon    integer
   declare @dfecvant  datetime
   declare @dfecvcup  datetime
-- crear archivo temporal.-
   create table #TMTD(
          tdmascara char(10)        null ,
          tdcupon   numeric  (3,0)  null ,
          tdfecven  datetime        null ,
          tdinteres numeric  (10,6) null ,
          tdamort   numeric  (10,6) null ,
          tdflujo   numeric  (10,6) null ,
          tdsaldo   numeric  (10,6) null
   )
-- inicializar variables.-
   select @fbascup    =  @nbascup
   select @fperiodo   =  @npervcup
   select @fnumamort  =  @nnumamort
   select @ftasemi    =  @ntasemi
   select @fbasemi    =  @nbasemi
   select @dfecvant   =  @dfecemi
   select @dfecvcup   =  @dfecemi
-- inicializar datos linea td.-
   select @fsaldo     =  @nbascup
   select @finteres   =       0.0
   select @famort     =       0.0
   select @fflujo     =       0.0
   select @icupon     =         0
-- c lculo de la tasa efectiva  y la cuota.- ( para flujos fijos )
   if @ctipvcup = 'D'
        begin
              -- diarios.-
              select @ftasefe  = ( power( 1.0+@ftasemi/100.0 , @fperiodo / @fbasemi ) - 1.0 ) * 100.0
              select @fcuota   = ( @fbascup*@ftasefe/100.0 ) / (1.0 - power( 1.0 / ( 1.0 + @ftasefe/100.0 ) , @fnumamort ))
        end
   else
        begin
              -- mensuales.-
              select @ftasefe  = ( power( 1.0+@ftasemi/100.0 , @fperiodo / 12.0 ) - 1.0 ) * 100.0
              select @fcuota   = ( @fbascup*@ftasefe/100.0 ) / (1.0 - power( 1.0 / ( 1.0 + @ftasefe/100.0 ) , @fnumamort ))
        end
-- ciclo de c lculo de cada flujo.-
   while @icupon <> @ncupones
         begin
              -- proximo cupon
                 select @icupon   = @icupon + 1
              -- determina fechas de vencimiento y dias.-
                 if @ctipvcup = 'D'
                      begin
                           -- tipo de periodo diario.-
                              select @dfecvant = @dfecvcup
                              select @dfecvcup = dateadd( day  , @npervcup * @icupon, @dfecemi )
                              select @fdias    = datediff( day , @dfecvant, @dfecvcup )
                      end
                 else
                      begin
                           -- tipo de periodo mensual.-
                              select @dfecvant = @dfecvcup
                              select @dfecvcup = dateadd( month, @npervcup * @icupon, @dfecemi  )
                              select @fdias    = datediff( day , @dfecvant, @dfecvcup )
                      end
              -- determina interes y amortizaci=n.-
                 select @finteres = round( ( power( 1.0+@ftasemi/100.0 , @fdias / @fbasemi ) - 1.0 ) * @fsaldo , @ndecs )
                 if @cffijos = 'S'
                      begin
                           -- flujos fijos
                              if @nnumamort > ( @ncupones - @icupon )
                                   select @famort = @fcuota - @finteres
                      end
                 else
                      begin
                           -- flujos variables
                              if @nnumamort > ( @ncupones - @icupon )
                                   select @famort = round( @fsaldo / @fnumamort, @ndecs )
                      end
           -- ajuste a la amortizaci=n en el £ltimo flujo
              if @icupon = @ncupones
                   select @famort = @fsaldo
              select @fflujo = @finteres + @famort
              select @fsaldo = @fsaldo   - @famort
              insert into #TMTD
                      ( tdmascara, tdcupon, tdfecven, tdinteres, tdamort, tdflujo, tdsaldo )
               values (@cmascara , @icupon,@dfecvcup ,@finteres ,@famort ,@fflujo ,@fsaldo )
         end
-- devuelve la td generada.-
   select tdmascara, tdcupon, tdfecven, tdinteres, tdamort, tdflujo, tdsaldo
   from #TMTD
   return
end

GO
