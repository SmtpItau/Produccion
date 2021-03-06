USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCADATOSRCRV]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_BUSCADATOSRCRV](
     @ctipoper char (03) ,
     @nrutcart numeric (09,0) ,
     @nnumoper numeric (10,0)) with recompile
as
begin
set nocount on
 declare @dfecpro datetime  ,
  @total  numeric (19,4)  ,
  @valmoninip numeric (19,4)  , 
  @valmonvenp numeric (19,4)  ,
  @monpacto char (05)  ,
  @codmonp numeric (03,0)  ,
  @uminip  numeric (19,4)  ,
  @umvenp  numeric (19,4)  ,
  @valinip numeric (19,4)  ,
  @valvenp numeric (19,4)  ,
  @totalinip numeric (19,4)  ,
  @ventas  numeric (10,0)  ,
  @diferencia   float    ,
  @tasap  float    ,
  @basep  integer   ,
  @valanti float    ,
  @plazop  integer   ,
  @ftipcam float 
  declare @peak_cce   float 
  declare @peak_pfe   float 
  declare @nmonemi    integer 
  declare @ftir     float
  declare @fvalormcdo float
  declare @fvpresen   float 
  declare @dfecven    datetime 
  declare @cseriado   char(01)
  declare @itotreg    integer 
  declare @icontador  integer 
  declare @icorrela   integer 
  declare @fdurmo     float 
  declare @ftot_cce   float 
  declare @ftot_pfe   float 
  declare @nnumdocu   numeric(10,0)
  declare @cmascara   char(10)
  declare @nRedondeo  integer
 select @dfecpro = acfecproc from MDAC
 select @total  = 0 ,
  @valmoninip = 0 ,
  @valmonvenp = 0 ,
  @ventas = 0
/* ====================================================================================================
 p r o c e s o         p a r a        r e c o m p r a s
 ==================================================================================================== */
 if @ctipoper='RC'
 begin
  select 'rutcli' = a.virutcli   ,
   'nomcli' = isnull(b.clnombre,'') ,
   'totalinip' = convert(float,0)  ,  -- valor inicial 
   'valact' = convert(float,0)  ,  -- valor actualizado del pacto, se calcula abajo 
   'taspact' = a.vitaspact  ,  -- tasa pacto 
   'valant' = convert(float,0)  ,  -- valor ha anticipar 
   'diferencia' = convert(float,0)  ,  -- diferencia diaria del pacto, se calcula abajo
   'total'  = convert(float,0)  ,
   'numdocu' = a.vinumdocu  ,
   'correla' = a.vicorrela  ,
   'tipoper' = a.vitipoper  , 
   'serie'  = a.viinstser  ,
   'emisor' = c.emgeneric  ,
   'um'  = d.mnnemo   ,
   'nominal' = a.vinominal  ,
   'tir'  = a.vitirvent  ,
--   'precio' = isnull(MDVI.vivpcomp,0.0) ,
   'precio' = isnull(a.vipvpvent,0.0) ,
   'valorpre' = a.vivptirvi  ,
   'fecinip' = a.vifecinip  ,
   'uminip' = a.vivalinip  ,
   'valinip' = a.vivalinip  ,
   'tasap'  = a.vitaspact  ,
   'plazop' = isnull(datediff(day,a.vifecinip,a.vifecvenp),0) ,
   'basep'  = a.vibaspact  ,
   'monedap' = space(5)   ,
   'fecvenp' = convert(char(10),a.vifecvenp,103),
   'umvenp' = a.vivalinip  ,
   'valvenp' = a.vivalinip  ,
   'dvcart' = e.rcdv   ,
   'dvcli'  = b.cldv   ,
   'codcart' = 0    ,
   'glocart' = space(25)   ,
   'ventas' = 0    ,
   'rut_emisor' = a.virutemi   ,
   'fp_vcto' = a.viforpagv  ,
   'codcli' = a.vicodcli   ,
   'duration' = a.vidurmod   ,
   'codmoneda'     = a.vimonemi ,
   'CodMonP'	= a.vimonpact
  into #TEMP
  from 
   --  REQ. 7619
   MDVI a LEFT OUTER JOIN VIEW_EMISOR c ON  a.virutemi = c.emrut 
          LEFT OUTER JOIN VIEW_MONEDA d ON  a.vimonemi = d.mncodmon,
   VIEW_CLIENTE b,
   --  REQ. 7619
   --VIEW_EMISOR c,
   --VIEW_MONEDA d,
   VIEW_ENTIDAD   e
  where 
   a.virutcart = @nrutcart 
  and a.vinumoper = @nnumoper 
  and a.virutcli  = b.clrut 
