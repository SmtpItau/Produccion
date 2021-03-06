USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAP6ANEXO2]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CAP6ANEXO2]( @dfecha   CHAR    ( 8 ) ,
									@nrutapo1 FLOAT			,
									@nrutapo2 FLOAT
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
   DECLARE @cuenta     NUMERIC (2,0)   
   SELECT @cfecpro    = CONVERT( CHAR( 10 ), acfecproc, 103 ), 
          @cfecha     = CONVERT( CHAR(10), convert(datetime,@dfecha), 103 )  ,
          @cnomprop   = acnomprop                            ,
          @ncodclie   = accodbcch                            ,
          @nrutprop   = acrutprop                            ,
          @cdigprop   = acdigprop                            ,
          @ncodcominf = 81
   FROM   MFAC
   SELECT @codpais = acpais 
   FROM   mfac
   /*=======================================================================*/
   /* Selecciona los Apoderados          */ 
   /*=======================================================================*/
   SELECT @ap1nombre = a.apnombre,
          @ap1cargo  = a.apcargo ,
          @ap1fono   = a.apfono
   FROM   VIEW_CLIENTE_APODERADO a,
   MFAC b
   WHERE  @nrutapo1   = a.aprutapo
     AND  b.acrutprop = a.aprutcli
   SELECT @ap2nombre = a.apnombre,
          @ap2cargo  = a.apcargo ,
          @ap2fono   = a.apfono
   FROM   VIEW_CLIENTE_APODERADO a,
          MFAC b
   WHERE  @nrutapo2   = a.aprutapo
     AND  b.acrutprop = a.aprutcli
   /*=======================================================================*/
   /* llena los datos desde la Cartera         */ 
   /*=======================================================================*/
   SELECT 'FecPro'   = @cfecpro                                          ,
   'FecInfo'		 = @cfecha                                                  ,
   'Status'          = 'I'                                                   ,
   'nomprop'         = @cnomprop                                                ,
   'codclie'         = @ncodclie                                                ,
   'rutprop'         = @nrutprop                                                ,
   'digprop'         = @cdigprop                                                ,
   'codcominf'       = @ncodcominf                                           ,
   'NomCli'          = b.clnombre                                               ,
   'CodPais'         = b.clpais                                              ,
   'NomPais'         = ISNULL(e.tbglosa,'')                                  ,
   'NumOpe'			 = a.canumoper                                              ,
   'FecIni'			 = CONVERT(CHAR(10),a.cafecha  ,103)                        ,
   'FecTer'			 = CONVERT(CHAR(10),a.cafecvcto,103)                        ,
   'Plazo'			 = a.caplazo                                                ,
   'Modal'			 = a.catipmoda                                              ,
   'CodInst'		 = 1                                                     ,
   'Instrumento'	 = 'Forward'                                             ,
   'CpaCodMon'		 = case a.catipoper when 'C' then a.cacodmon1 else a.cacodmon2 End,
   'CpaNemMon'		 = case a.catipoper when 'C' then c.mnnemo   else d.mnnemo   End,
   'CpaMonto'		 = case a.catipoper when 'C' then a.camtomon1 else a.camtomon2 End,
   'VtaCodMon'		 = case a.catipoper when 'V' then a.cacodmon1 else a.cacodmon2 End,
   'VtaNemMon'		 = case a.catipoper when 'V' then c.mnnemo   else d.mnnemo   End,
   'VtaMonto'		 = case a.catipoper when 'V' then a.camtomon1 else a.camtomon2 End,
   'Prima'			 = 0                                                              ,
   'PreFut'			 = CASE a.cacodpos1 WHEN 1 THEN a.caprecal ELSE a.caparmon2 END   ,
   'PreSpot'		 = a.capremon1                                                    ,          
   'Apodera1'		 = ISNULL( @ap1nombre , '' )                                      ,
   'Cargo1'			 = ISNULL( @ap1cargo  , '' )                                      ,
   'Fono1'			 = ISNULL( @ap1fono   , '' )                                      ,
   'Apodera2'		 = ISNULL( @ap2nombre , '' )                                      ,
   'Cargo2'			 = ISNULL( @ap2cargo  , '' )                                      ,
   'Fono2'			 = ISNULL( @ap2fono   , '' )									,
   'Contador'        = 0 ,
   'CanPag'          = 0
   INTO   #temp
  /* FROM   MFCA                    a,
          VIEW_CLIENTE b,
   VIEW_MONEDA c,
   VIEW_MONEDA d,
   VIEW_TABLA_GENERAL_DETALLE e       -- Tabla de Paises
   WHERE  CONVERT ( CHAR ( 8 ), a.cafecha, 112 )  =  @dFecha
     AND  a.catipoper  IN ( 'C', 'V' )                
     AND  a.cacodpos1  IN ( 1, 2, 3 )
     AND  (a.cacodigo   = b.clrut                     
     AND  a.cacodcli    = b.clcodigo)  --     AND  b.cltipcli    = 6 )                         
     AND  a.cacodmon1   = c.mncodmon                  
     AND  a.cacodmon2   = d.mncodmon                  
     AND  b.clpais     <> @codpais    -- discrimina mercado local
     AND  e.tbcateg     = 180
     AND  CONVERT(INTEGER,e.tbcodigo1) =* b.clpais   */
	--RQ 7619
     FROM MFC a
		   INNER JOIN  VIEW_CLIENTE b ON (a.cacodigo   = b.clrut AND  a.cacodcli    = b.clcodigo)    
		   INNER JOIN  VIEW_MONEDA  c ON  a.cacodmon1   = c.mncodmon  
		   INNER JOIN  VIEW_MONEDA  d ON  a.cacodmon2   = d.mncodmon
           RIGHT OUTER  JOIN  VIEW_TABLA_GENERAL_DETALLE e ON CONVERT(INT,e.tbcodigo1) = b.clpais
     WHERE CONVERT ( CHAR ( 8 ), a.cafecha, 112 )  =  @dFecha
     AND   a.catipoper  IN ( 'C', 'V' )                
     AND   a.cacodpos1  IN ( 1, 2, 3 )
	 AND  b.clpais     <> @codpais
	 AND  e.tbcateg     = 180

               
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
          'CpaNemMon'   = case a.catipoper when 'C' then c.mnnemo   else d.mnnemo   End,
          'CpaMonto'    = case a.catipoper when 'C' then a.camtomon1 else a.camtomon2 End,
          'VtaCodMon'   = case a.catipoper when 'V' then a.cacodmon1 else a.cacodmon2 End,
          'VtaNemMon'   = case a.catipoper when 'V' then c.mnnemo   else d.mnnemo   End,
          'VtaMonto'    = case a.catipoper when 'V' then a.camtomon1 else a.camtomon2 End,
          'Prima'       = 0                                                              ,
          'PreFut'      = CASE a.cacodpos1 WHEN  1  THEN a.caprecal  ELSE a.caparmon2 END,
--        'PreSpot'     = CASE a.cacodpos1 WHEN 1 THEN a.catcspot ELSE           0 END   ,
          'PreSpot'     = a.capremon1                                                    ,
          'Apodera1'    = ISNULL( @ap1nombre , '' )                                      ,
          'Cargo1'      = ISNULL( @ap1cargo  , '' )                                      ,
          'Fono1'       = ISNULL( @ap1fono   , '' )                                      ,
          'Apodera2'    = ISNULL( @ap2nombre , '' )                                      ,
          'Cargo2'      = ISNULL( @ap2cargo  , '' )                                      ,
          'Fono2'       = ISNULL( @ap2fono   , '' ),
          'Contador'    = 0 ,
          'CanPag'      = 0
   /*FROM   MFCAH           a,
          VIEW_CLIENTE b,
   VIEW_MONEDA c,
   VIEW_MONEDA d,
   VIEW_TABLA_GENERAL_DETALLE e       -- Tabla de Paises
   WHERE  CONVERT ( CHAR ( 8 ), a.cafecha, 112 )  =  @dFecha
     AND  a.catipoper  IN ( 'C', 'V' )                
     AND  a.cacodpos1  IN ( 1, 2, 3 )
     AND  (a.cacodigo   = b.clrut                     
     AND  a.cacodcli    = b.clcodigo)     --     AND  b.cltipcli    = 6 )                         
     AND  a.cacodmon1   = c.mncodmon                  
     AND  a.cacodmon2   = d.mncodmon                  
     AND  b.clpais     <> @codpais    -- discrimina mercado local
     AND  e.tbcateg     = 180                          
     AND  CONVERT(INTEGER,e.tbcodigo1) =* b.clpais */    

	FROM MFCAH a 
		INNER JOIN VIEW_CLIENTE b ON (a.cacodigo   = b.clrut AND  a.cacodcli    = b.clcodigo) 
		INNER JOIN VIEW_MONEDA  c ON  a.cacodmon1   = c.mncodmon
		INNER JOIN VIEW_MONEDA  d ON  a.cacodmon2   = d.mncodmon
        RIGHT OUTER JOIN VIEW_TABLA_GENERAL_DETALLE e ON CONVERT(INT,e.tbcodigo1) = b.clpais
	WHERE	CONVERT ( CHAR ( 8 ), a.cafecha, 112 )  =  @dFecha
	AND		a.catipoper  IN ( 'C', 'V' )                
    AND		a.cacodpos1  IN ( 1, 2, 3 )
	AND		b.clpais     <> @codpais    -- discrimina mercado local
    AND		e.tbcateg     = 180



             
----------------------------------------------------------- CARTERA LOG ----------------------------------------------
   SELECT 'FecPro'   = @cfecpro                                               ,
   'FecInfo'		 = @cfecha                                                       ,
   'Status'			 = 'M'                                                        ,
   'nomprop'		 = @cnomprop                                                     ,  
   'codclie'		 = @ncodclie                                                     ,
   'rutprop'		 = @nrutprop                                                     ,
   'digprop'		 = @cdigprop                                                     ,
   'codcominf'		 = @ncodcominf                                                ,
   'NomCli'			 = b.clnombre                                                    ,
   'CodPais'		 = b.clpais                                                   ,
   'NomPais'		 = ISNULL(e.tbglosa,'')                                       ,
   'NumOpe'			 = a.canumoper                                                   ,
   'FecIni'			 = CONVERT(CHAR(10),a.cafecha  ,103)                             ,
   'FecTer'			 = CONVERT(CHAR(10),a.cafecvcto,103)                             ,
   'Plazo'			 = a.caplazo                                                     ,
   'Modal'			 = a.catipmoda                                                   ,
   'CodInst'		 = 1                                                              ,
   'Instrumento'	 = 'Forward'                                                      ,
   'CpaCodMon'		 = case a.catipoper when 'C' then a.cacodmon1 else a.cacodmon2 End,
   'CpaNemMon'		 = case a.catipoper when 'C' then c.mnnemo   else d.mnnemo   End,
   'CpaMonto'		 = case a.catipoper when 'C' then a.camtomon1 else a.camtomon2 End,
   'VtaCodMon'		 = case a.catipoper when 'V' then a.cacodmon1 else a.cacodmon2 End,
   'VtaNemMon'		 = case a.catipoper when 'V' then c.mnnemo   else d.mnnemo   End,
   'VtaMonto'		 = case a.catipoper when 'V' then a.camtomon1 else a.camtomon2 End,
   'Prima'			 = 0                                                              ,
   'PreFut'			 = CASE a.cacodpos1 WHEN 1 THEN a.caprecal ELSE a.caparmon2 END   ,
   'PreSpot'		 = a.capremon1                                                    ,          
   'Apodera1'		 = ISNULL( @ap1nombre , '' )                                      ,
   'Cargo1'			 = ISNULL( @ap1cargo  , '' )                                      ,
   'Fono1'			 = ISNULL( @ap1fono   , '' )                                      ,
   'Apodera2'		 = ISNULL( @ap2nombre , '' )                                      ,
   'Cargo2'			 = ISNULL( @ap2cargo  , '' )                                      ,
   'Fono2'			 = ISNULL( @ap2fono   , '' ),
   'Contador'		 = 0 ,
   'CanPag'			 = 0
   INTO   #temp_log
   

   /*FROM   MFCA_log              a,
          VIEW_CLIENTE b,
   VIEW_MONEDA c,
   VIEW_MONEDA d,
   VIEW_TABLA_GENERAL_DETALLE e       -- Tabla de Paises
   WHERE a.caprimero = 'S'    
     AND CONVERT ( CHAR ( 8 ), a.cafecha, 112 )  =  @dFecha
     AND  a.catipoper  IN ( 'C', 'V' )                
     AND  a.cacodpos1  IN ( 1, 2, 3 )
     AND  (a.cacodigo   = b.clrut                     
     AND  a.cacodcli    = b.clcodigo)  --     AND  b.cltipcli    = 6 )                         
     AND  a.cacodmon1   = c.mncodmon                  
     AND  a.cacodmon2   = d.mncodmon                  
     AND  b.clpais     <> @codpais    -- discrimina mercado local
     AND  e.tbcateg     = 180
     AND  CONVERT(INTEGER,e.tbcodigo1) =* b.clpais */

	    
	FROM MFCA_log a
		INNER JOIN VIEW_CLIENTE b ON (a.cacodigo    = b.clrut AND  a.cacodcli    = b.clcodigo)
		INNER JOIN VIEW_MONEDA  c ON  a.cacodmon1   = c.mncodmon
		INNER JOIN VIEW_MONEDA  d ON  a.cacodmon2   = d.mncodmon
		RIGHT OUTER JOIN VIEW_TABLA_GENERAL_DETALLE e ON CONVERT(INT,e.tbcodigo1) = b.clpais -- Tabla de Paises
	WHERE	a.caprimero = 'S'    
    AND		CONVERT ( CHAR ( 8 ), a.cafecha, 112 )  =  @dFecha
    AND		a.catipoper  IN ( 'C', 'V' )                
    AND		a.cacodpos1  IN ( 1, 2, 3 )
	AND		e.tbcateg     = 180

              
----------------------------------------------------------- CARTERA  ----------------------------------------------
   SELECT 'FecPro'   = @cfecpro                                                 ,
   'FecInfo'		 = @cfecha															,
   'Status'			 = 'M'                                                          ,
   'nomprop'		 = @cnomprop														,
   'codclie'		 = @ncodclie														,
   'rutprop'		 = @nrutprop														,
   'digprop'		 = @cdigprop														,
   'codcominf'		 = @ncodcominf                                                  ,
   'NomCli'			 = b.clnombre														,
   'CodPais'		 = b.clpais                                                     ,
   'NomPais'		 = ISNULL(e.tbglosa,'')                                         ,
   'NumOpe'			 = a.canumoper														,
   'FecIni'			 = CONVERT(CHAR(10),a.cafecha  ,103)								,
   'FecTer'			 = CONVERT(CHAR(10),a.cafecvcto,103)								,
   'Plazo'			 = a.caplazo														,
   'Modal'			 = a.catipmoda														,
   'CodInst'		 = 1                                                            ,
   'Instrumento'	 = 'Forward'                                                    ,
   'CpaCodMon'		 = case a.catipoper when 'C' then a.cacodmon1 else a.cacodmon2 End,
   'CpaNemMon'		 = case a.catipoper when 'C' then c.mnnemo   else d.mnnemo   End,
   'CpaMonto'		 = case a.catipoper when 'C' then a.camtomon1 else a.camtomon2 End,
   'VtaCodMon'		 = case a.catipoper when 'V' then a.cacodmon1 else a.cacodmon2 End,
   'VtaNemMon'		 = case a.catipoper when 'V' then c.mnnemo   else d.mnnemo   End,
   'VtaMonto'		 = case a.catipoper when 'V' then a.camtomon1 else a.camtomon2 End,
   'Prima'			 = 0                                                              ,
   'PreFut'			 = CASE a.cacodpos1 WHEN 1 THEN a.caprecal ELSE a.caparmon2 END   ,
   'PreSpot'		 = a.capremon1                                                    ,          
   'Apodera1'		 = ISNULL( @ap1nombre , '' )                                      ,
   'Cargo1'			 = ISNULL( @ap1cargo  , '' )                                      ,
   'Fono1'			 = ISNULL( @ap1fono   , '' )                                      ,
   'Apodera2'		 = ISNULL( @ap2nombre , '' )                                      ,
   'Cargo2'			 = ISNULL( @ap2cargo  , '' )                                      ,
   'Fono2'			 = ISNULL( @ap2fono   , '' ),
   'Contador'		 = 0 ,
   'CanPag'			 = 0         
   INTO   #temp_car
   /*FROM   MFCA              a,
          VIEW_CLIENTE b,
   VIEW_MONEDA c,
   VIEW_MONEDA d,
   VIEW_TABLA_GENERAL_DETALLE e     ,  -- Tabla de Paises
          #temp_log    f
   WHERE  CONVERT ( CHAR ( 8 ), a.cafecha, 112 )  =  @dFecha
     AND  a.catipoper  IN ( 'C', 'V' )                
     AND  a.cacodpos1  IN ( 1, 2, 3 )
     AND  (a.cacodigo   = b.clrut                     
     AND  a.cacodcli    = b.clcodigo)  --     AND  b.cltipcli    = 6 )                         
     AND  a.cacodmon1   = c.mncodmon                  
     AND  a.cacodmon2   = d.mncodmon                  
     AND  b.clpais     <> @codpais    -- discrimina mercado local
     AND  e.tbcateg     = 180
     AND  CONVERT(INTEGER,e.tbcodigo1) =* b.clpais                  
     and  a.canumoper = f.numope */


	FROM  MFCA a
		INNER JOIN VIEW_CLIENTE b ON (a.cacodigo    = b.clrut AND  a.cacodcli    = b.clcodigo)
		INNER JOIN VIEW_MONEDA  c ON  a.cacodmon1   = c.mncodmon
		INNER JOIN VIEW_MONEDA  d ON  a.cacodmon2   = d.mncodmon
		INNER JOIN #temp_log    f ON  a.canumoper = f.numope
		RIGHT OUTER JOIN VIEW_TABLA_GENERAL_DETALLE e ON CONVERT(INT,e.tbcodigo1) = b.clpais  -- Tabla de Paises
	WHERE CONVERT ( CHAR ( 8 ), a.cafecha, 112 )  =  @dFecha
    AND  a.catipoper  IN ( 'C', 'V' )                
    AND  a.cacodpos1  IN ( 1, 2, 3 )
	AND  b.clpais     <> @codpais    -- discrimina mercado local
    AND  e.tbcateg     = 180





--------------------------------------------------- final --------------------------------------------------
   SELECT 'FecPro'   = CASE WHEN a.FecPro  = b.FecPro THEN '' ELSE b.FecPro  END,
   'FecInfo'		 = CASE WHEN a.FecInfo = b.FecInfo THEN '' ELSE b.FecInfo END, 
   'Status'          = a.Status,
   'nomprop'         = CASE WHEN a.nomprop = b.nomprop THEN '' ELSE b.nomprop END,
   'codclie'         = CASE WHEN a.codclie = b.codclie THEN 0 ELSE b.codclie END,
   'rutprop'         = CASE WHEN a.rutprop = b.rutprop THEN 0 ELSE b.rutprop END,
   'digprop'         = CASE WHEN a.digprop = b.digprop THEN '' ELSE b.digprop END, 
   'codcominf'       = CASE WHEN a.codcominf = b.codcominf THEN 0 ELSE b.codcominf END,
   'NomCli'          = CASE WHEN a.NomCli = b.NomCli THEN '' ELSE b.NomCli END,
   'CodPais'         = CASE WHEN a.CodPais = b.CodPais THEN 0 ELSE b.CodPais END,
   'NomPais'         = CASE WHEN a.NomPais = b.NomPais THEN '' ELSE b.NomPais END,
   'NumOpe'          = CASE WHEN a.NumOpe  = b.NumOpe  THEN 0 ELSE b.NumOpe  END, 
   'FecIni'          = CASE WHEN a.FecIni  = b.FecIni  THEN '' ELSE b.FecIni  END,
   'FecTer'          = CASE WHEN a.FecTer  = b.FecTer  THEN '' ELSE b.FecTer  END,
   'Plazo'           = a.plazo,
   'Modal'           = CASE WHEN a.Modal = b.Modal THEN '' ELSE b.fecter END,
   'CodInst'         = '01',
   'Instrumento'     = 'Forward',
   'CpaCodMon'       = CASE WHEN a.CpaCodMon = b.CpaCodMon THEN 0 ELSE b.CpaCodMon END,
   'CpaNemMon'       = CASE WHEN a.CpaNemMon = b.CpaNemMon THEN '' ELSE b.CpaNemMon END,
   'CpaMonto'        = CASE WHEN a.CpaMonto  = b.CpaMonto  THEN 0 ELSE b.CpaMonto END,
   'VtaCodMon'       = CASE WHEN a.VtaCodMon = b.VtaCodMon THEN 0 ELSE b.VtaCodMon END,
   'VtaNemMon'       = CASE WHEN a.VtaNemMon = b.VtaNemMon THEN '' ELSE b.VtaNemMon END,
   'VtaMonto'        = CASE WHEN a.VtaMonto = b.VtaMonto THEN 0 ELSE b.VtaMonto END,
   'Prima'           = CASE WHEN a.Prima = b.Prima THEN 0 ELSE b.Prima END,
   'PreFut'          = CASE WHEN a.PreFut = b.PreFut THEN 0 ELSE b.PreFut END,
   'PreSpot'         = CASE WHEN a.PreSpot = b.PreSpot THEN 0 ELSE b.PreSpot END,
   'Apodera1'        = a.Apodera1 ,
   'Cargo1'          = a.Cargo1   ,
   'Fono1'           = a.Fono1    ,
   'Apodera2'        = a.Apodera2 ,
   'Cargo2'          = a.Cargo2   ,
   'Fono2'           = a.Fono2    ,
   'Contador'        = a.Contador ,
   'CanPag'          = a.CanPag   
   INTO   #temp_final
   FROM   #temp_car  b,
          #temp_log  a
   WHERE  a.numope = b.numope and
          a.fecpro <> b.fecpro
   SELECT * FROM #temp
   union
   select * from #temp_final 
   order by numope 
SET NOCOUNT OFF
END

GO
