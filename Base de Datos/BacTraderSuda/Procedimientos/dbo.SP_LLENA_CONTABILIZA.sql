USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_CONTABILIZA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LLENA_CONTABILIZA] 
            ( @fecha_hoy datetime )
as
begin
declare @control_error    integer
declare @valor_observado  float   
declare @rut_central      numeric(10)
declare @habil            char(1)
declare @fecha_paso       datetime
declare @vvista           char(4)
select @valor_observado = 1.0
select @valor_observado = isnull(vmvalor,0.0) from VIEW_VALOR_MONEDA  where vmcodigo = 994 and vmfecha = @fecha_hoy
select @rut_central = 0
select @rut_central = isnull(folio,0) from GEN_FOLIOS where codigo = 'RUTBCCH'
/* ======================================================================================== */
/* limpia archivo de contabilizacion                                                        */
/* ======================================================================================== */
delete BAC_CNT_CONTABILIZA
if @@error <> 0
begin
   print 'ERROR_PROC FALLA BORRANDO ARCHIVO CONTABILIZA (RENTA FIJA).'
   return 1
end
/* ======================================================================================== */
/* busca si el sistema esta en una fecha no habil (fin de mes feriado)                      */
/* ======================================================================================== */
select @fecha_paso = @fecha_hoy
execute Sp_Diahabil @fecha_paso OUTPUT
if datediff(day, @fecha_hoy, @fecha_paso) <> 0
   select @habil = 'N'
else
   select @habil = 'S'
/* ======================================================================================= */
/* clasifica las operaciones de pactos y tipos de bono para trader                         */
/* ======================================================================================= */
--print '0'
execute @control_error = Sp_Actualiza_Mdmo
--print '0-0'
if @control_error <> 0
   return 1
/* ======================================================================================== */
/* llena renta fija operaciones                                                             */
/* ======================================================================================== */
--print '1'
insert into 
BAC_CNT_CONTABILIZA ( 
 id_sistema  ,
 tipo_movimiento  ,
 tipo_operacion  ,
 operacion  ,
 correlativo  ,
 codigo_instrumento ,
 moneda_instrumento ,
 valor_compra  ,
 valor_presente     ,
 valor_venta        ,
 utilidad            ,
 perdida            ,
 interes_papel      ,
 reajuste_papel     ,
 interes_pacto      ,
 reajuste_pacto     ,
 valor_cupon        ,
 valor_comprahis  ,
 dif_ant_pacto_pos ,
 dif_ant_pacto_neg ,
 dif_valor_mercado_pos ,
 dif_valor_mercado_neg ,
 condicion_pacto  ,
 tipo_cliente  ,
 forma_pago  ,
 tipo_emisor  ,
 nominalpesos  ,
 forma_pago_entregamos   ,
        tipo_instrumento        ,
        condicion_entrega       ,
        tipo_operacion_or       )
select  'BTR'   , 
 'MOV'   ,
 (case
         when a.moinstser = 'ICAP' and morutcli <> @rut_central then 'ICA'
         when a.moinstser = 'ICOL' then 'ICO'
         when a.moinstser = 'ICAP' and morutcli = @rut_central then 'CAB'
         when a.motipoper = 'IC' and monumdocu <> monumdocuo then 'RIC'
         else a.motipoper
        end)                    ,
 a.monumoper  ,
        (case 
         when substring(a.motipoper,1,1) = 'V'  then a.mocorvent
         when substring(a.motipoper,1,2) = 'RC' then a.mocorvent
         else                                        a.mocorrela
        end)                    ,
 (case a.motipoper
         when 'CI'  then ''
         when 'IB'  then ''
         when 'RV'  then ''
         when 'IC'  then ''
  when 'VIC' then ''
  when 'AIC' then ''
         else            b.inserie
        end)                    ,
 (case a.motipoper
         when 'CP'  then convert(char(06),a.momonemi)
         when 'VP'  then convert(char(06),a.momonemi)
         when 'VIC' then convert(char(06),a.momonemi)
 when 'IC'  then convert(char(06),a.momonemi)
         else            convert(char(06),a.momonpact)
        end)                    ,
 a.movalcomp  ,
 (case 
         when a.motipoper = 'RV' then a.movalvenp
         when a.motipoper = 'VI' then (a.movalcomp + a.mointeres + a.moreajuste)
         else a.movpresen
        end)   ,
        (case 
         when a.motipoper = 'RC'  then a.movalinip
         else a.movalven 
        end)   , 
        a.moutilidad  ,
 a.moperdida  ,
 0.0   ,
 0.0   ,
        a.mointpac  ,      -- interes pacto  
 a.moreapac  ,      -- reajuste pacto
 0.0   ,
 (case 
  when a.motipoper = 'RC'  then a.movalvenp
         else a.movalcomp
        end)   ,      -- val.compra historico
 a.moutilidad  ,      -- dif pacto pos
 a.moperdida  ,      -- dif pacto neg  vbarra 31/05/2000
 a.moutilidad  ,      -- valor mercado pos 
 a.moperdida  ,      -- valor mercado neg
 a.mocondpacto  ,      -- condicion pacto
 convert(char(01),c.cltipcli) , -- tipo de cliente
 convert(char(06),a.moforpagi), -- forma de pago
 isnull(e.emgeneric,'')       , -- generico de emisor
 a.monominal                  ,
 convert(char(03),momonemi)   , 
        isnull((case when motipoper <> 'IC' then a.motipobono else ( select tipo_deposito from  GEN_CAPTACION where numero_operacion = monumoper and correla_operacion = mocorrela ) end),'')                   , -- tipo bono
        a.modcv        ,
 (case when substring(a.motipopero,1,2) = 'CI' then '1' else '2' end)
from  -- REQ.7619
 MDMO a RIGHT OUTER JOIN  VIEW_EMISOR e ON e.emrut = a.morutemi
        RIGHT OUTER JOIN  VIEW_INSTRUMENTO b ON b.incodigo = a.mocodigo ,
-- VIEW_INSTRUMENTO b,
 VIEW_CLIENTE c,
-- REQ.7619
-- VIEW_EMISOR e,
 MDAC m
