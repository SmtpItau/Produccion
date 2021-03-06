USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ESTADO_CUENTA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_estado_cuenta    fecha de la secuencia de comandos: 05/04/2001 13:13:24 ******/
CREATE PROCEDURE [dbo].[SP_ESTADO_CUENTA] 
         ( @rut_cliente numeric(9) ,
           @codigo_rut  numeric(5)  )
as
begin
select acfecproc,
       acfecprox,
       'uf_hoy'    = convert(float, 0),
       'uf_man'    = convert(float, 0),
       'ivp_hoy'   = convert(float, 0),
       'ivp_man'   = convert(float, 0),
       'do_hoy'    = convert(float, 0),
       'do_man'    = convert(float, 0),
       'da_hoy'    = convert(float, 0),
       'da_man'    = convert(float, 0),
       acnomprop,
       'rut_empresa' = rtrim(convert(char(10),acrutprop)) + '-' + acdigprop
  into #PARAMETROS
  from MDAC
/* rescata valor de uf -------------------------------------------------------------- */
update #PARAMETROS set uf_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 998
update #PARAMETROS set uf_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 998
/* rescata valor de ivp ------------------------------------------------------------- */
update #PARAMETROS set ivp_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 997
update #PARAMETROS set ivp_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 997
/* rescata valor de do -------------------------------------------------------------- */
update #PARAMETROS set do_hoy = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 994
update #PARAMETROS set do_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 994
/* rescata valor de da -------------------------------------------------------------- */
update #PARAMETROS set da_hoy = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 995
update #PARAMETROS set da_man = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 995     
/*------------------------------------
     creacion de tabla temporal
--------------------------------------*/        
  create table #MOVIMIENTO ( rut_cliente        numeric  (10) default 0  ,
                                           codigo_cliente     char     ( 1) default ' ',
                                    nombre_cliente     char     (50) default ' ',   
                                    sistema            char     (10) default ' ', 
                                           numero_operacion   numeric  ( 5) default 0  ,
                                           tipo_operacion     char     (10) default ' ',
                                           instrumento        char     (10) default ' ',
                                           emisor             char     (15) default ' ',
                                           nominal            float                    ,
                                           moneda             char     ( 5) default ' ',
                                           tir_precio         float                    ,
                                           monto_operacion    float                    ,
                                           fecha_vcto         datetime      default ' ',
                                           moneda_pacto       char     ( 5) default ' ',
                                           tasa_pacto         float                    ,
                             valor_final        float       ,
               vcto_pacto         datetime      default ' ',  
                                    forma_pago         char     (15) default ' ',
                                           fecha_operacion    datetime      default ' ' )
         
/*------------------------------------
  selecci¢n de operacines irf del d¡a
-------------------------------------*/
 insert into #MOVIMIENTO ( rut_cliente      ,
                                  codigo_cliente   ,
                           nombre_cliente   , 
                           sistema          , 
                                  numero_operacion ,
                                  tipo_operacion   ,
                                  instrumento      ,
                                  emisor           ,
                                  nominal          ,
                                  moneda           ,
                                  tir_precio       ,
                                  monto_operacion  ,
                                  fecha_vcto       ,
                                  moneda_pacto     ,
                                  tasa_pacto       ,
                    valor_final      ,
                           vcto_pacto       ,  
                           forma_pago       ,
                                  fecha_operacion )
        
 
          select  a.morutcli  ,
                        c.cldv  ,
                 c.clnombre  , 
                 'IRF'      , 
                        a.monumoper ,
                        a.motipoper ,
                        a.moinstser ,
                        d.emgeneric ,
                        a.monominal ,
                               isnull((select mnnemo from VIEW_MONEDA where mncodmon = momonemi ),' '),
                        a.motir     ,
                        case motipoper when 'CI' then movalinip 
                                              when 'VI' then movalinip
                                when 'RV' then movalinip
                                       when 'RC' then movalinip
                             when 'CP' then movalcomp
                         when 'VP' then movalven  end,
                        a.mofecven ,
                        isnull((select mnnemo from VIEW_MONEDA where mncodmon = momonpact),' '),
                               motaspact,
                 case motipoper when 'CI' then movalvenp 
                                              when 'VI' then movalvenp
                                when 'RV' then movalvenp
                                       when 'RC' then movalvenp
                             when 'CP' then 0
                         when 'VP' then 0    end,
           a.mofecvenp,  
                  b.glosa    ,
                                a.mofecpro
        
        from  MDMO a,VIEW_FORMA_DE_PAGO b,VIEW_CLIENTE  c, VIEW_EMISOR d,VIEW_MONEDA e
        where  morutcli     =  @rut_cliente 
          and  @rut_cliente =  c.clrut
   and  @codigo_rut  =  c.clcodigo  
          and  moforpagi    =  b.codigo 
          and  morutemi     =  d.emrut 
          and  e.mncodmon   =  a.momonemi   
          and  mostatreg    <> 'A'                   
 
    
