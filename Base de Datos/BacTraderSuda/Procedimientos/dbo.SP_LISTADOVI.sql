USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOVI]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_LISTADOVI]
       (   @entidad numeric(9) )
as
begin
 declare @ncartini numeric(10,0)
 declare @ncartfin numeric(10,0)
 
 select @ncartini  = @entidad 
 select @ncartfin  = case @entidad when 0 then 999999999 else @entidad end
     select  
               'nomcli' = isnull( c.clnombre , ''),
                'noment' = isnull( r.rcnombre , ''),
  'tipcart' = isnull( t.tbglosa,''), 
               'numdocu' = isnull(rtrim(convert(char(10),a.monumdocu))+'-'+convert(char(3),a.mocorrela),''),
                'instrumento' = isnull( a.moinstser, ''),                       
               'emisor' = isnull( e.emgeneric, ''),                       
               'fecemi' = isnull( convert(char(10), a.mofecemi, 103), ''),
               'fecven' = isnull( convert(char(10), a.mofecven, 103), ''),
               'tasemi' = isnull( a.motasemi, 0),
               'basemi' = isnull( a.mobasemi, 0),
           'moneda' = isnull( m1.mnnemo, ''), 
  'nominal' = isnull( a.monominal,0.0),                                                            
                'tirventa' = isnull( a.motir,  0.0),                                                              
               'pvp'  = isnull( a.mopvp, 0.0),                                                               
               'tasest' = convert(float,a.motasest),                                                     
               'valorventa' = isnull( a.movpresen, 0.0),
               'fecinip' = isnull( convert ( char(10), a.mofecinip, 103), '' ),                                 
               'fecvtop' = isnull( convert ( char(10), a.mofecvenp, 103), '' ),                                 
               'tasapact' = isnull( a.motaspact, 0),                                                             
               'basepact' = isnull( a.mobaspact, 0),                                                             
             'monpacto' = isnull( m2.mnnemo, ''),                                                               
               'valinip' = isnull( a.movalinip, 0),                                                             
                'valorven' = isnull( a.movalvenp, 0),                                                             
               'forpagoini' = isnull( p1.glosa, '') ,                                                               
               'forpagoven' = isnull( p2.glosa, '') ,                                                               
  'familia' = isnull( i.inserie,''),
  'numoper' = isnull( a.monumoper,0)
 FROM   
  MDMO a RIGHT OUTER JOIN VIEW_EMISOR e ON e.emrut = a.morutemi  
		 RIGHT OUTER JOIN  VIEW_MONEDA  m1 ON m1.mncodmon = a.momonemi ,
  VIEW_CLIENTE c, 
  VIEW_ENTIDAD r, 
  VIEW_INSTRUMENTO i,
  VIEW_FORMA_DE_PAGO p1,
  VIEW_FORMA_DE_PAGO p2,
  BACPARAMSUDA..TABLA_GENERAL_DETALLE t,
  VIEW_MONEDA  m2
 WHERE  
		 a.motipoper = 'VI' 
 and	 a.mostatreg <> 'a'
 and     r.rcrut     = a.morutcart
 and	(c.clrut     = a.morutcli 
 and     c.clcodigo  = a.mocodcli)
 
 and     i.incodigo  = a.mocodigo  
 and     (t.tbcateg  = 204 
 and     convert(numeric(6),t.tbcodigo1)  = a.motipcart )
 
 and	 m2.mncodmon  = a.momonpact
 and     p1.codigo    = a.moforpagi
 and     p2.codigo    = a.moforpagv
 and     (a.morutcart >= @ncartini
 and     a.morutcart <= @ncartfin)

-- REQ.7619 CASS 25-01-2011
-- from   
--  MDMO a, 
--  VIEW_CLIENTE c, 
--  VIEW_ENTIDAD r, 
--  VIEW_EMISOR e, 
--  VIEW_INSTRUMENTO i,
--  VIEW_FORMA_DE_PAGO p1,
--  VIEW_FORMA_DE_PAGO p2,
--  MDTC t,
--  VIEW_MONEDA  m1,
--  VIEW_MONEDA  m2
--        where  
--  a.motipoper = 'VI' 
-- and  a.mostatreg <> 'a'
-- and    r.rcrut    = a.morutcart
-- and (c.clrut    = a.morutcli 
-- and    c.clcodigo  = a.mocodcli)
-- and     e.emrut=*a.morutemi  
-- and     i.incodigo = a.mocodigo  
-- and     (t.tbcateg  = 204        
-- and     convert(numeric(6),t.tbcodigo1)  = a.motipcart )
-- and     m1.mncodmon  =* a.momonemi
-- and m2.mncodmon  = a.momonpact
-- and     p1.codigo    = a.moforpagi
-- and     p2.codigo    = a.moforpagv
-- and     (a.morutcart >= @ncartini
-- and     a.morutcart <= @ncartfin)
end


GO
