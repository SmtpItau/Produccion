USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOVP]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_listadovp    fecha de la secuencia de comandos: 05/04/2001 13:13:40 ******/
CREATE PROCEDURE [dbo].[SP_LISTADOVP]
               (@entidad  numeric(9))
as 
begin
set nocount on
 declare @ncartini  numeric(10,0)
 declare @ncartfin numeric(10,0) 
 declare @numero  integer
 select @ncartini  = @entidad 
 select @ncartfin  = case @entidad when 0 then 999999999 else @entidad end
 
        select  
                'nomcli' = isnull( VIEW_CLIENTE.clnombre , ''),
                'noment' = isnull( MDRC.rcnombre, ''),
                'tipcart' = isnull( VIEW_TABLA_GENERAL_DETALLE.tbglosa, ''),
                'numdocu' = isnull(rtrim(convert(char(10),MDMO.monumdocuo))+'-'+convert(char(3),MDMO.mocorrelao),''),
                'instser' = isnull( MDMO.moinstser,''), 
                'emisor' = isnull( MDEM.emgeneric,''),
                'fecemi' = isnull( convert(char(10), MDMO.mofecemi, 103), ''),  
                'fecven' = isnull( convert(char(10), MDMO.mofecven, 103), ''),
                'tasemi' = isnull( MDMO.motasemi, 0),
                'baseemi' = isnull( MDMO.mobasemi, 0),
                'moneda' = isnull( VIEW_MONEDA .mnnemo,''),
                'nominal' = isnull( MDMO.monominal,0),
                'tirvta' = isnull( MDMO.motir,  0),
                'valpar' = isnull( MDMO.mopvp, 0),
                'tasest' = isnull( MDMO.motasest, 0),
                'valpresen' = isnull( MDMO.movpresen, 0),
                'valventa' = isnull( MDMO.movalven, 0),
                'utilidad' = convert( float, case MDMO.moutilidad when 0 then (MDMO.moperdida*-1) else MDMO.moutilidad end),
                'forpago' = isnull( VIEW_FORMA_DE_PAGO.glosa, ''),
                'tipcust' = isnull( MDMO.mocondpacto, ''),
                'paghoy' = isnull( MDMO.mopagohoy, ''),
                'serie'  = isnull( VIEW_INSTRUMENTO.inserie, ''),
                'numoper' = isnull( MDMO.monumoper,0)
       from  --  REQ. 7619  
        MDMO LEFT OUTER JOIN VIEW_EMISOR MDEM ON MDMO.morutemi = MDEM.emrut
             LEFT OUTER JOIN VIEW_MONEDA ON MDMO.momonemi= VIEW_MONEDA.mncodmon  ,
      --MDAC , 
      --  VIEW_EMISOR MDEM , 
      --  VIEW_MONEDA , 
        VIEW_INSTRUMENTO ,
        VIEW_ENTIDAD MDRC ,
        VIEW_CLIENTE ,
        VIEW_FORMA_DE_PAGO ,
        VIEW_TABLA_GENERAL_DETALLE
      where   
          MDMO.motipoper = 'VP' 
      and MDMO.mostatreg <> 'A' 
      and MDRC.rcrut     = MDMO.morutcart
      and (VIEW_CLIENTE.clrut    = MDMO.morutcli
      and VIEW_CLIENTE.clcodigo  = MDMO.mocodcli)
--  REQ. 7619
--      and MDMO.morutemi*= MDEM.emrut
--      and MDMO.momonemi*= VIEW_MONEDA.mncodmon
      and VIEW_INSTRUMENTO.incodigo  = MDMO.mocodigo
      and VIEW_FORMA_DE_PAGO.codigo    = MDMO.moforpagi
      and VIEW_TABLA_GENERAL_DETALLE.tbcateg  = 204 
      and MDMO.motipcart = convert(numeric(6),VIEW_TABLA_GENERAL_DETALLE.tbcodigo1)
      and (MDMO.morutcart >= @ncartini
      and MDMO.morutcart <= @ncartfin)
     order by MDMO.monumoper, MDMO.monumdocu
set nocount off
end


GO