/*--------------------------------------
  selecci¢n de operacines irf anteriores
----------------------------------------*/
 insert  into #MOVIMIENTO (rut_cliente     ,
                    codigo_cliente  ,
                           nombre_cliente  , 
             sistema         , 
                    numero_operacion,
                    tipo_operacion  ,
                    instrumento     ,
                    emisor          ,
                    nominal         ,
                    moneda          ,
                    tir_precio      ,
                    monto_operacion ,
                    fecha_vcto      ,
                    moneda_pacto    ,
                    tasa_pacto      ,
      valor_final     ,
                     vcto_pacto      ,  
             forma_pago      ,
      fecha_operacion  )
         
    select  a.morutcli  ,
                    c.cldv  ,
             c.clnombre  , 
             'IRF'      , 
                    a.monumoper ,
                    a.motipoper ,
                    a.moinstser ,
                    d.emgeneric ,
                    a.monominal ,
                    isnull((select mnnemo from VIEW_MONEDA where mncodmon = momonemi ),' '),
                    a.motir     ,
                    case motipoper when 'CI' then movalinip 
                                          when 'VI' then movalinip
                            when 'RV' then movalinip
                                   when 'RC' then movalinip
                         when 'CP' then movalcomp
                     when 'VP' then movalven  end,
                    a.mofecven ,
                    isnull((select mnnemo from VIEW_MONEDA where mncodmon = momonpact),' ') ,
                    motaspact,
      case motipoper when 'CI' then movalvenp 
                                          when 'VI' then movalvenp
                            when 'RV' then movalvenp
                                   when 'RC' then movalvenp
                         when 'CP' then 0
                     when 'VP' then 0    end,
             a.mofecvenp,  
             b.glosa    ,
      a.mofecpro  
 from  MDMH a,VIEW_FORMA_DE_PAGO b,VIEW_CLIENTE  c, VIEW_EMISOR d,VIEW_MONEDA e
        where  morutcli     = @rut_cliente
          and  @rut_cliente = c.clrut
          and  @codigo_rut  = c.clcodigo 
          and  moforpagi    = b.codigo 
          and  morutemi     = d.emrut 
          and  e.mncodmon   = a.momonemi                      
   and  mostatreg    <> 'A'  
