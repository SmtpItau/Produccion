USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAP7ANEXO1]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CAP7ANEXO1](
                            @dfecha   CHAR(08)   ,
							@nrutapo1 FLOAT		,
                            @nrutapo2  FLOAT
            )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @cfecha     CHAR(10)
   DECLARE @nnumope    NUMERIC(8)
   DECLARE @nvaluf     NUMERIC(10,4)
   DECLARE @nvalob     NUMERIC(10,4)
   DECLARE @cnomprop   CHAR(60)
   DECLARE @cdirprop   CHAR(60)
   DECLARE @nrutprop   NUMERIC(9) 
   DECLARE @cdigprop   CHAR(1)
   DECLARE @ncodclie   NUMERIC(4)
   DECLARE @cfecpro    CHAR(10)
   DECLARE @ap1nombre  CHAR(40)    
   DECLARE @ap1cargo   CHAR(40)    
   DECLARE @ap1fono    CHAR(15)    
   DECLARE @ap2nombre  CHAR(40)    
   DECLARE @ap2cargo   CHAR(40)    
   DECLARE @ap2fono    CHAR(15)  
   DECLARE @cuenta     NUMERIC (2,0)   
   
   /*=======================================================================*/
   /*               CODIGO DE PAIS SEGUN INSTALACION                        */
   /*=======================================================================*/
   DECLARE @CodPais    INTEGER  
   
   SELECT  @CodPais = 6          -- CHILE
   /*=======================================================================*/
   /*=======================================================================*/
