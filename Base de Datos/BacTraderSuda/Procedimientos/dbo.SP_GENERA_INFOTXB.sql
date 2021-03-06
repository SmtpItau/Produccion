USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_INFOTXB]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_genera_infotxb    fecha de la secuencia de comandos: 05/04/2001 13:13:26 ******/
CREATE PROCEDURE [dbo].[SP_GENERA_INFOTXB]
            ( @fecha_hoy datetime )
as
begin
      
      set nocount on
declare @regs integer 
create table #INFOTXB( entidad          char(1)     null default '',
                       correla          numeric(10) null default 0 ,
                       operacion        numeric(10) null default 0 ,
                       codclte          numeric(10) null default 0 ,
                       codemi           numeric(10) null default 0 ,
                       instrum          char(10)    null default '',
                       serie            char(6)     null default '',
                       monpac           char(2)     null default '',
                       nominal          float       null default 0 ,
                       compraps         float       null default 0 ,
                       fcompra          datetime    null default '',
                       fpacto           datetime    null default '',
                       fvcto            datetime    null default '',
                       tasaac           float       null default 0 ,
                       cartera          numeric(2)  null default 0 ,
                       tipcar           numeric(2)  null default 0 ,
                       insreal          char(10)    null default '',
                       moncon           char(2)     null default '',
                       tasaop           float       null default 0 ,
                       plzo             char(5)     null default '',
                       codtx            char(3)     null default '',
                       nominfi          char(1)     null default '',
                       tasemis          float       null default 0 ,
                       vfinal           float       null default 0 ,
                       monnom           char(2)     null default '',
                       tipocar          char(1)     null default '',
                       vfinpac          float       null default 0 ,
                       spread           float       null default 0 ,  
                       tipo_tasa        numeric(1)  null default 0 ,  
                       base_fluc        numeric(1)  null default 0 ,  
                       fpagpa           char(6)     null default '',
                       fpagre           char(6)     null default '',
                       rut_cliente      numeric(10) null default 0 ,
                       codigo_rut       numeric(10) null default 0 ,
                       rut_emisor       numeric(10) null default 0 ,
                       codigo_instrum   numeric(3)  null default 0 ,
                       moneda_pacto     numeric(5)  null default 0 ,
                       moneda_contable  numeric(5)  null default 0 ,
                       moneda_nominal   numeric(5)  null default 0 ,
                       dias             numeric(6)  null default 0 ,
                       pago_inicio      numeric(4)  null default 0 ,
                       pago_vcto        numeric(4)  null default 0 )
/* ======================================================================================= */
/* movimientos de renta fija                                                               */
/* ======================================================================================= */
insert #INFOTXB( codtx,
                 entidad,
                 correla,
                 operacion,
                 codclte,
                 codemi,
                 instrum,
                 serie,
                 monpac,
                 nominal,
                 compraps,
                 fcompra,
                 fpacto,
                 fvcto,
                 tasaac,
                 cartera,
                 tipcar,
                 insreal,
                 moncon,
                 tasaop,
                 plzo,
                 nominfi,
                 tasemis,
                 vfinal,
                 monnom, 
                 tipocar,
                 vfinpac,
                 spread,
                 tipo_tasa,
                 base_fluc,
                 rut_cliente,
                 codigo_rut,
                 rut_emisor,
                 codigo_instrum,
                 moneda_pacto,
                 moneda_nominal,
                 moneda_contable,
                 pago_inicio,
                 pago_vcto )
          select (case
                  when motipoper = 'CP'  then 'COM' 
                  when motipoper = 'CI'  then 'COP' 
                  when motipoper = 'VP'  then 'VED' 
                  when motipoper = 'VI' and motipopero = 'CP' then 'VEP'
                  when motipoper = 'VI' and motipopero = 'CI' then 'VEC'
                  when motipoper = 'RC'  then 'RCA' 
                  when motipoper = 'RV'  then 'RVA' 
                  when motipoper = 'RCA' then 'RCN' 
                  when motipoper = 'RVA' then 'RVN' 
                  when motipoper = 'IC'  then 'CAP' 
                  when motipoper = 'IB' and moinstser = 'ICAP' then 'ING'
                  when motipoper = 'IB' and moinstser = 'ICOL' then 'PRE'
                 end),
                 'B',
                 monumoper,
                 monumdocuo,
                 0,               -- codigo cliente
                 0,               -- codigo emisor
                 moinstser,
                 '',              -- ??? serie
                 '',              -- moneda pacto
                 monominal,
                 movpresen,
                 mofecpro,
                 mofecpro,
                 (case 
                  when motipoper = 'CP' or motipoper = 'VP' then mofecven
                  else mofecvenp 
                 end),
                 motaspact,             -- tasa captacion
                 (case 
                  when motipoper = 'CP' then 1
                  when motipoper = 'CI' then 2
                  when motipoper = 'VI' then 51
                  when motipoper = 'IC' then 55
                  when motipoper = 'IB' and moinstser = 'ICAP' then 55
                  when motipoper = 'IB' and moinstser = 'ICOL' then 2
                 end),
                 (case
                  when motipoper = 'CP' then 1
                  when motipoper = 'CI' then 2
                  when motipoper = 'IC' then 0
                  when motipoper = 'VI' and motipopero = 'CP' then 4
                  when motipoper = 'VI' and motipopero = 'CI' then 5
                  when motipoper = 'IB' then 0
                 end),
                 '',              -- instrum. real
                 '',              -- moneda cont.
                 motir,
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
                 (case when moseriado = 'N' then 'V' else 'N' end), -- nominal final
                 motasemi,        -- tasa emision
                 (case when motipoper = 'CI' or motipoper = 'VI' then movalvenp
                  else                                                monominal
                 end),            -- valor final
                 '',              -- moneda nominal
                 'a',             -- tipo cartera 
                 movalvenp,       -- vfinpac
                 0.0,             -- spread
                 (case when substring(moinstser,1,3) = 'PCD' or substring(moinstser,1,3) = 'PTF' then 2 else 1 end),  -- tipo tasa
                 (case when substring(moinstser,1,3) = 'PCD' or substring(moinstser,1,3) = 'PTF' then 3 else 0 end),  -- base fluc
                 morutcli,
                 mocodcli,
                 morutemi,
                 mocodigo,
                 momonpact,
                 momonemi,
                 (case when isnull(momonpact,0) = 0 then momonemi else momonpact end),
                 moforpagi,
                 moforpagv
            from MDMO
           where MDMO.mofecpro   = @fecha_hoy
             and MDMO.mostatreg <> 'A'
             and (MDMO.motipoper = 'CP' or 
                  MDMO.motipoper = 'CI' or 
                  MDMO.motipoper = 'VI' or 
                  MDMO.motipoper = 'IC' or
                  MDMO.motipoper = 'IB' )
