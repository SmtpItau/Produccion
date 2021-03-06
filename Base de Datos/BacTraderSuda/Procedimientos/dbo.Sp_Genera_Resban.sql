USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Genera_Resban]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** objeto:  procedimiento  almacenado dbo.sp_genera_resban    fecha de la secuencia de comandos: 05/04/2001 13:13:26 ******/
create proc [dbo].[Sp_Genera_Resban]
            ( @fecha_hoy datetime )
as
begin
   set nocount on
declare @regs          integer ,
        @control_error integer ,
        @usd_fin_mes   float
create table #RESBAN( fecpro            datetime    null default '',
                      entidad           char(1)     null default '',
                      correla           numeric(10) null default 0 ,
                      codclte           numeric(10) null default 0 ,
                      codemi            numeric(10) null default 0 ,
                      operacion         numeric(10) null default 0 ,
                      cartera           numeric(2)  null default 0 ,
                      tipcar            numeric(2)  null default 0 ,
                      tipocar           char(1)     null default '',
                      insreal           char(12)    null default '',
                      instser           char(12)    null default '',
                      fecemi            datetime    null default '',
                      fecini            datetime    null default '',
                      fecfin            datetime    null default '',
                      fecext            datetime    null default '',
                      moncon            char(2)     null default '',
                      tasa              float       null default 0 ,
                      tasemis           float       null default 0 ,
                      vfinal            float       null default 0 ,
                      capps             float       null default 0 ,
                      intps             float       null default 0 ,
                      nominal           float       null default 0 ,
                      pcupon            numeric(5)  null default 0 ,
                      plzo              char(5)     null default '',
                      compraor          float       null default 0 ,
                      mtocup            float       null default 0 ,
                      tipo_emp          char(1)     null default '',
                      com_del           char(1)     null default '',
                      monnom            char(2)     null default '',
                      valmerc           float       null default 0 ,
                      diferido          float       null default 0 ,
                      spread            float       null default 0 ,
                      tipo_tasa         numeric(1)  null default 0 ,
                      base_fluc         numeric(1)  null default 0 ,
                      rut_cliente       numeric(10) null default 0 ,
                      codigo_rut        numeric(10) null default 0 ,
                      rut_emisor        numeric(10) null default 0 ,
                      codigo_instrum    numeric(3)  null default 0 ,
                      moneda_contable   numeric(5)  null default 0 ,
                      moneda_nominal    numeric(5)  null default 0 ,
                      tipo_registro     char(1)     null default '',
                      tipo_operacion    char(4)     null default '',
                      corr_operacion    numeric(5)  null default 0 ,
                      dias              numeric(6)  null default 0 )
/* ======================================================================================= */
/* clasifica las operaciones de pactos y tipos de bono                                     */
/* ======================================================================================= */
execute @control_error = Sp_Actualiza_Mdmo
if @control_error <> 0
   set nocount off
   select 'OK'
   return 1
/* ======================================================================================= */
/* busca el valor dolar americano del ultimo dia habil de fin de mes                       */
/* ======================================================================================= */
select @regs = count(*)
  from VIEW_TABLA_GENERAL_DETALLE
 where tbcateg   = 55
   and tbcodigo1 = '13' 
   and tbfecha  <= @fecha_hoy
set rowcount @regs
select @usd_fin_mes = tbvalor
  from VIEW_TABLA_GENERAL_DETALLE 
 where tbcateg   = 55
   and tbcodigo1 = '13' 
   and tbfecha  <= @fecha_hoy
set rowcount 0
if @usd_fin_mes = 0 or @usd_fin_mes is null
begin
   set nocount off
   select 0, 'no encuentra dolar americano de fin de mes.'
   return 1
