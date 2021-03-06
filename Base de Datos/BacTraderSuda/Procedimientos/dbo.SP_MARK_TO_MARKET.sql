USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MARK_TO_MARKET]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_MARK_TO_MARKET]
            ( @fecha_c char(10) )
as
begin
declare @tasa           numeric(09,04)          ,
        @mayor          numeric(03,01)          ,
        @moneda         integer                 ,
        @libor          numeric(18,10)          ,
        @tasaestim      numeric(09,04)          ,
        @base           numeric(03,00)          ,
        @fecha_v        char(10)                ,
        @fecha_e        char(10)                ,
        @fecha_p        char(10)                ,
        @nominal        numeric(19,04)          ,
        @tir            numeric(09,04)          ,
        @x              integer                 ,
        @contador       numeric(10,0)           ,
        @fpvp           float                   ,
        @fmt_0          float                   ,
        @fmtum          float                   ,
        @fmt_cien       float                   ,
        @fvan           float                   ,
        @fvpar          float                   ,
        @nnumucup       integer                 ,
        @dfecucup       datetime                ,
        @fintucup       float                   ,
        @famoucup       float                   ,
        @fsalucup       float                   ,
        @nnumpcup       integer                 ,
        @dfecpcup       datetime                ,
        @fintpcup       float                   ,
        @famopcup       float                   ,
        @fsalpcup       float                   ,
        @fdurat         float                   ,
        @fconvx         float                   ,
        @fdurmo         float                   ,
        @cprog          char(10)                ,
        @nerror         integer                 ,
        @nnumoper       numeric(10,00)          ,
        @nnumdocu       numeric(10,00)          ,
        @ncorrela       numeric(03,00)          ,
        @cinstser       char(12)                ,
        @nnominal       numeric(19,04)          ,
        @dfecven        datetime                ,
        @nrutcart       numeric(09,00)          ,
        @ncodigo        numeric(05,00)          ,
        @ncodigo_mo     numeric(03,00)          ,
        @dfecemi        datetime                ,
        @cseriado       char(01)                ,
        @ntircomp       numeric(09,04)          ,
        @ncapitalc      numeric(19,04)          ,
        @icorvent       integer                 ,
        @dfecha_i       datetime                ,
        @dfecha_f       datetime                ,
        @nrango_i       numeric(05,2)           ,
        @nrango_f       numeric(05,2)           ,
        @crutemp        char(12)                ,
        @cnomemp        char(30)                ,
        @cglomon        char(05)  ,
        @nrutemi        numeric(10)  ,
        @fmt_p          float   ,
        @fdurmo_p       float
select  @fecha_c        = convert(char(10),acfecproc,101)       ,
        @crutemp        = convert(char(10),acrutprop)+acdigprop ,
        @cnomemp        = acnomprop    ,
        @fecha_p        = convert(char(10),acfecprox,101)
from MDAC
--******************************************************--
--**  valorizacion cartera de inversiones disponible  **--
--******************************************************--
select  @x        = 1
select  @contador = count(*) from MDCP where cpnominal > 0
delete  MDMM
while (@x<=@contador)
begin
   select  @cinstser       = '*'
   set rowcount @x
   select  @nnumoper       = cpnumdocu     ,
           @nnumdocu       = cpnumdocu     ,
           @ncorrela       = cpcorrela     ,
           @nrutcart       = cprutcart     ,
           @nnominal       = cpnominal     ,
           @cinstser       = cpinstser     ,
           @dfecven        = cpfecven      ,
           @ncodigo        = cpcodigo      ,
           @dfecemi        = cpfecemi      ,
           @cseriado       = cpseriado     ,
           @ntircomp       = cptircomp     ,
