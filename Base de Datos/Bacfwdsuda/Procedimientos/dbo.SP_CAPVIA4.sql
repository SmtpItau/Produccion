USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAPVIA4]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CAPVIA4] ( @dfecha   CHAR    ( 8 ) ,
                                  @nrutapo1 NUMERIC ( 9 ),
                                  @nrutapo2 NUMERIC ( 9 )
                                )
AS
BEGIN
SET NOCOUNT ON
   DECLARE @cfecpro    CHAR ( 10 )
   DECLARE @cfecha     CHAR ( 10 )
   DECLARE @cnomprop   CHAR ( 60 )
   DECLARE @ncodclie   NUMERIC ( 9 )
   DECLARE @nrutprop   NUMERIC ( 9 )
   DECLARE @cdigprop   CHAR ( 1 )
   DECLARE @ncodcominf NUMERIC ( 3 )
   DECLARE @ap1nombre  CHAR ( 40 )    
   DECLARE @ap1cargo   CHAR ( 40 )    
   DECLARE @ap1fono    CHAR ( 15 )    
   DECLARE @ap2nombre  CHAR ( 40 )    
   DECLARE @ap2cargo   CHAR ( 40 )    
   DECLARE @ap2fono    CHAR ( 15 )    
   DECLARE @codpais    INT
   DECLARE @cuenta     NUMERIC (19,0)   
   SELECT @cfecpro    = CONVERT( CHAR( 10 ), acfecproc, 103 ), 
          @cfecha     = CONVERT( CHAR(10), convert(datetime,@dfecha), 103 )  ,
          @cnomprop   = acnomprop                            ,
          @ncodclie   = accodbcch                            ,
          @nrutprop   = acrutprop                            ,
          @cdigprop   = acdigprop                            ,
          @ncodcominf = 81
   FROM   MFAC
   SELECT @codpais = 6          -- Segun tabla Mdtc.tbcateg = 180
   /*=======================================================================*/
   /* Selecciona los Apoderados          */ 
   /*=======================================================================*/
   SELECT @ap1nombre = a.apnombre,
          @ap1cargo  = a.apcargo ,
          @ap1fono   = a.apfono
   FROM   VIEW_CLIENTE_APODERADO a,
		  MFAC b
   WHERE  @nrutapo1   = a.aprutapo
   AND    b.acrutprop = a.aprutcli
   SELECT @ap2nombre = a.apnombre,
          @ap2cargo  = a.apcargo ,
          @ap2fono   = a.apfono
   FROM   VIEW_CLIENTE_APODERADO a,
          MFAC b
   WHERE  @nrutapo2   = a.aprutapo
   AND    b.acrutprop = a.aprutcli
   /*=======================================================================*/
   /* llena los datos desde la Cartera         */ 
   /*=======================================================================*/
   SELECT 'FecPro'   = @cfecpro                                                       ,
          'FecInfo'  = @cfecha                                                        ,
          'Status'   = 'I'                                                            ,
          'nomprop'  = @cnomprop                                                      ,
          'codclie'  = @ncodclie                                                      ,
          'rutprop'  = @nrutprop                                                      ,
          'digprop'  = @cdigprop													  ,
          'codcominf'= @ncodcominf                                                    ,
          'NomCli'   = b.clnombre                                                     ,
          'CodPais'  = b.clpais                                                       ,
          'NomPais'  = ISNULL(e.tbglosa,'')                                           ,
          'NumOpe'   = a.canumoper                                                    ,
          'FecIni'   = CONVERT(CHAR(10),a.cafecha  ,103)                              ,
          'FecTer'   = CONVERT(CHAR(10),a.cafecvcto,103)                              ,
          'Plazo'    = a.caplazo                                                      ,
          'Modal'    = a.catipmoda                                                    ,
          'CodInst'  = 1                                                              ,
          'Instrumento'= 'Forward'                                                      ,
          'CpaCodMon'  = case a.catipoper when 'C' then a.cacodmon1 else a.cacodmon2 End,
          'CpaNemMon'  = case a.catipoper when 'C' then c.mnglosa   else d.mnglosa   End,
          'CpaMonto'   = case a.catipoper when 'C' then a.camtomon1 else a.camtomon2 End,
          'VtaCodMon'  = case a.catipoper when 'V' then a.cacodmon1 else a.cacodmon2 End,
          'VtaNemMon'  = case a.catipoper when 'V' then c.mnglosa   else d.mnglosa   End,
          'VtaMonto'   = case a.catipoper when 'V' then a.camtomon1 else a.camtomon2 End,
          'Prima'      = 0                                                              ,
          'PreFut'     = CASE a.cacodpos1 WHEN 1 THEN a.caprecal ELSE a.caparmon2 END   ,