where  a.mostatreg <> 'A' 
  and   a.motipoper <> 'AIC'  -- se excluyen en este query los anticipos de captacion
  and  a.motipoper <> 'RCA'  -- se procesan mas abajo la recompra 
  and  a.motipoper <> 'RVA'  -- se procesan mas abajo la reventas
  and  (c.clrut    = a.morutcli 
  and c.clcodigo = a.mocodcli)
-- REQ.7619
--  and e.emrut    =* a.morutemi
--  and b.incodigo =* a.mocodigo 
  and  a.mofecpro = @fecha_hoy 
if @@error <> 0
begin
   print 'ERROR_PROC FALLA AGREGANDO MOVIMIENTOS RENTA FIJA ARCHIVO CONTABILIZA.'
   return 1
end

/* ======================================================================================== */
/* llena renta fija operaciones solo anticipos de captacion                                                            */ 
/* ======================================================================================== */
--print '2'
insert into 
BAC_CNT_CONTABILIZA( 
 id_sistema  ,
 tipo_movimiento  ,
 tipo_operacion  ,
 operacion  ,
 correlativo  ,
 codigo_instrumento ,
 moneda_instrumento ,
 interes_pacto  ,
 reajuste_pacto  ,
 valor_compra  ,
 valor_comprahis  ,
 dif_ant_pacto_pos ,
 dif_ant_pacto_neg ,
 forma_pago  )  -- para cambio de perfiles 
select   
 'BTR'   , 
 'MOV'   ,
 'AIC'   ,
 monumoper  ,
 mocorrela  ,
 ''   ,
 convert(char(06),momonemi),
 mointpac  ,
 moreapac  ,
 movalant  ,
 movalcomp  ,
 moutilidad  ,
 moperdida  ,
 convert(char(06),moforpagi)
from MDMO 
where  motipoper ='AIC'
  and  mofecpro  = @fecha_hoy 
/* ======================================================================================== */
/* llena renta fija operaciones solo anticipos de pacto recompras anticipadas       */ 
/* ======================================================================================== */
--print '3'

insert into 
BAC_CNT_CONTABILIZA( 
 id_sistema  ,
 tipo_movimiento  ,
 tipo_operacion  ,
 operacion  ,
 correlativo  ,
 codigo_instrumento ,
 moneda_instrumento ,
 valor_venta  ,  -- valor venta
 valor_presente  ,  -- valor final
 interes_pacto  ,  -- interes del pacto
 reajuste_pacto  ,  -- reajuste pacto
 valor_comprahis  ,  -- valor final del pacto
 dif_ant_pacto_pos ,  -- utilidad anticipo
 dif_ant_pacto_neg ,  -- perdidad anticipo
 tipo_instrumento ,  -- tipo de bonos 
 condicion_pacto  ,  -- condicion original del pacto   
 interes_papel  ,  -- interes devengado del papel
 reajuste_papel  ,  -- reajuste devengado del papel
 tipo_operacion_or ,
 forma_pago  )  -- operacion de compra original
select   
 'BTR'   , 
 'MOV'   ,
 'RCA'   ,
 a.monumoper  ,
 a.mocorvent  ,
 b.inserie  ,
 convert(char(06),a.momonemi),
 a.movalinip  ,
 a.movpresen  ,
 a.mointpac  ,
 a.moreapac  ,
 a.movalant  ,
 a.moutilidad  ,
 a.moperdida  ,
 a.motipobono  ,
 a.mocondpacto  , 
 a.mointeres  ,
 a.moreajuste  ,
 a.motipopero  ,
 convert(char(6),a.moforpagv)
from MDMO a,
 VIEW_INSTRUMENTO b
where  a.motipoper = 'RCA'
  and b.incodigo  = a.mocodigo 
  and  a.mofecpro  = @fecha_hoy 
/* ======================================================================================== */
/* llena renta fija operaciones solo anticipos de pacto reventas anticipadas       */ 
/* ======================================================================================== */
--print '4'
insert into 
BAC_CNT_CONTABILIZA( 
 id_sistema  ,
 tipo_movimiento  ,
 tipo_operacion  ,
 operacion  ,
 correlativo  ,
 codigo_instrumento ,
 moneda_instrumento ,
 valor_compra  ,  -- valor compra
 valor_presente  ,  -- valor final
 interes_pacto  ,  -- interes del pacto
 reajuste_pacto  ,  -- reajuste pacto
 dif_ant_pacto_pos ,  -- utilidad anticipo
 dif_ant_pacto_neg ,  -- perdidad anticipo
 tipo_instrumento ,  -- tipo de bonos 
 condicion_pacto  ,  -- condicion original del pacto   
 forma_pago   ) 
select   
 'BTR'   , 
 'MOV'   ,
 'RVA'   ,
 monumoper  ,
 mocorrela  ,
 ''   ,
 convert(char(06),momonemi),
 movalinip  ,
 movalant  ,
 mointpac  ,
 moreapac  ,
 moutilidad  ,
 moperdida  ,
 motipobono  ,
 mocondpacto  ,
 convert(char(6),moforpagv)
from MDMO 
where  motipoper = 'RVA'
  and  mofecpro  = @fecha_hoy 
update BAC_CNT_CONTABILIZA set nominalpesos = round(nominalpesos * isnull(vmvalor,1),0)
from VIEW_VALOR_MONEDA  
where  vmcodigo = convert( float, rtrim(forma_pago_entregamos) )
and vmfecha  = @fecha_hoy 
and  rtrim(forma_pago_entregamos)<>'999'
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO MOVIMIENTOS RENTA FIJA ARCHIVO CONTABILIZA.'
   return 1