--         @ncapitalc      = cpcapitalc    ,
           @ncapitalc      = cpvptirc      ,
           @dfecha_i       = ''            ,
           @dfecha_f       = ''            ,
           @nrango_i       = 0.0           ,
           @nrango_f       = 0.0
   from    MDCP
   where   cpnominal>0
   set rowcount 0
   select @x = @x + 1
   select @nrutemi = 0
   select @nrutemi = isnull(b.emrut,0)
     from MDDI  a,
          VIEW_EMISOR b
    where a.dinumdocu = @nnumdocu
      and a.dicorrela = @ncorrela
      and a.digenemi  = b.emgeneric
   if @cinstser='*'
     break
   select  @tasa   = 0.0
   select  @tasa           = b.trtasas               ,
           @dfecha_i       = a.rgfinic               ,
           @dfecha_f       = a.rgfvenc               ,
           @nrango_i       = a.rgvaldes              ,
           @nrango_f       = a.rgvalhas
   from    MDRG a, MDTR b
   where   @dfecven >=a.rgfinic and @dfecven <= a.rgfvenc and
           b.tremisor = @nrutemi and
           b.trserie  = (select distinct diserie from MDDI where diinstser=@cinstser and dinumdocu=@nnumdocu and dicorrela=@ncorrela)  and  rgvaldes = trvaldes and rgvalhas = trvalhas and trtasas > 0
