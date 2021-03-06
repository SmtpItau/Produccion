USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOIB]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_LISTADOIB]
             (@entidad numeric(9))
as
begin
 declare @ncartini numeric(10,0)
 declare @ncartfin numeric(10,0)
 
 select @ncartini  = @entidad 
 select @ncartfin  = case @entidad when 0 then 999999999 else @entidad end
 select 
   'nomemp' = isnull(acnomprop,'')       ,
   'rutemp' = isnull(rtrim(convert(char(9),acrutprop))+'-'+acdigprop,'')  ,
   'fecpro' = isnull(convert(char(10),acfecproc,103),'')    ,
   'nomcli' = isnull(clnombre,'')       ,
   'nomemp' = isnull(rcnombre,'')       ,
   'glosa'  = tbglosa         ,
   'numoper' = isnull(monumoper,0)       ,
   'instrumento' = case moinstser when 'ICOL' then 'COL' else 'CAP'  end   ,
   'plazo'  = convert(numeric(4,0),datediff(dd,mofecemi,mofecven))   ,
   'fecven' = isnull(convert(char(10),mofecven,103),'')    ,
   'moneda' = isnull(mnnemo,'')       ,
   'base'  = convert(numeric(3,0),mobaspact)      ,
   'valor'  = 0, --case momonemi when 999 then 1 else vmvalor end   ,
   'valinicial' = convert(numeric(19,4),movalinip)     ,
   'tasapacto' = convert(numeric(09,4),motaspact)     ,
   'valfinal' = convert(numeric(19,4),movalvenp)     ,
   'glosa_pago' = VIEW_FORMA_DE_PAGO.glosa        ,
   'tippago' = case mopagohoy when 'N' then 'PAGO MAYANA' else '' end  ,
   'serie'  = isnull(inserie,'')
  from 
   MDAC, 
   MDMO, 
   VIEW_MONEDA , 
   VIEW_ENTIDAD MDRC, 
   VIEW_CLIENTE, 
   VIEW_INSTRUMENTO,
   VIEW_TABLA_GENERAL_DETALLE,
   VIEW_FORMA_DE_PAGO  
  -- VIEW_VALOR_MONEDA
  where 
   motipoper = 'IB' 
  and mostatreg = ' '
  and MDRC.rcrut      = MDMO.morutcart
                and  momonpact = mncodmon 
                and  (morutcli = clrut 
                and  mocodcli = clcodigo )
--         and  momonemi = vmcodigo  
--  and  vmfecha  = MDAC.acfecproc
                and  mocodigo = incodigo
                and  tbcateg  = 204 
                and  convert(numeric(6),tbcodigo1) = motipcart
                and  VIEW_FORMA_DE_PAGO.codigo = moforpagv
  and     (MDMO.morutcart >= @ncartini
  and     MDMO.morutcart <= @ncartfin)
  order by 
   monumoper 
end


GO