end
/* ======================================================================================= */
/* devengamiento dia anterior de renta fija                                                */
/* ======================================================================================= */
insert #RESBAN( fecpro,
                entidad,
                correla,
                codclte,
                codemi,
                operacion,
                cartera,
                tipcar,
                tipocar,
                insreal,
                instser,
                fecemi,
                fecini,
                fecfin,
                fecext,
                moncon,
                tasa,
                tasemis,
                vfinal,
                capps,
                intps,
                nominal,
                pcupon,
                plzo,
                compraor,
                mtocup,
                tipo_emp,
                valmerc,
                spread,
                tipo_tasa,
                base_fluc,
                rut_cliente,
                codigo_rut,
                rut_emisor,
                codigo_instrum,
                moneda_nominal,
                tipo_registro,
                corr_operacion,
                moneda_contable )
         select @fecha_hoy,
                'b',
                monumoper,
                0,          -- codigo cliente
                0,          -- codigo emisor
                monumdocuo,
                (case 
                 when motipoper = 'CP' then 1
                 when motipoper = 'CI' then 2
                 when motipoper = 'VI' and motipopero = 'CP' then 1
                 when motipoper = 'VI' and motipopero = 'CI' then 2
                 when motipoper = 'IC' then 55
                 when motipoper = 'IB' and moinstser = 'ICAP' then 55
                 when motipoper = 'IB' and moinstser = 'ICOL' then 2
                end),
                (case
                 when motipoper = 'CP' then 1
                 when motipoper = 'CI' then 2
                 when motipoper = 'IC' then 0
                 when motipoper = 'VI' and motipopero = 'CP' then 3
                 when motipoper = 'VI' and motipopero = 'CI' then 6
                 when motipoper = 'IB' then 0
                end),
                'a',        -- a=activo, p=pasivo
                '',         -- insreal
                moinstser,  -- instser
                mofecemi,
                mofecpro,
                (case
                 when motipoper = 'CI' or motipoper = 'VI' then mofecvenp
                 else mofecven
                end),
                mofecven,
                space(2),   -- moneda pacto/papel
                motaspact,
                motasemi,
                rsnominal,  -- ??? valor final
                (case 
                 when momonpact <> 13 and momonemi <> 13 then (rsvppresenx - (rsinteres_acumulado + rsreajuste_acumulado))
                 else round((rsvppresenx - (rsinteres_acumulado + rsreajuste_acumulado)) * @usd_fin_mes, 0)
                end),
                (case
                 when momonpact <> 13 and momonemi <> 13 then (rsinteres_acumulado + rsreajuste_acumulado)
                 else round((rsinteres_acumulado + rsreajuste_acumulado) * @usd_fin_mes, 0)
                end),
                rsnominal,
                rsnumucup,
                (case
                 when motipoper = 'CI' and mocondpacto = '5'  then 'COPA'
                 when motipoper = 'CI' and mocondpacto = '2'  then 'COPB'                 
   when motipoper = 'CI' and mocondpacto = '4'  then 'COPC'
                 when motipoper = 'CI' and mocondpacto = '1'  then 'COPD'
                 when motipoper = 'CI' and mocondpacto = '6'  then 'CPCR'
                 when motipoper = 'CI' and mocondpacto = '3'  then 'CPDR'
                 when motipoper = 'VI' and mocondpacto = '1'  then 'VEPC'
                 when motipoper = 'VI' and mocondpacto = '15' then 'VEPE'
                 when motipoper = 'VI' and mocondpacto = '5'  then 'VEPF'
                 when motipoper = 'VI' and mocondpacto = '6'  then 'VEPG'
                 when motipoper = 'VI' and mocondpacto = '7'  then 'VEPB'
                 when motipoper = 'VI' and mocondpacto = '16' then 'VEPH'
                 when motipoper = 'VI' and (mocondpacto = '12' or mocondpacto = '2') then 'VEPI'
                 when motipoper = 'VI' and (mocondpacto = '13' or mocondpacto = '3') then 'VEPJ'
                 when motipoper = 'VI' and (mocondpacto = '14' or mocondpacto = '4') then 'VEPD'
                 when motipoper = 'VI' and mocondpacto = '8'  then 'VPHR'
                 when motipoper = 'VI' and mocondpacto = '9'  then 'VPIR'
                 when motipoper = 'VI' and mocondpacto = '10' then 'VPJR'
                 when motipoper = 'VI' and mocondpacto = '11' then 'VPDR'
                 else space(4)
                end),
                (case 
                 when motipoper = 'IB' or motipoper = 'IC' then rsnominal
                 else round((mocapitali * rsnominal) / monominal, 0)
                end),
                rscupamo,   -- valor cupon, solo devengamiento
                ' ',        -- tipo empresa 
                (case       -- valor mercado (mientras)
                 when momonpact <> 13 and momonemi <> 13 then rsvppresen
                 else round(rsvppresen * @usd_fin_mes, 0)
                end),
                0.0,        -- spread
                (case when substring(rsinstser,1,3) = 'PCD' or substring(rsinstser,1,3) = 'PTF' then 2 else 1 end),  -- tipo tasa
                (case when substring(rsinstser,1,3) = 'PCD' or substring(rsinstser,1,3) = 'PTF' then 3 else 0 end),  -- base fluc
                morutcli,
                mocodcli,
                morutemi,
                mocodigo,
                momonemi,
                'd',
                mocorrela,
                (case when isnull(momonpact,0) = 0 then momonemi else momonpact end)
           from MDRS,
                MDMH
          where rstipopero = motipoper
            and rsnumoper  = monumoper
            and rsnumdocu  = monumdocu
            and rscorrela  = mocorrela
            and rstipoper <> 'VC'
            and (MDMH.motipoper = 'CP' or 
                 MDMH.motipoper = 'CI' or 
                 MDMH.motipoper = 'VI' or 
                 MDMH.motipoper = 'IC' or 
                 MDMH.motipoper = 'IB' )
