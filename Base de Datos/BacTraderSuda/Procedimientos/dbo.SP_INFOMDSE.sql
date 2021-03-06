USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFOMDSE]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFOMDSE] ( @cserie char(12))
  
as
begin
    set nocount on
 declare @codigo  numeric(5,0)
        declare @mdtd    char(1)
        declare @mdpr    char(1)
     -----------------------------------------------------------------------    
     -- verificar si la serie tiene tabla de premio o tabla de desarrollo
     -----------------------------------------------------------------------
 select @codigo = secodigo
        from   VIEW_SERIE
        where  semascara = @cserie
 select       @mdtd = isnull(inmdtd, '' ),
                     @mdpr = isnull(inmdpr, '' )
               from  VIEW_INSTRUMENTO
        where incodigo = @codigo
 if @mdtd = 'S' begin
          select  'nomemp'     = isnull(c.acnomprop, ''),
                'rutemp'     = isnull( ( rtrim (convert( char(9),c.acrutprop ) ) + '-' + c.acdigprop ),'' ),
                'fecpro'     = convert(char(10),c.acfecproc, 103),
                'mascara'    = isnull( d.inserie, ''),
                'desmascara' = d.inglosa,
                'serie'      = isnull(a.seserie, ''),
                       'tera'       = isnull(a.setera,0),
         'monemi'     = isnull(a.semonemi,0),
         'desmonemi'  = f.mnglosa,
                'basemi'     = isnull(a.sebasemi,0),
                'rutemi'     = rtrim(convert(char(09),e.emrut)) + '-' + e.emdv,
                'nomemi'     = e.emnombre,
                'fecemi'     = isnull( convert(char(10),a.sefecemi, 103 ), ''),
                'fecvcto'    = isnull(convert(char(10),a.sefecven, 103 ), ''),
                'plazo'      = isnull(a.seplazo,0),
                'tasemi'     = isnull(a.setasemi, 0),           
                'cupones'    = isnull(a.secupones,0),
         'perivc'     = isnull(a.sepervcup,0),
                       'mtocorte'   = isnull(a.secorte,0),
                'numamort'   = isnull(a.senumamort,0),  
                'nidec'      = isnull(a.sedecs,0),
                'diavcup'    = isnull(a.sediavcup,0),
         'moncort'    = isnull(a.sebascup,0),
                'tipamort'   = g.tbglosa,                       
                'cupon'      = isnull(convert(float,b.tdcupon),0),          
                'fecven'     = isnull( convert( char(10),b.tdfecven, 103), ''),
                'interes'    = isnull(convert(float,b.tdinteres),0),
                'amort'      = isnull(convert(float,b.tdamort),0),
                'flujo'      = isnull(convert(float,b.tdflujo),0),     
                       'saldo'      = isnull(convert(float,b.tdsaldo),0),
         'despervcup' = 0
         from    VIEW_SERIE a, 
   VIEW_TABLA_DESARROLLO b, 
   MDAC c, 
   VIEW_INSTRUMENTO d, 
   VIEW_EMISOR e, 
   VIEW_MONEDA  f, 
   VIEW_TABLA_GENERAL_DETALLE g
         where  a.semascara = @cserie         and
                b.tdmascara = @cserie         and
                       d.incodigo  = a.secodigo   and
                       e.emrut     = a.serutemi   and
                       f.mncodmon  = a.semonemi   and
                       g.tbcateg   = 212              and 
                       convert(numeric(6),g.tbcodigo1)  = a.setipamort
        end else if @mdpr ='s' begin
         select  'nomemp'     = isnull( c.acnomprop, ''),
                'rutemp'     = isnull( ( rtrim (convert( char(9), c.acrutprop ) ) + '-' + c.acdigprop ),'' ),
                'fecpro'     = convert(char(10),c.acfecproc, 103),
                'mascara'    = isnull( d.inserie, ''),
                'desmascara' = d.inglosa,
                'serie'      = isnull(a.seserie, ''),
                       'tera'       = isnull(a.setera,0),
         'monemi'     = isnull(a.semonemi,0),
         'desmonemi'  = f.mnglosa,
                'basemi'     = isnull( a.sebasemi,0),
                'rutemi'     = rtrim(convert(char(09),e.emrut)) + '-' + e.emdv,
                'nomemi'     = e.emnombre,
                'fecemi'     = isnull( convert(char(10),a.sefecemi, 103 ), ''),
                'fecvcto'    = isnull(convert(char(10),a.sefecven, 103 ), ''),
                'plazo'      = isnull(a.seplazo,0),
                'tasemi'     = isnull(a.setasemi, 0),           
                'cupones'    = isnull(a.secupones,0),
         'perivc'     = isnull(a.sepervcup,0),
                       'mtocorte'   = isnull(a.secorte,0),
                'numamort'   = isnull(a.senumamort,0),  
                'nidec'      = isnull(a.sedecs,0),
                'diavcup'    = isnull(a.sediavcup,0),
                       'moncort'    = isnull(a.sebascup,0),
                'tipamort'   = g.tbglosa,
                'cupon'      = isnull(convert(float,b.tdcupon),0),          
                'fecven'     = isnull( convert( char(10),b.tdfecven, 103), ''),
                'interes'    = isnull(convert(float,b.tdinteres),0),
                'amort'      = isnull(convert(float,b.tdamort),0),
                'flujo'      = isnull(convert(float,b.tdflujo),0),     
                       'saldo'      = isnull(convert(float,b.tdsaldo),0),
                'despervcup' = 0
         from    VIEW_SERIE a, 
   VIEW_TABLA_DESARROLLO b, 
   MDAC c, 
   VIEW_INSTRUMENTO d, 
   VIEW_EMISOR e, 
   VIEW_MONEDA  f, 
   VIEW_TABLA_GENERAL_DETALLE g
         where  a.semascara = @cserie         and
                b.tdmascara = @cserie         and
                       d.incodigo  = a.secodigo   and
                       e.emrut     = a.serutemi   and
                       f.mncodmon  = a.semonemi   and
                       g.tbcateg   = 212              and 
                       convert(numeric(6),g.tbcodigo1)  = a.setipamort
             end   
     set nocount off
end
--sp_infomdse 'prc-sss'
--sp_infomdse '0'


GO
