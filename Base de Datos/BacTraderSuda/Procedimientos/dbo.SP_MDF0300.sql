USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDF0300]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MDF0300]
                              (@modcal    integer         ,
                               @dfeccal   datetime        ,
                               @ncodigo   integer         ,
                               @cmascara  char(12)        ,
                               @nmonemi   integer         ,
                               @dfecemi   datetime        ,
                               @dfecven   datetime        ,
                               @ftasemi   float           ,
                               @fbasemi   float           ,
                               @ftasest   float           ,
                               @fnominal  float     OUTPUT,
                               @ftir      float     OUTPUT,
                               @fpvp      float     OUTPUT,
                               @fmt       float     OUTPUT,
                               @fmtum     float     OUTPUT,
                               @fmt_cien  float     OUTPUT,
                               @fvan      float     OUTPUT,
                               @fvpar     float     OUTPUT,
                               @nnumucup  integer   OUTPUT,
                               @dfecucup  datetime  OUTPUT,
                               @fintucup  float     OUTPUT,
                               @famoucup  float     OUTPUT,
                               @fsalucup  float     OUTPUT,
                               @nnumpcup  integer   OUTPUT,
                               @dfecpcup  datetime  OUTPUT,
                               @fintpcup  float     OUTPUT,
                               @famopcup  float     OUTPUT,
                               @fsalpcup  float     OUTPUT)
  as
  begin
        
       -- declaro variables
       ---------------------------------
       declare @dfecvcup  datetime
       declare @nsaldo    float
       declare @nmt       float
       declare @nfecha    numeric(8,0)  
       declare @result    float
       declare @ndia1     integer
       declare @ndia2     integer
       declare @tdmascara char(12)
       declare @tdcupon   numeric(3,0)
       declare @tdamort   numeric(19,10)
       declare @tdinteres numeric(19,10)
       declare @tdflujo   numeric(19,10)
       declare @tdsaldo   numeric(19,10)
       declare @ntera     numeric (9,4)
       declare @ncupones  numeric (3,0)
       declare @npervcup  numeric (2,0)
       -- buscamos datos en la tabla de 
       -- serie desde la tabla MDSE
       ----------------------------------
       if not exists ( select semascara from VIEW_SERIE where semascara = @cmascara )         
          begin
              select 'ERROR 4', 4
              return
          end
--       select 'modcal' = @modcal
       
       select @ntera    = setera    , 
              @ncupones = secupones , 
              @npervcup = sepervcup , 
              @nmonemi  = semonemi
       from   VIEW_SERIE
       where  semascara = @cmascara       
       -- validamos fechas 
       ----------------------------------
--       select 'feccal' = convert(char(10),@dfeccal,101), 'fecemi' = convert(char(10),@dfecemi, 101)
       if @dfeccal < @dfecemi 
          begin 
            select 'ERROR 1' =  1 
            return
          end
--       select 'feccal' = convert(char(10),@dfeccal,101) , 'fecven' = convert(char(10),@dfecven, 101)
       if @dfeccal > @dfecven 
          begin
            select 'ERROR 2' = 2 
            return
          end
       if @dfeccal = @dfecven
          begin
             if not exists ( select * from VIEW_TABLA_DESARROLLO where tdmascara = @cmascara and tdcupon = @ncupones ) 
                begin  
                    select 'ERROR 13' = 13 
                    return  
                end
             -- buscamos datos en la tabla de 
             -- desarrollo
             ----------------------------------
             select @nfecha   = convert ( numeric(8,0), convert( char(8), convert(datetime,@dfecemi), 112) ) - datepart ( day, @dfecemi) + 1
