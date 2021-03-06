USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOVCTOPAP]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_LISTADOVCTOPAP]
                              ( @dfecdesde datetime , 
                                @dfechasta datetime  ,
								@entidad   numeric(09,0))
as
begin
      
 select 
  'nomemp'     = isnull( MDRC.rcnombre,''),
               'rutemp'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
               'fecpro'     = convert( char(10), MDAC.acfecproc, 103),
               'fecdesde'   = convert( char(10), @dfecdesde, 103 ),
               'fechasta'   = convert( char(10), @dfechasta, 103 ),
               'rutcart'    = isnull( MDCP.cprutcart,0),
               'numdoc'     = isnull( MDCP.cpnumdocu,0),       
        'codser'     = isnull( MDCP.cpcodigo, 0),
       'familia'    = space(12),
  'largo_util' = 0,
          'correla'    = isnull( MDCP.cpcorrela, 0),
               'numdocu'    = rtrim ( convert(char(10), isnull( MDCP.cpnumdocu, 0))) + '-' + convert(char(3), isnull( MDCP.cpcorrela, 0) ),
               'serie'      = isnull( MDCP.cpinstser, ''),
               'seriado'    = convert(char(01), MDCP.cpseriado),
               'fecemi'     = isnull( convert(char(10), MDCP.cpfecemi, 103), ''),
               'fecven'     = isnull( convert(char(10), MDCP.cpfecven, 103), ''),
               'tasemi'     = convert( float, 0 ),
               'basemi'     = convert( numeric(5,0),0),
               'monemi'     = space(05),
               'codmon'     = 0,
               'nominal'    = convert( float, isnull( MDCP.cpnominal, 0) ),
               'tir'        = convert( float, isnull( MDCP.cptircomp, 0) ),
               'pvp'        = convert( float, isnull( MDCP.cppvpcomp, 0) ),
               'mtocom'     = convert( float, isnull( MDCP.cpvalcomp, 0) ),
               'vpproc'     = convert( float, isnull( MDCP.cpvptirc,  0) ),
  'entidad'    = MDRC.rcnombre
 into   
  #TEMP1
 from   
  MDAC ,
  MDCP ,
  VIEW_ENTIDAD MDRC
 where  
  MDCP.cpfecven >= @dfecdesde
 and MDCP.cpfecven <= @dfechasta
 and MDCP.cprutcart = MDRC.rcrut
 and    (@entidad=0 or MDCP.cprutcart = @entidad )
  
 order by 
  MDCP.cpnumdocu , 
  MDCP.cpcorrela
 update #TEMP1
 set   familia = VIEW_INSTRUMENTO.inserie
 from  #TEMP1, VIEW_INSTRUMENTO
 where #TEMP1.codser = VIEW_INSTRUMENTO.incodigo
 update #TEMP1
 set   largo_util = datalength(VIEW_MASCARA_INSTRUMENTO.msmascara)
 from  #TEMP1, VIEW_MASCARA_INSTRUMENTO
 where #TEMP1.familia = VIEW_MASCARA_INSTRUMENTO.msfamilia     
 select largo_util from #TEMP1
   /*================================================================================== 
       cuando es seriado
       actualizamos datos de la tabla de temporal con los datos de serie
   ==================================================================================*/
       update #TEMP1 set
              fecemi     = convert( char(10), VIEW_SERIE.sefecemi, 103),
              fecven     = convert( char(10), VIEW_SERIE.sefecven, 103),  
              tasemi     = isnull( VIEW_SERIE.setasemi, 0 ),
              basemi     = isnull( VIEW_SERIE.sebasemi, 0 ),
              monemi     = '', 
              codmon     = VIEW_SERIE.semonemi
       from   VIEW_SERIE
       where  seriado    = 'S'
       and    substring(serie,1,#TEMP1.largo_util) = VIEW_SERIE.seserie
   /*================================================================================== 
       cuando no es seriado   
       datos de VIEW_NOSERIE
   ==================================================================================*/
       update #TEMP1 set
              fecemi     = convert( char(10), VIEW_NOSERIE.nsfecemi, 103 ),
              fecven     = convert( char(10), VIEW_NOSERIE.nsfecven, 103 ),  
              tasemi     = isnull( VIEW_NOSERIE.nstasemi, 0 ),
              basemi     = isnull( VIEW_NOSERIE.nsbasemi, 0 ),
              monemi     = '',
              codmon     = VIEW_NOSERIE.nsmonemi
       from   VIEW_NOSERIE
       where  seriado <> 'S'
       and    rutcart        = VIEW_NOSERIE.nsrutcart
       and    numdoc         = VIEW_NOSERIE.nsnumdocu 
       and    correla        = VIEW_NOSERIE.nscorrela
   ------------------------------------------------------------
   -- actualizamos gentrico de la moneda                     --
   ------------------------------------------------------------ 
  
       update #TEMP1 set monemi = isnull(VIEW_MONEDA.mnnemo,'')
       from VIEW_MONEDA
       where VIEW_MONEDA.mncodmon = #TEMP1.codmon
       
       select nomemp,
               rutemp,
               fecpro,
               fecdesde,
               fechasta,
               numdocu,
               serie,
               fecemi,
               fecven,
               tasemi,
               basemi,
               monemi,
               nominal,
               tir,
               pvp,
               mtocom,
               vpproc
       from   #TEMP1
                                
end


GO
