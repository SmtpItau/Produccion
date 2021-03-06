USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOVCTOPACT]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_listadovctopact    fecha de la secuencia de comandos: 05/04/2001 13:13:39 ******/
CREATE PROCEDURE [dbo].[SP_LISTADOVCTOPACT]
                                 ( @dfecdesde datetime, 
                                 @dfechasta datetime,
     @entidad   numeric(09,0) )
as
begin
set nocount on
       select 'nomemp'     = isnull( MDAC.acnomprop, ''),                                                                       
              'rutemp'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
              'fecpro'     = convert(char(10), MDAC.acfecproc, 103),
              'fecdesde'   = convert(char(10), @dfecdesde, 103),
              'fechasta'   = convert(char(10), @dfechasta, 103),
              'numdoc'     = isnull( MDCI.cinumdocu, 0),
              'rutcart'    = isnull( MDCI.cirutcart, 0),
              'correla'    = isnull( MDCI.cicorrela, 0),
              'numdocu'    = rtrim(convert(char(10),isnull( MDCI.cinumdocu, 0))) +'-'+ convert(char(3),isnull( MDCI.cicorrela, 0)),
              'tipoper'    = 'CI',
              'serie'      = isnull(  MDCI.ciinstser, ''),
       'monemi'     = isnull( VIEW_MONEDA.mnnemo,''),
              'fecinip'    = convert( char(10), MDCI.cifecinip, 103 ),
              'fecvenp'    = convert( char(10), MDCI.cifecvenp, 103 ),
              'taspact'    = isnull( MDCI.citaspact, 0 ),
              'baspact'    = isnull( MDCI.cibaspact, 0 ),
              'monpact'    = space(05),
              'codmon'     = MDCI.cimonpact,
              'nominal'    = isnull( MDCI.cinominal, 0 ),
              'valinip'    = isnull( MDCI.civalinip, 0 ),
              'valvenp'    = isnull( MDCI.civalvenp, 0 ),
              'interes'    = case cimonpact when 999 then round(isnull( MDCI.civalvenp, 0 ) - isnull( MDCI.civalinip, 0 ),0)
         else isnull( MDCI.civalvenp, 0 ) - isnull( MDCI.civalcomu,0 )
         end,
       'entidad'    = MDRC.rcnombre,
       'valinipum'  = case cimonpact when 999 then isnull( MDCI.civalinip, 0 )
         else  isnull( MDCI.civalcomu,0 )
         end
       into   #TEMP1
       from   MDAC
        --  REQ. 7619  
            , MDCI   LEFT OUTER JOIN  VIEW_MONEDA ON cimonemi = VIEW_MONEDA.mncodmon
            , VIEW_ENTIDAD MDRC
        --  REQ. 7619
--            , VIEW_MONEDA
       where  
      (@entidad=0 or MDCI.cirutcart = @entidad )
       and    MDCI.cifecvenp >= @dfecdesde
       and    MDCI.cifecvenp <= @dfechasta
       and    MDCI.cirutcart = MDRC.rcrut
       and   (MDCI.ciinstser <> 'ICAP'  and MDCI.ciinstser <> 'ICOL' )
       --  REQ. 7619  