/*---------------------------------------
  selecci¢n de operacines forward del d¡a
-----------------------------------------*/
 insert  into #MOVIMIENTO (rut_cliente     ,
                    codigo_cliente  ,
                           nombre_cliente  , 
             sistema         , 
                    numero_operacion,
                    tipo_operacion  ,
                    instrumento     ,
                    emisor          ,
                    nominal         ,
                    moneda          ,
                    tir_precio      ,
                    monto_operacion ,
                    fecha_vcto      ,
                    moneda_pacto    ,
                    tasa_pacto      ,
      valor_final     ,
             vcto_pacto      ,  
             forma_pago      ,
      fecha_operacion  )
         
    select  a.mocodigo  ,
                          c.cldv  ,
            c.clnombre  , 
            'FORWARD'   , 
                   a.monumoper ,
                   case a.motipoper when 'C' then 'compra'
          else 'venta' end,
                   isnull((select mnnemo from VIEW_MONEDA where mncodmon = mocodmon1 ),' '),  --??
                   ' '         ,
                   0           ,  --??
                   isnull((select mnnemo from VIEW_MONEDA where mncodmon = mocodmon2 ),' '),
                   a.motipcam  ,
                   0           ,
                   a.mofecvcto ,
                   ' '         ,
                   0           ,
     a.moequusd2 ,
            ' '         ,  
            b.glosa     ,
     a.mofecha 
 from  VIEW_MFMO a,VIEW_FORMA_DE_PAGO b,VIEW_CLIENTE  c, VIEW_MONEDA e
        where  mocodigo      = @rut_cliente
   and  mocodcli      = @codigo_rut 
          and  @rut_cliente  = c.clrut
          and  @codigo_rut   = c.clcodigo
          and  mofpagomn     = b.codigo 
   and  mncodmon      = mocodmon1 
   
          
/*------------------------------------------
  selecci¢n de operacines forward anteriores
--------------------------------------------*/
 insert  into #MOVIMIENTO (rut_cliente     ,
                    codigo_cliente  ,
                           nombre_cliente  , 
             sistema         , 
               numero_operacion,
                    tipo_operacion  ,
                    instrumento     ,
                    emisor          ,
                    nominal         ,
                    moneda          ,
                    tir_precio      ,
                    monto_operacion ,
                    fecha_vcto      ,
                    moneda_pacto    ,
                    tasa_pacto      ,
      valor_final     ,
             vcto_pacto      ,  
             forma_pago      ,
      fecha_operacion  )
         
    select  a.mocodigo  ,
                          c.cldv  ,
            c.clnombre  , 
            'FORWARD'   , 
                   a.monumoper ,
                   case a.motipoper when 'C' then 'compra'
          else 'venta' end ,
                   isnull((select mnnemo from VIEW_MONEDA where mncodmon = mocodmon1 ),' '),  --??
                   ' '         ,
                   0           ,  --??
                   isnull((select mnnemo from VIEW_MONEDA where mncodmon = mocodmon2 ),' '),
                   a.motipcam  ,
                   0           ,
                   a.mofecvcto ,
                   ' '         ,
                   0           ,
     moequusd2   ,
            ' '         ,  
            b.glosa     ,
     a.mofecha 
 from  VIEW_MFMOH a,VIEW_FORMA_DE_PAGO b,VIEW_CLIENTE  c,VIEW_MONEDA e
        where  mocodigo      = @rut_cliente
   and  mocodcli      = @codigo_rut 
          and  @rut_cliente  = c.clrut
          and  @codigo_rut   = c.clcodigo
          and  mofpagomn     = b.codigo 
   and  mncodmon      = mocodmon1 
   
/*---------------------------------------
  selecci¢n de operacines captacion
-----------------------------------------*/
 insert  into #MOVIMIENTO (rut_cliente     ,
                    codigo_cliente  ,
                           nombre_cliente  , 
             sistema         , 
                    numero_operacion,
                    tipo_operacion  ,
                    instrumento     ,
                    emisor          ,
                    nominal         ,
                    moneda          ,
                    tir_precio      ,
                    monto_operacion ,
                    fecha_vcto      ,
                    moneda_pacto    ,
                    tasa_pacto      ,
      valor_final     ,
             vcto_pacto      ,  
             forma_pago      ,
      fecha_operacion )
         
    select  a.rut_cliente        ,
                          c.cldv           ,
            c.clnombre           , 
            'CAPTACIONES'        , 
                   a.numero_operacion   ,
                   tipo_operacion       ,
                   ' '                  ,  --??
                   ' '                  ,
                   0                    ,  --??
                   isnull((select mnnemo from VIEW_MONEDA where mncodmon = moneda ),' '),
                   a.tasa               ,
                   a.monto_inicio_pesos ,
                   a.fecha_vencimiento  ,
                   ' '                  ,
                   0                    ,
     a.monto_final        ,
            ' '                  ,  
            b.glosa              ,
     a.fecha_operacion 
 from  GEN_CAPTACION a,VIEW_FORMA_DE_PAGO b,VIEW_CLIENTE  c, VIEW_MONEDA e
        where  rut_cliente   = @rut_cliente
   and  codigo_rut    = @codigo_rut 
          and  @rut_cliente  = c.clrut
          and  @codigo_rut   = c.clcodigo
          and  b.codigo      = convert(numeric,forma_pago,4)
   and  moneda        = mncodmon 