end
/* ======================================================================================== */
/* llena renta fija devengo                                                                 */
/* ======================================================================================== */
--print '5'
insert into 
BAC_CNT_CONTABILIZA( 
 id_sistema  ,
 tipo_movimiento  ,
 tipo_operacion  ,
 operacion  ,
 correlativo  ,
 codigo_instrumento ,
 moneda_instrumento ,
 valor_compra  ,
 valor_presente     ,
 valor_venta        ,
 utilidad            ,
 perdida            ,
 interes_papel      ,
 reajuste_papel     ,
 interes_pacto      ,
 reajuste_pacto     ,
 valor_cupon        ,
 nominalpesos  ,
 valor_comprahis  ,
 dif_ant_pacto_pos ,
 dif_ant_pacto_neg ,
 dif_valor_mercado_pos ,
 dif_valor_mercado_neg ,
 condicion_pacto  ,
 forma_pago  ,
 tipo_instrumento ,
 tipo_cliente  ,
 tipo_emisor  ,
 valor_futuro  )
select 
 'BTR'   , 
 'DEV'   ,      -- VB+- 21/03/2000 SE CAMBIA DEFINICI¢N DE TIPO DE OPERACION
 case     
  when rscartera = '111' and rstipoper ='DEV' then 'DVCP'
  when rscartera = '130' and rstipoper ='DEV' and rsrutcli <> @rut_central then 'DVCP'
  when rscartera = '111' and rstipoper ='VC'  then 'DVVC'
         when rscartera = '121' and rstipoper = 'VC' and b.inserie = 'ICAP' and rsrutcli <> @rut_central then 'VICA'
         when rscartera = '121' and rstipoper = 'VC' and b.inserie = 'ICOL' then 'VICO'
         when rscartera = '130' and rstipoper = 'VC' and b.inserie = 'ICAP' then 'VCAB'
         when rscartera = '121' and rstipoper = 'DEV' and b.inserie = 'ICAP' and rsrutcli <> @rut_central then 'DICA'
         when rscartera = '121' and rstipoper = 'dev' and b.inserie = 'icol' then 'dico'
         when rscartera = '130' and rstipoper = 'dev' and b.inserie = 'icap' then 'dcab'
  when rscartera = '112' and rstipoper ='DEV' then 'DVCI' 
  when rscartera = '114' and rstipoper ='DEV' then 'DVIT'
  when rscartera = '114' and rstipoper ='VC'  then 'DVVCI'
  when rscartera = '115' and rstipoper ='DEV' then 'DVVI'
  when rscartera = '150' and rstipoper ='DEV' then 'DIC'
  else 'DEV' 
        end   ,
 a.rsnumoper  ,
 a.rscorrela  ,
 case     
  when rscartera = '111' then isnull(b.inserie,'')
  when rscartera = '114' then isnull(b.inserie,'')
  else '' 
 end   ,
 convert(char(06),a.rsmonpact),
 0.0   ,
 isnull(a.rsinteres,0) + isnull(a.rsreajuste,0),
        isnull(a.rsvppresenx,0) ,
        0.0   ,
 0.0   ,
 isnull(a.rsinteres,0) ,
 isnull(a.rsreajuste,0) ,
 isnull(a.rsinteres,0) ,
 isnull(a.rsreajuste,0) ,
 isnull(a.rsvppresenx,0) ,
 0.0   ,
        isnull(a.rsvppresen,0)  ,      -- val.compra historico
 0.0   ,      -- dif pacto pos
 0.0   ,      -- dif pacto neg
 0.0   ,      -- valor mercado pos 
 0.0   ,      -- valor mercado neg
        ' ',--isnull(left(h.mocondpacto,1),''),      -- condicion pacto
        case          -- forma de pago  
  when rscartera = '121' and rstipoper = 'VC' and b.inserie = 'ICAP' then convert(char(06),rsforpagv)
         when rscartera = '121' and rstipoper = 'VC' and b.inserie = 'ICOL' then convert(char(06),rsforpagv)
  else '0' 
 end,
        ' ',--isnull(h.motipobono,'')  ,     -- tipo instrumento
 convert(char(01),c.cltipcli),  -- tipo de cliente
 ''                      ,      -- generico de emisor
 isnull(a.rsvppresenx,0)        -- valor futuro para vencimiento de interbancarios  
from 
 MDRS a,
 VIEW_INSTRUMENTO b,
 VIEW_CLIENTE c
--        MDMH    h
where a.rscodigo   = b.incodigo
  and (c.clrut     = a.rsrutcli 
  and c.clcodigo = a.rscodcli)
--  and   a.rstipopero = h.motipoper  -- cvi revisar
/*  and   a.rsnumoper  = h.monumoper
  and   a.rsnumdocu  = h.monumdocu
  and   a.rscorrela  = h.mocorrela*/

--  print 'devengo'

if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO RENTA FIJA ARCHIVO CONTABILIZA.'
   return 1
end
/* ======================================================================================== */
/* spot compras y ventas spot bancos, empresas y arbitrajes                                 */
/* ======================================================================================== */
--print '6'
insert BAC_CNT_CONTABILIZA(
        id_sistema  ,
        tipo_movimiento  ,
        tipo_operacion  ,
        operacion  ,
        correlativo  ,
        codigo_instrumento ,
        moneda_instrumento ,
        valor_compra  ,
        valor_presente     ,
        nominalpesos            ,
        forma_pago_entregamos   ,
        forma_pago         )
        select  'BCC'             ,
        'MOV'                     ,
        (case when motipope = 'C' and motipmer = 'PTAS' then 'CSB'
              when motipope = 'C' and motipmer = 'EMPR' then 'CSE'
              when motipope = 'V' and motipmer = 'PTAS' then 'VSB'
              when motipope = 'V' and motipmer = 'EMPR' then 'VSE'
              when motipope = 'C' and motipmer = 'ARBI' then 'AMC'
              when motipope = 'V' and motipmer = 'ARBI' then 'AMV'
        end)                      ,
        monumope                  ,
        1                         ,
        convert(char(6),mncodmon) ,
        ''                        ,
        momonmo                   ,
        (case when motipmer = 'ARBI' then moussme else momonpe end),
        momonpe                   ,
        convert(char(06),moentre) ,
        convert(char(06),morecib) 
   from VIEW_MEMO ,
 VIEW_MONEDA 
  where mofech    = @fecha_hoy
    and mnnemo    = mocodmon                  
    and motipope <> 'A'
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO MOVIMIENTOS DE SPOT ARCHIVO CONTABILIZA.'
   return 1