--  REQ. 7619  
--  and a.virutemi *= c.emrut 
--  and a.vimonemi *= d.mncodmon 
  and a.virutcart = e.rcrut
  select @total  = sum(isnull(vivptirvi,0.0)) , -- valor presente del pacto 
   @totalinip = sum(isnull(vivalinip,0.0)) , -- valor inicial 
   @valvenp = sum(isnull(vivalvenp,0.0))   -- valor final del pacto 
  from 
   MDVI
  where virutcart=@nrutcart 
  and  vinumoper=@nnumoper
  set rowcount 1
  select 
   @tasap  = vitaspact ,
   @basep  = vibaspact  ,
   @plazop = isnull(datediff(day,vifecinip,@dfecpro),0)    
  from 
   MDVI
  where 
   virutcart=@nrutcart 
  and  vinumoper=@nnumoper
  set rowcount 0
  select @valanti    = @total
  select @diferencia = 0  select @monpacto = a.mnnemo  ,
   @codmonp = b.vimonpact
  from   
   VIEW_MONEDA  a,
   MDVI b
  where  
   b.virutcart = @nrutcart 
  and b.vinumoper = @nnumoper 
  and b.vimonpact = a.mncodmon
  select @valmoninip = isnull(b.vmvalor,0)
  from 
  --  REQ. 7619
   MDVI a LEFT OUTER JOIN VIEW_VALOR_MONEDA b ON a.vimonpact = b.vmcodigo 
                                             and a.vifecinip = b.vmfecha
--   VIEW_VALOR_MONEDA b
  where 
   a.virutcart=@nrutcart 
  and a.vinumoper=@nnumoper 
--  REQ. 7619  
--  and a.vimonpact*=b.vmcodigo 
--  and a.vifecinip*=b.vmfecha
  select @valmonvenp = isnull(vmvalor,0)
  from VIEW_VALOR_MONEDA
  where @codmonp=vmcodigo 
  and vmfecha=@dfecpro

  Select @nRedondeo = mndecimal from View_Moneda where mncodmon = @codmonp

  If @codmonp = 13 Begin
	Select @valmonvenp = Vmvalor FROM View_Valor_Moneda Where vmcodigo = 994 And Vmfecha = @dfecpro
  	select @valmoninip = isnull(b.vmvalor,0)
  	from 
   		MDVI   a,
   		VIEW_VALOR_MONEDA b
  	where 
   		a.virutcart=@nrutcart 
  		and a.vinumoper=@nnumoper 
  		and b.vmcodigo = 994 
  		and b.vmfecha = a.vifecinip
  End

  if @codmonp=999
  begin
   select @valmonvenp = 1   ,
    @valmoninip = 1  ,
    @uminip = @totalinip
  end
  else begin  
--VGS   select @uminip  = round(@totalinip/@valmoninip,4)
	select @uminip  = round(@totalinip,@nRedondeo)
  end
 
        update #TEMP
   set codcart = cptipcart
   from MDCP  
   where tipoper='CP' and cpnumdocu=numdocu and cpcorrela=correla
   update #TEMP
   set codcart = MDCI.citipcart
   from MDCI
   where tipoper='CI' and cinumdocu=numdocu and cicorrela=correla
   update #TEMP
   set glocart = tbglosa
   from VIEW_TABLA_GENERAL_DETALLE
   where tbcateg=1 and codcart=convert(numeric(6),tbcodigo1)