/*-------------------------------------
  selecci¢n de operacines spot del d¡a
 puntas / empresas
--------------------------------------*/
 insert  into #MOVIMIENTO (rut_cliente     ,
                    codigo_cliente  ,
                           nombre_cliente  , 
             sistema         , 
                    numero_operacion,
                    tipo_operacion  ,
      instrumento     ,
                  emisor          ,
                    nominal         ,
                    moneda          ,
                    tir_precio      ,
                    monto_operacion ,
                    fecha_vcto      ,
                    moneda_pacto    ,
                    tasa_pacto      ,
      valor_final     ,
             vcto_pacto      ,  
             forma_pago      ,
      fecha_operacion     )
         
    select  a.morutcli  ,
                          c.cldv  ,
            c.clnombre  , 
            'SPOT'      , 
                   a.monumope  ,
                   case a.motipope  when 'C' then 'compra'
          else 'venta' end ,
                   mocodmon    ,  --??
                   ' '         ,
                   momonmo     ,  --??
                   a.mocodmon  ,
                   a.moticam   ,
                   momonpe     ,
                   ' '         ,
                   ' '         ,
                   0           ,
     0           ,
            ' '         ,  
            b.glosa     ,
     a.mofech 
 from  VIEW_MEMO a,VIEW_FORMA_DE_PAGO b,VIEW_CLIENTE  c
        where  morutcli      = @rut_cliente
   and  mocodcli      = @codigo_rut 
          and  @rut_cliente  = c.clrut
          and  @codigo_rut   = c.clcodigo
          and  codigo        = case a.motipope  when 'C' then moentre
      else morecib end 
   
     
/*------------------------------------------
  selecci¢n de operacines spot anteriores
 puntas / empresas
--------------------------------------------*/
 insert  into #MOVIMIENTO (rut_cliente     ,
                    codigo_cliente  ,
                           nombre_cliente  , 
             sistema         , 
                    numero_operacion,
                    tipo_operacion  ,
                    instrumento     ,
                    emisor          ,
                    nominal         ,
                    moneda          ,
                    tir_precio      ,
                    monto_operacion ,
                    fecha_vcto      ,
                    moneda_pacto    ,
                    tasa_pacto      ,
      valor_final     ,
             vcto_pacto      ,  
      forma_pago      ,
      fecha_operacion  )
         
    select  a.morutcli  ,
                          c.cldv  ,
            c.clnombre  , 
            'SPOT'      , 
                   a.monumope  ,
                   case a.motipope  when 'C' then 'compra'
          else 'venta' end ,
                   mocodmon    ,  --??
                   ' '         ,
                   momonmo     ,  --??
                   a.mocodmon  ,
                   a.moticam   ,
                   momonpe     ,
                   ' '         ,
                   ' '         ,
                   0           ,
     0           ,
            ' '         ,  
            b.glosa     ,
     a.mofech 
 from  VIEW_MEMOH a,VIEW_FORMA_DE_PAGO b,VIEW_CLIENTE  c
        where  morutcli      = @rut_cliente
   and  mocodcli      = @codigo_rut 
          and  @rut_cliente  = c.clrut
          and  @codigo_rut   = c.clcodigo
          and  codigo        = case a.motipope  when 'C' then moentre
      else morecib end 
   