--        'PreSpot'    = CASE a.cacodpos1 WHEN 1 THEN a.catcspot ELSE           0 END
          'PreSpot'    = CONVERT(FLOAT,0)                                               ,
          'Apodera1'   = ISNULL( @ap1nombre , '' )                                      ,
          'Cargo1'     = ISNULL( @ap1cargo  , '' )                                      ,
          'Fono1'      = ISNULL( @ap1fono   , '' )                                      ,
          'Apodera2'   = ISNULL( @ap2nombre , '' )                                      ,
          'Cargo2'     = ISNULL( @ap2cargo  , '' )                                      ,
          'Fono2'      = ISNULL( @ap2fono   , '' )										,
          'Contador'   = 0 ,
          'CanPag'     = 0
   INTO   #temp
   -- RQ 7619
   FROM   MFCA a  ,
          VIEW_CLIENTE b RIGHT OUTER JOIN VIEW_TABLA_GENERAL_DETALLE e ON CONVERT(INT,e.tbcodigo1) = b.clpais ,
		  VIEW_MONEDA c,
          VIEW_MONEDA d
          --VIEW_TABLA_GENERAL_DETALLE e       -- Tabla de Paises
   WHERE  SUBSTRING ( CONVERT ( CHAR ( 10 ), a.cafecha, 103 ), 1, 6 )  = SUBSTRING ( @cFecha, 1, 6 )
     AND  a.catipoper  IN ( 'C', 'V' )                
     AND  a.cacodpos1  IN ( 1, 2, 3 )
     AND  (a.cacodigo   = b.clrut                     
     AND  a.cacodcli    = b.clcodigo)  --     AND  b.cltipcli    = 6 )                         
     AND  a.cacodmon1   = c.mncodmon                  
     AND  a.cacodmon2   = d.mncodmon                  
     AND  b.clpais     <> @codpais    -- discrimina mercado local
     AND  e.tbcateg     = 180
     --AND  CONVERT(INT,e.tbcodigo1) =* b.clpais 

                 
   INSERT INTO #temp
   SELECT 'FecPro'      = @cfecpro                                                       ,
          'FecInfo'     = @cfecha                                                        ,
          'Status'      = 'I'                                                            ,
          'nomprop'     = @cnomprop                                                      ,
          'codclie'     = @ncodclie                                                      ,
          'rutprop'     = @nrutprop                                                      ,
          'digprop'     = @cdigprop                                                      ,
          'codcominf'   = @ncodcominf                                                    ,
          'NomCli'      = b.clnombre                                                     ,
          'CodPais'     = b.clpais                                                       ,
          'NomPais'     = ISNULL(e.tbglosa,'')                                           ,
          'NumOpe'      = a.canumoper                                                    ,
          'FecIni'      = CONVERT(CHAR(10),a.cafecha  ,103)                              ,
          'FecTer'      = CONVERT(CHAR(10),a.cafecvcto,103)                              ,
          'Plazo'       = a.caplazo                                                      ,
          'Modal'       = a.catipmoda                                                    ,
          'CodInst'     = 1                                                              ,
          'Instrumento' = 'Forward'                                                      ,
          'CpaCodMon'   = case a.catipoper when 'C' then a.cacodmon1 else a.cacodmon2 End,
          'CpaNemMon'   = case a.catipoper when 'C' then c.mnglosa   else d.mnglosa   End,
          'CpaMonto'    = case a.catipoper when 'C' then a.camtomon1 else a.camtomon2 End,
          'VtaCodMon'   = case a.catipoper when 'V' then a.cacodmon1 else a.cacodmon2 End,
          'VtaNemMon'   = case a.catipoper when 'V' then c.mnglosa   else d.mnglosa   End,
          'VtaMonto'    = case a.catipoper when 'V' then a.camtomon1 else a.camtomon2 End,
          'Prima'       = 0                                                              ,
          'PreFut'      = CASE a.cacodpos1 WHEN  1  THEN a.caprecal  ELSE a.caparmon2 END,