--   @cfecha = @dfecha , --CONVERT( CHAR(10), convert(datetime,@dfecha), 112 )  ,
   SELECT      @nvaluf = b.vmvalor       ,
               @nvalob = c.vmvalor      ,
               @cnomprop = (Select rcnombre from VIEW_ENTIDAD)   ,   
               @cdirprop = d.acdirprop,
               @nrutprop = d.acrutprop    ,
               @cdigprop = d.acdigprop    ,
               @ncodclie = d.accodbcch    ,
               @cfecpro = CONVERT( CHAR(10), d.acfecproc, 103 ) 
              
   FROM		   VIEW_VALOR_MONEDA b ,
               VIEW_VALOR_MONEDA c ,
               MFAC d
   WHERE       b.vmcodigo = 998 AND
               convert(char(08),b.vmfecha,112)  = @dfecha AND
               c.vmcodigo = 994 AND
               convert(char(08),c.vmfecha,112)  = @dfecha   
   /*=======================================================================*/
   /* Selecciona los Apoderados          */ 
   /*=======================================================================*/
   SELECT       @ap1nombre = a.apnombre   ,
				@ap1cargo  = a.apcargo    ,
				@ap1fono   = a.apfono   
   FROM			VIEW_CLIENTE_APODERADO a,
				MFAC b
   WHERE		@nrutapo1 = a.aprutapo AND b.acrutprop = a.aprutcli
   
   SELECT       @ap2nombre = a.apnombre   ,
				@ap2cargo  = a.apcargo    ,
				@ap2fono   = a.apfono   
   FROM			VIEW_CLIENTE_APODERADO a,
				MFAC b
   WHERE		@nrutapo2 = a.aprutapo AND
                b.acrutprop = a.aprutcli
 
   /*=======================================================================*/
   /* llena los datos desde la Cartera         */ 
   /*=======================================================================*/
   SELECT     'TipOpe'   = a.catipoper    ,
              'NumOpe'   = a.canumoper    ,
              'RutCli'   = a.cacodigo     ,
			  'DigCli'   = b.cldv  ,
              'NomCli'   = b.clnombre     ,
              'FecIni'   = CONVERT(CHAR(10),a.cafecha  ,103) ,
              'FecTer'   = CONVERT(CHAR(10),a.cafecvcto,103) ,
              'CpaCodMon'  = case a.catipoper when 'C' then a.cacodmon1 else a.cacodmon2 End  ,    
              'CpaNemMon'  = case a.catipoper when 'C' then c.mnnemo else d.mnnemo End   ,    
              'CpaMonto'   = case a.catipoper when 'C' then a.camtomon1 else a.camtomon2 End  ,    
              'VtaCodMon'  = case a.catipoper when 'V' then a.cacodmon1 else a.cacodmon2 End  ,    
              'VtaNemMon'  = case a.catipoper when 'V' then c.mnnemo else d.mnnemo End   ,    
              'VtaMonto'   = case a.catipoper when 'V' then a.camtomon1 else a.camtomon2 End  ,    
              'Modal'    = a.catipmoda    ,
              'PreFut'   = CASE a.cacodpos1 WHEN 3 THEN a.capremon2 ELSE a.caprecal END,
              'PreSpt'   = a.capremon1    ,
			  'nomprop'  = @cnomprop  ,
			  'dirprop'  = @cdirprop  ,
		      'rutprop'  = @nrutprop  ,
		      'digprop'  = @cdigprop  ,
		      'FecInfo'  = @dfecha  ,
		      'codclie'  = @ncodclie      ,
		      'FecPro'   = @cfecpro       ,
		      'Marca'    = 'I'   , 
		      'Plazo'    = a.caplazo      ,
              'Apodera1'  = ISNULL( @ap1nombre , '' ) ,
              'Cargo1'    = ISNULL( @ap1cargo  , '' ) ,
              'Fono1'     = ISNULL( @ap1fono   , '' ) ,
              'Apodera2'  = ISNULL( @ap2nombre , '' ) ,
              'Cargo2'    = ISNULL( @ap2cargo  , '' ) ,
              'Fono2'     = ISNULL( @ap2fono   , '' ) ,
              'Contador'        = 0,
              'CanPag'          = 0,
              'SectorEconomico' = b.clactivida   ,
              'CodigoIns'       = '01'           ,
              'Instrumento'     = 'Forward'     ,
              'Estado'          = a.caestado               
         INTO  #temp
         FROM  MFCA  a,
               VIEW_CLIENTE  b,
			   VIEW_MONEDA   c,
               VIEW_MONEDA   d
         WHERE a.cafecha  = @dFecha      AND
               a.catipoper IN ('C','V')   AND
               a.cacodpos1 IN (1,2,7)       AND        -- falta discriminar s«lo mercado local
              (a.cacodigo = b.clrut      AND
               a.cacodcli  = b.clcodigo   AND
               b.clpais    = @CodPais  )  AND
			   a.cacodmon1 = c.mncodmon   AND
               a.cacodmon2 = d.mncodmon
        INSERT INTO  #temp
      SELECT  'TipOpe'   = a.catipoper    ,
              'NumOpe'   = a.canumoper    ,
              'RutCli'   = a.cacodigo     ,
              'DigCli'   = b.cldv  ,
              'NomCli'   = b.clnombre     ,
              'FecIni'   = CONVERT(CHAR(10),a.cafecha  ,103) ,
              'FecTer'   = CONVERT(CHAR(10),a.cafecvcto,103) ,
              'CpaCodMon'  = case a.catipoper when 'C' then a.cacodmon1 else a.cacodmon2 End  ,    
              'CpaNemMon'  = case a.catipoper when 'C' then c.mnnemo else d.mnnemo End   ,    
              'CpaMonto'   = case a.catipoper when 'C' then a.camtomon1 else a.camtomon2 End  ,    
              'VtaCodMon'  = case a.catipoper when 'V' then a.cacodmon1 else a.cacodmon2 End  ,    
              'VtaNemMon'  = case a.catipoper when 'V' then c.mnnemo else d.mnnemo End   ,    
              'VtaMonto'   = case a.catipoper when 'V' then a.camtomon1 else a.camtomon2 End  ,    
              'Modal'    = a.catipmoda    ,
              'PreFut'   = CASE a.cacodpos1 WHEN 3 THEN a.capremon2 ELSE a.caprecal END,
              'PreSpt'   = a.capremon1    ,       
		      'nomprop'  = @cnomprop  ,
		      'dirprop'  = @cdirprop  ,
		      'rutprop'  = @nrutprop  ,
		      'digprop'  = @cdigprop  ,
		      'FecInfo'  = @cfecha  ,
		      'codclie'  = @ncodclie      ,
		      'FecPro'   = @cfecpro    ,
              'Marca'    = 'I'    , 
              'Plazo'    = a.caplazo      ,
              'Apodera1'  = ISNULL( @ap1nombre , '' ) ,
              'Cargo1'    = ISNULL( @ap1cargo  , '' ) ,
              'Fono1'     = ISNULL( @ap1fono   , '' ) ,
              'Apodera2'  = ISNULL( @ap2nombre , '' ) ,
              'Cargo2'    = ISNULL( @ap2cargo  , '' ) ,
              'Fono2'     = ISNULL( @ap2fono   , '' ) ,
              'Contador'        = 0 ,
              'CanPag'          = 0  ,
              'SectorEconomico' = b.clactivida    ,
              'CodigoIns'       = '01'           ,
              'Instrumento'     = 'Forward'    ,
              'Estado'          = a.caestado 
         FROM  MFCAH         a,
               VIEW_CLIENTE  b,
               VIEW_MONEDA   c,
               VIEW_MONEDA   d
         WHERE a.cafecha   = @cFecha      and
               a.catipoper IN ('C','V')   AND
               a.cacodpos1 IN (1,2,7 )    AND        -- falta discriminar s«lo mercado local
              (a.cacodigo = b.clrut      AND
               a.cacodcli  = b.clcodigo  AND
               b.clpais    = @CodPais  )  AND
               a.cacodmon1 = c.mncodmon   AND
               a.cacodmon2 = d.mncodmon
 select 'TipOpe_L'   = a.catipoper    ,
        'Numope_L'      = a.canumoper    ,
        'RutCli_L'   = a.cacodigo     ,
	    'DigCli_L'   = b.cldv  ,
	    'NomCli_L'   = b.clnombre     ,
	    'FecIni_L'   = CONVERT(CHAR(10),a.cafecha  ,103) ,
	    'FecTer_L'   = CONVERT(CHAR(10),a.cafecvcto,103) ,
	    'CpaCodMon_L'  = case a.catipoper when 'C' then a.cacodmon1 else a.cacodmon2 End  ,    
	    'CpaNemMon_L'  = case a.catipoper when 'C' then c.mnnemo else d.mnnemo End   ,    
	    'CpaMonto_L'   = case a.catipoper when 'C' then a.camtomon1 else a.camtomon2 End  ,    
	    'VtaCodMon_L'  = case a.catipoper when 'V' then a.cacodmon1 else a.cacodmon2 End  ,    
	    'VtaNemMon_L'  = case a.catipoper when 'V' then c.mnnemo else d.mnnemo End   ,    
	    'VtaMonto_L'   = case a.catipoper when 'V' then a.camtomon1 else a.camtomon2 End  ,    
	    'Modal_L'    = a.catipmoda    ,
	    'PreFut_L'   = CASE a.cacodpos1 WHEN 3 THEN a.capremon2 ELSE a.caprecal END,
        'PreSpt_L'   = a.capremon1                                                 ,
        'SectorEconomico_L' = b.clactivida ,
        'Marca_L'       = 'M'  ,
        'Contador_L'    = 0   ,
        'nomprop_L'  = @cnomprop  ,
        'dirprop_L'  = @cdirprop  ,
        'rutprop_L'  = @nrutprop  ,
        'digprop_L'  = @cdigprop  ,
        'FecInfo_L'  = @dfecha  ,
        'codclie_L'  = @ncodclie      ,
        'FecPro_L'   = @cfecpro       ,
        'Plazo_L'    = a.caplazo      ,
        'Apodera1_L'  = ISNULL( @ap1nombre , '' ) ,
        'Cargo1_L'    = ISNULL( @ap1cargo  , '' ) ,
        'Fono1_L'     = ISNULL( @ap1fono   , '' ) ,
        'Apodera2_L'  = ISNULL( @ap2nombre , '' ) ,
        'Cargo2_L'    = ISNULL( @ap2cargo  , '' ) ,
        'Fono2_L'     = ISNULL( @ap2fono   , '' ) ,
        'CanPag_L'          = 0,
        'CodigoIns_L'       = '01'        ,
        'Instrumento_L'     = 'Forward'  ,
        'Estado_L'          = a.caestado  
  into  #temp_log
  from  mfca_LOG     a    ,
        view_cliente b    ,
        view_moneda  c    ,
        view_moneda  d
  where a.caprimero = 'S'  and
      ( a.cafecmod  = @dFecha    AND
        a.cafecha   <> a.cafecmod   ) AND
        a.catipoper IN ('C','V')   AND
        a.cacodpos1 IN (1,2,7 )    AND        -- falta discriminar s«lo mercado local
       (a.cacodigo = b.clrut      AND
        a.cacodcli  = b.clcodigo  AND
        b.clpais    = @CodPais  )  AND
        a.cacodmon1 = c.mncodmon   AND
        a.cacodmon2 = d.mncodmon
  
 select distinct	'TipOpe' = a.catipoper    ,
					'Numope'        = a.canumoper    ,
					'RutCli'   = a.cacodigo     ,
					'DigCli'   = b.cldv  ,
					'NomCli'   = b.clnombre     ,
					'FecIni'   = CONVERT(CHAR(10),a.cafecha  ,103) ,
					'FecTer'   = CONVERT(CHAR(10),a.cafecvcto,103) ,
					'CpaCodMon'  = case a.catipoper when 'C' then a.cacodmon1 else a.cacodmon2 End  ,    
					'CpaNemMon'  = case a.catipoper when 'C' then c.mnnemo else d.mnnemo End   ,    
					'CpaMonto'   = case a.catipoper when 'C' then a.camtomon1 else a.camtomon2 End  ,    
					'VtaCodMon'  = case a.catipoper when 'V' then a.cacodmon1 else a.cacodmon2 End  ,    
					'VtaNemMon'  = case a.catipoper when 'V' then c.mnnemo else d.mnnemo End   ,    
					'VtaMonto'   = case a.catipoper when 'V' then a.camtomon1 else a.camtomon2 End  ,    
					'Modal'    = a.catipmoda    ,
					'PreFut'   = CASE a.cacodpos1 WHEN 3 THEN a.capremon2 ELSE a.caprecal END,
					'PreSpt'   = a.capremon1                                                 ,
					'SectorEconomico' = b.clactivida   ,
					'Marca'         = 'M' ,
					'Contador'      = 0 ,
					'nomprop'  = @cnomprop  ,
					'dirprop'  = @cdirprop  ,
					'rutprop'  = @nrutprop  ,
					'digprop'  = @cdigprop  ,
					'FecInfo'  = @dfecha  ,
					'codclie'  = @ncodclie      ,
					'FecPro'   = @cfecpro       ,
					'Plazo'    = a.caplazo      ,
					'Apodera1'  = ISNULL( @ap1nombre , '' ) ,
					'Cargo1'    = ISNULL( @ap1cargo  , '' ) ,
					'Fono1'     = ISNULL( @ap1fono   , '' ) ,
					'Apodera2'  = ISNULL( @ap2nombre , '' ) ,
					'Cargo2'    = ISNULL( @ap2cargo  , '' ) ,
					'Fono2'     = ISNULL( @ap2fono   , '' ) ,
					'CanPag'        = 0,
					'CodigoIns'     = '01'        ,
					'Instrumento'   = 'Forward'  ,
					'Estado'        = a.caestado  
  into #temp_car
  from mfca         a    ,
       view_cliente b    ,
       view_moneda  c    ,
       view_moneda  d   ,
       mfca_log e
  where --a.cafecha   = @cFecha   and
	  ( e.cafecmod  = @dFecha    AND
        a.cafecha   <> e.cafecmod   ) AND
		a.catipoper IN ('C','V')   AND
		a.cacodpos1 IN (1,2,7 )    AND        -- falta discriminar s«lo mercado local
	  ( a.cacodigo = b.clrut      AND
        a.cacodcli  = b.clcodigo  AND
        b.clpais    = @CodPais  )  AND
		a.cacodmon1 = c.mncodmon   AND
		a.cacodmon2 = d.mncodmon   and
        a.canumoper  = e.canumoper
   