end
/* ======================================================================================== */
/* forward seguro cambio            */
/* ======================================================================================== */
--print '7'
insert BAC_CNT_CONTABILIZA(
        id_sistema  ,
        tipo_movimiento  ,
        tipo_operacion  ,
        operacion  ,
        correlativo  ,
        codigo_instrumento ,
        moneda_instrumento ,
 valor_compra  ,
 valor_futuro  ,
 valor_presente  ,
 perdida   ,
 utilidad  ,
 tipo_cliente  ,
 forma_pago  )
 select  
 'BFW'                         ,
        'MOV'                         ,
        '1'+catipoper               ,
 canumoper                     ,
        1                             ,
        convert(char(03),cacodmon2)   ,
        ''                            ,
 caequusd1               ,
 caequmon2               ,
 caequmon1               ,
 case when caperddiferir < 0 then caperddiferir * - 1 else 0 end,
 case when cautildiferir > 0 then cautildiferir else 0 end,
 case when y.clpais = 6 then 'l' else 'E' end,
 convert(char(6),cafpagomn)
   from VIEW_MFCA x, VIEW_CLIENTE y
  where cacodpos1 = 1 
    and cafecha   = @fecha_hoy
    and cacodigo  = y.clrut
    and cacodcli  = y.clcodigo
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO SEGUROS DE CAMBIO FORWARD ARCHIVO CONTABILIZA.'
   return 1
end
/* ======================================================================================== */
/* forward arbitraje             */
/* ======================================================================================== */
--print '8'
insert BAC_CNT_CONTABILIZA(
        id_sistema  ,
        tipo_movimiento  ,
        tipo_operacion  ,
        operacion  ,
        correlativo  ,
        codigo_instrumento ,
        moneda_instrumento ,
 dif_valor_mercado_neg ,
 dif_valor_mercado_pos  ,
 valor_compra  ,
 valor_venta  ,
 utilidad  ,
 perdida          ,
 tipo_cliente  ,
 forma_pago  )
select  
 'BFW'                   ,
        'MOV'                   ,
        '2'+catipoper  ,
 canumoper               ,
        1                       ,
        convert(char(03),cacodmon1)     ,
        '',
 0   ,
 0   ,
 case catipoper when 'C' then camtomon1 else camtomon2 end,
 case catipoper when 'C' then camtomon2 else camtomon1 end,
 0   ,
 0   ,
 case when y.clpais = 6 then 'l' else 'E' end,
 convert(char(06),cafpagomn)
   from VIEW_MFCA x, VIEW_CLIENTE y
  where cacodpos1 = 2
    and cafecha   = @fecha_hoy
    and cacodigo  = y.clrut
    and cacodcli  = y.clcodigo
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO ARBITRAJES FORWARD ARCHIVO CONTABILIZA.'
   return 1
end
/* ======================================================================================== */
/* forward seguro inflacion vb                                                              */
/* ======================================================================================== */
--print '9'
insert BAC_CNT_CONTABILIZA(
        id_sistema  ,
        tipo_movimiento  ,
        tipo_operacion  ,
        operacion  ,
        correlativo  ,
        codigo_instrumento ,
        moneda_instrumento ,
 valor_compra  ,
 valor_venta  ,
 utilidad  ,
 perdida   ,
 forma_pago  )
 select  
 'BFW'                   ,
        'MOV'                   ,
        '3'+catipoper       ,
 canumoper               ,
        1                       ,
        convert(char(03),cacodmon1)   ,
        ''                            ,
 case catipoper  when 'C' then  caequmon1 else camtomon2 end,
 case catipoper  when 'C' then  camtomon2 else caequmon1 end,
 case when cautildiferir>0 then cautildiferir      else 0 end ,
 case when caperddiferir<0 then abs(caperddiferir) else 0 end,
 convert(char(06),cafpagomn)
   from VIEW_MFCA 
  where cacodpos1 = 3
    and cafecha   = @fecha_hoy
if @@error <> 0
begin
 print 'ERROR_PROC FALLA ACTUALIZANDO VCTO. SEG. CAMBIO FORWARD ARCHIVO CONTABILIZA.'
   return 1
end
/* ======================================================================================== */
/* forward devengamiento seguro cambio                                                      */
/* ======================================================================================== */
if @habil = 'S'
begin
   insert BAC_CNT_CONTABILIZA(
 id_sistema  ,
        tipo_movimiento ,
        tipo_operacion ,
        operacion  ,
        correlativo  ,
        codigo_instrumento ,
        moneda_instrumento ,
 utilidad  ,
        perdida  ,
 valor_compra  ,
 valor_venta  ,
        valor_presente ,
        reajuste_papel ,
 forma_pago  )
   select 
 'BFW'                    ,
        'DEV'                    ,
        'D1'+catipoper           ,
        canumoper                ,
        1                        ,
        convert(char(03),cacodmon2) ,
        ''                       ,
        abs(cautildevenga)  ,
        abs(caperddevenga)  ,
        cavalordia   ,
        case when cavalordia > 0 then abs(cavalordia) else 0 end ,
        case when cavalordia < 0 then abs(cavalordia) else 0 end ,
        cadifuf    ,
 convert(char(06),cafpagomn)
     from VIEW_MFCA
    where cacodpos1 = 1
      and cafecha  <= @fecha_hoy
      and (abs(cautildevenga) + abs(caperddevenga) <> 0 
           or cadifuf    <> 0                          --- variaci¢n uf diaria
           or cavalordia <> 0)                         --- valorizaci¢n diaria
   if @@error <> 0
   begin
      print 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO SEGURO CAMBIO, FORWARD ARCHIVO CONTABILIZA.'
      return 1
   end