--        'PreSpot'     = CASE a.cacodpos1 WHEN 1 THEN a.catcspot ELSE           0 END   ,
          'PreSpot'     = CONVERT(FLOAT,0)                                               ,
          'Apodera1'    = ISNULL( @ap1nombre , '' )                                      ,
          'Cargo1'      = ISNULL( @ap1cargo  , '' )                                      ,
          'Fono1'       = ISNULL( @ap1fono   , '' )                                      ,
          'Apodera2'    = ISNULL( @ap2nombre , '' )                                      ,
          'Cargo2'      = ISNULL( @ap2cargo  , '' )                                      ,
          'Fono2'       = ISNULL( @ap2fono   , '' ),
          'Contador'    = 0 ,
          'CanPag'      = 0
   
   -- RQ 7619
   FROM   MFCAH           a,
          VIEW_CLIENTE b RIGHT OUTER JOIN VIEW_TABLA_GENERAL_DETALLE e  ON CONVERT(INT,e.tbcodigo1) = b.clpais,
          VIEW_MONEDA c,
          VIEW_MONEDA d
          --VIEW_TABLA_GENERAL_DETALLE e       -- Tabla de Paises
   WHERE  SUBSTRING ( CONVERT ( CHAR ( 10 ), a.cafecha, 103 ), 1, 6 )  = SUBSTRING ( @cFecha, 1, 6 )
     AND  a.catipoper  IN ( 'C', 'V' )                
     AND  a.cacodpos1  IN ( 1, 2, 3 )
     AND  (a.cacodigo   = b.clrut                     
     AND  a.cacodcli    = b.clcodigo)     --     AND  b.cltipcli    = 6 )                         
     AND  a.cacodmon1   = c.mncodmon                  
     AND  a.cacodmon2   = d.mncodmon                  
     AND  b.clpais     <> @codpais    -- discrimina mercado local
     AND  e.tbcateg     = 180                          
     --AND  CONVERT(INT,e.tbcodigo1) =* b.clpais                  
 /*=======================================================================*/
--   Modificaaciones para ese dia
 /*=======================================================================*/
   INSERT INTO #temp
   SELECT 'FecPro'      = @cfecpro														 ,
          'FecInfo'     = @cfecha                                                        ,
          'Status'      = 'M'                                                            ,
          'nomprop'     = @cnomprop                                                      ,
          'codclie'     = @ncodclie                                                      ,
          'rutprop'     = @nrutprop                                                      ,
          'digprop'     = @cdigprop                                                      ,
          'codcominf'   = @ncodcominf                                                    ,
          'NomCli'      = b.clnombre                                                     ,
          'CodPais'     = b.clpais                                                       ,
          'NomPais'     = ISNULL(f.tbglosa,'')                                           ,
          'NumOpe'      = a.canumoper                                                    ,
          'FecIni'      = CONVERT(CHAR(10),a.cafecha  ,103)                              ,
          'FecTer'      = CONVERT(CHAR(10),a.cafecvcto,103)                              ,
          'Plazo'       = case a.caplazo when e.caplazo then 0 else e.caplazo    end     ,
          'Modal'       = Case a.catipmoda when e.catipmoda then ' ' else e.catipmoda end     ,
          'CodInst'     = 1                                                              ,
          'Instrumento' = 'Forward'                                                      ,
          'CpaCodMon'       = case a.catipoper when e.catipoper then 0 else  case a.catipoper when  'C' then a.cacodmon1 else a.cacodmon2 End End    ,
          'CpaNemMon'       = case a.catipoper when 'C' then
                                  case a.cacodmon1 when e.cacodmon1 then ' ' else c.mnnemo  End
                              Else
                                  case a.cacodmon2 when e.cacodmon2 then ' ' else d.mnnemo End
                              End     ,
          'CpaMonto'        = case a.catipoper when 'C' then
                                   case a.camtomon1 when e.camtomon1 then  0 else a.camtomon1 End
                              Else
                                   case a.camtomon2 when e.camtomon2 then  0 else a.camtomon2 End
                              End ,
          'VtaCodMon'       = Case a.catipoper when 'V' then
                                   case  a.cacodmon1 when e.cacodmon1 then 0 else a.cacodmon1 End
                              Else
                                   case  a.cacodmon2 when e.cacodmon2 then 0 else a.cacodmon2 End
                              End,
          'VtaNemMon'       = Case a.catipoper when 'V' then
                                   case  a.cacodmon1 when e.cacodmon1 then ' ' else  c.mnnemo  End
                              Else
                                   case  a.cacodmon2 when e.cacodmon2 then ' ' else  d.mnnemo  End
                              End ,
          'VtaMonto'        = Case a.catipoper when 'V' then
                                   case  a.camtomon1 when e.camtomon1 then 0 else a.camtomon1 End
                              Else
                                   case  a.camtomon2 when e.camtomon2 then 0 else a.camtomon2 End
                              End ,
          'Prima'       = 0                                                              ,
          'PreFut'      = CASE a.cacodpos1 WHEN  1  THEN a.caprecal  ELSE a.caparmon2 END,