--       and   cimonemi     *= VIEW_MONEDA.mncodmon
       order by MDCI.cinumdocu,
                MDCI.cicorrela

     ---------------------------------------------------
     -- seleccionamos todos los campos de la tabla MDVI
     ---------------------------------------------------
       select 'nomemp'     = isnull( MDAC.acnomprop, ''),                                                                       
              'rutemp'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),               
              'fecpro'     = convert(char(10), MDAC.acfecproc, 103),                                                            
              'fecdesde'   = convert(char(10), @dfecdesde, 103),
              'fechasta'   = convert(char(10), @dfechasta, 103),
              'numdoc'     = isnull( MDVI.vinumdocu, 0),
              'rutcart'    = isnull( MDVI.virutcart, 0),
              'correla'    = isnull( MDVI.vicorrela, 0),
              'numdocu'    = rtrim(convert(char(10),isnull( MDVI.vinumdocu, 0))) +'-'+ convert(char(03),isnull( MDVI.vicorrela, 0)), 
              'tipoper'    = 'VI',
              'serie'      = MDVI.viinstser,
          'monemi'     = isnull(VIEW_MONEDA.mnnemo,''),
              'fecinip'    = convert(char(10),MDVI.vifecinip,103),
              'fecvenp'    = convert(char(10),MDVI.vifecvenp,103),
              'taspact'    = isnull(MDVI.vitaspact,0),
              'baspact'    = isnull(MDVI.vibaspact,0),
              'monpact'    = space(05),
              'codmon'     = MDVI.vimonpact,
              'nominal'    = isnull( MDVI.vinominal, 0 ),
              'valinip'    = isnull( MDVI.vivalinip, 0 ),
              'valvenp'    = isnull( MDVI.vivalvenp, 0 ),
              'interes'    = case vimonpact when 999  then round(isnull( MDVI.vivalvenp, 0 )- MDVI.vivalinip ,0)
       else round(isnull( MDVI.vivalvenp, 0 )- round(MDVI.vivalinip / isnull( VIEW_VALOR_MONEDA.vmvalor,1),4),4)
       end,
       'entidad'    = MDRC.rcnombre,
       'valinipum'  = case vimonpact when 999  then round(MDVI.vivalinip ,0)
       else round(MDVI.vivalinip / isnull(VIEW_VALOR_MONEDA.vmvalor,1),4)
       end
       into   #TEMP2
       from   MDAC
       --  REQ. 7619   
            , MDVI LEFT OUTER JOIN VIEW_VALOR_MONEDA ON MDVI.vifecinip = VIEW_VALOR_MONEDA.vmfecha
                                                    and MDVI.vimonpact = VIEW_VALOR_MONEDA.vmcodigo
                   LEFT OUTER JOIN VIEW_MONEDA ON MDVI.vimonemi = mncodmon         
 
            , VIEW_ENTIDAD MDRC
       --  REQ. 7619  
--            , VIEW_VALOR_MONEDA 
--            , VIEW_MONEDA
       where  MDVI.vifecvenp >= @dfecdesde
       and    MDVI.vifecvenp <= @dfechasta
       and (@entidad=0 or MDVI.virutcart = @entidad )
       and    MDVI.virutcart = MDRC.rcrut
      --  REQ. 7619  
/*
       and MDVI.vifecinip *= VIEW_VALOR_MONEDA.vmfecha
       and MDVI.vimonpact *= VIEW_VALOR_MONEDA.vmcodigo
       and MDVI.vimonemi  *= mncodmon
*/
       order by MDVI.vinumdocu,
                MDVI.vicorrela

    ------------------------------------------------------
    --        actualizamos nemotécnico de moneda        --
    ------------------------------------------------------
      update #TEMP1 set monpact = isnull(VIEW_MONEDA.mnnemo,'')
      from   #TEMP1, VIEW_MONEDA 
      where  #TEMP1.codmon = VIEW_MONEDA.mncodmon
      update #TEMP2 set monpact = isnull(VIEW_MONEDA.mnnemo,'')
      from   #TEMP2, VIEW_MONEDA 
      where  #TEMP2.codmon = VIEW_MONEDA.mncodmon
    ------------------------------------------------------
    -- traspasamos registros de la tabla temporal 2
    -- y de la tabla temporal 3 a la temporal 1
    ------------------------------------------------------
      insert into #TEMP1 select #TEMP2.nomemp  ,
                                #TEMP2.rutemp  ,
                                #TEMP2.fecpro  ,
                                #TEMP2.fecdesde,
                                #TEMP2.fechasta,
    #TEMP2.numdoc,
    #TEMP2.rutcart,
    #TEMP2.correla,
                                #TEMP2.numdocu ,
                                #TEMP2.tipoper ,
                                #TEMP2.serie   ,
    #TEMP2.monemi  ,
                                #TEMP2.fecinip ,
                                #TEMP2.fecvenp ,
                                #TEMP2.taspact ,
                                #TEMP2.baspact ,
                                #TEMP2.monpact ,
    #TEMP2.codmon,
                                #TEMP2.nominal ,
                                #TEMP2.valinip ,
                                #TEMP2.valvenp ,
                                #TEMP2.interes ,
    #TEMP2.entidad ,
    #TEMP2.valinipum
    
                         from   #TEMP2
                         order by #TEMP2.tipoper,
                                  #TEMP2.numdoc ,
                                  #TEMP2.correla
       select entidad,
              rutemp,
              fecpro,
              fecdesde,
              fechasta,
              numdocu,
              serie,
              fecinip,
              fecvenp,
              taspact,
              baspact,
              monpact,
              tipoper,
              nominal,
              valinip,
              valvenp,
              interes,
       valinipum,
       monemi
       from   #TEMP1 order by tipoper,fecvenp,monpact
set nocount off
end
/*
sp_listadovctopact '01/01/2000', '10/02/2000', 0
*/




GO