/*------------------------------------------
  selecci¢n de operacines spot del d¡a
 arbitrajes de mesa
--------------------------------------------*/
 insert  into #MOVIMIENTO (rut_cliente     ,
                    codigo_cliente  ,
                           nombre_cliente  , 
             sistema         , 
                    numero_operacion,
                    tipo_operacion  ,
                    instrumento     ,
                    emisor          ,
                    nominal         ,
                    moneda          ,
                    tir_precio      ,
                    monto_operacion ,
                    fecha_vcto      ,
                    moneda_pacto   ,
                    tasa_pacto      ,
      valor_final     ,
             vcto_pacto      ,  
             forma_pago      ,
          fecha_operacion   )
         
    select  a.arbrutcli ,
                          c.cldv  ,
            c.clnombre  , 
            'SPOT'      , 
                   a.arbnumope ,
                   case a.arbtipope  when 'C' then 'compra'
          else 'venta' end ,
                   a.arbcodmon ,  --??
                   ' '         ,
                   a.arbmtomex ,  --??
                   a.arbcodmon ,
                   a.arbticamt ,
                   a.arbprecfi ,
                   ' '         ,
                   ' '         ,
                   0           ,
     0           ,
            ' '         ,  
            b.glosa     ,
     a.arbfecha 
 from  VIEW_MEARBM a,VIEW_FORMA_DE_PAGO b,VIEW_CLIENTE  c
        where  a.arbrutcli     = @rut_cliente
   and  a.arbcodcli     = @codigo_rut 
          and  @rut_cliente    = c.clrut
          and  @codigo_rut     = c.clcodigo
          and  codigo          = arbcodfp
/*------------------------------------------
  selecci¢n de operacines spot anteriores
 arbitrajes de mesa
--------------------------------------------*/
 insert  into #MOVIMIENTO (rut_cliente     ,
                    codigo_cliente  ,
                           nombre_cliente  , 
             sistema         , 
                    numero_operacion,
                    tipo_operacion  ,
                    instrumento     ,
                    emisor          ,
                    nominal         ,
                    moneda          ,
                    tir_precio      ,
                    monto_operacion ,
                    fecha_vcto      ,
                    moneda_pacto    ,
                    tasa_pacto      ,
      valor_final     ,
             vcto_pacto      ,  
             forma_pago      ,
      fecha_operacion )
         
    select  a.arbrutcli ,
                          c.cldv  ,
            c.clnombre  , 
            'SPOT'      , 
                   a.arbnumope ,
                   case a.arbtipope  when 'C' then 'compra'
          else 'venta' end ,
                   a.arbcodmon ,  --??
                   ' '         ,
                   a.arbmtomex ,  --??
                   a.arbcodmon ,
                   a.arbticamt ,
                   a.arbprecfi ,
                   ' '         ,
                   ' '         ,
                   0           ,
     0           ,
            ' '         ,  
            b.glosa     ,
     a.arbfecha  
 from  VIEW_MEARBMH a,VIEW_FORMA_DE_PAGO b,VIEW_CLIENTE  c
        where  a.arbrutcli     = @rut_cliente
   and  a.arbcodcli     = @codigo_rut 
          and  @rut_cliente    = c.clrut
          and  @codigo_rut     = c.clcodigo
          and  codigo          = arbcodfp