/* ======================================================================================= */
/* movimientos del dia de carteras                                                         */
/* ======================================================================================= */
insert #RESBAN( fecpro,
                entidad,
                correla,
                codclte,
                codemi,
                operacion,
                cartera,
                tipcar,
                tipocar,
                insreal,
                instser,
                fecemi,
                fecini,
                fecfin,
                fecext,
                moncon,
                tasa,
                tasemis,
                vfinal,
                capps,
                intps,
                nominal,
                pcupon,
                plzo,
                compraor,
                mtocup,
                tipo_emp,
         valmerc,
                spread,
                tipo_tasa,
                base_fluc,
                rut_cliente,
                codigo_rut,
                rut_emisor,
                codigo_instrum,
                moneda_nominal,
                tipo_registro,
                corr_operacion,
                moneda_contable )
         select @fecha_hoy,
                'b',
                monumoper,
                0,          -- codigo cliente
                0,          -- codigo emisor
                monumdocuo,
                (case 
                 when motipoper = 'CP' then 1
                 when motipoper = 'CI' then 2
                 when motipoper = 'VI' and motipopero = 'CP' then 1
                 when motipoper = 'VI' and motipopero = 'CI' then 2
                 when motipoper = 'IC' then 55
                 when motipoper = 'IB' and moinstser = 'ICAP' then 55
                 when motipoper = 'IB' and moinstser = 'ICOL' then 2
                end),
                (case
                 when motipoper = 'CP' then 1
                 when motipoper = 'CI' then 2
                 when motipoper = 'IC' then 0
                 when motipoper = 'VI' and motipopero = 'CP' then 3
                 when motipoper = 'VI' and motipopero = 'CI' then 6
                 when motipoper = 'IB' then 0
                end),
                'a',        -- a=activo, p=pasivo
                '',         -- insreal
                moinstser,  -- instser
                mofecemi,
                mofecpro,
                (case
                 when motipoper = 'CI' or motipoper = 'VI' then mofecvenp
                 else mofecven
                end),
                mofecven,
                space(2),   -- moneda pacto/papel
                motaspact,
                motasemi,
                monominal,  -- ??? valor final
                (case when momonpact <> 13 and momonemi <> 13 then movpresen
                 else round(movpresen * @usd_fin_mes, 2)
                end),
                0.0,
                monominal,
                0,
                (case
                 when motipoper = 'CI' and mocondpacto = '5'  then 'COPA'
                 when motipoper = 'CI' and mocondpacto = '2'  then 'COPB'                 when motipoper = 'CI' and mocondpacto = '4'  then 'COPC'
                 when motipoper = 'CI' and mocondpacto = '1'  then 'COPD'
                 when motipoper = 'CI' and mocondpacto = '6'  then 'CPCR'
                 when motipoper = 'CI' and mocondpacto = '3'  then 'CPDR'
                 when motipoper = 'VI' and mocondpacto = '1'  then 'VEPC'
                 when motipoper = 'VI' and mocondpacto = '15' then 'VEPE'
                 when motipoper = 'VI' and mocondpacto = '5'  then 'VEPF'
                 when motipoper = 'VI' and mocondpacto = '6'  then 'VEPG'
                 when motipoper = 'VI' and mocondpacto = '7'  then 'VEPB'
                 when motipoper = 'VI' and mocondpacto = '16' then 'VEPH'
                 when motipoper = 'VI' and (mocondpacto = '12' or mocondpacto = '2') then 'VEPI'
                 when motipoper = 'VI' and (mocondpacto = '13' or mocondpacto = '3') then 'VEPJ'
                 when motipoper = 'VI' and (mocondpacto = '14' or mocondpacto = '4') then 'VEPD'
                 when motipoper = 'VI' and mocondpacto = '8'  then 'VPHR'
                 when motipoper = 'VI' and mocondpacto = '9'  then 'VPIR'
                 when motipoper = 'VI' and mocondpacto = '10' then 'VPJR'
                 when motipoper = 'VI' and mocondpacto = '11' then 'VPDR'
                 else space(4)
                end),
                (case when motipoper = 'IB' or motipoper = 'IC' then monominal
                 else mocapitali
                end),
                0.0,        -- valor cupon, solo devengamiento
                ' ',        -- tipo empresa 
                (case       -- valor mercado
                 when momonpact <> 13 and momonemi <> 13 then movpresen
   else round(movpresen * @usd_fin_mes, 2)
                end),
                0.0,        -- spread
                (case when substring(moinstser,1,3) = 'PCD' or substring(moinstser,1,3) = 'PTF' then 2 else 1 end),  -- tipo tasa
                (case when substring(moinstser,1,3) = 'PCD' or substring(moinstser,1,3) = 'PTF' then 3 else 0 end),  -- base fluc
                morutcli,
                mocodcli,
                morutemi,
                mocodigo,
                momonemi,
                'm',
                mocorrela,
                (case when isnull(momonpact,0) = 0 then momonemi else momonpact end) 
           from MDMO
          where (MDMO.motipoper = 'CP' or 
                 MDMO.motipoper = 'CI' or 
                 MDMO.motipoper = 'VI' or 
                 MDMO.motipoper = 'IC' or 
                 MDMO.motipoper = 'IB' )
             and MDMO.mostatreg <> 'A'