/* ======================================================================================= */
/* movimientos de forwards (activos - solo seguros de cambio)                              */
/* ======================================================================================= */
insert #INFOTXB( codtx,
                 entidad,
                 correla,
                 operacion,
                 codclte,
                 codemi,
                 instrum,
                 serie,
                 monpac,
                 nominal,
                 compraps,
                 fcompra,
                 fpacto,
                 fvcto,
                 tasaac,
                 cartera,
                 tipcar,
                 insreal,
                 moncon,
                 tasaop,
                 plzo,
                 nominfi,
                 tasemis,
                 vfinal,
                 monnom, 
                 tipocar,
                 rut_cliente,
                 codigo_rut,
                 rut_emisor,
                 codigo_instrum,
                 moneda_pacto,
                 moneda_nominal,
                 moneda_contable )
          select (case 
                  when motipoper = 'C' then 'CFU' 
                  else                      'VFU' 
                 end),
                 'B',
                 monumoper,
                 0,               -- operacion
                 0,               -- codigo cliente
                 0,               -- codigo emisor
                 (case when datediff(day, mofecha, mofecvcto) > 365 then 'futdo+1' else 'futdo-1' end),
                 '',              -- ??? serie
                 '',              -- moneda pacto
                 (case 
                  when motipoper = 'C' then momtomon1
                  else                      moequmon1
                 end),
                 moequmon1,       -- compra ps
                 mofecha,
                 mofecha,
                 mofecvcto,
                 motipcam,        -- tasa act.
                 3,               -- cartera
                 0,               -- tipo cartera
   (case when datediff(day, mofecha, mofecvcto) > 365 then 'futdo+1' else 'futdo-1' end),
                 '',              -- moneda cont.
                 motipcam,        -- tasa operacion
                 (case 
                  when motipoper = 'C' then 'CFU'
                  else                      'VFU'
                 end),
                 '',              -- nominal final
                 0.0,             -- tasa emision
                 (case 
                  when motipoper = 'C' then momtomon1
                  else                      moequmon1
                 end),
                 '',              -- moneda nominal
                 'a',
                 mocodigo,
                 mocodcli,
                 0,               -- rut emisor
                 0,               -- codigo instrumento
                 0,               -- moneda pacto
                 (case 
                  when motipoper = 'C' then mocodmon2
                  else                      mocodmon1
                 end),
                 (case 
                  when motipoper = 'C' then mocodmon1
                  else                      mocodmon2
                 end)
            from VIEW_MFMO
           where mocodpos1 = 1