/* inicio calculo pfe cce */
  select @itotreg    =  count(*) from MDVI where MDVI.virutcart=@nrutcart and MDVI.vinumoper=@nnumoper
  select @icontador  = 1
  select @ftot_pfe = 0
  select @ftot_cce = 0
  while @icontador<= @itotreg 
  begin 
   set rowcount @icontador 
   select  
    @ftir     = vitircomp ,
    @cseriado = viseriado ,
    @fvpresen = vivptirc  ,
    @dfecven  = vifecvenp ,
    @icorrela = vicorrela ,
    @nnumdocu = vinumdocu ,
    @cmascara = vimascara ,
    @fdurmo   = vidurmod
   from   MDVI
   where 
    MDVI.virutcart=@nrutcart 
   and  MDVI.vinumoper=@nnumoper
   set rowcount 0
   if @cseriado='S'
    select @nmonemi= semonemi 
    from VIEW_SERIE
    where semascara=@cmascara
   else
    select @nmonemi= nsmonemi 
    from VIEW_NOSERIE
    where nsrutcart=@nrutcart 
    and  nsnumdocu=@nnumdocu 
    and  nscorrela=@icorrela
   select @fvalormcdo  = 0
--   select @fvalormcdo  = mmvalor
--   from MDMM
--   where mmnumoper = @nnumoper
--   and   mmcorrela = @icorrela
--   and   mmnumdocu = @nnumdocu
  
   if @fvalormcdo is null or @fvalormcdo = 0  select @fvalormcdo = @fvpresen 
--   execute Sp_Calculo_Pfe_Cce 'BTR'   ,
--     @nmonemi  , 
--     @fdurmo   , 
--     @ftir   ,
--     @fvalormcdo  ,
--     @fvpresen   ,
--     @dfecpro  ,
--     @dfecven  ,
--     'v'   ,
--     @peak_pfe output ,
--     @peak_cce output
  
   select  @ftot_pfe = 0 ,
    @ftot_cce = 0
--   select  @ftot_pfe = @ftot_pfe + @peak_pfe  ,
--    @ftot_cce = @ftot_cce + @peak_cce 
   select @icontador = @icontador + 1
  end
/* fin calculo pfe cce */
   update #TEMP
   set  monedap  = @monpacto   ,
        uminip  = @uminip   ,
        umvenp  = @valvenp   ,
        valinip  = round(@uminip*@valmoninip,0) ,
        valvenp  = 0.0    ,    
       valact  = Round(@total*@valmonvenp,0)   ,
        valant  = round(@valanti*@valmonvenp,0) ,
    diferencia  = round((@valanti-@total)*@valmonvenp,0) ,
  total  = @valmonvenp   
   select
    nomcli    , 
    valact    , 
    taspact    , 
    valant    , 
    diferencia   , 
    total    , 
    serie    , 
    emisor    , 
    um    , 
    nominal    , 
    tir    , 
    precio    , 
    valorpre   , 
    'fechaini'=convert(char(10),fecinip,103) , 
    uminip    , 
    valinip    , 
    tasap    , 
    plazop    , 
    basep    , 
    monedap    , 
    fecvenp    , 
    umvenp    , 
    valvenp    , 
    rutcli    , 
    dvcart    , 
    dvcli    , 
    glocart    , 
    ventas    , 
    rut_emisor   , 
    fp_vcto    , 
    codcli    ,
    duration   ,
    codmoneda    ,
    'monto_pfe' = @ftot_pfe  ,
    'monto_cce' = @ftot_cce,
    CodMonP
   from #TEMP
 end
