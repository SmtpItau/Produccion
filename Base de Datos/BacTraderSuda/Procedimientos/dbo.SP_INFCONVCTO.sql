USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFCONVCTO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFCONVCTO]
             (  @dfecinicio char(8),
           @dfecfinal char(8),
   @ncodcart  numeric(09) 
      )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @acfecproc   char(10),
           @acfecprox   char(10),
           @uf_hoy      float,
           @uf_man      float,
           @ivp_hoy     float,
           @ivp_man     float,
           @do_hoy      float,
           @do_man      float,
           @da_hoy      float,
           @da_man      float,
           @acnomprop   char(40),
           @rut_empresa char(12),
           @hora        char(8)
   execute Sp_Base_Del_Informe
           @acfecproc   output,
           @acfecprox   output,
           @uf_hoy      output,
           @uf_man      output,
           @ivp_hoy     output,
           @ivp_man     output,
           @do_hoy      output,
           @do_man      output,
           @da_hoy      output,
           @da_man      output,
           @acnomprop   output,
           @rut_empresa output,
           @hora        output
   -- vencimiento de br-cbr (gbm)
   declare   
            @nvalorfinal numeric (19,4) ,
     @nindice1  float  ,
     @nindice2  float  ,
     @dmesantcar  datetime ,
            @dmesantpro  datetime ,
            @dmesantemi  datetime ,
            @nanos  integer  ,
            @nmeses  integer  ,
            @niniserie  numeric(3,0) ,
            @nfinserie  numeric(3,0)
  -- delete from #PALISVCTO 
 declare @xtipoper char(10) ,
  @xnumdocu numeric(10,00) ,
  @xnumcorr numeric(03,00) ,
  @xinstser char(12) ,
  @xnominal numeric(19,04) ,
  @xflujo  numeric(19,04) ,
  @xfecvcto datetime ,
  @xfecpago datetime ,
  @xcupon  numeric(03,00) ,
  @xmoneda char(05) ,
  @xtipcam numeric(19,04)  ,
  @xflujoum numeric(19,04) ,
  @xflujopesos numeric(19,04) ,
  @xfecemis datetime ,
  @xserie  char(12) ,
  @xrutcart numeric(9,0)
 declare @dfecpago datetime ,
  @xfecven datetime ,
  @ntipcam numeric(19,04) ,
  @nvalcupon numeric(19,00) ,
  @nvalpremio numeric(19,04) ,
  @nvallibo numeric(17,04) ,
  @nvaltip numeric(17,04) ,
  @ndias  integer  ,
  @nflujoreal numeric(19,04) ,
  @nflujo  numeric(19,04) ,
  @nliborest numeric(19,04) ,
  @ntipest numeric(19,04) ,
  @xcodmoneda numeric(03,00)
 declare @imesemi integer  ,
  @ianoemi integer  ,
  @ianovto integer  ,
  @imesman integer  ,
  @iextrae integer  ,
  @cfecemi char (10) ,
  @cfecemi_ipc char (10) ,
  @dfecemi_ipc datetime ,
  @cfecven char (10) ,
  @cfecman char (8) ,
  @fipcemi float  ,
  @fipccal float  ,
  @dfecman datetime ,
  @nm1  integer  ,
  @nm2  integer  ,
  @nfactor integer  ,
  @ndifmes integer  ,
  @dfecemi        datetime        ,
  @dfecven     datetime        ,
  @fvpar  float  ,
  @cont  float
 declare @dfinmesant datetime 
 declare @dfinmesant1  char (8) 
 declare @rcrut  numeric(09,0),
  @rcfecproc datetime ,
  @dfecpro datetime
 select @rcfecproc = acfecproc from MDAC
 select  tiporeport = 'vctocupcp'     ,
  numdocu  = b.cpnumdocu     ,
  numcorr  = b.cpcorrela     ,
  instser  = b.cpinstser     ,
  nominal  = b.cpnominal     ,
  flujo  =(case when (charindex('&',cpinstser)>0 or charindex('*',cpinstser)>0  ) and cpcodigo=20
    then
    0      
     else
    ((c.tdflujo*b.cpnominal)/100)  
    end),
  fecvcto  =(case 
    when cpcodigo = 890 or cpcodigo = 895 or cpcodigo = 20 
    then dateadd(month, sepervcup * tdcupon, cpfecemi) 
    else tdfecven                          
    end), 
  cupon  =c.tdcupon     , 
  cancupones =d.secupones,
  moneda  =f.mnnemo     ,
  fecventa =b.cpfecven     ,
  tipoperac ='cp '      ,
  flujoum  = (case when (charindex('&',cpinstser)>0 or charindex('*',cpinstser)>0  ) and cpcodigo=20
     then 0      
     else
     ((c.tdflujo*b.cpnominal)/100) 
     end),
  fecemis  =   b.cpfecemi     ,
  tasemis  =   d.setasemi     , 
  tircomp  =  b.cptircomp     ,
  fecpago  =  ' '      ,
  tipcam  =  0    ,
  flujopesos =  0      ,
  emisor  =  a.emgeneric     ,
  serie  =  e.inserie     ,
  rutcart  =   b.cprutcart    ,
  fechaproc =                 @rcfecproc    ,
  codinstr = 0
 into #PALISVCTO
 from
  VIEW_EMISOR a,
  MDCP b,
  VIEW_TABLA_DESARROLLO c,
  VIEW_SERIE d,
  VIEW_INSTRUMENTO e,
  VIEW_MONEDA     f
 where 
  cpnominal >  0
 and cpseriado = 'S'
 and cpmascara = semascara  
 and cpmascara = tdmascara
 and  convert(char(10),dateadd(month, sepervcup * tdcupon, cpfecemi),112) >= convert(char(10),@dfecinicio,112)
 and  convert(char(10),dateadd(month, sepervcup * tdcupon, cpfecemi),112) <= convert(char(10),@dfecfinal,112)
 and cpcodigo = incodigo
 and  serutemi = emrut
 and  semonemi = mncodmon
    /* ======================================================================================= */ 
     /* lee datos de cartera de ventas con pactos
 =========================================  */
 insert into 
 #PALISVCTO(
  tiporeport ,
  numdocu  ,
  numcorr  ,
  instser  ,
  nominal  ,
  flujo  ,
  fecvcto  ,
  cupon  ,
  cancupones ,
  moneda  ,
  fecventa ,
  tipoperac ,
  flujoum  ,
  fecemis  ,
  tasemis  ,
  tircomp  ,
  fecpago  ,
  tipcam  ,
  flujopesos ,
  emisor  ,
  serie  ,
  rutcart  ,
  fechaproc ,
  codinstr
  ) 
 select 
  'vctocupvi'     ,  
  b.vinumdocu     ,
  b.vicorrela     ,
  b.vimascara     ,
  b.vinominal     ,
  case when (charindex('&',viinstser)>0 or charindex('*',viinstser)>0  ) and vicodigo=20
  then
   0      
   else
   ((c.tdflujo*b.vinominal)/100) 
  end,
                case 
                   when vicodigo = 890 or vicodigo = 895 or vicodigo = 20 
                   then dateadd(month, sepervcup * tdcupon, vifecemi) 
                   else tdfecven                          
                end,
  c.tdcupon     , 
  d.secupones     ,
  f.mnnemo     ,
  b.vifecven     ,
  'vi '      ,
  case when (charindex('&',viinstser)>0 or charindex('*',viinstser)>0  ) and vicodigo=20
  then
   0      
   else
   ((c.tdflujo*b.vinominal)/100) 
  end,
  b.vifecemi     ,
  d.setasemi     ,
  b.vitircomp     ,
  ''      ,
  0      ,
  0       ,
  a.emgeneric     ,
  e.inserie     ,
  b.virutcart     ,
  @rcfecproc     ,
  0
 from
  VIEW_EMISOR a,--( index = mddgi1 ) ,
  MDVI b,--( index = MDVI1  ) ,
  VIEW_TABLA_DESARROLLO c,--( index = mdtd01 ) ,
  VIEW_SERIE d,--( index = se01 ) 
  VIEW_INSTRUMENTO e,
  VIEW_MONEDA    f
 where 
  vinominal > 0 
 and viseriado = 'S' 
 and vitipoper = 'CP '
 and vimascara  = semascara 
 and vimascara  = tdmascara
 and  convert(char(10),dateadd(month, sepervcup * tdcupon, vifecemi),112) >= convert(char(10),@dfecinicio,112)
 and  convert(char(10),dateadd(month, sepervcup * tdcupon, vifecemi),112) <= convert(char(10),@dfecfinal,112)
 and  vicodigo = incodigo
 and  serutemi = emrut
 and  mncodmon = semonemi
     /* ======================================================================================= */
     /* ***************************************************************** 
             v e n c i m i e n t o s    de   p a p e l e s     
      ***************************************************************** */  
     /* lee datos de cartera de compras propias
 =======================================  */
 insert into 
 #PALISVCTO(
  tiporeport ,
  numdocu  ,
  numcorr  ,
  instser  ,
  nominal  ,
  flujo  ,
  fecvcto  ,
  cupon  ,
  cancupones ,
  moneda  ,
  fecventa ,
  tipoperac ,
  flujoum  ,
  fecemis  ,
  tasemis  ,
  tircomp  ,
  fecpago  ,
  tipcam  ,
  flujopesos ,
  emisor  ,
  serie  ,
  rutcart  ,
  fechaproc ,
  codinstr
  )
 select 
  'vctopapcp'     ,
  b.cpnumdocu     ,
  b.cpcorrela     ,
  b.cpinstser     ,
  b.cpnominal     ,
  0      ,
  b.cpfecven     ,
  0      ,
  0      ,
  f.mnnemo     ,
 b.cpfecemi     ,
  'cp'      ,
  b.cpnominal     ,
  b.cpfecemi     ,
  e.nstasemi     ,
  b.cptircomp     ,
  b.cpfecven     ,
  0      ,
  isnull(b.cpnominal * (select vmvalor from VIEW_VALOR_MONEDA where vmcodigo = cpcodigo and vmfecha = cpfeccomp),0),
  a.emgeneric     ,
  d.inserie     ,
  b.cprutcart     ,
  c.acfecproc     ,
  b.cpcodigo
 from
  VIEW_EMISOR a,
  MDCP b,
  MDAC c,
  VIEW_INSTRUMENTO  d,
  VIEW_NOSERIE e,
  VIEW_MONEDA     f
 where 
  cpnominal > 0 
 and cprutcart =  acrutprop
 and cpseriado = 'N'
 and  convert(char(10),cpfecven,103) >= convert(char(10),@dfecinicio,103)
 and  convert(char(10),cpfecven,103) <= convert(char(10),@dfecfinal,103)
 and cpcodigo = incodigo
 and nsrutemi = emrut
 and nsmonemi = mncodmon
 and nsnumdocu = cpnumdocu
 and nscorrela = cpcorrela
     /* lee datos de cartera de ventas con pacto
 ========================================  */
 insert into 
 #PALISVCTO(
  tiporeport ,
  numdocu  ,
  numcorr  ,
  instser  ,
  nominal  ,
  flujo  ,
  fecvcto  ,
  cupon  ,
  cancupones ,
  moneda  ,
  fecventa ,
  tipoperac ,
  flujoum  ,
  fecemis  ,
  tasemis  ,
  tircomp  ,
  fecpago  ,
  tipcam  ,
  flujopesos ,
  emisor  ,
  serie  ,
  rutcart  ,
  fechaproc ,
  codinstr
  )
 select 
  'vctopapvi'     ,
  b.vinumdocu     ,
  b.vicorrela     ,
  b.viinstser     ,
  b.vinominal     ,
  0      ,
  b.vifecven     ,
  0      ,
  0      ,
  e.mnnemo     ,
  b.vifecemi     ,
  b.vitipoper     ,
  b.vinominal     ,
  b.vifecemi     ,
  0      ,
  0      ,
  b.vifecven     ,
  0      ,
  0      ,
  d.emgeneric     ,
  f.inserie     ,
  b.virutcart     ,
  c.acfecproc     ,
  0
 from
  VIEW_NOSERIE a,
  MDVI b,
  MDAC  c,
  VIEW_EMISOR d,
  VIEW_MONEDA e,
  VIEW_INSTRUMENTO f
 where 
  vinominal > 0 
 and     virutcart = acrutprop
 and viseriado = 'N'
 and     vitipoper = 'CP' 
 and  convert(char(10),vifecven,103) >= convert(char(10),@dfecinicio,103)
 and  convert(char(10),vifecven,103) <= convert(char(10),@dfecfinal,103)
 and vicodigo = incodigo
 and virutemi = emrut
 and nsmonemi = mncodmon
 and vinumdocu = nsnumdocu
 and vicorrela = nscorrela
 
     /* datos tasas estimadas del d-a para pcd's
 ======================================== */
 declare @codinstr integer
 declare cur_temp
 scroll cursor 
 for
 select  tiporeport ,
  numdocu  ,  
  numcorr  ,
  instser  ,
  nominal  ,
  flujo  ,
  fecvcto  ,
  fecpago  ,
  cupon  ,
  moneda  ,
  tipcam  ,
  fecventa ,
  fecemis  ,
  moneda  ,
  flujoum  ,
  flujopesos ,
  serie  ,
  rutcart  ,
  fechaproc ,
  codinstr
 from #PALISVCTO   
 open cur_temp
 fetch first 
 from CUR_TEMP
 into 
  @xtipoper ,
  @xnumdocu ,
  @xnumcorr ,
  @xinstser ,
  @xnominal ,
  @xflujo  ,
  @xfecvcto ,
  @xfecpago ,
  @xcupon  ,
  @xmoneda ,
  @xtipcam ,
  @xfecven ,
  @xfecemis ,
  @xmoneda ,
  @xflujoum ,
  @xflujopesos ,
  @xserie  ,
  @xrutcart ,
  @dfecpro ,
  @codinstr
 while (@@fetch_status=0)
 begin
 
 
  select @xcodmoneda = mncodmon from VIEW_MONEDA  where mnnemo = @xmoneda
  select  @nliborest = a.vmvalor  ,
   @ntipest   = b.vmvalor
  from 
   VIEW_VALOR_MONEDA a,
   VIEW_VALOR_MONEDA b
  where  a.vmcodigo = 302
  and b.vmcodigo = 301
  and convert(char(10),a.vmfecha,112)  = convert(char(10),@dfecpro,112)    --c.acfecproc
  and convert(char(10),b.vmfecha,112)  = convert(char(10),@dfecpro,112)    --c.acfecproc
            if @xtipoper = 'VCTOCUPCP'   or  @xtipoper = 'VCTOCUPVI'
     begin   
  if  @xcodmoneda <> 999
                begin 
      select  @xflujopesos = @xflujo * vmvalor 
   from  VIEW_VALOR_MONEDA 
   where  convert(char(10),vmfecha,112) = convert(char(10),@xfecvcto,112)
   and    vmcodigo     = @xcodmoneda
                end
  else
            begin 
   select @xflujopesos = @xflujo
                end
  
  if @xflujopesos = 0 
                begin
          select  @xflujopesos = @xflujo * vmvalor 
   from  VIEW_VALOR_MONEDA
   where  convert(char(10),vmfecha,112) = convert(char(10),@dfecpro,112)
   and    vmcodigo     = @xcodmoneda
                end
  
  select @dfecpago = @xfecvcto
  execute Sp_Diahabil @dfecpago output
  
  select  @ntipcam = isnull(vmvalor,1) 
  from    VIEW_VALOR_MONEDA 
  where   vmcodigo = @xcodmoneda and  
   convert(char(10),vmfecha,112) = convert(char(10),@dfecpago,112)
             /* si no encuentra tipo de cambio en VIEW_VALOR_MONEDA, utiliza tipo de cambio de fecha cartera */
  if @ntipcam = 0  
   select  @ntipcam = isnull(vmvalor,1) 
   from  VIEW_VALOR_MONEDA
   where  vmcodigo = @xcodmoneda and  
    convert(char(10),vmfecha,112) = convert(char(10),@dfecpro,112)  
  if substring(@xinstser,1,3)='PCD'
  begin
   if substring(@xinstser,1,6)='PCDUS$'
   begin
    select @nvalpremio  = prpremio from MDPR where prserie = substring(@xinstser,7,1) and  prcupon = @xcupon
    select @nvallibo    = isnull(vmvalor,0) from VIEW_VALOR_MONEDA where  vmcodigo = 222 and convert(char(10),vmfecha,112) = convert(char(10),@xfecvcto,112)
    select @nvallibo    = case @nvallibo when 0 then @nliborest else @nvallibo end
    select @nflujo     = @nvalpremio + @nvallibo
   end
   else
   begin
    select @nvalpremio  = prpremio from MDPR where prserie = substring(@xinstser,4,1) and  prcupon = @xcupon
    select @nvaltip  = isnull(vmvalor,0) from VIEW_VALOR_MONEDA where  vmcodigo = 433 and convert(char(10),vmfecha,112) = convert(char(10),@xfecvcto,112)
    select @nvaltip  = case when @nvaltip=0 then @ntipest when @nvaltip=null then @ntipest else @nvaltip end   
    select @nflujo  = @nvalpremio + @nvaltip
   end 
   select @ndias   = datediff( day,@xfecvcto ,@xfecven )
   select @nflujoreal = @nflujo*( @ndias/360)
   if @xfecvcto = @xfecven  select @nflujoreal = 100+@nflujoreal
   select @xflujo = (@xnominal * @nflujoreal)/100 
  end
  select @nvalcupon  = round(@xflujo*@ntipcam,0)
  update #PALISVCTO
  set
   fecpago    = @dfecpago,
   tipcam     = isnull(@ntipcam,0),
   flujo      = isnull(@xflujopesos,0), /* isnull(@nvalcupon,0), */
   flujoum    = isnull(@xflujo,0),
   flujopesos = isnull(@xflujopesos,0)
  where   tiporeport =  @xtipoper 
  and  numdocu    =  @xnumdocu
  and numcorr    =  @xnumcorr
  and cupon      =  @xcupon 
  and rutcart    =  @xrutcart
     
            end   /* fin cliclo de vencimientos de cupones */
            if @xtipoper =  'VCTOPAPCP' or  @xtipoper = 'VCTOPAPVI'
     begin   
  if  @xcodmoneda <> 999 
                    begin 
      select  @xflujopesos = @xnominal * vmvalor 
   from  VIEW_VALOR_MONEDA 
   where  convert(char(10),vmfecha,112) = convert(char(10),@xfecvcto,112)
        and    vmcodigo     = @xcodmoneda
                    end
  else
         begin 
    select @xflujopesos = @xnominal * 1
                    end
  if @xflujopesos = 0 
                   begin
          select  @xflujopesos = @xnominal * vmvalor 
   from  VIEW_VALOR_MONEDA --( INDEX = VIEW_VALOR_MONEDA01 )  
   where  convert(char(10),vmfecha,112) = convert(char(10),@dfecpro,112)
   and    vmcodigo     = @xcodmoneda
                   end   
     update #PALISVCTO set flujopesos = isnull(@xflujopesos,0)         ,
     flujo      = isnull(@xflujopesos,0)
             where @xtipoper = tiporeport
       and  @xnumdocu = numdocu 
       and  @xnumcorr = numcorr
       and  @xrutcart = rutcart
  -- calculo de valor final (gbm)
  if rtrim(@xserie) = 'BR' or rtrim(@xserie) = 'CBR'
  begin
   select @dmesantcar = dateadd(dd,datepart(dd,@dfecpro)*-1,@dfecpro)
   select @dmesantemi = dateadd(dd,datepart(dd,@xfecemis)*-1,@xfecemis)
   select @dmesantcar = dateadd(dd,(datepart(dd,@dmesantcar)-1)*-1,@dmesantcar)
   select @dmesantemi = dateadd(dd,( case rtrim(@xserie) when 'BR' then (datepart(dd,@dmesantemi)-1)*-1 else 1 end ),@dmesantemi)
   select @nindice1 = vmvalor
   from VIEW_VALOR_MONEDA
   where vmcodigo = 502
   and vmfecha  = @dmesantcar
   select @nindice2 = vmvalor
   from VIEW_VALOR_MONEDA
   where vmcodigo = 502
   and vmfecha  = @dmesantemi
   select @nanos  = datediff(mm,@xfecemis,@xfecvcto) / 12
   select @nmeses  = datediff(mm,@xfecemis,@xfecvcto) % 12
   if @xserie  = 'BR'
    select @nvalorfinal = @xnominal * ( @nindice1 / @nindice2 ) *
         power( convert(float,1.04), convert(float,@nanos) )  *
         ( 1 + ( convert(float,0.04) / 12 * convert(float,@nmeses) ))
   else
    select @nvalorfinal = @xnominal * ( @nindice1 / @nindice2 ) *
         power( convert(float,1.00), convert(float,@nanos) )  *
         ( 1 + ( convert(float,0.00) / 12 * convert(float,@nmeses) ))
           update #PALISVCTO
   set flujopesos  = isnull(@nvalorfinal,0) ,
    flujoum     = isnull(@nvalorfinal,0)
   where tiporeport = @xtipoper
   and numdocu  = @xnumdocu
   and  numcorr  = @xnumcorr
  end
            end
     if @xtipoper = 'VCTOPACCI'  or   @xtipoper = 'VCTOPACVI'
     begin
  if  @xcodmoneda <> 999 
                begin 
      select @xflujopesos= @xflujoum * vmvalor from VIEW_VALOR_MONEDA --( index = VIEW_VALOR_MONEDA01 )  
          where convert(char(10),vmfecha,112) = convert(char(10),@xfecvcto,112)
          and   vmcodigo = @xcodmoneda
                end
  else
                begin 
   select @xflujopesos = @xflujoum
                end
  if @xflujopesos = 0 
                begin
            select @xflujopesos = @xflujoum * vmvalor from VIEW_VALOR_MONEDA --( index = VIEW_VALOR_MONEDA01 )  
         where convert(char(10),vmfecha,112) = convert(char(10),@dfecpro,112)
         and   vmcodigo = @xcodmoneda
                end   
          update #PALISVCTO set flujopesos = isnull(@xflujopesos,0),
         flujo      =  isnull(@xflujopesos,0)
            where  @xtipoper = tiporeport
       and  @xnumdocu = numdocu 
       and  @xnumcorr = numcorr
       and  @xrutcart = rutcart
     end
 fetch next
  from CUR_TEMP
  into 
  @xtipoper ,
  @xnumdocu ,
  @xnumcorr ,
  @xinstser ,
  @xnominal ,
  @xflujo  ,
  @xfecvcto ,
  @xfecpago ,
  @xcupon  ,
  @xmoneda ,
  @xtipcam ,
  @xfecven ,
  @xfecemis ,
  @xmoneda ,
  @xflujoum ,
  @xflujopesos ,
  @xserie  ,
  @xrutcart ,
  @dfecpro ,
  @codinstr
 end
   set nocount off
   if exists( select * from #PALISVCTO, MDAC
                  where rutcart = acrutprop 
            ) begin
   select
               'tiporeport'     = tiporeport ,
               'numdocu'           = numdocu    ,
               'numcorr'           = numcorr    ,
               'instser'           = instser    ,
               'nominal'           = nominal    ,
               'flujo'             = flujo      ,
               'fecvcto'           = convert(char(10),fecvcto,103),
               'cupon'             = cupon      ,
               'cancupones'        = cancupones ,
               'moneda'            = moneda     ,
               'fecventa'          = convert(char(10),fecventa,103),
               'tipoper'           = tipoperac         ,
               'flujoum'           = flujoum    ,
               'facemis'           = convert(char(10),fecemis,103),
               'tasemis'           = tasemis    ,
               'tircomp'           = tircomp    ,
               'fecpago'           = convert(char(10),fecpago,103),
               'tipcam'            = tipcam     ,
               'flujopesos'        = flujopesos ,
               'emisor'            = emisor     ,
               'serie'             = serie ,
        'acfecproc'         = @acfecproc   ,
               'acfecprox'         = @acfecprox   ,
        'uf_hoy'            = @uf_hoy      ,
        'uf_man'            = @uf_man      ,
        'ivp_hoy'           = @ivp_hoy     ,
        'ivp_man'           = @ivp_man     ,
        'do_hoy'            = @do_hoy      ,
        'do_man'            = @do_man      ,
               'da_hoy'            = @da_hoy      ,
        'da_man'            = @da_man   ,
        'acnomprop'         = @acnomprop   ,
        'rut_empresa'       = @rut_empresa,
        'hora'              = @hora