/* ======================================================================================== */
/* forward devengamiento arbitraje                                                          */
/* ======================================================================================== */
--print '10'
   insert BAC_CNT_CONTABILIZA(
          id_sistema  ,
          tipo_movimiento ,
          tipo_operacion ,
          operacion  ,
          correlativo  ,
          codigo_instrumento ,
          moneda_instrumento ,
          utilidad  ,
          perdida  ,
          interes_papel         ,
          reajuste_papel        ,
   forma_pago  )
   select 'BFW'                   ,
          'DEV'                   ,
          'D2'+catipoper          ,
          canumoper               ,
          1                       ,
          ''                      ,
          ''                      ,
          case  when cavalordia  > 0 then     cavalordia   else 0 end , -- utilidad arbitraje hoy
          case  when cavalordia  < 0 then abs(cavalordia)  else 0 end , -- perdida arbitraje hoy
          case  when cavalorayer > 0 then     cavalorayer  else 0 end , -- utilidad arbitraje ayer
          case  when cavalorayer < 0 then abs(cavalorayer) else 0 end ,  -- perdida arbitraje ayer
 convert(char(06),cafpagomn)
     from VIEW_MFCA
    where cacodpos1 = 2
      and cafecvcto > @fecha_hoy
      and cafecha   < @fecha_hoy
   if @@error <> 0
   begin
      print 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO ARBITRAJES, FORWARD ARCHIVO CONTABILIZA.'
      return 1
   end
/* ======================================================================================== */
/* forward devengamiento seguros de inflacion                                               */
/* ======================================================================================== */
--print '12'
   insert BAC_CNT_CONTABILIZA(
   id_sistema  ,
   tipo_movimiento ,
   tipo_operacion ,
   operacion  ,
   correlativo  ,
   codigo_instrumento ,
   moneda_instrumento ,
   valor_compra  ,
   utilidad  , 
   perdida  ,
   valor_venta  ,
   valor_presente ,
   forma_pago  )
  select 'BFW'          ,
          'DEV'                   ,
          'D3'+catipoper          ,
          canumoper               ,
  1                     ,
          convert(char(03),cacodmon1),
         ''                      ,
          cavalordia     ,
          cautildevenga    ,
          abs(caperddevenga)    ,
          case  when cavalordia > 0  then     cavalordia  else 0 end ,
          case  when cavalordia < 0  then abs(cavalordia) else 0 end ,
   convert(char(06),cafpagomn)
     from VIEW_MFCA
    where cacodpos1  = 3
      and cafecvcto  >= @fecha_hoy
      and cafecha   <= @fecha_hoy
      and abs(cautildevenga) + abs(caperddevenga) <> 0
   if @@error <> 0
   begin
      print 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO ARBITRAJES, FORWARD ARCHIVO CONTABILIZA.'
      return 1
   end
end   /* fin if dia no habil */
/* ======================================================================================== */
/* forward vencimiento seguro cambio           */
/* ======================================================================================== */
-- vb+- 24/10/2000 se cambia contabilizacion forma de pago para contabilizacion 
--print '13'
insert BAC_CNT_CONTABILIZA(
        id_sistema  ,
        tipo_movimiento  ,
        tipo_operacion  ,
        operacion  ,
        correlativo  ,
        codigo_instrumento ,
        moneda_instrumento ,
 valor_compra  ,
 valor_presente  ,
 valor_futuro  ,
 utilidad  ,
 perdida   ,
 tipo_cliente         ,
 forma_pago  )
 select  
 'BFW'                             ,
        'MOV'                             ,
        'V1'+catipoper+catipmoda          ,
 canumoper                         ,
        1                           ,
        convert(char(03),cacodmon2)    ,
        ''                                ,
 camtomon1           ,
 caclpmoneda2      ,
 round(camtomon1*@valor_observado,0)   ,
 case when camtocomp >0 then camtocomp      else 0 end , 
 case when camtocomp <0 then abs(camtocomp) else 0 end   ,
 case when b.clpais = 6 then 'l' else 'E' end  ,
 case  when c.cc2756 = 's' and  b.clpais <> 6 then convert(char(06),10) else convert(char(06),cafpagomn) end 
   from VIEW_MFCA a, 
 VIEW_CLIENTE b, 
 VIEW_FORMA_DE_PAGO c
  where cacodpos1 = 1
    and cafecvcto = @fecha_hoy
    and cacodigo  = b.clrut
    and cacodcli  = b.clcodigo
    and c.codigo = cafpagomn
-- select * from MDFP
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO VCTO. SEG. CAMBIO FORWARD ARCHIVO CONTABILIZA.'
   return 1
end
/* ======================================================================================== */
/* forward vencimiento arbitraje           */
/* ======================================================================================== */
--print '14'
insert BAC_CNT_CONTABILIZA(
        id_sistema  ,
        tipo_movimiento  ,
        tipo_operacion  ,
        operacion  ,
        correlativo  ,
        codigo_instrumento ,
        moneda_instrumento ,
 valor_venta   ,
 valor_compra          ,
 utilidad      ,
 perdida                 ,
        interes_papel           ,
        reajuste_papel          ,
        tipo_cliente            ,
 forma_pago  )
 select  
 'BFW'                         ,
        'MOV'                         ,
        'V2'+catipoper+catipmoda      ,
 canumoper                     ,
        1                             ,
        convert(char(03),cacodmon1)   ,
        ''                            ,
 case catipoper when 'C'   then       camtomon2  else camtomon1 end,
 case catipoper when 'C'   then       camtomon1  else camtomon2 end,
 case when camtocomp   > 0 then       camtocomp  else       0.0 end,
 case when camtocomp   < 0 then   abs(camtocomp) else       0.0 end,
 case when cavalorayer > 0 then     cavalorayer  else       0.0 end,
 case when cavalorayer < 0 then abs(cavalorayer) else       0.0 end,
 case when w.clpais = 6 then 'l' else 'E' end,
 convert(char(06),cafpagomn)
   from VIEW_MFCA q, VIEW_CLIENTE w
  where cacodpos1 = 2
    and cafecvcto = @fecha_hoy
and cacodigo  = w.clrut
    and cacodcli  = w.clcodigo
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO VCTO. ARBITRAJES FORWARD ARCHIVO CONTABILIZA.'
   return 1