select
    'TipOpe'         = CASE WHEN TipOpe    =  TipOpe_L   THEN ' ' ELSE TipOpe  END   , 
    'NumOpe'         = numope                                                      ,
    'RutCli'         = CASE WHEN RutCli    = RutCli_L    THEN 0   ELSE RutCli  END  ,
    'DigCli'         = CASE WHEN DigCli    = DigCli_L    THEN ' ' ELSE DigCli  END  ,
    'NomCli'          = CASE WHEN NomCli    = NomCli_L    THEN ' ' ELSE NomCli  END  ,
    'FecIni'         = FecIni, --CASE WHEN FecIni    = FecIni_L    THEN ' ' ELSE FecIni  END  ,
    'FecTer'         = CASE WHEN FecTer    = FecTer_L    THEN ' ' ELSE FecTer  END  ,
    'CpaCodMon'       = CASE WHEN CpaCodMon = CpaCodMon_L THEN 0   ELSE CpaCodMon END,    
    'CpaNemMon'       = CASE WHEN CpaNemMon = CpaNemMon_L THEN ' ' ELSE CpaNemMon END,    
    'CpaMonto'        = CASE WHEN CpaMonto  = CpaMonto_L  THEN 0   ELSE CpaMonto  END,    
    'VtaCodMon'       = CASE WHEN VtaCodMon = VtaCodMon_L THEN 0   ELSE VtaCodMon END,      
    'VtaNemMon'       = CASE WHEN VtaNemMon = VtaNemMon_L THEN ' ' ELSE VtaNemMon END,    
    'VtaMonto'        = CASE WHEN VtaMonto  = VtaMonto_L  THEN 0   ELSE VtaMonto  END,      
    'Modal'          = CASE WHEN Modal     = Modal_L     THEN ' ' ELSE Modal     END,
    'PreFut'         = CASE WHEN PreFut    = PreFut_L    THEN ' ' ELSE PreFut    END,
    'PreSpt'         = CASE WHEN PreSpt    = PreSpt_L    THEN ' ' ELSE PreSpt      END,
    'nomprop'        = nomprop        ,
    'dirprop'        = dirprop        ,
    'rutprop'        = rutprop        ,
    'digprop'        = digprop        ,
    'FecInfo'         = fecinfo        , 
    'codclie'        = codclie        ,
    'FecPro'          = fecpro         ,
    'Marca'           = 'M'            ,
    'Plazo'          = CASE WHEN Plazo     = Plazo_L    THEN 0   ELSE Plazo      END,
    'Apodera1'        = Apodera1       ,
    'Cargo1'          = Cargo1         ,
    'Fono1'           = Fono1          ,
    'Apodera2'        = Apodera2       ,
    'Cargo2'          = Cargo2         ,
    'Fono2'           = Fono2          ,
    'Contador'        = 0              ,
    'CanPag'          = CanPag         ,
    'SectorEconomico' = CASE WHEN SectorEconomico = SectorEconomico_L THEN 0 ELSE SectorEconomico  END ,
    'CodigoIns'       = '01'           ,
    'Instrumento'     = 'Forward'      ,
    'Estado'          = Estado     
INTO #temp_final          
FROM #temp_car        ,
     #temp_log   
WHERE numope = numope_l  
DELETE  #temp_final
WHERE   TipOpe  = ' '	AND 
 RutCli			= 0		AND
 DigCli			= ' '	AND
 NomCli			= ' '	AND
 FecTer			= ' '	AND
 CpaCodMon		= 0		AND
 CpaNemMon		= ' '	AND
 CpaMonto       = 0		AND
 VtaCodMon      = 0		AND
 VtaNemMon      = ' '	AND
 VtaMonto       = 0		AND
 Modal			= ' '	AND
 PreFut         = ' '	AND
 PreSpt			= ' ' 
      SELECT * FROM #temp
      UNION
      SELECT DISTINCT * FROM #temp_final       
      ORDER BY numope   
     
SET NOCOUNT OFF
END

GO