--           b.trserie  = (select diserie from MDDI where diinstser='dpr 050500' and dinumdocu=4 and dicorrela=1) and  rgvaldes = trvaldes and rgvalhas = trvalhas and trtasas > 0
             
   if @tasa <> 0.0
   begin
      select @moneda = 0
      if @cseriado='S'
              select  @tasaestim      = setasemi      ,
                      @moneda         = semonemi      ,
                      @base           = sebasemi
              from    VIEW_SERIE 
              where   semascara=@cinstser
      else
              select  @tasaestim      = nstasemi      ,
                      @moneda         = nsmonemi      ,
                      @base           = nsbasemi
              from    VIEW_NOSERIE
              where   nsrutcart=@nrutcart and nsnumdocu=@nnumdocu and nscorrela=@ncorrela
      if @moneda=0
       select  @moneda = (select mncodmon from MDDI, VIEW_MONEDA where dinumdocu=@nnumdocu and dicorrela=@ncorrela and VIEW_MONEDA.mnnemo = MDDI.dinemmon)
      select  @cglomon        = ''
      select  @cglomon        = isnull(mnnemo,'') from VIEW_MONEDA where mncodmon=@moneda
      select  @libor          = (select vmvalor from VIEW_VALOR_MONEDA where vmcodigo=@moneda and convert(char(8),vmfecha,112)=convert(char(8),getdate(),112))
      if @libor=null
              select  @libor  = 0.0
      select  @fecha_v        = convert(char(10),@dfecven,101)        ,
              @nominal        = @nnominal                             ,
              @tir            = @ntircomp                             ,
              @fecha_e        = convert(char(10),@dfecemi,101)
      select  @cprog='SP_' + inprog from VIEW_INSTRUMENTO where incodigo=@ncodigo
      if @cprog<>'SP_'
      begin
  /* valoriza a fecha proximo proceso */
         execute @nerror = @cprog 2      ,
                 @fecha_p                ,
                 @ncodigo                ,
                 @cinstser               ,
                 @moneda                 ,
                 @fecha_e                ,
                 @fecha_v                ,
                 @tasaestim              ,
                 @base                   ,
                 @libor                  ,
                 @nominal        OUTPUT  ,
                 @tasa           OUTPUT  ,
                 @fpvp           OUTPUT  ,
                 @fmt_p          OUTPUT  ,
                 @fmtum          OUTPUT  ,
                 @fmt_cien       OUTPUT  ,
                 @fvan           OUTPUT  ,
                 @fvpar          OUTPUT  ,
                 @nnumucup       OUTPUT  ,
                 @dfecucup       OUTPUT  ,
                 @fintucup       OUTPUT  ,
          @famoucup       OUTPUT  ,
                 @fsalucup       OUTPUT  ,
                 @nnumpcup       OUTPUT  ,
                 @dfecpcup       OUTPUT  ,
                 @fintpcup       OUTPUT  ,
                 @famopcup       OUTPUT  ,
                 @fsalpcup       OUTPUT  ,
                 @fdurat         OUTPUT  ,
                 @fconvx         OUTPUT  ,
                 @fdurmo_p  OUTPUT
  /* valoriza a fecha proceso */
         execute @nerror = @cprog 2      ,
                 @fecha_c                ,
                 @ncodigo                ,
                 @cinstser               ,
                 @moneda                 ,
                 @fecha_e                ,
                 @fecha_v                ,
                 @tasaestim              ,
                 @base                   ,
                 @libor                  ,
                 @nominal        OUTPUT  ,
                 @tasa           OUTPUT  ,
                 @fpvp           OUTPUT  ,
                 @fmt_0          OUTPUT  ,
                 @fmtum          OUTPUT  ,
                 @fmt_cien       OUTPUT  ,
                 @fvan           OUTPUT  ,
                 @fvpar          OUTPUT  ,
                 @nnumucup       OUTPUT  ,
                 @dfecucup       OUTPUT  ,
                 @fintucup       OUTPUT  ,
                 @famoucup       OUTPUT  ,
                 @fsalucup       OUTPUT  ,
                 @nnumpcup       OUTPUT  ,
                 @dfecpcup       OUTPUT  ,
                 @fintpcup       OUTPUT  ,
                 @famopcup       OUTPUT  ,
                 @fsalpcup       OUTPUT  ,
                 @fdurat         OUTPUT  ,
                 @fconvx         OUTPUT  ,
                 @fdurmo   OUTPUT
         if @tasa=null
                 select  @tasa   = 0.0
         if @fmt_0=null
                 select  @fmt_0  = 0.0
         if @fmt_p=null
                 select  @fmt_p  = 0.0
         insert into MDMM
                         (
                         mmnumoper                       ,
                         mmnumdocu                       ,
                         mmrutcart                       ,
                         mmcorrela                       ,
                         mmvptirc                        ,
                         mmtirc                          ,
                         mmtasarg                        ,
                         mmvalor                         ,
                         mmtipoper                       ,
                         mmcorvent                       ,
                         mminstser                       ,
                         mmfecven                        ,
                         mmrango1                        ,
                         mmrango2                        ,
                         mmrutemp                        ,
                         mmnomemp                        ,
                         mmutil                          ,
                         mmfecpro                        ,
                         mmcodinst                       ,
                         mmfecini                        ,
                         mmfecter                        ,
                         mmmoneda                        ,
                         mmnominal    ,
    mmpvp     ,
    mmvp_um    ,
     mmvan      ,
     mmvpar     ,
    mmvalor_prox
                         )
         values
                         (
                         @nnumoper                       ,
                         @nnumdocu                       ,
                         @nrutcart                       ,
                         @ncorrela                       ,
                         @ncapitalc                      ,
                         @ntircomp                    ,
                         @tasa             ,
                         @fmt_0                          ,
                         'CP'                            ,
                         @ncorrela                       ,
                         @cinstser                       ,
                         @dfecven                        ,
                         @nrango_i                       ,
                         @nrango_f                       ,
                         @crutemp                        ,
                         @cnomemp                        ,
                         round(@ncapitalc-@fmt_0,0)      ,
                         @fecha_c                        ,
                         @cinstser                       ,
                         @dfecha_i                       ,
                         @dfecha_f                       ,
                         @cglomon                        ,
                         @nnominal    ,
    @fpvp     ,
    @fmtum     ,
    @fvan     ,
     @fvpar     ,
    @fmt_p
                         )
      end
   end