end
/* ======================================================================================== */
/* forward vencimiento seguro inflacion           */
/* ======================================================================================== */
--print '15'
insert BAC_CNT_CONTABILIZA(
        id_sistema  ,
        tipo_movimiento  ,
        tipo_operacion  ,
        operacion  ,
        correlativo  ,
        codigo_instrumento ,
        moneda_instrumento ,
 valor_compra  ,
 valor_venta  ,
 utilidad  ,
 perdida   ,
 forma_pago  )
 select  
 'BFW'                             ,
        'MOV'                             ,
        'V3'+catipoper            ,
 canumoper                         ,
        1                           ,
        convert(char(03),cacodmon1)    ,
        ''                                ,
 caclpmoneda1      ,
 caclpmoneda2      ,
 case when camtocomp >0 then camtocomp      else 0 end , 
 case when camtocomp <0 then abs(camtocomp) else 0 end   ,
 convert(char(06),cafpagomn)
   from VIEW_MFCA
  where cacodpos1 = 3
    and cafecvcto = @fecha_hoy
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO VCTO. SEG. INFLACION FORWARD ARCHIVO CONTABILIZA.'
   return 1
end
/* ======================================================================================== */
/* liquidaciones de tesoreria clp                                                           */
/* ======================================================================================== */
--print '16'
insert BAC_CNT_CONTABILIZA(
        id_sistema  ,
        tipo_movimiento  ,
        tipo_operacion  ,
        operacion               ,
        correlativo             ,
        valor_presente          ,
        forma_pago              ,
 condicion_entrega  )
 select a.id_sistema,
        'LIQ'                   ,
        (case b.tipo_movimiento_caja
         when 'A' then (case
                        when b.id_sistema      = 'BTR' 
                         and b.tipo_operacion  = 'IC' 
                         and a.moneda             = '$$' or a.moneda='clp'  then 'INCA' --o clp
                        when b.id_sistema      = 'BTR' 
                         and b.tipo_operacion <> 'IC' 
                         and a.moneda             = '$$' or a.moneda='clp' then 'INTR' --o clp
                        when b.id_sistema      = 'BTR' 
                         and a.moneda             = 'USD' then 'INTM'
                        when b.id_sistema = 'BFW' then 'INFW'
                        when b.id_sistema = 'BCC' then 'INSP'
                       end)
         else          (case 
                        when b.id_sistema      = 'BTR' 
                         and b.tipo_operacion  = 'IC' 
                         and a.moneda             = '$$' or a.moneda='clp' then 'EGCA' --o clp
                        when b.id_sistema      = 'BTR' 
                         and b.tipo_operacion <> 'IC' 
                         and a.moneda             = '$$' or a.moneda='clp' then 'EGTR'--O clp
                        when b.id_sistema      = 'BTR' 
                         and a.moneda             = 'USD' then 'EGTM'
                        when b.id_sistema = 'BFW' then 'EGFW'
                        when b.id_sistema = 'BCC' then 'EGSP'
                       end)
        end)                    ,
        operacion               ,
        1                       ,
        monto_operacion         ,
        forma_pago  ,
 'TIPODEP'=isnull(case b.tipo_operacion when 'IC' then (select isnull(tipo_deposito,'') from GEN_CAPTACION where a.operacion = GEN_CAPTACION.numero_operacion and a.correlativo = GEN_CAPTACION.correla_operacion 
) else '' end,'')
   from GEN_OPERACIONES a, VIEW_MOVIMIENTO_CNT b
  where a.fecha_pago     = @fecha_hoy
    and a.tipo_operacion = b.tipo_operacion
    and a.moneda         = '$$' or a.moneda='clp'--o clp
    and a.cerrada        = 'S'
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO LIQUIDACIONES TESORERIA (CLP) ARCHIVO CONTABILIZA.'
   return 1
end
/* actualiza moneda para captaciones ---------------------------------------------------------------------------------------- */
update BAC_CNT_CONTABILIZA set moneda_instrumento = convert(char(4),momonpact)
                          from MDMO
                         where tipo_movimiento = 'LIQ'
                           and (tipo_operacion = 'INCA' or tipo_operacion = 'EGCA')
                           and MDMO.motipoper = 'IC'
                           and MDMO.monumoper = BAC_CNT_CONTABILIZA.operacion
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO MONEDA CAPTACIONES ARCHIVO CONTABILIZA.'
   return 1
end
/* ======================================================================================== */
/* liquidaciones de tesoreria usd                                                           */
/* ======================================================================================== */
--print '17'
insert BAC_CNT_CONTABILIZA(
        id_sistema  ,
        tipo_movimiento  ,
        tipo_operacion  ,
        codigo_instrumento      ,
        moneda_instrumento      ,
        operacion               ,
        correlativo             ,
        valor_presente          ,
        forma_pago              )
 select a.id_sistema,
        'LIQ'                   ,
        (case 
         when b.tipo_movimiento_caja = 'C' and moneda_mx = 'USD' and a.tipo_operacion <> 'IC' then 'INMX'
         when b.tipo_movimiento_caja = 'A' and moneda_mx = 'USD' and a.tipo_operacion <> 'IC' then 'EGMX'
         when b.tipo_movimiento_caja = 'C' and moneda    = 'USD' and charindex(rtrim(a.tipo_operacion), 'IC   ICO  CP   VICO DVVC V1CC V1CE V2CC V2CE V3C  ') = 0 then 'EGMX'
         when b.tipo_movimiento_caja = 'A' and moneda    = 'USD' and charindex(rtrim(a.tipo_operacion), 'IC   ICO  CP   VICO DVVC V1VC V1VE V2VC V2VE V3V  ') = 0 then 'INMX'
         when b.tipo_movimiento_caja = 'C' and moneda    = 'USD' and charindex(rtrim(a.tipo_operacion), 'V1CC V1CE V2CC V2CE V3C  ') > 0 then 'EGFM'
         when b.tipo_movimiento_caja = 'A' and moneda    = 'USD' and charindex(rtrim(a.tipo_operacion), 'V1VC V1VE V2VC V2VE V3V  ') > 0 then 'INFM'
         when b.tipo_movimiento_caja = 'C' and moneda    = 'USD' and a.tipo_operacion  = 'CP' then 'EGTM'
         when b.tipo_movimiento_caja = 'A' and moneda    = 'USD' and a.tipo_operacion  = 'VP' then 'INTM'
         when b.tipo_movimiento_caja = 'A' and moneda    = 'USD' and a.tipo_operacion  = 'IC' then 'INCA'
         when b.tipo_movimiento_caja = 'A' and moneda    = 'USD' and a.tipo_operacion  = 'IC' then 'EGCA'
         when b.tipo_movimiento_caja = 'C' and moneda    = 'USD' and a.tipo_operacion  = 'VIC' then 'EGTM'
         when b.tipo_movimiento_caja = 'C' and moneda    = 'USD' and a.tipo_operacion  = 'ICO'  then 'EGTM'
         when b.tipo_movimiento_caja = 'A' and moneda    = 'USD' and a.tipo_operacion  = 'VICO' then 'INTM'
         when b.tipo_movimiento_caja = 'A' and moneda    = 'USD' and a.tipo_operacion  = 'DVVC' then 'INTM'
        end)                    ,
        (case when charindex(rtrim(a.tipo_operacion), 'IC  ICO CP  VICODVVC') = 0 then convert(char(4),c.mncodmon) else '' end),
        (case when a.tipo_operacion  = 'IC' then convert(char(4),c.mncodmon) else '' end),
        operacion               ,
        1                       ,
        (case moneda
  when 'USD' then monto_operacion
      else            monto_mx
        end)                    ,
        (case moneda
         when 'USD' then forma_pago
         else            forma_pago_mx
        end)
   from GEN_OPERACIONES    a, 
 VIEW_MOVIMIENTO_CNT b, 
 VIEW_MONEDA   c
  where a.fecha_pago     = @fecha_hoy
    and a.tipo_operacion = b.tipo_operacion
    and a.cerrada        = 'S'
    and c.mnnemo                    = 'USD'
    and (a.moneda_mx = 'USD' or a.moneda = 'USD')
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO LIQUIDACIONES TESORERIA (USD) ARCHIVO CONTABILIZA.'
   return 1