/*------------------------------------------
  selecci¢n de operacines spot del d¡a
 arbitrajes internacionales
--------------------------------------------*/
 insert  into #MOVIMIENTO (rut_cliente     ,
                    codigo_cliente  ,
                           nombre_cliente  , 
             sistema         , 
                    numero_operacion,
                    tipo_operacion  ,
                    instrumento     ,
                    emisor          ,
                    nominal         ,
                    moneda          ,
                    tir_precio      ,
                    monto_operacion ,
                    fecha_vcto      ,
                    moneda_pacto    ,
                    tasa_pacto      ,
      valor_final     ,
             vcto_pacto      ,  
             forma_pago      ,
      fecha_operacion )
                  select  a.arbrutcli ,
                          c.cldv  ,
            c.clnombre  , 
            'SPOT'      , 
                   a.arbnumope ,
                   case a.arbtipope  when 'C' then 'compra'
        else 'venta' end ,
                 a.arbcodmon ,  --??
                   ' '         ,
                   a.arbmtomex ,  --??
                   a.arbcodmon ,
                   a.arbticamx ,
                   a.arbmtomch ,
                   ' '         ,
                   ' '         ,
                   0           ,
     0           ,
            ' '         ,  
            b.glosa     ,
     a.arbfecha 
 from  VIEW_MEARB a,VIEW_FORMA_DE_PAGO b,VIEW_CLIENTE  c
        where  a.arbrutcli     = @rut_cliente
   and  a.arbcodcli     = @codigo_rut 
          and  @rut_cliente    = c.clrut
          and  @codigo_rut     = c.clcodigo
          and  codigo          = case a.arbtipope  when 'C' then arbentreg
        else arbrecibi end 
/*------------------------------------------
  selecci¢n de operacines spot anteriores
 arbitrajes internacionales
--------------------------------------------*/
 insert  into #MOVIMIENTO (rut_cliente     ,
                    codigo_cliente  ,
                           nombre_cliente  , 
             sistema         , 
                    numero_operacion,
                    tipo_operacion  ,
                    instrumento     ,
                    emisor          ,
                    nominal         ,
                    moneda          ,
                    tir_precio      ,
                    monto_operacion ,
                    fecha_vcto      ,
                    moneda_pacto    ,
                    tasa_pacto      ,
      valor_final     ,
             vcto_pacto      ,  
             forma_pago      ,
      fecha_operacion )
         select              
                          a.arbrutcli ,
                          c.cldv  ,
            c.clnombre  , 
            'SPOT'      , 
                   a.arbnumope ,
                   case a.arbtipope  when 'C' then 'compra'
          else 'venta' end ,
                   a.arbcodmon ,  --??
                   ' '         ,
                   a.arbmtomex ,  --??
                   a.arbcodmon ,
                   a.arbticamx ,
                   a.arbmtomch ,
                   ' '         ,
                   ' '         ,
                   0           ,
     0           ,
            ' '         ,  
            b.glosa     ,
     a.arbfecha 
 from  VIEW_MEARBH a,VIEW_FORMA_DE_PAGO b,VIEW_CLIENTE  c
        where  a.arbrutcli     = @rut_cliente
   and  a.arbcodcli     = @codigo_rut 
          and  @rut_cliente    = c.clrut
          and  @codigo_rut     = c.clcodigo
          and  codigo          = case a.arbtipope  when 'C' then arbentreg
        else arbrecibi end 
               
select 'acfecproc' = convert(char(10), acfecproc, 103),
       'acfecprox' = convert(char(10), acfecprox, 103),
       uf_hoy,
       uf_man,
       ivp_hoy,
       ivp_man,
       do_hoy,
       do_man,
       da_hoy,
       da_man,
       acnomprop,
       rut_empresa,
       'hora' = convert(varchar(10), getdate(), 108),
       #movimiento.* 
from #MOVIMIENTO, #PARAMETROS
end
--select * from MDMH where morutcli = 97051000
--select * from view_memoh
--select * from VIEW_CLIENTE
--select * from view_mfmo
--select * from VIEW_MONEDA
--select * from MDMO
--select mnnemo from VIEW_MONEDA where 998 = mncodmon
--select * from view_memoh
--select * from sysobjects where  name like '%captacion%' and type = 'u'
--select * from gen_captacion
--sp_help gen_captacion
--select * from view_mearbh
--sp_help mearbm


GO
