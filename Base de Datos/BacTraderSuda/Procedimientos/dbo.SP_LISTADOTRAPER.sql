USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOTRAPER]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_LISTADOTRAPER]
   (@clave   char(1)='',
    @entidad numeric(9)=0)
 
as
begin
 
 declare @acfecproc char(10),
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
            @acfecproc   OUTPUT,
            @acfecprox   OUTPUT,
            @uf_hoy      OUTPUT,
            @uf_man      OUTPUT,
            @ivp_hoy     OUTPUT,
           @ivp_man     OUTPUT,
            @do_hoy      OUTPUT,
           @do_man      OUTPUT,
            @da_hoy      OUTPUT,
            @da_man      OUTPUT,
            @acnomprop   OUTPUT,
            @rut_empresa OUTPUT,
            @hora        OUTPUT
if exists (select 1 from MDAC,MDDI,VIEW_CLIENTE,VIEW_ENTIDAD MDRC,VIEW_EMISOR MDEM,
    VIEW_MONEDA,VIEW_TABLA_GENERAL_DETALLE,VIEW_INSTRUMENTO
  where  (MDDI.codigo_carterasuper=@clave or @clave='')
  and  (MDDI.dirutcart=@entidad or @entidad=0)
  )  
begin
         select   'acfecproc' = convert(char(10),@acfecproc,103),
                  'acfecprox'  =convert(char(10),@acfecprox,103),
           'uf_hoy' =@uf_hoy,
           'uf_man' =@uf_man,
           'ivp_hoy' =@ivp_hoy,
           'ivp_man' =@ivp_man,
           'do_hoy' =@do_hoy,
           'do_man' =@do_man,
           'da_hoy' =@da_hoy,
    'da_man' =@da_man,
    'acnomprop' =@acnomprop,
           'rut_empresa' =@rut_empresa,
    'hora' =@hora,
    'rcnombre' =rcnombre,
    'numero' =rsnumdocu ,
    'correla' =rscorrela,
    'serie' =rsinstser,
    'emisor' =(select emnombre from MDEM where emrut = rsrutemis),
    'fecemi' =convert(char(10),rsfecemis,103) ,
    'fecvenc' =convert(char(10),rsfecvcto,103),
    'tasaemi' =rstasemi,
    'baseemi' =rsbasemi,
    'moneda' =(select mnnemo from VIEW_MONEDA where rsmonemi = mncodmon),
    'nominal' =rsnominal,
    'tir'  =rstir ,
    '%'  =rsvpcomp,
    'valor_pres' =rsinteres + rsreajuste +rsvppresen ,
    'familia' =(select inserie from MDIN where rscodigo = incodigo),
    'hora' =convert(varchar(10),getdate(),108)    
           from MDRS ,VIEW_CLIENTE,VIEW_ENTIDAD,MDDI,MDAC,VIEW_MONEDA,VIEW_TABLA_GENERAL_DETALLE,VIEW_INSTRUMENTO,VIEW_FORMA_DE_PAGO,MDRC
    where (rsnumdocu=dinumdocu)
  and (MDDI.codigo_carterasuper=@clave or @clave='')
  and (rstipcart = @entidad or @entidad = 0) 
  
  
end else begin
 select    'acfecproc' =@acfecproc,
                  'acfecprox' =@acfecprox,
           'uf_hoy' =@uf_hoy,
           'uf_man' =@uf_man,
           'ivp_hoy' =@ivp_hoy,
           'ivp_man' =@ivp_man,
           'do_hoy' =@do_hoy,
           'do_man' =@do_man,
           'da_hoy' =@da_hoy,
    'da_man' =@da_man,
    'acnomprop' =@acnomprop,
           'rut_empresa' =@rut_empresa,
    'rcnombre' =rcnombre,
    'numero' =0 ,
    'correla' =0,
    'serie' ='',
    'emisor' ='',
    'fecemi' ='',
    'fecvenc' =  '',
    'tasaemi' = '',
    'baseemi' = '',
    'moneda' = '',
    'nominal' = 0,
    'tir'  = 0,
    '%'  = 0,
    'valor_pres' = 0 ,
    'familia' = 0,
    'hora' = ''    
    from MDRS ,VIEW_CLIENTE,VIEW_ENTIDAD,MDDI,MDAC,VIEW_MONEDA,VIEW_TABLA_GENERAL_DETALLE,VIEW_INSTRUMENTO,VIEW_FORMA_DE_PAGO
    where (MDDI.codigo_carterasuper=@clave or @clave='')
   and (rstipcart = @entidad or @entidad = 0) 
   and (rsnumdocu=dinumdocu)
 
           end
end


GO