/* ======================================================================================= */
/* movimientos de forwards (activos - solo seguros de cambio)                              */
/* ======================================================================================= */
insert #RESBAN( fecpro,
                entidad,
                correla,
                codclte,
                codemi,
                operacion,
                cartera,
                tipcar,
                tipocar,
                insreal,
                instser,
                fecemi,
                fecini,
                fecfin,
                fecext,
                moncon,
                tasa,
                tasemis,
                vfinal,
                capps,
                intps,
                nominal,
                pcupon,
                plzo,
                compraor,
                mtocup,
                tipo_emp,
                com_del,
                diferido,
                rut_cliente,
                codigo_rut,
                rut_emisor,
                codigo_instrum,
                moneda_nominal,
                tipo_registro,
                corr_operacion,
                moneda_contable )
         select @fecha_hoy,
                'b',
                canumoper,
                0,            -- codigo cliente
                0,            -- codigo emisor
                0,            -- operacion
                3,            -- cartera
                0,            -- tipo cartera
                'a',          -- activo 
                (case when datediff(day, cafecha, cafecvcto) > 365 then 'futdo+1' else 'futdo-1' end),
                '',           -- serie
                cafecha,
                cafecha,
                cafecvcto,
                cafecvcto,
                '',           -- moneda cont.
                catipcam,
                0.0,          -- tasa emision
                (case         -- vfinal
                 when catipoper = 'C' then caequusd1
                 else                      camtomon2
                end),
                caequmon1, -- capps
                0.0,          -- interes
                (case         -- nominal
                 when catipoper = 'C' then caequusd1
                 when catipoper = 'V' and cacodmon2 = 999 then caequmon1
                 when catipoper = 'V' and cacodmon2 = 998 then camtomon2ini
                end),
                0,            -- cupon
                (case 
                 when catipoper = 'C' then 'CFU'
                 else                      'VFU'
                end),
                camtomon1,    -- compraor
                0.0,          -- valor cupon
                '',           -- tipo empresa
                (case 
                 when catipmoda = 'E' then 'D' 
                 else                      'C'
                end),
             cavalordia,   -- diferido
                cacodigo,
                cacodcli,
                0,
                0,
                (case 
                 when catipoper = 'C' then cacodmon2
                 else                      camdausd
                end),
                'd',
                1,
                (case 
                 when catipoper = 'C' then camdausd
                 else                      cacodmon2
                end)
           from VIEW_MFCA
          where cacodpos1 = 1
            and cafecvcto > @fecha_hoy