end  /* fin ciclo cartera propia */
--********************************************************--
--**  valorizacion cartera de inversiones intermediada  **--
--********************************************************--
select  @x        = 1
select  @contador = count(*) from MDVI where vitipoper='CP'
while (@x <= @contador)
begin
   select  @cinstser       = '*'
   set rowcount @x
   select  @nnumoper       =  vinumoper    ,
           @nnumdocu       =  vinumdocu    ,
           @ncorrela       =  vicorrela    ,
           @nrutcart       =  virutcart    ,
           @nnominal       =  vinominal    ,
           @cinstser       =  viinstser    ,
           @dfecven        =  vifecven     ,
           @ncodigo        =  vicodigo     ,
           @dfecemi        =  vifecemi     ,
           @cseriado       =  viseriado    ,
           @ntircomp       =  vitircomp    ,
           @ncapitalc      =  vivptirc     ,
           @icorvent       =  vicorvent    ,
           @nrutemi        =  virutemi
   from    MDVI
   where   vitipoper='CP'
   set rowcount 0
   select @x = @x + 1
   if @cinstser = '*'
     break
print @tasa
   select  @tasa           = 0.0
print @tasa
   select  @tasa           = b.trtasas               ,
           @dfecha_i       = a.rgfinic               ,
           @dfecha_f       = a.rgfvenc               ,
           @nrango_i       = a.rgvaldes              ,
           @nrango_f       = a.rgvalhas
   from    MDRG a, MDTR b
   where   a.rgfinic <= @dfecven and a.rgfvenc >= @dfecven and
           b.tremisor = @nrutemi and
           b.trserie  = (select diserie from MDDI where diinstser=@cinstser and dinumdocu=@nnumdocu and dicorrela=@ncorrela) and
           a.rgvaldes = b.trvaldes and a.rgvalhas = b.trvalhas and b.trtasas>0