end
/* ======================================================================================== */
/* liquidaciones de tesoreria m/x                                                           */
/* ======================================================================================== */
--print '18'
insert BAC_CNT_CONTABILIZA(
        id_sistema  ,
        tipo_movimiento  ,
        tipo_operacion  ,
        codigo_instrumento      ,
        operacion               ,
        correlativo             ,
        valor_presente          ,
        forma_pago              )
 select a.id_sistema,
        'LIQ'                   ,
        (case b.tipo_movimiento_caja
         when 'C' then 'INMX'
         else          'EGMX'
        end)                    ,
        convert(char(4),c.mncodmon),
        operacion               ,
        1                       ,
        monto_mx                ,
        forma_pago_mx
   from GEN_OPERACIONES    a, 
 VIEW_MOVIMIENTO_CNT b, 
 VIEW_MONEDA   c
  where a.fecha_pago     = @fecha_hoy
    and a.tipo_operacion = b.tipo_operacion
    and a.cerrada        = 'S'
    and a.moneda_mx      = c.mnnemo
    and (a.moneda_mx <> 'USD' and rtrim(a.moneda_mx) <> '')
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO LIQUIDACIONES TESORERIA (MX) ARCHIVO CONTABILIZA.'
   return 1
end
/* ======================================================================================== */
/* vencimiento valuta forma de pago usd/m/x                                                 */
/* ======================================================================================== */
--print '19'
insert BAC_CNT_CONTABILIZA(
        id_sistema  ,
        tipo_movimiento  ,
        tipo_operacion  ,
        operacion               ,
        correlativo             ,
        codigo_instrumento      ,
        valor_presente          ,
        forma_pago              )
 select 'BCC'                   ,
        'LIQ'                   ,
        tipo_operacion          ,
        operacion               ,
        1                       ,
        convert(char(4),moneda) ,
        monto     ,
        forma_pago
   from gen_recepcion_pagos
    
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO VCTOS. M/X TESORERIA ARCHIVO CONTABILIZA.'
   return 1
end
/* ======================================================================================== */
/* traspaso valutas 48-24-hoy spot                                                          */
/* ======================================================================================== */
--print '20'
insert BAC_CNT_CONTABILIZA(
       id_sistema  ,
        tipo_movimiento  ,
        tipo_operacion  ,
        operacion               ,
        correlativo             ,
        codigo_instrumento      ,
        valor_presente          )
 select 'BCC'                   ,
        'LIQ'                   ,
        tipo_tran               ,
        operacion               ,
        1                       ,
        convert(char(4),moneda) ,
        monto
   from GEN_TRANSFER_MX
  where fecha_tran = @fecha_hoy
    
if @@error <> 0
begin
   PRINT 'ERROR_PROC FALLA ACTUALIZANDO TRANSFERENCIAS MX TESORERIA ARCHIVO CONTABILIZA.'
   return 1
end
/* ======================================================================================== */
/* cargos y abonos de tesoreria                                                             */
/* ======================================================================================== */
--print '21'
insert BAC_CNT_CONTABILIZA(
        id_sistema  ,
        tipo_movimiento  ,
        tipo_operacion  ,
        operacion               ,
        correlativo             ,
        valor_presente          ,
        forma_pago              )
--        forma_pago_entregamos   )
 select 'TES'                   ,
        'MOV'                   ,
        tipo_operacion          ,
        operacion               ,
        1                       ,
        monto_operacion         ,
        forma_pago             
--        tipo_docto_canje
   from GEN_PAGOS_OPERACION
  where GEN_PAGOS_OPERACION.fecha_pago   = @fecha_hoy
    and GEN_PAGOS_OPERACION.tipo_ingreso = 'M'
    and (GEN_PAGOS_OPERACION.estado = 'a' or GEN_PAGOS_OPERACION.estado = 'c')
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO CARGOS/ABONOS DE TESORERIA ARCHIVO CONTABILIZA.'
   return 1