/* ======================================================================================= */
/* movimientos de forwards (pasivos - solo seguros de cambio)                              */
/* ======================================================================================= */
insert #RESBAN( fecpro,
                entidad,
                correla,
                codclte,
                codemi,
                operacion,
                cartera,
                tipcar,
                tipocar,
                insreal,
                instser,
                fecemi,
                fecini,
                fecfin,
                fecext,
                moncon,
                tasa,
                tasemis,
                vfinal,
                capps,
                intps,
                nominal,
                pcupon,
                plzo,
                compraor,
                mtocup,
                tipo_emp,
                com_del,
                diferido,
                rut_cliente,
                codigo_rut,
                rut_emisor,
                codigo_instrum,
                moneda_nominal,
                tipo_registro,
                corr_operacion,
                moneda_contable )
         select @fecha_hoy,
                'b',
                canumoper,
                0,            -- codigo cliente
                0,            -- codigo emisor
                0,            -- operacion
                54,           -- cartera
                0,            -- tipo cartera
                'p',          -- activo 
                (case when datediff(day, cafecha, cafecvcto) > 365 then 'futdo+1' else 'futdo-1' end),
                '',           -- serie
                cafecha,
                cafecha,
                cafecvcto,
                cafecvcto,
                '',           -- moneda cont.
                catipcam,
                0.0,          -- tasa emision
                (case 
                 when catipoper = 'C' then camtomon2
                 else                      caequusd1
                end),
                caequmon1,
                0.0,          -- interes
                (case 
                 when catipoper = 'C' and cacodmon2 = 999 then caequmon1
                 when catipoper = 'C' and cacodmon2 = 998 then camtomon2ini
                 else caequusd1
                end),
                0,            -- cupon
                (case 
                 when catipoper = 'C' then 'CFU'
                 else                      'VFU'
                end),
                camtomon1,    -- compraor
                0.0,          -- valor cupon
                '',           -- tipo empresa
                (case 
                 when catipmoda = 'E' then 'D' 
                 else                      'C'
                end),
                cavalordia,   -- diferido
                cacodigo,
                cacodcli,
                0,
                0,
                (case 
                 when catipoper = 'C' then camdausd
                 else                      cacodmon2
                end),
                'd',
                1,
                (case 
                 when catipoper = 'C' then cacodmon2
                 else                      camdausd
                end)
           from VIEW_MFCA
          where cacodpos1 = 1
            and cafecvcto > @fecha_hoy
/* ======================================================================================= */
/* borra del archivos los movimientos sin cartera                                          */
/* ======================================================================================= */
delete #RESBAN 
  from MDCP
 where tipo_registro  = 'M'
   and MDCP.cpnumdocu = #RESBAN.correla
   and MDCP.cpcorrela = #RESBAN.corr_operacion
   and MDCP.cpnominal = 0
update #RESBAN set nominal = cpnominal
  from MDCP
 where tipo_registro  = 'M'
   and MDCP.cpnumdocu = #RESBAN.correla
   and MDCP.cpcorrela = #RESBAN.corr_operacion
/* ======================================================================================= */
/* actualiza archivo con informacion de cliente, emisor y moneda                           */
/* ======================================================================================= */
update #RESBAN set codclte  = VIEW_CLIENTE.clcodfox,
                   tipo_emp = (case VIEW_CLIENTE.clrelacion when 1 then ' ' else 'R' end)
              from VIEW_CLIENTE  VIEW_CLIENTE
             where #RESBAN.rut_cliente = VIEW_CLIENTE.clrut
               and #RESBAN.codigo_rut  = VIEW_CLIENTE.clcodigo
update #RESBAN set codemi = MDEM.emcodigo
              from VIEW_EMISOR MDEM
             where #RESBAN.rut_emisor = MDEM.emrut
update #RESBAN set monnom = VIEW_MONEDA.mncodfox
              from VIEW_MONEDA VIEW_MONEDA
             where #RESBAN.moneda_nominal = VIEW_MONEDA.mncodmon
update #RESBAN set moncon = VIEW_MONEDA.mncodfox
              from VIEW_MONEDA VIEW_MONEDA
             where #RESBAN.moneda_contable = VIEW_MONEDA.mncodmon