--        'PreSpot'     = CASE a.cacodpos1 WHEN 1 THEN a.catcspot ELSE           0 END   ,
          'PreSpot'     = CONVERT(FLOAT,0)                                               ,
          'Apodera1'    = ISNULL( @ap1nombre , '' )                                      ,
          'Cargo1'      = ISNULL( @ap1cargo  , '' )                                      ,
          'Fono1'       = ISNULL( @ap1fono   , '' )                                      ,
          'Apodera2'    = ISNULL( @ap2nombre , '' )                                      ,
          'Cargo2'      = ISNULL( @ap2cargo  , '' )                                      ,
          'Fono2'       = ISNULL( @ap2fono   , '' ),
          'Contador'    = 0 ,
          'CanPag'      = 0
   --RQ 7619
   FROM   MFCA_LOG      a,
          VIEW_CLIENTE  b RIGHT OUTER JOIN VIEW_TABLA_GENERAL_DETALLE f ON CONVERT(INT,f.tbcodigo1) = b.clpais,
          VIEW_MONEDA   c,
          VIEW_MONEDA   d,
          MFCA          e
         -- VIEW_TABLA_GENERAL_DETALLE f       -- Tabla de Paises
   WHERE SUBSTRING(CONVERT(CHAR(10),a.cafecmod,103),1,6) = SUBSTRING(@cFecha,1,6)
     AND NOT EXISTS( select * from #temp where #temp.NumOpe = a.canumoper)
     AND  a.catipoper  IN ( 'C', 'V' )
     AND  a.cacodpos1  IN ( 1, 2, 3 )
     AND  (a.cacodigo   = b.clrut                     
     AND  a.cacodcli    = b.clcodigo)     --     AND  b.cltipcli    = 6 )                         
     AND  a.cacodmon1   = c.mncodmon                  
     AND  a.cacodmon2   = d.mncodmon                  
     AND  b.clpais     <> @codpais    -- discrimina mercado local
     AND  f.tbcateg     = 180
     --AND  CONVERT(INT,f.tbcodigo1) =* b.clpais

   ---- Temporal hasta leer Circular 711 del 19.05.2000 , avisar a COyarzo
   UPDATE #temp SET PreSpot = vmvalor
                FROM VIEW_VALOR_MONEDA 
                WHERE vmfecha  = @cFecha
                AND vmcodigo = 994 
    
    Select @cuenta = 1  
    While (1=1) Begin
       If not Exists (Select * from #temp Where contador=0 ) Begin
          Break 
       End
       Set Rowcount 15
       Update #temp set contador=@cuenta Where Contador =0
       Set Rowcount 0
       Select @cuenta =@cuenta +1
     END
    UPDATE #temp set CanPag=@cuenta -1
   SELECT * FROM #temp
SET NOCOUNT OFF
END

GO