--select @nfecha
--             select @dfecucup = convert(char(10),convert(datetime,@nfecha, 112), 101)
--             select @dfecucup = dateadd ( day, ( @npervcup * @ncupones ) + 1, @dfecucup  ) 
--             select @dfecucup = dateadd ( day, - 1, @dfecucup )
             select @nsaldo    = 0.0       , 
                    @nnumucup  = @ncupones ,  
                    @dfecucup  = @dfecucup , 
                    @fintucup  = tdinteres ,
                    @famoucup  = tdamort   ,
                    @fsalucup  = 0.0       ,
                    @nmt       = 0.0
             from   VIEW_TABLA_DESARROLLO 
             where  tdmascara  = @cmascara
             and    tdcupon    = @ncupones
          end                
      -- creamos cursor
      -----------------------------------
       declare tdesa cursor  for select tdmascara, tdcupon, tdsaldo, tdamort, tdinteres from VIEW_TABLA_DESARROLLO where tdmascara = @cmascara
       open tdesa
       if  @modcal = 2  or  @modcal = 5
           select @nsaldo   = 100.0
           select @dfecucup = convert(char(8),@dfecemi, 101)
           select @nnumucup = 0.0
           select @famoucup = 0.0
           select @fintucup = 0
           select @fsalucup = 0.0
           select @fvan     = 0.0  
           fetch next from tdesa into @tdmascara, @tdcupon, @tdsaldo, @tdamort, @tdinteres
           while (@@fetch_status <> -1)
                 begin
                    if @tdmascara = @cmascara
                       begin
--                         select @nfecha   = convert ( numeric(8,0), convert( char(8), convert(datetime,@dfecemi), 112) ) - datepart ( day, @dfecemi) + 1
--                         select @dfecvcup = convert(char(10),convert(datetime,@nfecha, 112), 101)
--                         select @dfecvcup = dateadd ( day, ( @npervcup * @ncupones ) + 1, @dfecvcup  ) 
--                         select @dfecvcup = dateadd ( day, - 1, @dfecvcup )
                         if @dfeccal >= @dfecvcup
                            begin
                              select @nsaldo   = @tdsaldo
                              select @dfecucup = @dfecvcup
                              select @nnumucup = @tdcupon
                              select @famoucup = @tdamort
                              select @fintucup = @tdinteres
                              select @fsalucup = @tdsaldo 
                            end
                              
                         if @dfeccal < @dfecvcup
                            begin
                              if @tdcupon = @nnumucup + 1
                                 select @dfecpcup = @dfecvcup
                                 select @nnumpcup = @tdcupon
                                 select @famopcup = @tdamort
                                 select @fintpcup = @tdinteres
                                 select @fsalpcup = @tdsaldo
                            end   
                             
                         if 30 < datepart( day, @dfeccal  )  select @ndia1 = 30  else  select @ndia1 = datepart( day, @dfeccal ) 
                                                                                                                         
                         if 30 < datepart( day, @dfecvcup )  select @ndia2 = 30  else  select @ndia2 = datepart( day, @dfecvcup ) 
                           
                         select @result = ( datepart (year, @dfeccal) - datepart (year, @dfecvcup) ) * 360 + datepart ( month, @dfeccal ) - datepart (month, @dfecvcup) * 30 + @ndia2 - @ndia1
                         
                         select @fvan   = power ( @fvan + @tdflujo / ( 1.0 + @ftir / 100.0), (@result / 360.0) )
                    end
                    fetch next from tdesa into @tdmascara, @tdcupon, @tdsaldo, @tdamort, @tdinteres
                 end
                
                 select @fvpar = round ( power ( @nsaldo * ( 1.0 + @ntera / 100.0 ), @result ), 8) 
                 if @modcal = 2
                         select @nmt = ( @fpvp / 100.0 ) * ( @fvpar / 100.0 ) * @fnominal
                 else
                         select @fnominal = round (  10000.0 * @nmt / ( @fpvp * @fvpar), 4.0 )
                 close      tdesa
                 deallocate tdesa  
                 return
  end 
--sp_help mdtd
--select * from mdtd
--declare @nfecha numeric(8)
--select @nfecha = 19970225
--select dateadd(day, dateadd ( day, convert(char(10),convert(datetime,@nfecha, 112), 101) , ( 6 * 8 ) + 1 ) -- , - 1 )
--select dateadd ( day, ( 6 * 8 ) + 1 ,convert(char(10),convert(datetime,convert(char(10),@nfecha)),101)
--select dateadd ( day, 1, '02/25/1997' ) --( 6 * 8 ) + 1  ) 


GO