/* ======================================================================================= */
/* genera instrumento real                                                                 */
/* ======================================================================================= */
update #RESBAN set dias = datediff(day, fecini, fecfin)
update #RESBAN set insreal = (case
                              when instser = 'ICAP' and moneda_nominal = 999 and dias <= 365                then 'poif-1'
                              when instser = 'ICAP' and moneda_nominal = 999 and dias >  365                then 'poif+1'
                              when instser = 'ICAP' and moneda_nominal = 998 and dias <= 365                then 'poifu-1'
                              when instser = 'ICAP' and moneda_nominal = 998 and dias >  365                then 'poifu+1'
                              when instser = 'ICAP' and moneda_nominal = 994 and dias <= 365                then 'poifdd-1'
                              when instser = 'ICAP' and moneda_nominal = 994 and dias >  365                then 'poifdd+1'
                              when instser = 'ICOL' and moneda_nominal = 999 and dias <= 365                then 'ptmoifp-1'
                              when instser = 'ICOL' and moneda_nominal = 999 and dias >  365                then 'ptmoifp+1'
                              when instser = 'ICOL' and moneda_nominal = 998 and dias <= 365                then 'ptmoiff-1'
                              when instser = 'ICOL' and moneda_nominal = 998 and dias >  365                then 'ptmoiff+1'
                              when instser = 'ICOL' and moneda_nominal = 994 and dias <= 365                then 'ptmoifd-1'
                              when instser = 'ICOL' and moneda_nominal = 994 and dias >  365                then 'ptmoifd+1'
                              when instser = 'CAP'  and moneda_nominal = 999 and dias <  30                 then 'cap1$$'
                              when instser = 'CAP'  and moneda_nominal = 999 and dias >= 30 and dias <= 89  then 'cap2$$'
                              when instser = 'CAP'  and moneda_nominal = 999 and dias >= 90 and dias <= 365 then 'cap3$$'
                              when instser = 'CAP'  and moneda_nominal = 999 and dias >  365                then 'cap4$$'
                              when instser = 'CAP'  and moneda_nominal = 998 and dias <  30                 then 'cap1uf'
                              when instser = 'CAP'  and moneda_nominal = 998 and dias >= 30 and dias <= 89  then 'cap2uf'
                              when instser = 'CAP'  and moneda_nominal = 998 and dias >= 90 and dias <= 365 then 'cap3uf'
                              when instser = 'CAP'  and moneda_nominal = 998 and dias >  365                then 'cap4uf'
                              when instser = 'CAP'  and moneda_nominal = 994 and dias <  30                 then 'cap1do'
                              when instser = 'CAP'  and moneda_nominal = 994 and dias >= 30 and dias <= 89  then 'cap2do'
                              when instser = 'CAP'  and moneda_nominal = 994 and dias >= 90 and dias <= 365 then 'cap3do'
                              when instser = 'CAP'  and moneda_nominal = 994 and dias >  365                then 'cap4do'
                              when instser = 'CAP'  and moneda_nominal =  13 and dias <  30                 then 'cap1dd'
                              when instser = 'CAP'  and moneda_nominal =  13 and dias >= 30 and dias <= 89  then 'cap2dd'
                              when instser = 'CAP'  and moneda_nominal =  13 and dias >= 90 and dias <= 365 then 'cap3dd'
                              when instser = 'CAP'  and moneda_nominal =  13 and dias >  365                then 'cap4dd'
                              else mdin.inserie
                             end)
              from VIEW_INSTRUMENTO MDIN
             where codigo_instrum *= MDIN.incodigo
               and plzo <> 'CFU'  
               and plzo <> 'VFU'
update #RESBAN set instser = (case
                              when substring(insreal,1,3) = 'CAP'  then insreal
                              when substring(insreal,1,4) = 'POIF' then insreal
                              when substring(insreal,1,4) = 'PTMO' then insreal
                              else instser
                             end)
             where plzo <> 'CFU'  
               and plzo <> 'VFU'
/* ======================================================================================= */
/* envia informacion                                                                       */
/* ======================================================================================= */
select @regs = count(*) from #RESBAN
set nocount off
select @regs, 
       convert(char(10),fecpro,103),
       entidad,
       correla,
       codclte,
       codemi,
       operacion,
       cartera,
       tipcar,
       tipocar,
       insreal,
       instser,
       convert(char(10),fecemi,103),
       convert(char(10),fecini,103),
       convert(char(10),fecfin,103),
       convert(char(10),fecext,103),
       moncon,
       tasa,
       tasemis,
       vfinal,
       capps,
       intps,
       nominal,
       pcupon,
       plzo,
       compraor,
       mtocup,
       tipo_emp,
       com_del,
       monnom,
       valmerc,
       diferido,
       spread,
       tipo_tasa,
       base_fluc
  from #RESBAN
 order by correla
return 0
end   /* fin procedimiento */
--select * from VIEW_CLIENTE
--select * from lgrupo
--select * from MDMO
--select * from MDRS
--select * from view_mfca
--sp_genera_resban '20000226'
GO