print @tasa
   if @tasa <> 0.0
   begin
      select @moneda = 0
      if @cseriado='S'
              select  @tasaestim      = setasemi      ,
                      @moneda         = semonemi      ,
                      @base           = sebasemi
              from    VIEW_SERIE 
              where   semascara=@cinstser
      else
              select  @tasaestim      = nstasemi      ,
                      @moneda         = nsmonemi      ,
                      @base           = nsbasemi
              from    VIEW_NOSERIE
              where   nsrutcart=@nrutcart and nsnumdocu=@nnumdocu and nscorrela=@ncorrela
      if @moneda=0
       select  @moneda = (select mncodmon from MDDI, VIEW_MONEDA where dinumdocu=@nnumdocu and dicorrela=@ncorrela and VIEW_MONEDA.mnnemo= MDDI.dinemmon)
      select  @cglomon        = ''
      select  @cglomon        = isnull(mnnemo,'') from VIEW_MONEDA where mncodmon=@moneda
      select  @libor          = (select vmvalor from VIEW_VALOR_MONEDA  where vmcodigo=@moneda and convert(char(8),vmfecha,112)=convert(char(8),getdate(),112))
      if @libor=null
              select  @libor  = 0
      select  @fecha_v        = convert(char(10),@dfecven,101)        ,
              @nominal        = @nnominal                             ,
              @tir            = @ntircomp          ,
              @fecha_e        = convert(char(10),@dfecemi,101)
      select  @cprog  = 'SP_' + inprog from VIEW_INSTRUMENTO where incodigo=@ncodigo
      if @cprog<>'SP_'
      begin
  /* valoriza a fecha proximo proceso */
         execute @nerror = @cprog 2      ,
                 @fecha_p                ,
                 @ncodigo                ,
                 @cinstser               ,
                 @moneda                 ,
                 @fecha_e                ,
                 @fecha_v                ,
                 @tasaestim              ,
                 @base                   ,
                 @libor                  ,
                 @nominal        OUTPUT  ,
                 @tasa           OUTPUT  ,
                 @fpvp           OUTPUT  ,
                 @fmt_p          OUTPUT  ,
                 @fmtum          OUTPUT  ,
                 @fmt_cien       OUTPUT  ,
                 @fvan           OUTPUT  ,
                 @fvpar          OUTPUT  ,
                 @nnumucup       OUTPUT  ,
                 @dfecucup       OUTPUT  ,
                 @fintucup       OUTPUT  ,
                 @famoucup       OUTPUT  ,
                 @fsalucup       OUTPUT  ,
                 @nnumpcup       OUTPUT  ,
                 @dfecpcup       OUTPUT  ,
                 @fintpcup       OUTPUT  ,
                 @famopcup       OUTPUT  ,
                 @fsalpcup       OUTPUT  ,
                 @fdurat         OUTPUT  ,
                 @fconvx         OUTPUT  ,
                 @fdurmo_p       OUTPUT
  /* valoriza a fecha proceso */
         execute @nerror = @cprog 2      ,
                 @fecha_c                ,
                 @ncodigo                ,
                 @cinstser               ,
                 @moneda                 ,
                 @fecha_e                ,
                 @fecha_v                ,
                 @tasaestim              ,
                 @base                   ,
                 @libor                  ,
                 @nominal        OUTPUT  ,
                 @tasa           OUTPUT  ,
                 @fpvp           OUTPUT  ,
                 @fmt_0          OUTPUT  ,
                 @fmtum          OUTPUT  ,
                 @fmt_cien       OUTPUT  ,
                 @fvan           OUTPUT  ,
                 @fvpar          OUTPUT  ,
                 @nnumucup       OUTPUT  ,
                 @dfecucup       OUTPUT  ,
                 @fintucup       OUTPUT  ,
                 @famoucup       OUTPUT  ,
                 @fsalucup       OUTPUT  ,
                 @nnumpcup       OUTPUT  ,
                 @dfecpcup       OUTPUT  ,
                 @fintpcup       OUTPUT  ,
                 @famopcup       OUTPUT  ,
                 @fsalpcup       OUTPUT  ,
                 @fdurat         OUTPUT  ,
                 @fconvx         OUTPUT  ,
                 @fdurmo         OUTPUT
         if @tasa=null
                 select  @tasa   = 0.0
         if @fmt_0=null
                 select  @fmt_0  = 0.0
         if @fmt_p=null
                 select  @fmt_p  = 0.0
         insert into MDMM
                         (
                         mmnumoper                       ,
                         mmnumdocu                       ,
                         mmrutcart                       ,
                         mmcorrela                       ,
                         mmvptirc                        ,
                         mmtirc                          ,
                       mmtasarg                 ,
                         mmvalor                         ,
                         mmtipoper                       ,
                         mmcorvent                       ,
                         mminstser                       ,
                         mmfecven                        ,
                         mmrango1           ,
                         mmrango2                        ,
                         mmrutemp                        ,
                         mmnomemp                        ,
                         mmutil                          ,
                         mmfecpro                        ,
                         mmcodinst                       ,
                         mmfecini                        ,
                         mmfecter                        ,
                         mmmoneda                        ,
                         mmnominal                       ,
                         mmpvp     ,
    mmvp_um    ,
    mmvan      ,
    mmvpar     ,
    mmvalor_prox
                         )
         values
                         (
                         @nnumoper                       ,
                         @nnumdocu                       ,
                         @nrutcart                       ,
                         @ncorrela                       ,
                         @ncapitalc                      ,
                         @ntircomp                       ,
                         @tasa                           ,
                         @fmt_0                          ,
                         'VI'                            ,
                         @icorvent                       ,
                         @cinstser                       ,
                         @dfecven                        ,
                         @nrango_i                       ,
                         @nrango_f                       ,
                         @crutemp                        ,
                         @cnomemp                        ,
                         round(@ncapitalc-@fmt_0,0)      ,
                         @fecha_c                        ,
                         @cinstser                       ,
                         @dfecha_i                       ,
                         @dfecha_f                       ,
                         @cglomon                        ,
                         @nnominal                       ,
                         @fpvp     ,
    @fmtum     ,
    @fvan     ,
    @fvpar     ,
    @fmt_p
                         )
      end
   end