/* ====================================================================================================
   p r o c e s o         p a r a        r e v e n t a s
   ==================================================================================================== */
 if @ctipoper='RV'
 begin
  select  
   'rutcli' = a.cirutcli   ,
   'nomcli' = isnull(b.clnombre,'') ,
   'totalinip' = a.civalinip  ,
   'valact' = a.civalinip ,
   'taspact' = a.citaspact ,
   'valant' = a.civalinip ,
   'diferencia' = (a.civalinip + ( a.civalinip * a.citaspact * isnull( datediff( day, a.cifecinip, @dfecpro),0) ) / ( a.cibaspact *100) )-(a.civalinip + ( a.civalinip * a.citaspact * isnull( datediff( day, a.cifecinip, @dfecpro),0) ) / ( a.cibaspact *100)) ,
   'total'  = a.civalinip ,
   'numdocu' = a.cinumdocu ,
   'correla' = a.cicorrela ,
   'serie'  = a.ciinstser ,
   'emisor' = c.emgeneric ,
   'um'  = d.mnnemo  ,
   'nominal' = a.cinominal ,
   'tir'  = a.citircomp ,
   'precio' = a.cipvpcomp ,
   'valorpre' = a.civptirci ,
   'fecinip' = a.cifecinip ,
   'uminip' = a.civalinip ,
   'valinip' = a.civalinip ,
   'tasap'  = a.citaspact ,
   'plazop' = isnull( datediff( day, a.cifecinip, a.cifecvenp),0) ,
   'basep'  = a.cibaspact ,
   'monedap' = space(5)  ,
   'fecvenp' = convert(char(10),a.cifecvenp,103),
   'umvenp' = a.civalinip  ,
   'valvenp' = a.civalinip  ,
   'dvcart' = e.rcdv  ,
   'dvcli'  = b.cldv  ,
   'glocart' = (SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BTR' AND rccodpro=@ctipoper And rcrut =  a.citipcart),
--   'glocart' = f.tbglosa  ,
   'ventas' = 0   ,
   'rut_emisor' = a.cirutemi  ,
   'fp_vcto' = a.ciFORPAGv ,
   'codcli' = a.cicodcli  ,
   'duration' = a.cidurmod  ,
   'codmoneda' = a.cimonemi,
   'CodMonP'	= a.cimonpact
  into #TEMP1
  from 
--  REQ. 7619    
   MDCI a LEFT OUTER JOIN VIEW_EMISOR c ON a.cirutemi = c.emrut 
          LEFT OUTER JOIN VIEW_MONEDA d ON a.cimonemi = d.mncodmon ,   
   VIEW_CLIENTE b,
--  REQ. 7619  
--   VIEW_EMISOR c,
--   VIEW_MONEDA d,
   VIEW_ENTIDAD   e --,
  -- VIEW_TABLA_GENERAL_DETALLE f
  where 
   a.cirutcart     = @nrutcart 
  and  a.cinumdocu = @nnumoper 
  and  a.cirutcli  = b.clrut 
  and  a.cicodcli  = b.clcodigo 
--  REQ. 7619  
  -- and  a.cirutemi *= c.emrut 
  -- and  a.cimonemi *= d.mncodmon 
  and  a.cirutcart = e.rcrut 
--  and  f.tbcateg   = 204 
--  and  convert(numeric(6),f.tbcodigo1) = a.citipcart 
  and  a.ciinstser <>'ICAP' 
  and  a.ciinstser <>'ICOL'

  select  
   @monpacto = a.mnnemo  ,
   @codmonp = b.cimonpact   
  from    
   VIEW_MONEDA  a,
   MDCI   b
  where   
   b.cirutcart=@nrutcart 
  and  b.cinumdocu=@nnumoper 
  and  b.cimonpact=a.mncodmon
  select @ftipcam = isnull(vmvalor,1) from VIEW_VALOR_MONEDA where vmcodigo = @codmonp and vmfecha = @dfecpro
  
  
  select @total  = sum(isnull(MDCI.civptirci,0)) ,
   @totalinip = sum(isnull(MDCI.civalinip,0))  ,
   @valvenp = sum(isnull(MDCI.civalvenp,0))
  from MDCI
  where MDCI.cirutcart=@nrutcart and MDCI.cinumdocu=@nnumoper
 
  set rowcount 1
  select 
   @tasap  = citaspact ,
   @basep  = cibaspact  ,
   @plazop = isnull(datediff(day,a.cifecinip,@dfecpro),0),    
   @valmoninip = isnull(b.vmvalor,0)
  from 
   MDCI   a,
   VIEW_VALOR_MONEDA b
  where 
   a.cirutcart=@nrutcart 
  and  a.cinumdocu=@nnumoper
  and  b.vmcodigo  = @codmonp
  and b.vmfecha   =a.cifecinip
  set rowcount 0
  select @valanti    = @total 
  select @diferencia = 0
  select @valmonvenp = isnull(vmvalor,0)
  from VIEW_VALOR_MONEDA
  where vmcodigo=@codmonp and vmfecha=@dfecpro
                set rowcount 1
  select @ventas = vinumoper
  from MDVI
  where MDVI.virutcart=@nrutcart and MDVI.vinumdocu=@nnumoper
  
  set rowcount 0
  Select @nRedondeo = mndecimal from View_Moneda where mncodmon = @codmonp

  If @codmonp = 13 Begin
	Select @valmonvenp = Vmvalor FROM View_Valor_Moneda Where vmcodigo = 994 And Vmfecha = @dfecpro
	Set Rowcount 1
  	select @valmoninip = isnull(b.vmvalor,0)
  	from 
   		MDCI   a,
   		VIEW_VALOR_MONEDA b
  	where 
   		a.cirutcart=@nrutcart 
  		and  a.cinumdocu=@nnumoper
  		and  b.vmcodigo  = 994
  		and b.vmfecha   =a.cifecinip
  	set rowcount 0
  End

  if @codmonp=999
  begin
   select @valmonvenp = 1   ,
    @valmoninip = 1   ,
    @uminip  = @totalinip  ,
    @valvenp = round(@valvenp,0)
  end else  
                begin
--VGS   select @uminip  = round(@totalinip/@valmoninip,4)
	select @uminip  = round(@totalinip,@nRedondeo)
  end
/*
   update #TEMP
    total = @valmonvenp   
*/
/* inicio calculo pfe cce */
  select @itotreg    =  count(*) from MDCI where MDCI.cirutcart=@nrutcart and MDCI.cinumdocu=@nnumoper
  select @icontador  = 1
  select @ftot_pfe = 0
  select @ftot_cce = 0
  while @icontador<= @itotreg 
  begin 
   set rowcount @icontador 
   select  
    @ftir     = citircomp ,
    @cseriado = ciseriado ,
    @fvpresen = civptirc  ,
    @dfecven  = cifecvenp ,
    @cmascara = cimascara ,
    @icorrela = cicorrela ,
    @fdurmo   = cidurmod
   from   MDCI
   where 
    MDCI.cirutcart=@nrutcart 
   and  MDCI.cinumdocu=@nnumoper
   set rowcount 0
   if @cseriado='S'
    select @nmonemi= semonemi 
    from VIEW_SERIE
    where semascara=@cmascara
   else
    select @nmonemi= nsmonemi 
    from VIEW_NOSERIE
    where nsrutcart=@nrutcart and nsnumdocu=@nnumoper and nscorrela=@icorrela
   select @fvalormcdo  = 0
--   select @fvalormcdo  = mmvalor
--   from MDMM
--   where mmnumoper = @nnumoper
--   and   mmcorrela = @icorrela 
   
   if @fvalormcdo is null or @fvalormcdo = 0  select @fvalormcdo = @fvpresen 
---   execute Sp_Calculo_Pfe_Cce 'BTR'   ,
--     @nmonemi  , 
--     @fdurmo   , 
--     @ftir   ,
--     @fvalormcdo  ,
--     @fvpresen   ,
--     @dfecpro  ,
--     @dfecven  ,
--     'C'   ,
--     @peak_pfe output ,
--     @peak_cce output
  
   select  @ftot_pfe = @ftot_pfe + @peak_pfe  ,
    @ftot_cce = @ftot_cce + @peak_cce 
   select @icontador = @icontador + 1
  end
/* fin calculo pfe cce */
  update #TEMP1
  set total  = @valmonvenp    ,
   monedap  = @monpacto    ,
   uminip  = @uminip    ,
   umvenp  = @valvenp    ,
   valinip  = round(@valmoninip * @uminip,0) ,
   valvenp  = 0.0     ,
   valact  = Round(@total* @valmonvenp,0),
   valant  = Round(@valanti* @valmonvenp,0)    ,
   diferencia  = round((@valanti-@total)* @uminip,0) ,
   ventas  = @ventas
   
  select  nomcli  ,
   valact  ,
   taspact  ,
   valant  ,
   diferencia ,
   total  ,
   serie  ,
   emisor  ,
   um  ,   
   nominal  ,
   tir  ,
   precio  ,
   valorpre ,
   'fechainip'=convert(char(10),fecinip,103),
   uminip  ,
   valinip  ,
   tasap  ,
   plazop  ,
   basep  ,
   monedap  ,
   fecvenp  ,
   umvenp  ,
   valvenp  ,
   rutcli  ,
   dvcart  ,
   dvcli  ,
   glocart  ,
   ventas  ,
   rut_emisor ,
   fp_vcto  ,
   codcli  ,
   duration  ,
   codmoneda ,

   'monto_pfe' = isnull(@ftot_pfe,0)  ,
   'monto_cce' = isnull(@ftot_cce,0)  ,  
   CodMonP,
   0      ,   --> Falta
   0      ,   --> Falta
   0          --> Falta
  from #TEMP1
        end

end

GO