/* ======================================================================================= */
/* movimientos de forwards (pasivos - solo seguros de cambio)                              */
/* ======================================================================================= */
insert #INFOTXB( codtx,
                 entidad,
                 correla,
                 operacion,
                 codclte,
                 codemi,
                 instrum,
                 serie,
                 monpac,
                 nominal,
                 compraps,
                 fcompra,
                 fpacto,
                 fvcto,
                 tasaac,
                 cartera,
                 tipcar,
                 insreal,
                 moncon,
                 tasaop,
                 plzo,
                 nominfi,
                 tasemis,
                 vfinal,
                 monnom, 
                 tipocar,
                 rut_cliente,
                 codigo_rut,
                 rut_emisor,
                 codigo_instrum,
                 moneda_pacto,
                 moneda_nominal,
                 moneda_contable )
          select (case 
                  when motipoper = 'C' then 'CFU' 
                  else                      'VFU' 
                 end),
                 'b',
                 monumoper,
                 0,
                 0,               -- codigo cliente
                 0,               -- codigo emisor
                 (case when datediff(day, mofecha, mofecvcto) > 365 then 'futdo+1' else 'futdo-1' end),
                 '',              -- ??? serie
                 '',              -- moneda pacto
                 (case 
                  when motipoper = 'V' then momtomon1
                  else                      moequmon1
                 end),
                 moequmon1,       -- compra ps
                 mofecha,
                 mofecha,
                 mofecvcto,
                 motipcam,        -- tasa act.
                 54,              -- cartera
                 0,               -- tipo cartera
                 (case when datediff(day, mofecha, mofecvcto) > 365 then 'futdo+1' else 'futdo-1' end),
                 '',              -- moneda cont.
                 motipcam,        -- tasa operacion
                 (case 
                  when motipoper = 'C' then 'CFU'
                  else                      'VFU'
                 end),
                 '',              -- nominal final
                 0.0,             -- tasa emision
                 (case 
                  when motipoper = 'C' then momtomon1
                else                      moequmon1
                 end),
                 '',              -- moneda nominal
                 'p',
                 mocodigo,
                 mocodcli,
                 0,               -- rut emisor
                 0,               -- codigo instrumento
                 0,               -- moneda pacto
                 (case 
                  when motipoper = 'C' then mocodmon1
                  else                      mocodmon2
                 end),
                 (case 
                  when motipoper = 'C' then mocodmon2
                  else                      mocodmon1
                 end)
            from VIEW_MFMO
           where mocodpos1 = 1
/* ======================================================================================= */
/* actualiza archivo con informacion de cliente, emisor, moneda y forma de pago            */
/* ======================================================================================= */
update #INFOTXB set codclte = VIEW_CLIENTE.clcodfox
               from VIEW_CLIENTE  VIEW_CLIENTE
              where #INFOTXB.rut_cliente = VIEW_CLIENTE.clrut
                and #INFOTXB.codigo_rut  = VIEW_CLIENTE.clcodigo
update #INFOTXB set codemi = MDEM.emcodigo
               from VIEW_EMISOR MDEM
              where #INFOTXB.rut_emisor = MDEM.emrut
update #INFOTXB set monpac = VIEW_MONEDA.mncodfox
               from VIEW_MONEDA VIEW_MONEDA
              where #INFOTXB.moneda_pacto = VIEW_MONEDA.mncodmon
update #INFOTXB set moncon = VIEW_MONEDA.mncodfox
               from VIEW_MONEDA VIEW_MONEDA
              where #INFOTXB.moneda_contable = VIEW_MONEDA.mncodmon
update #INFOTXB set monnom = VIEW_MONEDA.mncodfox
               from VIEW_MONEDA VIEW_MONEDA
              where #INFOTXB.moneda_nominal = VIEW_MONEDA.mncodmon
update #INFOTXB set fpagpa = MDFP.perfil
               from VIEW_FORMA_DE_PAGO MDFP
              where #INFOTXB.pago_inicio = MDFP.codigo
update #INFOTXB set fpagre = MDFP.perfil
               from VIEW_FORMA_DE_PAGO MDFP
              where #INFOTXB.pago_vcto = MDFP.codigo
