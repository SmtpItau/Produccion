USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFTASAMER]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFTASAMER]
  as
  begin     
        select 'nomemp'      = isnull( MDAC.acnomprop, ''),
               'rutemp'      = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
               'fecpro'      = convert(char(10), MDAC.acfecproc, 103),
               'codfam'      =MDTM.tmcodigo ,
               'familia'     = VIEW_INSTRUMENTO.inserie    ,
               'desfamilia'  = VIEW_INSTRUMENTO.inglosa    ,
               'serie'       =MDTM.tmserie    ,
               'valor'       =MDTM.tmtir
        into   #TEMP1
        from   MDAC, VIEW_INSTRUMENTO,MDTM
        where MDTM.tmcodigo  = VIEW_INSTRUMENTO.incodigo
         
 select  nomemp,
  rutemp,
  fecpro,
  familia,
  desfamilia,
  serie,
  valor
 from  #TEMP1
end


GO