end  /* fin ciclo cartera intermediada */
--********************************************************--
--**  valorizacion cartera de compras con pacto         **--
--********************************************************--
select  @x        = 1
select  @contador = count(*) from MDCI
while (@x <= @contador)
begin
   select  @cinstser       = '*'
   set rowcount @x
   select  @nnumoper       =  cinumdocu    ,
           @nnumdocu       =  cinumdocu    ,
           @ncorrela       =  cicorrela    ,
           @nrutcart       =  cirutcart    ,
           @nnominal       =  cinominal    ,
           @cinstser       =  ciinstser    ,
           @dfecven        =  cifecven     ,
           @ncodigo        =  cicodigo     ,
           @dfecemi        =  cifecemi     ,
           @cseriado       =  ciseriado    ,
           @ntircomp       =  citircomp    ,
           @ncapitalc      =  civptirc     ,
           @icorvent       =  0            ,
           @nrutemi        =  cirutemi
   from    MDCI
   set rowcount 0
   select @x = @x + 1
   if @cinstser='*'
      break
   select  @tasa           = 0.0
   select  @tasa           = b.trtasas               ,
           @dfecha_i       = a.rgfinic               ,
    @dfecha_f       = a.rgfvenc     ,
           @nrango_i       = a.rgvaldes              ,
           @nrango_f       = a.rgvalhas
   from    MDRG a, MDTR b
   where   a.rgfinic <= @dfecven and a.rgfvenc >= @dfecven and
           b.tremisor = @nrutemi and
           b.trserie  = (select diserie from MDDI where diinstser=@cinstser and dinumdocu=@nnumdocu and dicorrela=@ncorrela) and
           a.rgvaldes = b.trvaldes and a.rgvalhas = b.trvalhas and b.trtasas>0
   if @tasa <> 0.0
   begin
      select @moneda = 0
      if @cseriado='S'
              select  @tasaestim      = setasemi      ,
                      @moneda         = semonemi      ,
                      @base           = sebasemi
              from    VIEW_SERIE 
              where   semascara=@cinstser
      else
              select  @tasaestim      = nstasemi      ,
                      @moneda         = nsmonemi      ,
                      @base           = nsbasemi
              from    VIEW_NOSERIE
              where   nsrutcart=@nrutcart and nsnumdocu=@nnumdocu and nscorrela=@ncorrela
      if @moneda=0
       select  @moneda = (select mncodmon from MDDI, VIEW_MONEDA where dinumdocu=@nnumdocu and dicorrela=@ncorrela and VIEW_MONEDA.mnnemo= MDDI.dinemmon)
      select  @cglomon        = ''
      select  @cglomon        = isnull(mnnemo,'') from VIEW_MONEDA where mncodmon=@moneda
      select  @libor          = (select vmvalor from VIEW_VALOR_MONEDA  where vmcodigo=@moneda and convert(char(8),vmfecha,112)=convert(char(8),getdate(),112))
      if @libor=null
              select  @libor  = 0
      select  @fecha_v        = convert(char(10),@dfecven,101)        ,
              @nominal        = @nnominal                             ,
              @tir            = @ntircomp                             ,
              @fecha_e        = convert(char(10),@dfecemi,101)
      select  @cprog  = 'SP_' + inprog from VIEW_INSTRUMENTO where incodigo=@ncodigo
      if @cprog<>'SP_'
      begin
  /* valoriza a fecha proximo proceso */
         execute @nerror = @cprog 2      ,
                 @fecha_p                ,
                 @ncodigo                ,
                 @cinstser               ,
                 @moneda                 ,
                 @fecha_e                ,
                 @fecha_v                ,
                 @tasaestim              ,
                 @base                   ,
                 @libor                  ,
                 @nominal        OUTPUT  ,
                 @tasa           OUTPUT  ,
                 @fpvp           OUTPUT  ,
                 @fmt_p          OUTPUT  ,
                 @fmtum          OUTPUT  ,
                 @fmt_cien       OUTPUT  ,
                 @fvan           OUTPUT  ,
                 @fvpar          OUTPUT  ,
                 @nnumucup       OUTPUT  ,
                 @dfecucup       OUTPUT  ,
                 @fintucup       OUTPUT  ,
                 @famoucup       OUTPUT  ,
                 @fsalucup       OUTPUT  ,
                 @nnumpcup       OUTPUT  ,
                 @dfecpcup       OUTPUT  ,
                 @fintpcup       OUTPUT  ,
                 @famopcup       OUTPUT  ,
                 @fsalpcup       OUTPUT  ,
                 @fdurat         OUTPUT  ,
                 @fconvx         OUTPUT  ,
                 @fdurmo_p       OUTPUT
  /* valoriza a fecha proceso */
         execute @nerror = @cprog 2      ,
                 @fecha_c                ,
                 @ncodigo                ,
                 @cinstser               ,
                 @moneda                 ,
                 @fecha_e                ,
                 @fecha_v                ,
                 @tasaestim              ,
                 @base                   ,
                 @libor ,
                 @nominal        OUTPUT  ,
                 @tasa           OUTPUT  ,
                 @fpvp           OUTPUT  ,
                 @fmt_0          OUTPUT  ,
                 @fmtum          OUTPUT  ,
                 @fmt_cien       OUTPUT  ,
                 @fvan           OUTPUT  ,
                 @fvpar          OUTPUT  ,
                 @nnumucup       OUTPUT  ,
                 @dfecucup       OUTPUT  ,
                 @fintucup       OUTPUT  ,
                 @famoucup       OUTPUT  ,
                 @fsalucup       OUTPUT  ,
                 @nnumpcup       OUTPUT  ,
                 @dfecpcup       OUTPUT  ,
                 @fintpcup       OUTPUT  ,
                 @famopcup       OUTPUT  ,
                 @fsalpcup       OUTPUT  ,
                 @fdurat         OUTPUT  ,
                 @fconvx         OUTPUT  ,
                 @fdurmo         OUTPUT
         if @tasa=null
                 select  @tasa   = 0.0
         if @fmt_0=null
                 select  @fmt_0  = 0.0
         if @fmt_p=null
                 select  @fmt_p  = 0.0
         insert into MDMM
                         (
                         mmnumoper                       ,
                         mmnumdocu                       ,
                         mmrutcart                       ,
                         mmcorrela                       ,
                         mmvptirc                        ,
                         mmtirc                          ,
                         mmtasarg                        ,
                         mmvalor                         ,
                         mmtipoper                       ,
                         mmcorvent                       ,
                         mminstser                       ,
                         mmfecven                        ,
                         mmrango1                        ,
                         mmrango2                        ,
                         mmrutemp                        ,
                         mmnomemp                        ,
                         mmutil                          ,
                         mmfecpro                        ,
                         mmcodinst                       ,
                         mmfecini                        ,
                         mmfecter                        ,
                         mmmoneda                        ,
                         mmnominal                       ,
                         mmpvp     ,
    mmvp_um    ,
    mmvan      ,
    mmvpar     ,
    mmvalor_prox
                         )
         values
                         (
                         @nnumoper                       ,
                         @nnumdocu                       ,
                         @nrutcart                       ,
                         @ncorrela                       ,
                         @ncapitalc                      ,
                         @ntircomp                       ,
                         @tasa                           ,
                         @fmt_0                          ,
                         'CI'                            ,
                         @icorvent                       ,
                         @cinstser                       ,
                         @dfecven                        ,
                         @nrango_i                       ,
                         @nrango_f                       ,
                         @crutemp                        ,
                         @cnomemp                        ,
                         round(@ncapitalc-@fmt_0,0)      ,
                         @fecha_c                        ,
                         @cinstser                       ,
                         @dfecha_i                       ,
                         @dfecha_f             ,
                         @cglomon                   ,
                         @nnominal                       ,
                         @fpvp     ,
    @fmtum     ,
    @fvan     ,
    @fvpar     ,
    @fmt_p
                         )
      end
   end
end  /* fin ciclo cartera compras con pacto */
update MDAC set acsw_mm = '1'
select 'OK'
end   /* fin procedimiento */
-- sp_mark_to_market '20000925'
-- sp_mark_to_market '25092000'
-- select * from MDCP
-- select * from MDMM
-- select * from MDDI
-- select * from MDVI
-- select * from MDAC


GO