/* ======================================================================================= */
/* genera instrumento real                                                                 */
/* ======================================================================================= */
update #INFOTXB set dias = datediff(day, fpacto, fvcto)
update #INFOTXB set insreal = (case
                               when instrum = 'ICAP' and moneda_nominal = 999 and dias <= 365                then 'poif-1'
                               when instrum = 'ICAP' and moneda_nominal = 999 and dias >  365                then 'poif+1'
                               when instrum = 'ICAP' and moneda_nominal = 998 and dias <= 365                then 'poifu-1'
                               when instrum = 'ICAP' and moneda_nominal = 998 and dias >  365                then 'poifu+1'
                               when instrum = 'ICAP' and moneda_nominal = 994 and dias <= 365                then 'poifdd-1'
                               when instrum = 'ICAP' and moneda_nominal = 994 and dias >  365                then 'poifdd+1'
                               when instrum = 'ICOL' and moneda_nominal = 999 and dias <= 365                then 'ptmoifp-1'
                               when instrum = 'ICOL' and moneda_nominal = 999 and dias >  365                then 'ptmoifp+1'
                               when instrum = 'ICOL' and moneda_nominal = 998 and dias <= 365                then 'ptmoiff-1'
                               when instrum = 'ICOL' and moneda_nominal = 998 and dias >  365                then 'ptmoiff+1'
                               when instrum = 'ICOL' and moneda_nominal = 994 and dias <= 365                then 'ptmoifd-1'
                               when instrum = 'ICOL' and moneda_nominal = 994 and dias >  365                then 'ptmoifd+1'
                               when instrum = 'CAP'  and moneda_nominal = 999 and dias <  30          then 'cap1$$'
                               when instrum = 'CAP'  and moneda_nominal = 999 and dias >= 30 and dias <= 89  then 'cap2$$'
                               when instrum = 'CAP'  and moneda_nominal = 999 and dias >= 90 and dias <= 365 then 'cap3$$'
                               when instrum = 'CAP'  and moneda_nominal = 999 and dias >  365                then 'cap4$$'
                               when instrum = 'CAP'  and moneda_nominal = 998 and dias <  30                 then 'cap1uf'
                               when instrum = 'CAP'  and moneda_nominal = 998 and dias >= 30 and dias <= 89  then 'cap2uf'
                               when instrum = 'CAP'  and moneda_nominal = 998 and dias >= 90 and dias <= 365 then 'cap3uf'
                               when instrum = 'CAP'  and moneda_nominal = 998 and dias >  365                then 'cap4uf'
                               when instrum = 'CAP'  and moneda_nominal = 994 and dias <  30                 then 'cap1do'
                               when instrum = 'CAP'  and moneda_nominal = 994 and dias >= 30 and dias <= 89  then 'cap2do'
                               when instrum = 'CAP'  and moneda_nominal = 994 and dias >= 90 and dias <= 365 then 'cap3do'
                               when instrum = 'CAP'  and moneda_nominal = 994 and dias >  365                then 'cap4do'
                               when instrum = 'CAP'  and moneda_nominal =  13 and dias <  30                 then 'cap1dd'
                               when instrum = 'CAP'  and moneda_nominal =  13 and dias >= 30 and dias <= 89  then 'cap2dd'
                               when instrum = 'CAP'  and moneda_nominal =  13 and dias >= 90 and dias <= 365 then 'cap3dd'
                               when instrum = 'CAP'  and moneda_nominal =  13 and dias >  365                then 'cap4dd'
                               else mdin.inserie
                              end)
               from 
                --  REQ. 7619
                VIEW_INSTRUMENTO MDIN  LEFT OUTER JOIN #INFOTXB ON  codigo_instrum = MDIN.incodigo
              where /*codigo_instrum *= MDIN.incodigo
              and*/ plzo <> 'CFU'  
                and plzo <> 'VFU'
update #INFOTXB set instrum = (case
                               when substring(insreal,1,3) = 'CAP'  then insreal
                               when substring(insreal,1,4) = 'POIF' then insreal
                               when substring(insreal,1,4) = 'PTMO' then insreal
                               else instrum
                              end),
                    serie = substring(insreal,1,6)
              where plzo <> 'CFU'  
                and plzo <> 'VFU'
/* ======================================================================================= */
/* envia informacion                                                                       */
/* ======================================================================================= */
select @regs = count(*) from #infotxb
set nocount off
select @regs, 
       entidad,
       correla,
       operacion,
       codclte,
       codemi,
       instrum,
       serie,
       monpac,
       nominal,
       compraps,
       convert(char(10), fcompra, 103),
       convert(char(10), fpacto, 103),
       convert(char(10), fvcto, 103),
       tasaac,
       cartera,
       tipcar,
       insreal,
       moncon,
       tasaop,
       plzo,
       codtx,
       nominfi,
       tasemis,
       vfinal,
       monnom,
       tipocar,
       vfinpac,
       spread,
       tipo_tasa,
       base_fluc,
       fpagpa,
       fpagre
  from #INFOTXB
return 0
end   /* fin procedimiento */
--select * from VIEW_CLIENTE
--select * from lgrupo
--select * from MDMO
--select * from MDRS
--select * from view_mfmo
--sp_genera_infotxb '20001002'


GO