end
/* ======================================================================================== */
/* vencimiento de captacion                                                                 */
/* ======================================================================================== */
--print '22'
insert BAC_CNT_CONTABILIZA(
        id_sistema  ,
        tipo_movimiento  ,
        tipo_operacion  ,
        operacion               ,
        correlativo             ,
        valor_presente          ,
        valor_compra            ,
        interes_pacto           ,
        reajuste_pacto          ,
        nominalpesos            ,
        condicion_pacto  ,
        forma_pago              ,
 moneda_instrumento  ,
        condicion_entrega       )
 select 'BTR'                   ,
        'MOV'                   ,
        'VIC'                   ,
        numero_operacion        ,
        1                       ,
        valor_presente          ,
        monto_inicio_pesos      ,
        interes_acumulado       ,
        reajuste_acumulado      ,
        monto_inicio            ,
        b.mocondpacto        ,
        forma_pago              ,
 convert(char(06),moneda ),
        custodia 
   from GEN_CAPTACION a, 
 MDMH  b
  where a.fecha_vencimiento = @fecha_hoy
    and b.motipoper                  = 'IC'
    and b.monumoper                  = a.numero_operacion
    and b.mocorrela       = a.correla_operacion
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO CARGOS/ABONOS DE TESORERIA ARCHIVO CONTABILIZA.'
   return 1
end
/* ======================================================================================== */
/* valorizacion de posicion spot               */
/* ======================================================================================== */
--print '23'
insert BAC_CNT_CONTABILIZA(
        id_sistema  ,
        tipo_movimiento  ,
        tipo_operacion  ,
        operacion  ,
        correlativo  ,
        codigo_instrumento ,
        moneda_instrumento ,
 utilidad  ,
 perdida   )
 select 'BCC'    , 
        'MOV'              ,
        'VSP'                ,
 rscodigome                   ,
        1                            ,
        convert(char(03),rscodigome) ,
        ''                           ,
 rsutilidad                   ,
 rsperdida 
   from VIEW_MERS
  where rsfecha = @fecha_hoy
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO VALORIZACION SPOT ARCHIVO CONTABILIZA.'
   return 1
end
/* ======================================================================================== */
/* saldo camara del dia                        */
/* ======================================================================================== */
if @habil = 'S'
begin
--print '24'
   insert BAC_CNT_CONTABILIZA(
          id_sistema    ,
          tipo_movimiento   ,
          tipo_operacion   ,
          operacion               ,
          correlativo             ,
          valor_presente          )
   select 'TES' ,
    'MOV'                   ,
          (case when saldo_camara > 0 then 'SNC' else 'SCC' end),
          1                       ,
          1                       ,
          abs(saldo_camara)
     from GEN_SALDO_BCCH
    where saldo_camara <> 0
   if @@error <> 0
   begin
      print 'ERROR_PROC FALLA ACTUALIZANDO SALDO CAMARA ARCHIVO CONTABILIZA.'
      return 1
   end
end
/* ======================================================================================== */
/* canje recibido                              */
/* ======================================================================================== */
--print '25'
insert BAC_CNT_CONTABILIZA(
        id_sistema  ,
        tipo_movimiento  ,
        tipo_operacion  ,
        operacion               ,
        correlativo             ,
        valor_presente          ,
        forma_pago              )
 select 'TES'                   ,
        'MOV'                   ,
        'CARE'                  ,
        numero_documento        ,
        1                       ,
        monto_operacion         ,
        forma_pago
   from GEN_PAGOS_OPERACION
  where fecha_cobro   = @fecha_hoy
    and tipo_canje    = 'R'
    and forma_pago   <> '0'
    and tipo_ingreso <> 'C'
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO CANJE RECIBIDO ARCHIVO CONTABILIZA.'
   return 1
end
/*  tasa de mercado  */
execute @control_error = Sp_Conta_Tasamercado
if @control_error <> 0 return 1
/* ======================================================================================== */
/* clasifica formas de pago para contabilidad                                               */
/* ======================================================================================== */
select @vvista = convert(char(4),folio) from GEN_FOLIOS where codigo = 'vista'
-- select * from MDTC where tbcateg = 201
update BAC_CNT_CONTABILIZA set forma_pago = VIEW_TABLA_GENERAL_DETALLE.tbcodigo1
  from VIEW_TABLA_GENERAL_DETALLE
 where VIEW_TABLA_GENERAL_DETALLE.tbtasa  = convert(numeric(5), forma_pago)
   and VIEW_TABLA_GENERAL_DETALLE.tbcateg =  201 -- codigos de forma de pago
   and VIEW_TABLA_GENERAL_DETALLE.tbvalor = (case when forma_pago = @vvista and ltrim(rtrim(tipo_cliente)) <> '1' then 2 else 1 end )
   and len(ltrim(rtrim(forma_pago)))>0
--select @@rowcount
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO FORMA PAGO.'
   return 1
end
update BAC_CNT_CONTABILIZA set forma_pago_entregamos = VIEW_TABLA_GENERAL_DETALLE.tbcodigo1
  from VIEW_TABLA_GENERAL_DETALLE
 where VIEW_TABLA_GENERAL_DETALLE.tbtasa  = convert(numeric(5), forma_pago_entregamos)
   and VIEW_TABLA_GENERAL_DETALLE.tbcateg =  201 -- codigos de forma de pago
   and VIEW_TABLA_GENERAL_DETALLE.tbvalor = (case when forma_pago_entregamos = @vvista and tipo_cliente <> '1' then 2 else 1 end)
   and len(ltrim(rtrim(forma_pago_entregamos)))>0
--select @@rowcount
if @@error <> 0
begin
   print 'ERROR_PROC FALLA ACTUALIZANDO FORMA PAGO ENTREGAMOS.'
   return 1
end
return 0
end   /* fin procedimiento */
/*
-- tabla_campo          campo_tabla                    campos_tablas                  
 update bac_cnt_campos set tabla_campo = 'MDTC' 
  campo_tabla  = 'tbcodigo1',
  campos_tablas = tbcodigo1,tbglosa,
where tabla_campo  = 'MDFP'
sp_help MDTC
-- sp_contabilizacion '20000912'
-- select convert(numeric(5), forma_pago) from BAC_CNT_CONTABILIZA MDTC where 
-- select * from MDTC where tbcateg = 201
---- select id_sistema,forma_pago, forma_pago_entregamos , * from BAC_CNT_CONTABILIZA
delete * 
*/

GO