/*
               'acfecproc' = convert(char(10), p.acfecproc, 103),
               'acfecprox' = convert(char(10), p.acfecprox, 103),
               uf_hoy,
               uf_man,
               ivp_hoy,
               ivp_man,
               do_hoy,
               do_man,
               da_hoy,
               da_man,
               p.acnomprop,
               rut_empresa,
               'hora' = convert(varchar(10), getdate(), 108),
*/         from
               #PALISVCTO, MDAC,#PARAMETROS p
         where
               rutcart = acrutprop end
   else begin
      select   'tiporeport'  = ''   ,
               'numdocu'     = ''   ,
               'numcorr'     = ''   ,
               'instser'     = ''   ,
               'nominal'     = ''   ,
               'flujo'       = ''   ,
               'fecvcto'     = ''   ,
               'cupon'       = ''   ,
               'cancupones'  = ''   ,
               'moneda'      = ''   ,
               'fecventa'    = ''   ,
               'tipoper'     = ''   ,
               'flujoum'     = ''   ,
               'facemis'     = ''   ,
               'tasemis'     = ''   ,
               'tircomp'     = ''   ,
               'fecpago'     = ''   ,
               'tipcam'      = ''   ,
               'flujopesos'  = ''   ,
               'emisor'      = ''   ,
               'serie'       = ''   ,
        'acfecproc' = @acfecproc   ,
               'acfecprox' = @acfecprox   ,
        'uf_hoy'    = @uf_hoy      ,
        'uf_man'    = @uf_man      ,
        'ivp_hoy'   = @ivp_hoy     ,
        'ivp_man'   = @ivp_man     ,
        'do_hoy'    = @do_hoy      ,
        'do_man'    = @do_man      ,
        'da_hoy'    = @da_hoy      ,
        'da_man'    = @da_man      ,
        'acnomprop' = @acnomprop   ,
        'rut_empresa' = @rut_empresa,
        'hora'      = @hora
   end
   close cur_temp
   deallocate cur_temp
end
/*
 select * from mdcp
 sp_infconvcto '20010510','20010510',0
 select * from #PALISVCTO
*/


GO
