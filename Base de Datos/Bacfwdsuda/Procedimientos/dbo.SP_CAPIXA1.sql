USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAPIXA1]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CAPIXA1]
   (   @dfecha        DATETIME  
   ,   @nrutapo1      FLOAT  
   ,   @nrutapo2      FLOAT  
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  

-- SP_CAPIXA1 '20111012',12947634,12947634
-- SP_CAPIXA1 '20111209',12947634,12947634
-- SP_CAPIXA1 '20111213',12947634,12947634

  
   /*=======================================================================*/  
   /*=======================================================================*/  
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
   DECLARE @cEmailApo1 CHAR (40)    
  
   -- 21 Oct. 2009  Para calculo prima en dólares  
   DECLARE @DoObs      FLOAT   
   SELECT  @DoObs = 0.0  
  
  
   /*=======================================================================*/   /*=======================================================================*/  
   /*=======================================================================*/  
   SELECT      @cfecha = @dfecha, --> CONVERT( CHAR(10), convert(datetime,@dfecha), 103 )  ,  
               @nvaluf = b.vmvalor     ,  
               @nvalob = c.vmvalor     ,  
               @cnomprop = (Select acnomprop from mfac),  
               @cdirprop = (d.acdirprop + 'SANTIAGO')    ,  
               @nrutprop = d.acrutprop    ,  
               @cdigprop = d.acdigprop    ,  
      @ncodclie = 2                          ,  
            @cfecpro = CONVERT( CHAR(10), d.acfecproc, 103 )   
   FROM        view_valor_moneda b with (nolock) ,  
               view_valor_moneda c with (nolock) ,  
            mfac              d with (nolock)   
   WHERE     b.vmcodigo = 998 AND  
               convert(char(08),b.vmfecha,112)  = @dfecha AND   
               c.vmcodigo = 994 AND  
               convert(char(08),c.vmfecha,112)  = @dfecha     
  
   /*=======================================================================*/  
   /* Selecciona los Apoderados          */   
   /*=======================================================================*/  
  
   SELECT      @ap1nombre  = a.apnombre   ,  
        @ap1cargo   = a.apcargo    ,  
            @ap1fono    = a.apfono    ,  
         @cEmailApo1 = a.apemail  
   FROM     view_cliente_apoderado a with (nolock) ,  
            mfac                   b with (nolock)   
   WHERE     @nrutapo1 = a.aprutapo AND b.acrutprop = a.aprutcli  
  
   SELECT      @ap2nombre = a.apnombre   ,  
           @ap2cargo  = a.apcargo    ,  
            @ap2fono   = a.apfono     
   FROM     view_cliente_apoderado a with (nolock) ,  
            mfac                   b with (nolock)   
   WHERE     @nrutapo2 = a.aprutapo AND b.acrutprop = a.aprutcli  
  
 
     
   -- 21 Oct. 2009  Para calculo prima en dólares  
   SELECT @DoObs = vmvalor    
   FROM  BacParamSuda..Valor_Moneda      
   WHERE vmFecha = @dfecha  
   AND  vmcodigo =994  
  
   SELECT vmfecha, vmcodigo, vmvalor  
   INTO  #VALOR_MONEDA   
   FROM  BacParamSuda..VALOR_MONEDA  
   WHERE vmFecha    = @dfecha  
  
   INSERT INTO #VALOR_MONEDA  
   SELECT @dfecha, 999, 1.0  
  
   INSERT INTO #VALOR_MONEDA  
   SELECT @dfecha, 13, @DoObs  
  
   /*=======================================================================*/  
   /* llena los datos desde la Cartera         */   
   /*=======================================================================*/  
  
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
              'VtaNemMon'  = case a.catipoper when 'V' then c.mnnemo else CASE WHEN a.var_moneda2 > 0 THEN 'CLP' ELSE d.mnnemo END End   ,      
              'VtaMonto'   = case a.catipoper when 'V' then a.camtomon1 else CASE WHEN a.var_moneda2 > 0 THEN a.caequmon2 ELSE a.camtomon2 END End  ,      
              'Modal'    = a.catipmoda    ,   -- select * from mfca  
              'PreFut'   = CASE  WHEN a.cacodpos1 = 3  THEN a.capremon2   
       WHEN a.cacodpos1 = 13 THEN a.capremon2  
       WHEN a.cacodpos1 = 11 THEN a.catipcam  --> CS-AG  
     WHEN a.cacodpos1 = 2  THEN CASE WHEN a.var_moneda2 > 0 THEN a.caprecal ELSE a.catipcam  END  
       ELSE       a.caprecal   
       END, -- caparbcch  
              'PreSpt'   = a.capremon1, --a.precio_spot, --a.caTcSpot     ,  
           'nomprop'  = @cnomprop  ,  
           'dirprop'  = @cdirprop  ,  
           'rutprop'  = @nrutprop  ,  
           'digprop'  = @cdigprop  ,  
           'FecInfo'  = @cfecha  ,  
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
             'CodPais'         = ISNULL(e.codigo_pais,0)   ,  
              'NomPais'         = ISNULL(e.nombre,'')  ,  
              'EmailApo1'       = @cEmailApo1,  
              'Sector Eco'      = b.CLACTIVIDA,  
              'cod_instru'      = a.caoperrelaspot, --'01'  
              'Prima'           = CONVERT(FLOAT,0.0)   
         INTO  #temp  
           
     /* FROM  mfca          a with (nolock) ,  
           view_cliente  b with (nolock) ,  
        view_moneda   c with (nolock) , -- mdmn  c,  
        view_moneda   d with (nolock) , -- mdmn  d ,   
        view_pais     e with (nolock)   -- Tabla de Paises   
           WHERE  a.cafecha = @dfecha AND  --SUBSTRING(CONVERT(CHAR(10),a.cafecha,103),1,6) = SUBSTRING(@cFecha,1,6) AND  
     a.catipoper IN ('C','V')    AND  
     a.cacodpos1 IN (1, 2, 3, 12, 11) AND        -- falta discriminar s«lo mercado local --> CS-AG  
   ( a.cacodigo = b.clrut       AND  
                  a.cacodcli  = b.clcodigo )  AND  
     a.cacodmon1 = c.mncodmon    AND  
     a.cacodmon2 = d.mncodmon    AND  
     CONVERT(INT,e.codigo_pais ) =* b.clpais -- tbcodigo1   
                   AND NOT (a.cacodpos1=1 and var_moneda2<>0) --REQ. 5541 */   
    --RQ 7619  
    FROM   mfca a with (nolock)  
    INNER JOIN  view_cliente  b with (nolock) ON (a.cacodigo = b.clrut AND a.cacodcli  = b.clcodigo )  
    INNER JOIN  view_moneda   c with (nolock)ON  a.cacodmon1 = c.mncodmon  
    INNER JOIN  view_moneda   d with (nolock)ON  a.cacodmon2 = d.mncodmon  
    RIGHT OUTER JOIN  view_pais  e with (nolock) ON CONVERT(INT,e.codigo_pais ) = b.clpais  
    WHERE a.cafecha = @dfecha   
    AND a.catipoper IN ('C','V')      
		  AND	a.cacodpos1 IN (1, 2, 3, 12, 11,14)  
                  AND NOT (a.cacodpos1=1 and var_moneda2<>0) --REQ. 5541   
    AND  NumeroContratoCliente = 0  
     
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
              'VtaNemMon'  = case a.catipoper when 'V' then c.mnnemo else CASE WHEN a.var_moneda2 > 0 THEN 'CLP' ELSE d.mnnemo END End   ,      
              'VtaMonto'   = case a.catipoper when 'V' then a.camtomon1 else CASE WHEN a.var_moneda2 > 0 THEN a.caequmon2 ELSE a.camtomon2 END End  ,      
--              'VtaNemMon'  = case a.catipoper when 'V' then c.mnnemo else d.mnnemo End   ,      
--              'VtaMonto'   = case a.catipoper when 'V' then a.camtomon1 else a.camtomon2 End  ,      
              'Modal'    = a.catipmoda    ,  
/*  
              'PreFut'   = CASE WHEN a.cacodpos1=3 THEN a.capremon2   
         WHEN a.cacodpos1=13 THEN a.capremon2  
         WHEN a.cacodpos1 = 11 THEN a.catipcam  --> CS-AG  
         WHEN a.cacodpos1 = 2  THEN a.catipcam    
         ELSE       a.caprecal   
         END, -- caparbcch  
*/  
              'PreFut'   = CASE  WHEN a.cacodpos1 = 3  THEN a.capremon2   
     WHEN a.cacodpos1 = 13 THEN a.capremon2  
     WHEN a.cacodpos1 = 11 THEN a.catipcam  --> CS-AG  
     WHEN a.cacodpos1 = 2  THEN CASE WHEN a.var_moneda2 > 0 THEN a.caprecal ELSE a.catipcam  END  
     ELSE       a.caprecal   
      END, -- caparbcch  
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
              'CanPag'          = 0 ,  
             'CodPais'         = ISNULL(e.codigo_pais,0)   ,  
              'NomPais'         = ISNULL(e.nombre,'')  ,  
              'EmailApo1'       = @cEmailApo1 ,  
              'Sector Eco'      = b.CLACTIVIDA,  
              'cod_instru'      = '01',  
              'Prima'           = 0.0  
           
   /* FROM  mfcah         a with (nolock) ,  
           view_cliente  b with (nolock) ,  
         view_moneda   c with (nolock) , -- mdmn  c,  
        view_moneda   d with (nolock) , -- mdmn  d ,  
           view_pais     e with (nolock)   -- Tabla de Paises   
         WHERE  a.cafecha = @dfecha AND --SUBSTRING(CONVERT(CHAR(10),a.cafecha,103),1,6) = SUBSTRING(@cFecha,1,6) AND  
          a.catipoper IN ('C','V')   AND  
          a.cacodpos1 IN (1,2,3,12,11)    AND    --> CS-AG  
            (a.cacodigo = b.clrut      AND  
                a.cacodcli  = b.clcodigo)  AND 
    a.cacodmon1 = c.mncodmon   AND  
    a.cacodmon2 = d.mncodmon   AND    
    --e.tbcateg     = 180    AND    
                CONVERT(INT,e.codigo_pais) =* b.clpais  -- tbcodigo1    
      AND NOT (a.cacodpos1=1 and var_moneda2<>0) --REQ. 5541 */  
  --RQ 7619  
  FROM   mfcah a with (nolock)  
  INNER JOIN view_cliente  b with (nolock) ON (a.cacodigo = b.clrut AND a.cacodcli  = b.clcodigo)  
  INNER JOIN view_moneda   c with (nolock) ON  a.cacodmon1 = c.mncodmon  
  INNER JOIN view_moneda   d with (nolock) ON  a.cacodmon2 = d.mncodmon  
  RIGHT OUTER JOIN view_pais  e with (nolock) ON CONVERT(INT,e.codigo_pais) = b.clpais  
	 WHERE  a.cafecha = @dfecha 
		AND a.catipoper IN ('C','V')   
		AND	a.cacodpos1 IN (1,2,3,12,11,14) 
        AND NOT (a.cacodpos1=1 and var_moneda2<>0)                    
    AND  NumeroContratoCliente = 0  
  
 /*=======================================================================*/  
--   Modificaaciones para ese dia  
 /*=======================================================================*/  
--SET ROWCOUNT 1   
 INSERT INTO  #temp            
 SELECT       'TipOpe'   = a.catipoper    ,  
              'NumOpe'   = a.canumoper    ,  
              'RutCli'   = a.cacodigo     ,  
              'DigCli'   = b.cldv         ,   
              'NomCli'   = b.clnombre     ,  
              'FecIni'   = CONVERT(CHAR(10),a.cafecha  ,103) ,  
              'FecTer'   = CASE WHEN CONVERT(CHAR(10),a.cafecvcto,103) = CONVERT(CHAR(10),e.cafecvcto,103) THEN CONVERT(CHAR(10),'',103) ELSE CONVERT(CHAR(10),e.cafecvcto,103) END, 	  
              'CpaCodMon'  = case a.catipoper when e.catipoper then 0 else  case a.catipoper when  'C' then a.cacodmon1 else a.cacodmon2 End End    ,                 
              'CpaNemMon'  = case a.catipoper when 'C' then            
                                  case when a.cacodmon1 = e.cacodmon1 then ' ' else c.mnnemo  End     
                                  Else      
                                      case when a.cacodmon2 = e.cacodmon2 then ' ' else d.mnnemo End      
                                  End     ,      
              'CpaMonto'   = case a.catipoper when 'C' then   
                                       case when a.camtomon1 = e.camtomon1 then  0 else e.camtomon1 End  
                                  Else   
                                       case when a.camtomon2 = e.camtomon2 then  0 else e.camtomon2 End          
                                  End ,  
              'VtaCodMon'  = Case a.catipoper when 'V' then  
                                       case  when a.cacodmon1 = e.cacodmon1 then 0 else e.cacodmon1 End  
                                  Else     
                                       case  when a.cacodmon2 = e.cacodmon2 then 0 else e.cacodmon2 End       
                                  End,    
              'VtaNemMon'  = Case a.catipoper when 'V' then   
                                       case  when a.cacodmon1 = e.cacodmon1 then ' ' else  c.mnnemo  End  
                                  Else   
                                       case  when a.cacodmon2 = e.cacodmon2 then ' ' else  d.mnnemo  End      
                                  End ,     
              'VtaMonto'   = Case a.catipoper when 'V' then   
                                       case  when a.camtomon1 = e.camtomon1 then 0 else e.camtomon1 End  
                                  Else   
                                       case  when a.camtomon2 = e.camtomon2 then 0 else e.camtomon2 End  
                                  End ,     
              'Modal'    = Case  when a.catipmoda = e.catipmoda then ' ' else e.catipmoda end     ,  
              'PreFut'   = Case  when a.caprecal  = e.caprecal  then  0  else e.caprecal  end     ,  
              'PreSpt'   = Case a.capremon1 when e.capremon1 then  0  else e.capremon1 end,      --Case  when a.capremon1 = e.capremon1 then  0  else e.capremon1 end     ,            
              'nomprop'  = @cnomprop  ,  
           'dirprop'  = @cdirprop  ,  
           'rutprop'  = @nrutprop  ,  
           'digprop'  = @cdigprop  ,  
           'FecInfo'  = @cfecha  ,  
           'codclie'  = @ncodclie      ,  
              'FecPro'   = @cfecpro    ,  
             'Marca'    = 'M'    ,   
           'Plazo'    = CASE WHEN CONVERT(CHAR(08),a.cafecvcto,112) = CONVERT(CHAR(08),e.cafecvcto,112) THEN 0 ELSE DATEDIFF(DD,a.cafecha, e.cafecvcto) END, 	
              'Apodera1'  = ISNULL( @ap1nombre , '' ) ,  
              'Cargo1'    = ISNULL( @ap1cargo  , '' ) ,  
              'Fono1'     = ISNULL( @ap1fono   , '' ) ,  
              'Apodera2'  = ISNULL( @ap2nombre , '' ) ,  
              'Cargo2'    = ISNULL( @ap2cargo  , '' ) ,  
              'Fono2'     = ISNULL( @ap2fono   , '' ) ,  
              'Contador'    = 0 ,  
              'CanPag'      = 0 ,  
             'CodPais'     = ISNULL(f.codigo_pais,0)   ,  
              'NomPais'     = ISNULL(f.nombre,'')  ,  
              'EmailApo1'   = @cEmailApo1 ,  
              'Sector Eco'  = 0, --b.CLACTIVIDA  ,  
              'cod_instru'  = '00', -- e.caoperrelaspot ,--'01'  
              'Prima'       = 0.0  
  
      /* FROM  mfca_log  a with (nolock) ,  
               view_cliente b with (nolock) ,  
        view_moneda  c with (nolock) , -- mdmn  c,  
        view_moneda  d with (nolock) , -- mdmn  d,  
               mfca   e with (nolock) ,  
               view_pais  f with (nolock)   -- Tabla de Paises   
         WHERE a.cafecmod   = @dfecha AND   
               a.cafecmod   > a.cafecha     And  
               a.canumoper  = e.canumoper   And  
      a.caprimero = 'S'            AND  
         a.catipoper IN ('C','V')     AND  
         a.cacodpos1 IN (1,2,3,12,11) AND        --> CS-AG  
        (a.cacodigo = b.clrut         AND  
         a.cacodcli = b.clcodigo  )   AND  
         a.cacodmon1 = c.mncodmon     AND  
         a.cacodmon2 = d.mncodmon     and  
         CONVERT(INT,f.codigo_pais ) =* b.clpais --AND  
 --                NOT EXISTS( SELECT * FROM #temp WHERE #temp.NumOpe = a.canumoper)  */  
 -- RQ 7619  
  FROM  mfca_log a with (nolock)  
  INNER JOIN view_cliente b with (nolock) ON  (a.cacodigo = b.clrut AND a.cacodcli = b.clcodigo  )   
  INNER JOIN view_moneda  c with (nolock) ON   a.cacodmon1 = c.mncodmon  
  INNER JOIN view_moneda  d with (nolock) ON   a.cacodmon2 = d.mncodmon  
  INNER JOIN mfca   e with (nolock) ON   a.canumoper  = e.canumoper  
  RIGHT OUTER JOIN view_pais  f with (nolock) ON CONVERT(INT,f.codigo_pais ) = b.clpais  
   WHERE a.cafecmod   > a.cafecha  
   AND a.cafecmod   = @dfecha   
   AND a.caprimero = 'S'              
   AND a.catipoper IN ('C','V')       
   AND a.cacodpos1 IN (1,2,3,12,11,14) 
   AND e.NumeroContratoCliente = 0  

   UNION

SELECT       'TipOpe'   = a.catipoper    ,  
              'NumOpe'   = a.canumoper    ,  
              'RutCli'   = a.cacodigo     ,  
              'DigCli'   = b.cldv         ,   
              'NomCli'   = b.clnombre     ,  
              'FecIni'   = CONVERT(CHAR(10),a.cafecha  ,103) ,  
              'FecTer'   = CASE WHEN CONVERT(CHAR(10),a.cafecvcto,103) = CONVERT(CHAR(10),e.cafecvcto,103) THEN CONVERT(CHAR(10),'',103) ELSE CONVERT(CHAR(10),a.cafecvcto,103) END, 	 --a.cafecvcto 
              'CpaCodMon'  = case a.catipoper when e.catipoper then 0 else  case a.catipoper when  'C' then a.cacodmon1 else a.cacodmon2 End End    ,                 
              'CpaNemMon'  = case a.catipoper when 'C' then            
                                  case when a.cacodmon1 = e.cacodmon1 then ' ' else c.mnnemo  End     
                                  Else      
                                      case when a.cacodmon2 = e.cacodmon2 then ' ' else d.mnnemo End      
                                  End     ,      
              'CpaMonto' = case a.catipoper when 'C' then   
                                       case when a.camtomon1 = e.camtomon1 then  0.0 else e.camtomon1 End  
                                  Else   
                                       case when a.camtomon2 = e.camtomon2  or a.cacodpos1 = 14 then  0.0 else e.camtomon2 End          
                                  End ,    
              'VtaCodMon'  = Case a.catipoper when 'V' then  
                                       case  when a.cacodmon1 = e.cacodmon1 then 0 else e.cacodmon1 End  
                                  Else     
                                       case  when a.cacodmon2 = e.cacodmon2 then 0 else e.cacodmon2 End       
                                  End,    
              'VtaNemMon'  = Case a.catipoper when 'V' then   
                                       case  when a.cacodmon1 = e.cacodmon1 then ' ' else  c.mnnemo  End  
                                  Else   
                                       case  when a.cacodmon2 = e.cacodmon2 then ' ' else  d.mnnemo  End      
                                  End ,     
              'VtaMonto'   = Case a.catipoper when 'V' then   
                                       case  when a.camtomon1 = e.camtomon1 then 0.0 else e.camtomon1 End  
                                  Else   
                                       case  when a.camtomon2 = e.camtomon2  or a.cacodpos1 = 14 then 0 else e.camtomon2 End  
                                  End ,     
              'Modal'    = Case  when a.catipmoda = e.catipmoda then ' ' else e.catipmoda end     ,  
              'PreFut'   = Case  when a.caprecal  = e.caprecal  then  0  else e.caprecal  end     ,  
              'PreSpt'   = Case a.capremon1 when e.capremon1 then  0  else e.capremon1 end,      --Case  when a.capremon1 = e.capremon1 then  0  else e.capremon1 end     ,            
              'nomprop'  = @cnomprop  ,  
           'dirprop'  = @cdirprop  ,  
           'rutprop'  = @nrutprop  ,  
           'digprop'  = @cdigprop  ,  
           'FecInfo'  = @cfecha  ,  
           'codclie'  = @ncodclie      ,  
              'FecPro'   = @cfecpro    ,  
             'Marca'    = 'M'    ,   
           'Plazo'    = CASE WHEN CONVERT(CHAR(08),a.cafecvcto,112) = CONVERT(CHAR(08),e.cafecvcto,112) THEN 0 ELSE DATEDIFF(DD,a.cafecha, a.cafecvcto) END, 	 --a.cafecvcto
              'Apodera1'  = ISNULL( @ap1nombre , '' ) ,  
              'Cargo1'    = ISNULL( @ap1cargo  , '' ) ,  
              'Fono1'     = ISNULL( @ap1fono   , '' ) ,  
              'Apodera2'  = ISNULL( @ap2nombre , '' ) ,  
              'Cargo2'    = ISNULL( @ap2cargo  , '' ) ,  
              'Fono2'     = ISNULL( @ap2fono   , '' ) ,  
              'Contador'    = 0 ,  
              'CanPag'      = 0 ,  
             'CodPais'     = ISNULL(f.codigo_pais,0)   ,  
              'NomPais'     = ISNULL(f.nombre,'')  ,  
              'EmailApo1'   = @cEmailApo1 ,  
              'Sector Eco'  = 0 ,    --b.CLACTIVIDA  ,  
              'cod_instru'  = '00' , -- e.caoperrelaspot ,--'01'  
              'Prima'       = 0.0  
  
      /* FROM  mfca_log  a with (nolock) ,  
               view_cliente b with (nolock) ,  
        view_moneda  c with (nolock) , -- mdmn  c,  
        view_moneda  d with (nolock) , -- mdmn  d,  
               mfca   e with (nolock) ,  
               view_pais  f with (nolock)   -- Tabla de Paises   
         WHERE a.cafecmod   = @dfecha AND   
               a.cafecmod   > a.cafecha     And  
               a.canumoper  = e.canumoper   And  
      a.caprimero = 'S'            AND  
         a.catipoper IN ('C','V')     AND  
         a.cacodpos1 IN (1,2,3,12,11) AND        --> CS-AG  
        (a.cacodigo = b.clrut         AND  
         a.cacodcli = b.clcodigo  )   AND  
         a.cacodmon1 = c.mncodmon     AND  
         a.cacodmon2 = d.mncodmon     and  
         CONVERT(INT,f.codigo_pais ) =* b.clpais --AND  
 --                NOT EXISTS( SELECT * FROM #temp WHERE #temp.NumOpe = a.canumoper)  */  
 -- RQ 7619  
  FROM  mfcah a with (nolock)  
  INNER JOIN view_cliente b with (nolock) ON  (a.cacodigo = b.clrut AND a.cacodcli = b.clcodigo  )   
  INNER JOIN view_moneda  c with (nolock) ON   a.cacodmon1 = c.mncodmon  
  INNER JOIN view_moneda  d with (nolock) ON   a.cacodmon2 = d.mncodmon  
  INNER JOIN mfca_log   e with (nolock) ON   a.canumoper  = e.canumoper  
  RIGHT OUTER JOIN view_pais  f with (nolock) ON CONVERT(INT,f.codigo_pais ) = b.clpais  
   WHERE a.cafecmod   > a.cafecha  
   AND a.cafecmod   = @dfecha   
   AND e.caprimero = 'S'              
   AND a.catipoper IN ('C','V')       
   AND a.cacodpos1 IN (1,2,3,12,11,14) 
   AND a.NumeroContratoCliente = 0  



 /*=======================================================================*/  
--   Anticipos Forward
 /*=======================================================================*/  
 
   DECLARE @Fecha_ant_Habil DATETIME
   DECLARE @Fecha_Proceso   DATETIME
   SELECT  @Fecha_ant_Habil = acfecante 
        ,  @Fecha_Proceso 	= acfecproc  
   FROM mfac      

 
IF  @dfecha =@Fecha_Proceso  
BEGIN
--- Anticipos Totales   
    INSERT INTO  #temp            
	SELECT 'TipOpe'  = a.CaTipOper 
         , 'NumOpe'  = a.Canumoper 
         , 'RutCli'  = a.cacodigo    
		 , 'DigCli'  = CLIENTE.cldv  
         , 'NomCli'  = CLIENTE.clnombre
         , 'FecIni'   = CONVERT(CHAR(10),ORIGINAL.cafecha  ,103)  -- CONVERT(CHAR(10),A.cafecha  ,103)
         , 'FecTer'   = CASE WHEN CONVERT(CHAR(10),a.cafecvcto,103) = CONVERT(CHAR(10),ORIGINAL.cafecvcto,103) THEN CONVERT(CHAR(10),'        ',103) ELSE CONVERT(CHAR(10),a.cafecvcto,103) END -- CONVERT(CHAR(10),A.cafecvcto,103)              
         , 'CpaCodMon'= case a.catipoper when ORIGINAL.catipoper then 0 else  case a.catipoper when'C' then a.cacodmon1 else a.cacodmon2 End End       
		 , 'CpaNemMon'= Case a.catipoper when 'C' then 
								     case when a.cacodmon1 = ORIGINAL.cacodmon1 then ' ' else MONEDA1.mnnemo end     	
								  Else 
									  case when a.cacodmon2 = ORIGINAL.cacodmon2 then ' ' else MONEDA2.mnnemo end      	
								  End
		 , 'CpaMonto' = Case a.catipoper when 'C' then 
								      case when a.camtomon1 = ORIGINAL.camtomon1  then  0 else a.camtomon1 end  
							      Else 
									  case when a.camtomon2 = ORIGINAL.camtomon2 then  0 else a.camtomon2 end          
								  End
		 , 'VtaCodMon'= Case a.catipoper when 'V' then 
								   case  when a.cacodmon1 = ORIGINAL.cacodmon1 then 0 else a.cacodmon1 end  
							 Else 
								   case  when a.cacodmon2 = ORIGINAL.cacodmon2 then 0 else a.cacodmon2 end       	
							 End
		 , 'VtaNemMon'= Case a.catipoper when 'V' then 
										case  when a.cacodmon1 = ORIGINAL.cacodmon1 then ' ' else  MONEDA1.mnnemo  end  
								  Else 
										case  when a.cacodmon2 = ORIGINAL.cacodmon2 then ' ' else  (CASE WHEN a.var_moneda2 > 0 THEN 'CLP' ELSE MONEDA2.mnnemo END)  end      
								  End
		 , 'VtaMonto' = Case a.catipoper when 'V' then 
									      	case  when a.camtomon1 = ORIGINAL.camtomon1 then 0 else a.camtomon1 end  
						                 Else 
											case  when a.camtomon2 = ORIGINAL.camtomon2 then 0 else (CASE WHEN a.var_moneda2 > 0 THEN a.caequmon2 ELSE a.camtomon2 END) End  	
										 End
		 , 'Modal'    = Case  when a.catipmoda = ORIGINAL.catipmoda then ' ' else a.catipmoda End   
         , 'PreFut'   = 0.0 /*CASE  WHEN a.cacodpos1 = 3  THEN (Case  when a.capremon2  = ORIGINAL.capremon2  then  0  else a.capremon2  end)   
						   	  WHEN a.cacodpos1 = 13 THEN (Case  when a.capremon2  = ORIGINAL.capremon2  then  0  else a.capremon2  end)  
						      WHEN a.cacodpos1 = 11 THEN (Case  when a.catipcam  = ORIGINAL.catipcam  then  0  else a.catipcam end)  --> CS-AG  
						      WHEN a.cacodpos1 = 2  THEN CASE WHEN a.var_moneda2 > 0 THEN (Case  when a.caprecal = ORIGINAL.caprecal  then  0  else a.caprecal end) ELSE (Case  when a.catipcam  = ORIGINAL.catipcam  then  0  else a.catipcam end)   END  
						ELSE  (Case  when a.caprecal  = ORIGINAL.caprecal  then  0  else a.caprecal end)   
				        END*/

/*
         , 'PreFut'   = CASE  WHEN a.cacodpos1 = 3  THEN a.capremon2   
						 WHEN a.cacodpos1 = 13 THEN a.capremon2  
						 WHEN a.cacodpos1 = 11 THEN a.catipcam  --> CS-AG  
						 WHEN a.cacodpos1 = 2  THEN CASE WHEN a.var_moneda2 > 0 THEN a.caprecal ELSE a.catipcam  END  
				   ELSE       a.caprecal   
				   END
*/
         , 'PreSpt'   = 0.0 --Case a.capremon1 when ORIGINAL.capremon1 then  0  else a.capremon1 end 
         , 'nomprop'  = @cnomprop
         , 'dirprop'  = @cdirprop
         , 'rutprop'  = @nrutprop
         , 'digprop'  = @cdigprop
         , 'FecInfo'  = @cfecha
         , 'codclie'  = @ncodclie
         , 'FecPro'   = @cfecpro
         , 'Marca'    = 'M' 
         , 'Plazo'    = CASE WHEN CONVERT(CHAR(08),a.cafecvcto,112) = CONVERT(CHAR(08),ORIGINAL.cafecvcto,112) THEN 0 ELSE DATEDIFF(DD,ORIGINAL.cafecha, a.cafecvcto) END
         , 'Apodera1' = ISNULL( @ap1nombre , '' )
         , 'Cargo1'   = ISNULL( @ap1cargo  , '' )
         , 'Fono1'    = ISNULL( @ap1fono   , '' )
         , 'Apodera2' = ISNULL( @ap2nombre , '' )
         , 'Cargo2'   = ISNULL( @ap2cargo  , '' )
         , 'Fono2'    = ISNULL( @ap2fono   , '' )
         , 'Contador' = 0
         , 'CanPag'   = 0
	     , 'CodPais'	= ISNULL(e.codigo_pais,0)
		 , 'NomPais'	= ISNULL(e.nombre,'')
		 , 'EmailApo1'	= @cEmailApo1
		 , 'Sector Eco'	= 0 --CLIENTE.CLACTIVIDA
		 , 'cod_instru'	= '00' -- a.caoperrelaspot
		 , 'Prima'		= CONVERT(FLOAT,0.0)           
	FROM  MFCA AS a 
        , MFCARES AS ORIGINAL
		, BacParamSuda..MONEDA AS MONEDA1
		, BacParamSuda..MONEDA AS MONEDA2
		, BacParamSuda..MONEDA AS MONEDACOMP
		, VIEW_CLIENTE AS CLIENTE
        , view_pais  e  
	WHERE a.cafecvcto      =  @dfecha -- @Fecha_usuario 
	AND   a.caantici       = 'A'
	AND   MONEDA1.MnCodMon     = a.CaCodMon1	
	AND   MONEDA2.MnCodMon     = a.CaCodMon2	
	AND   MONEDACOMP.MnCodMon  = a.Moneda_Compensacion
	AND   a.CaCodigo       = CLIENTE.ClRut
	AND   a.CaCodCli       = CLIENTE.ClCodigo     
	AND   ORIGINAL.CaFechaProceso =  @Fecha_ant_Habil 
	AND   ORIGINAL.Canumoper    = a.NumeroContratoCliente
    AND   a.Canumoper           = a.NumeroContratoCliente 
    AND   CONVERT(INT,e.codigo_pais ) = CLIENTE.clpais  
    ORDER BY A.NumeroContratoCliente


--- Anticipos Parciales  
--- Saldo    
    SELECT a.canumoper
         , a.cafecvcto
         , a.NumeroContratoCliente  
    INTO #AntParcialSaldo
	FROM  MFCA AS a 
        , MFCARES AS ORIGINAL
		, BacParamSuda..MONEDA AS MONEDA1
		, BacParamSuda..MONEDA AS MONEDA2
		, BacParamSuda..MONEDA AS MONEDACOMP
		, VIEW_CLIENTE AS CLIENTE
        , view_pais  e  
	WHERE a.cafecvcto      =  @dfecha -- @Fecha_usuario 
	AND   a.caantici       = 'A'
	AND   MONEDA1.MnCodMon     = a.CaCodMon1	
	AND   MONEDA2.MnCodMon     = a.CaCodMon2	
	AND   MONEDACOMP.MnCodMon  = a.Moneda_Compensacion
	AND   a.CaCodigo       = CLIENTE.ClRut
	AND   a.CaCodCli       = CLIENTE.ClCodigo     
	AND   ORIGINAL.CaFechaProceso =  @Fecha_ant_Habil 
	AND   ORIGINAL.Canumoper      = a.NumeroContratoCliente
    AND   a.Canumoper             <> a.NumeroContratoCliente 
    AND   CONVERT(INT,e.codigo_pais ) = CLIENTE.clpais  
    ORDER BY A.NumeroContratoCliente



	 INSERT INTO  #temp            
	 SELECT       'TipOpe'   = a.catipoper    ,  
				  'NumOpe'   = a.canumoper    ,  
				  'RutCli'   = a.cacodigo     ,  
				  'DigCli'   = b.cldv         ,   
				  'NomCli'   = b.clnombre     ,  
				  'FecIni'   = CONVERT(CHAR(10),a.cafecha  ,103) ,  
				  'FecTer'   = CASE WHEN CONVERT(CHAR(10),a.cafecvcto,103) = CONVERT(CHAR(10),e.cafecvcto,103) THEN CONVERT(CHAR(10),'        ',103) ELSE CONVERT(CHAR(10),a.cafecvcto,103) END,
				  'CpaCodMon'  = case a.catipoper when e.catipoper then 0 else  case a.catipoper when  'C' then a.cacodmon1 else a.cacodmon2 End End    ,                 
				  'CpaNemMon'  = case a.catipoper when 'C' then            
									  case when a.cacodmon1 = e.cacodmon1 then ' ' else c.mnnemo  End     
									  Else      
										  case when a.cacodmon2 = e.cacodmon2 then ' ' else d.mnnemo End      
									  End     ,      
				  'CpaMonto'   = case a.catipoper when 'C' then   
										   case when a.camtomon1 = e.camtomon1 then  0 else e.camtomon1 End  
									  Else   
										   case when a.camtomon2 = e.camtomon2 then  0 else e.camtomon2 End          
									  End ,  
				  'VtaCodMon'  = Case a.catipoper when 'V' then  
										   case  when a.cacodmon1 = e.cacodmon1 then 0 else e.cacodmon1 End  
									  Else     
										   case  when a.cacodmon2 = e.cacodmon2 then 0 else e.cacodmon2 End       
									  End,    
				  'VtaNemMon'  = Case a.catipoper when 'V' then   
										   case  when a.cacodmon1 = e.cacodmon1 then ' ' else  c.mnnemo  End  
									  Else   
										   case  when a.cacodmon2 = e.cacodmon2 then ' ' else  d.mnnemo  End      
									  End ,     
				  'VtaMonto'   = Case a.catipoper when 'V' then   
										   case  when a.camtomon1 = e.camtomon1 then 0 else e.camtomon1 End  
									  Else   
										   case  when a.camtomon2 = e.camtomon2 then 0 else e.camtomon2 End  
									  End ,     
				  'Modal'    = Case  when a.catipmoda = e.catipmoda then ' ' else e.catipmoda end     ,  
				  'PreFut'   = Case  when a.caprecal  = e.caprecal  then  0  else e.caprecal  end     ,  
				  'PreSpt'   = Case a.capremon1 when e.capremon1 then  0  else e.capremon1 end,      --Case  when a.capremon1 = e.capremon1 then  0  else e.capremon1 end     ,            
				  'nomprop'  = @cnomprop  ,  
			   'dirprop'  = @cdirprop  ,  
			   'rutprop'  = @nrutprop  ,  
			   'digprop'  = @cdigprop  ,  
			   'FecInfo'  = @cfecha  ,  
			   'codclie'  = @ncodclie      ,  
				  'FecPro'   = @cfecpro    ,  
				 'Marca'    = 'M'    ,   
			   'Plazo'    = case when a.caplazo = e.caplazo then 0 else e.caplazo    end ,  
				  'Apodera1'  = ISNULL( @ap1nombre , '' ) ,  
				  'Cargo1'    = ISNULL( @ap1cargo  , '' ) ,  
				  'Fono1'     = ISNULL( @ap1fono   , '' ) ,  
				  'Apodera2'  = ISNULL( @ap2nombre , '' ) ,  
				  'Cargo2'    = ISNULL( @ap2cargo  , '' ) ,  
				  'Fono2'     = ISNULL( @ap2fono   , '' ) ,  
				  'Contador'    = 0 ,  
				  'CanPag'      = 0 ,  
				 'CodPais'     = ISNULL(f.codigo_pais,0)   ,  
				  'NomPais'     = ISNULL(f.nombre,'')  ,  
				  'EmailApo1'   = @cEmailApo1 ,  
				  'Sector Eco'  = b.CLACTIVIDA  ,  
				  'cod_instru'  = e.caoperrelaspot ,--'01'  
				  'Prima'       = 0.0  
	  
	   FROM  mfca_log a with (nolock)           
	   INNER JOIN view_cliente      b with (nolock) ON  (a.cacodigo = b.clrut AND a.cacodcli = b.clcodigo  )   
	   INNER JOIN view_moneda       c with (nolock) ON   a.cacodmon1 = c.mncodmon  
	   INNER JOIN view_moneda       d with (nolock) ON   a.cacodmon2 = d.mncodmon  
	   INNER JOIN mfca              e with (nolock) ON   a.canumoper  = e.canumoper  
	   INNER JOIN #AntParcialSaldo  AntParcial with (nolock) ON   AntParcial.NumeroContratoCliente = e.canumoper   
	   RIGHT OUTER JOIN view_pais  f with (nolock) ON CONVERT(INT,f.codigo_pais ) = b.clpais  
	   WHERE a.cafecmod   > a.cafecha  
		 AND a.cafecmod   = @dfecha   
		 AND a.caprimero = 'S'              
		 AND a.catipoper IN ('C','V')       
		 AND a.cacodpos1 IN (1,2,12,11,14)
         AND e.canumoper = e.NumeroContratoCliente

    END
    ELSE	
    BEGIN
    SELECT  @Fecha_ant_Habil = acfecante FROM mfach WHERE acfecproc = @dfecha -- @Fecha_usuario
    INSERT INTO  #temp            
	SELECT 'TipOpe'  = a.CaTipOper 
         , 'NumOpe'  = a.Canumoper 
         , 'RutCli'  = a.cacodigo    
		 , 'DigCli'  = CLIENTE.cldv  
         , 'NomCli'  = CLIENTE.clnombre
         , 'FecIni'   = CONVERT(CHAR(10),ORIGINAL.cafecha  ,103) 
         , 'FecTer'   = CASE WHEN CONVERT(CHAR(10),a.cafecvcto,103) = CONVERT(CHAR(10),ORIGINAL.cafecvcto,103) THEN CONVERT(CHAR(10),'',103) ELSE CONVERT(CHAR(10),a.cafecvcto,103) END -- CONVERT(CHAR(08),A.cafecvcto,112) ,   
         , 'CpaCodMon'= case a.catipoper when ORIGINAL.catipoper then 0 else  case a.catipoper when'C' then a.cacodmon1 else a.cacodmon2 End End       
		 , 'CpaNemMon'= Case a.catipoper when 'C' then 
								     case when a.cacodmon1 = ORIGINAL.cacodmon1 then ' ' else MONEDA1.mnnemo end     	
								  Else 
									  case when a.cacodmon2 = ORIGINAL.cacodmon2 then ' ' else MONEDA2.mnnemo end      	
								  End
		 , 'CpaMonto' = Case a.catipoper when 'C' then 
								      case when a.camtomon1 = ORIGINAL.camtomon1  then  0 else a.camtomon1 end  
							      Else 
									  case when a.camtomon2 = ORIGINAL.camtomon2 then  0 else a.camtomon2 end          
								  End
		 , 'VtaCodMon'= Case a.catipoper when 'V' then 
								   case  when a.cacodmon1 = ORIGINAL.cacodmon1 then 0 else a.cacodmon1 end  
							 Else 
								   case  when a.cacodmon2 = ORIGINAL.cacodmon2 then 0 else a.cacodmon2 end       	
							 End
		 , 'VtaNemMon'= Case a.catipoper when 'V' then 
										case  when a.cacodmon1 = ORIGINAL.cacodmon1 then ' ' else  MONEDA1.mnnemo  end  
								  Else 
										case  when a.cacodmon2 = ORIGINAL.cacodmon2 then ' ' else  (CASE WHEN a.var_moneda2 > 0 THEN 'CLP' ELSE MONEDA2.mnnemo END)  end      
								  End
		 , 'VtaMonto' = Case a.catipoper when 'V' then 
									      	case  when a.camtomon1 = ORIGINAL.camtomon1 then 0 else a.camtomon1 end  
						                 Else 
											case  when a.camtomon2 = ORIGINAL.camtomon2 then 0 else (CASE WHEN a.var_moneda2 > 0 THEN a.caequmon2 ELSE a.camtomon2 END) End  	
										 End
		 , 'Modal'    = Case  when a.catipmoda = ORIGINAL.catipmoda then ' ' else a.catipmoda End   
         , 'PreFut'   = 0.0 /*CASE  WHEN a.cacodpos1 = 3  THEN (Case  when a.capremon2  = ORIGINAL.capremon2  then  0  else a.capremon2  end)   
						   	  WHEN a.cacodpos1 = 13 THEN (Case  when a.capremon2  = ORIGINAL.capremon2  then  0  else a.capremon2  end)  
						      WHEN a.cacodpos1 = 11 THEN (Case  when a.catipcam  = ORIGINAL.catipcam  then  0  else a.catipcam end)  --> CS-AG  
						      WHEN a.cacodpos1 = 2  THEN CASE WHEN a.var_moneda2 > 0 THEN (Case  when a.caprecal  = ORIGINAL.caprecal  then  0  else a.caprecal end) ELSE (Case  when a.catipcam  = ORIGINAL.catipcam  then  0  else a.catipcam end)   END  
						ELSE  (Case  when a.caprecal  = ORIGINAL.caprecal  then  0  else a.caprecal end)   
				        END*/

/*
         , 'PreFut'   = CASE  WHEN a.cacodpos1 = 3  THEN a.capremon2   
						 WHEN a.cacodpos1 = 13 THEN a.capremon2  
						 WHEN a.cacodpos1 = 11 THEN a.catipcam  --> CS-AG  
						 WHEN a.cacodpos1 = 2  THEN CASE WHEN a.var_moneda2 > 0 THEN a.caprecal ELSE a.catipcam  END  
				   ELSE       a.caprecal   
				   END
*/
         , 'PreSpt'   = 0.0 --Case a.capremon1 when ORIGINAL.capremon1 then  0  else a.capremon1 end 
         , 'nomprop'  = @cnomprop
         , 'dirprop'  = @cdirprop
         , 'rutprop'  = @nrutprop
         , 'digprop'  = @cdigprop
         , 'FecInfo'  = @cfecha
         , 'codclie'  = @ncodclie
         , 'FecPro'   = @cfecpro
         , 'Marca'    = 'M'
         , 'Plazo'    = CASE WHEN CONVERT(CHAR(08),a.cafecvcto,112) = CONVERT(CHAR(08),ORIGINAL.cafecvcto,112) THEN 0 ELSE DATEDIFF(DD,ORIGINAL.cafecha, a.cafecvcto)  END 
         , 'Apodera1' = ISNULL( @ap1nombre , '' )
         , 'Cargo1'   = ISNULL( @ap1cargo  , '' )
         , 'Fono1'    = ISNULL( @ap1fono   , '' )
         , 'Apodera2' = ISNULL( @ap2nombre , '' )
         , 'Cargo2'   = ISNULL( @ap2cargo  , '' )
         , 'Fono2'    = ISNULL( @ap2fono   , '' )
         , 'Contador' = 0
         , 'CanPag'   = 0
	     , 'CodPais'	= ISNULL(e.codigo_pais,0)
		 , 'NomPais'	= ISNULL(e.nombre,'')
		 , 'EmailApo1'	= @cEmailApo1
		 , 'Sector Eco'	=  0 -- CLIENTE.CLACTIVIDA
		 , 'cod_instru'	= '00' -- a.caoperrelaspot
		 , 'Prima'		= CONVERT(FLOAT,0.0)           
	from 	MFCARES As A , MFCARES As ORIGINAL
		, BacParamSuda..MONEDA As MONEDA1
		, BacParamSuda..MONEDA As MONEDA2
		, BacParamSuda..MONEDA As MONEDACOMP
		, VIEW_CLIENTE As CLIENTE
        , view_pais  e          
	where A.CaFechaProceso = @dfecha        --@Fecha_usuario
	and   A.cafecvcto      = @dfecha        -- @Fecha_usuario 
	and   A.caantici = 'A'
	and   MONEDA1.MnCodMon  = A.CaCodMon1	
	and   MONEDA2.MnCodMon  = A.CaCodMon2	
	and   MONEDACOMP.MnCodMon = A.Moneda_Compensacion
	and   A.CaCodigo = CLIENTE.ClRut
	and   A.CaCodCli = CLIENTE.ClCodigo 
	and   ORIGINAL.CaFechaProceso =  @Fecha_ant_Habil 
	and   ORIGINAL.Canumoper = A.NumeroContratoCliente  
    and   A.Canumoper        = A.NumeroContratoCliente 
    and   CONVERT(INT,e.codigo_pais ) = CLIENTE.clpais        
    ORDER BY A.NumeroContratoCliente

-- Anticipos Parciales Saldo
    
    SELECT a.canumoper
         , a.cafecvcto
         , a.NumeroContratoCliente  
    INTO #AntParcialSaldoHis
	FROM  MFCARES AS a 
        , MFCARES AS ORIGINAL
		, BacParamSuda..MONEDA AS MONEDA1
		, BacParamSuda..MONEDA AS MONEDA2
		, BacParamSuda..MONEDA AS MONEDACOMP
		, VIEW_CLIENTE AS CLIENTE
        , view_pais  e  
	WHERE a.CaFechaProceso = @dfecha        --@Fecha_usuario
	AND   a.cafecvcto      =  @dfecha		-- @Fecha_usuario 
	AND   a.caantici       = 'A'
	AND   MONEDA1.MnCodMon     = a.CaCodMon1	
	AND   MONEDA2.MnCodMon     = a.CaCodMon2	
	AND   MONEDACOMP.MnCodMon  = a.Moneda_Compensacion
	AND   a.CaCodigo       = CLIENTE.ClRut
	AND   a.CaCodCli       = CLIENTE.ClCodigo     
	AND   ORIGINAL.CaFechaProceso =  @Fecha_ant_Habil 
	AND   ORIGINAL.Canumoper      = a.NumeroContratoCliente
    AND   a.Canumoper             <> a.NumeroContratoCliente 
    AND   CONVERT(INT,e.codigo_pais ) = CLIENTE.clpais  
    ORDER BY A.NumeroContratoCliente
 

	 INSERT INTO  #temp            
	 SELECT       'TipOpe'   = a.catipoper    ,  
				  'NumOpe'   = a.canumoper    ,  
				  'RutCli'   = a.cacodigo     ,  
				  'DigCli'   = b.cldv         ,   
				  'NomCli'   = b.clnombre     ,  
				  'FecIni'   = CONVERT(CHAR(10),a.cafecha  ,103) ,  
				  'FecTer'   = CASE WHEN CONVERT(CHAR(10),a.cafecvcto,103) = CONVERT(CHAR(10),e.cafecvcto,103) THEN CONVERT(CHAR(10),'',103) ELSE CONVERT(CHAR(10),a.cafecvcto,103) END,-- CONVERT(CHAR(08),A.cafecvcto,112) ,  
				  'CpaCodMon'  = case a.catipoper when e.catipoper then 0 else  case a.catipoper when  'C' then a.cacodmon1 else a.cacodmon2 End End    ,                 
				  'CpaNemMon'  = case a.catipoper when 'C' then            
									  case when a.cacodmon1 = e.cacodmon1 then ' ' else c.mnnemo  End     
									  Else      
										  case when a.cacodmon2 = e.cacodmon2 then ' ' else d.mnnemo End      
									  End     ,      
				  'CpaMonto'   = case a.catipoper when 'C' then   
										   case when a.camtomon1 = e.camtomon1 then  0 else e.camtomon1 End  
									  Else   
										   case when a.camtomon2 = e.camtomon2 then  0 else e.camtomon2 End          
									  End ,  
				  'VtaCodMon'  = Case a.catipoper when 'V' then  
										   case  when a.cacodmon1 = e.cacodmon1 then 0 else e.cacodmon1 End  
									  Else     
										   case  when a.cacodmon2 = e.cacodmon2 then 0 else e.cacodmon2 End       
									  End,    
				  'VtaNemMon'  = Case a.catipoper when 'V' then   
										   case  when a.cacodmon1 = e.cacodmon1 then ' ' else  c.mnnemo  End  
									  Else   
										   case  when a.cacodmon2 = e.cacodmon2 then ' ' else  d.mnnemo  End      
									  End ,     
				  'VtaMonto'   = Case a.catipoper when 'V' then   
										   case  when a.camtomon1 = e.camtomon1 then 0 else e.camtomon1 End  
									  Else   
										   case  when a.camtomon2 = e.camtomon2 then 0 else e.camtomon2 End  
									  End ,     
				  'Modal'    = Case  when a.catipmoda = e.catipmoda then ' ' else e.catipmoda end     ,  
				  'PreFut'   = Case  when a.caprecal  = e.caprecal  then  0  else e.caprecal  end     ,  
				  'PreSpt'   = Case a.capremon1 when e.capremon1 then  0  else e.capremon1 end,      --Case  when a.capremon1 = e.capremon1 then  0  else e.capremon1 end     ,            
				  'nomprop'  = @cnomprop  ,  
			   'dirprop'  = @cdirprop  ,  
			   'rutprop'  = @nrutprop  ,  
			   'digprop'  = @cdigprop  ,  
			   'FecInfo'  = @cfecha  ,  
			   'codclie'  = @ncodclie      ,  
				  'FecPro'   = @cfecpro    ,  
				 'Marca'    = 'M'    ,   
			   'Plazo'    = case when a.caplazo = e.caplazo then 0 else e.caplazo    end ,  
				  'Apodera1'  = ISNULL( @ap1nombre , '' ) ,  
				  'Cargo1'    = ISNULL( @ap1cargo  , '' ) ,  
				  'Fono1'     = ISNULL( @ap1fono   , '' ) ,  
				  'Apodera2'  = ISNULL( @ap2nombre , '' ) ,  
				  'Cargo2'    = ISNULL( @ap2cargo  , '' ) ,  
				  'Fono2'     = ISNULL( @ap2fono   , '' ) ,  
				  'Contador'    = 0 ,  
				  'CanPag'      = 0 ,  
				 'CodPais'     = ISNULL(f.codigo_pais,0)   ,  
				  'NomPais'     = ISNULL(f.nombre,'')  ,  
				  'EmailApo1'   = @cEmailApo1 ,  
				  'Sector Eco'  = b.CLACTIVIDA  ,  
				  'cod_instru'  = e.caoperrelaspot ,--'01'  
				  'Prima'       = 0.0  
	  
	   FROM  mfca_log a with (nolock)           
	   INNER JOIN view_cliente         b with (nolock) ON  (a.cacodigo = b.clrut AND a.cacodcli = b.clcodigo  )   
	   INNER JOIN view_moneda          c with (nolock) ON   a.cacodmon1 = c.mncodmon  
	   INNER JOIN view_moneda          d with (nolock) ON   a.cacodmon2 = d.mncodmon  
	   INNER JOIN MFCARES              e with (nolock) ON   a.canumoper  = e.canumoper  
	   INNER JOIN #AntParcialSaldoHis  AntParcial with (nolock) ON   AntParcial.NumeroContratoCliente = e.canumoper   
	   RIGHT OUTER JOIN view_pais  f with (nolock) ON CONVERT(INT,f.codigo_pais ) = b.clpais  
	   WHERE a.cafecmod   > a.cafecha  
		 AND a.cafecmod   = @dfecha   
		 AND a.caprimero = 'S'              
		 AND a.catipoper IN ('C','V')       
		 AND a.cacodpos1 IN (1,2,12,11,14)
         AND e.canumoper = e.NumeroContratoCliente        


    END     



--***************************************SWAP**************************************************************  
-- INICIO INGRESOS SWAP

   CREATE TABLE #CARTERA
      (   compra_amortiza          NUMERIC(19,4)   NOT NULL DEFAULT(0.0)  
      ,   compra_interes           NUMERIC(19,4)   NOT NULL DEFAULT(0.0)  
      ,   venta_amortiza           NUMERIC(19,4)   NOT NULL DEFAULT(0.0)  
      ,   venta_interes            NUMERIC(19,4)   NOT NULL DEFAULT(0.0)  
      ,   fecha_inicio             DATETIME     NOT NULL DEFAULT('')  
      ,   tipo_operacion           CHAR(1)      NOT NULL DEFAULT('')  
      ,   tipo_swap                INTEGER      NOT NULL DEFAULT(0)  
      ,	  numero_flujo	           NUMERIC(3)   NOT NULL DEFAULT(0)  
	  ,	  rut_cliente	           NUMERIC(9)   NOT NULL DEFAULT(0)  
	  ,	  Dig_Rut			       CHAR(1)      NOT NULL DEFAULT('')  
      ,	  codigo_cliente	       NUMERIC(9)   NOT NULL DEFAULT(0)  
      ,   Rec_Moneda               NUMERIC(3)   NOT NULL DEFAULT(0)  
      ,   Pag_Moneda               NUMERIC(3)   NOT NULL DEFAULT(0)  
      ,	  Rec_Nemo_Moneda		   CHAR(8)      NOT NULL DEFAULT('')  
      ,	  Pag_Nemo_Moneda		   CHAR(8)      NOT NULL DEFAULT('')  
      ,   fecha_termino            DATETIME     NOT NULL DEFAULT('')  
	  ,	  numero_operacion         NUMERIC(9)   NOT NULL DEFAULT(0)  
      ,   modalidad_pago           CHAR(1)      NOT NULL DEFAULT('')  
      ,   compra_moneda            NUMERIC(3)   NOT NULL DEFAULT(0)  
      ,   venta_moneda             NUMERIC(3)   NOT NULL DEFAULT(0)  
      ,   compra_valor_tasa        NUMERIC(10,6)   NOT NULL DEFAULT(0.0)  
      ,   venta_valor_tasa         NUMERIC(10,6)   NOT NULL DEFAULT(0.0)  
      ,   fecha_cierre             DATETIME     NOT NULL DEFAULT('')  
      ,   compra_saldo             NUMERIC(19,4)   NOT NULL DEFAULT(0.0)
      ,   venta_saldo              NUMERIC(19,4)   NOT NULL DEFAULT(0.0)
      ,   compra_Flujo_adicional   FLOAT        NOT NULL DEFAULT(0.0)  
      ,   venta_Flujo_adicional    FLOAT        NOT NULL DEFAULT(0.0)  
      ,	  SwapCCS_X_Flujo	       NUMERIC(9)   NOT NULL DEFAULT(0)  
      ,   IntercPrincRec           INTEGER      NOT NULL DEFAULT(0)  
      ,   IntercPrincPag           INTEGER      NOT NULL DEFAULT(0)  
      ,   MontoRec                 FLOAT        NOT NULL DEFAULT(0.0)  
      ,   MontoEnt                 FLOAT        NOT NULL DEFAULT(0.0)        
      ,   compra_capital           NUMERIC(19,4)   NOT NULL DEFAULT(0.0)
      ,   venta_capital            NUMERIC(19,4)   NOT NULL DEFAULT(0.0)
      ,   Codigo_Inst              CHAR(3)      NOT NULL DEFAULT('')  
      ,   Estado_Flujo             NUMERIC(1)   NOT NULL DEFAULT(0)

/*
           CONSTRAINT [PK_CARTERA_CNT]   PRIMARY KEY CLUSTERED  
          (   Fecha_Cierre,   Tipo_Swap, Numero_Operacion )   ON [PRIMARY]  
*/
      )--  ON [PRIMARY]   

-- sp_help cartera

INSERT INTO #CARTERA
SELECT  DISTINCT compra_amortiza      = 0.0
      ,   compra_interes              = 0.0
      ,   venta_amortiza              = 0.0
      ,   venta_interes               = 0.0
      ,   fecha_inicio                = fecha_inicio
      ,   tipo_operacion              = tipo_operacion
      ,   tipo_swap                   = tipo_swap
      ,   numero_flujo				  = numero_flujo
      ,   rut_cliente                 = rut_cliente
      ,   Dig_Rut			          = Cldv
      ,   codigo_cliente              = codigo_cliente
      ,   Rec_Moneda			      = 0
      ,   Pag_Moneda                  = 0
      ,   Rec_Nemo_Moneda		      = ''
      ,   Pag_Nemo_Moneda             = ''
      ,   fecha_termino               = fecha_termino
      ,   numero_operacion            = numero_operacion 
      ,   modalidad_pago              = modalidad_pago
      ,   compra_moneda               = 0
      ,   venta_moneda                = 0
      ,   compra_valor_tasa           = 0.0
      ,   venta_valor_tasa            = 0.0
      ,   fecha_cierre                = fecha_cierre
      ,   compra_saldo                = 0.0
      ,   venta_saldo                 = 0.0
      ,   Compra_Flujo_Adicional      = 0.0
      ,   Venta_Flujo_Adicional       = 0.0
      ,   SwapCCS_X_Flujo             = 0
      ,   IntercPrincRec              = 0
      ,   IntercPrincPag              = 0
      ,   MontoRec                    = 0.0
      ,   MontoEnt                    = 0.0
      ,   compra_capital              = 0.0
      ,   venta_capital               = 0.0
      ,   Codigo_Inst                 = '08'      
      ,   Estado_Flujo		          = estado_flujo
   FROM   bacswapsuda.dbo.cartera with (nolock)
          LEFT JOIN BacParamSuda..CLIENTE with (nolock)   ON clrut = rut_cliente AND clcodigo = codigo_cliente
          LEFT JOIN BacParamSuda..MONEDA  m with (nolock) ON m.mncodmon = compra_moneda
   WHERE     fecha_cierre           =  @dfecha --  @cfecha
		 AND estado_flujo			<> 2 -- Excluir los flujos vencidos cuyos Valores Razonables son distintos y duplican los movimientos    

-- SELECT '#CARTERA_CER', * FROM #CARTERA 

   INSERT  INTO  #CARTERA
   SELECT  DISTINCT 
          compra_amortiza             = a.compra_amortiza
      ,   compra_interes              = a.compra_interes
      ,   venta_amortiza              = 0.0
      ,   venta_interes               = 0.0
      ,   fecha_inicio                = fecha_inicio
      ,   tipo_operacion              = tipo_operacion
      ,   tipo_swap                   = tipo_swap
,   numero_flujo				  = 0
      ,   rut_cliente                 = rut_cliente
      ,   Dig_Rut			          = Cldv
      ,   codigo_cliente              = codigo_cliente
      ,   Rec_Moneda			      = a.recibimos_moneda
      ,   Pag_Moneda                  = 0
      ,   Rec_Nemo_Moneda		      = Rec.mnnemo
      ,   Pag_Nemo_Moneda             = ''
      ,   fecha_termino               = fecha_termino
      ,   numero_operacion            = a.numero_operacion
      ,   modalidad_pago              = modalidad_pago
      ,   compra_moneda               = a.compra_moneda
      ,   venta_moneda                = 0
      ,   compra_valor_tasa           = a.compra_valor_tasa
      ,   venta_valor_tasa            = 0.0
      ,   fecha_cierre                = fecha_cierre
      ,   compra_saldo                = a.compra_saldo
      ,   venta_saldo                 = 0.0
      ,   Compra_Flujo_Adicional      = a.Compra_Flujo_Adicional
      ,   Venta_Flujo_Adicional       = 0.0
      ,   SwapCCS_X_Flujo             = 0
      ,   IntercPrincRec              = a.IntercPrinc
      ,   IntercPrincPag              = 0
      ,   MontoRec                    = convert(numeric(21,4), a.compra_saldo + a.compra_amortiza )
      ,   MontoEnt                    = 0.0
      ,   compra_capital              = a.compra_capital
      ,   venta_capital               = 0.0
      ,   Codigo_Inst                 = '07'   
      ,   Estado_Flujo                = a.estado_flujo
   
   FROM  bacswapsuda.dbo.cartera  a with (nolock)
         inner join bacparamsuda.dbo.cliente cli with (nolock) on cli.clrut             = rut_cliente and cli.clcodigo = codigo_cliente
         inner join bacparamsuda.dbo.moneda  Rec with (nolock) on Rec.mncodmon          = a.recibimos_moneda
   WHERE  a.fecha_cierre           = @dfecha   --  @cfecha
    AND   a.tipo_flujo             = 1
    AND   a.estado_flujo		   = 1
    AND   a.tipo_swap              = 2
  
   UPDATE #CARTERA
   SET    venta_amortiza              = a.venta_amortiza
      ,   venta_interes               = a.venta_interes
      ,   Pag_Moneda                  = a.pagamos_moneda
      ,   Pag_Nemo_Moneda             = Pag.mnnemo
      ,   venta_moneda                = a.venta_moneda
      ,   venta_valor_tasa            = a.venta_valor_tasa
      ,   venta_saldo                 = a.venta_saldo
      ,   Venta_Flujo_Adicional       = a.Venta_Flujo_Adicional
      ,   IntercPrincPag              = a.IntercPrinc
      ,   MontoEnt                    = convert(numeric(21,4), a.venta_saldo  + a.venta_amortiza )      
      ,   venta_capital               = a.venta_capital
   FROM  bacswapsuda.dbo.cartera  a with (nolock)
         inner join bacparamsuda.dbo.cliente cli with (nolock) on cli.clrut             = rut_cliente and cli.clcodigo = codigo_cliente
         inner join bacparamsuda.dbo.moneda  Pag with (nolock) on Pag.mncodmon          = a.Pagamos_moneda 
   WHERE #CARTERA.numero_operacion = a.numero_operacion   
   AND   #CARTERA.numero_flujo     = 0        
   AND   a.tipo_flujo              = 2
   AND   a.tipo_swap               = 2

-- DETALLE 

   UPDATE #CARTERA
   SET    compra_amortiza             = a.compra_amortiza
      ,   compra_interes              = a.compra_interes
      ,   Rec_Moneda			        = a.recibimos_moneda
      ,   Rec_Nemo_Moneda		        = Rec.mnnemo
      ,   compra_moneda                 = a.compra_moneda
      ,   compra_valor_tasa             = a.compra_valor_tasa
      ,   compra_saldo                  = a.compra_saldo
      ,   Compra_Flujo_Adicional        = a.Compra_Flujo_Adicional
      ,   IntercPrincRec                = a.IntercPrinc
      ,   MontoRec                      = convert(numeric(21,4), a.Compra_Flujo_Adicional + (a.compra_amortiza * a.IntercPrinc) + a.compra_interes )
      ,   compra_capital                = a.compra_capital      
   FROM  bacswapsuda.dbo.cartera  a  with (nolock)
inner join bacparamsuda.dbo.cliente cli with (nolock) on cli.clrut             = rut_cliente and cli.clcodigo = codigo_cliente
         inner join bacparamsuda.dbo.moneda  Rec with (nolock) on Rec.mncodmon          = a.recibimos_moneda
   WHERE #CARTERA.numero_operacion       = a.numero_operacion
   AND   #CARTERA.numero_flujo = a.numero_flujo        
   AND   a.tipo_flujo             = 1
   AND   a.tipo_swap              = 2
  

   UPDATE #CARTERA
   SET    venta_amortiza              = a.venta_amortiza
      ,   venta_interes               = a.venta_interes
      ,   Pag_Moneda                  = a.pagamos_moneda
      ,   Pag_Nemo_Moneda             = Pag.mnnemo
      ,   venta_moneda                = a.venta_moneda
      ,   venta_valor_tasa            = a.venta_valor_tasa
      ,   venta_saldo                 = a.venta_saldo
      ,   Venta_Flujo_Adicional       = a.Venta_Flujo_Adicional
      ,   IntercPrincPag              = a.IntercPrinc
      ,   MontoEnt                    = convert(numeric(21,4), a.venta_Flujo_Adicional  + (a.venta_amortiza  * a.IntercPrinc) + a.venta_interes  )
      ,   venta_capital               = a.venta_capital
      ,   Codigo_Inst                      = '08'    
   FROM  bacswapsuda.dbo.cartera  a
         inner join bacparamsuda.dbo.cliente cli with (nolock) on cli.clrut             = rut_cliente and cli.clcodigo = codigo_cliente
         inner join bacparamsuda.dbo.moneda  Pag with (nolock) on Pag.mncodmon          = a.Pagamos_moneda 
   WHERE #CARTERA.numero_operacion       = a.numero_operacion
   AND   #CARTERA.numero_flujo = a.numero_flujo       
   AND   a.tipo_flujo             = 2
   AND   a.tipo_swap              = 2
              
 INSERT INTO  #temp  
 SELECT 
    'TipOpe' = tipo_Operacion 
  , 'NumOpe' = RTRIM(CONVERT(CHAR(5), numero_operacion )) + RTRIM(CONVERT(CHAR(5), numero_flujo ))
  , 'RutCli' = Rut_Cliente   
  , 'DigCli' = Dig_Rut  
  , 'NomCli' = b.Clnombre
  , 'FecIni' = fecha_inicio  -- CONVERT(CHAR(10),fecha_inicio,103)  
  , 'FecTer' = Fecha_Termino -- CONVERT(CHAR(10),Fecha_Termino,103)  
  , 'CpaCodMon' = Rec_Moneda 
  , 'CpaNemMon' = Rec_Nemo_Moneda   
  , 'CpaMonto'  = MontoRec  
  , 'VtaCodMon' = Pag_Moneda  
  , 'VtaNemMon' = Pag_Nemo_Moneda  
  , 'VtaMonto' = MontoEnt  
  , 'Modal'     = modalidad_pago  
  , 'PreFut' = case when tipo_swap in ( 1, 4) 
                                        then compra_valor_tasa 
                                   -- MN x MX
                                   when compra_moneda in ( 998, 999 ) and venta_moneda not in ( 998, 999 ) 
               then compra_capital / venta_capital
                                   -- MX x MN
                                   when Venta_moneda in ( 998, 999 ) and compra_moneda not in ( 998, 999 )  
                                        then venta_capital / compra_capital
                                   -- MN x MN
                                   when compra_moneda in ( 999 )
                                        then compra_capital / venta_capital
                                   when venta_moneda in ( 999 )
       then venta_capital / compra_capital
                                   -- MX x USD
				   when compra_moneda not in ( 13 )  and  venta_moneda in ( 13 )
                                        then compra_capital / venta_capital
                                   -- USD x MX
                                   when venta_moneda  not in ( 13 )  and  compra_moneda in  ( 13 )
                                        then compra_capital / venta_capital 
                                   -- MX x MX
                                   else compra_capital / venta_capital
                              end 
        , 'PreSpt'   = 0.0   
        , 'nomprop'  = @cnomprop   
        , 'dirprop'  = @cdirprop    
        , 'rutprop'  = @nrutprop    
        , 'digprop'  = @cdigprop    
        , 'FecInfo'  = @cfecha
        , 'codclie'  = @ncodclie    
        , 'FecPro'   = CONVERT(CHAR(10),@cfecpro,103)     
        , 'Marca'    = 'I'
        , 'Plazo'    = DATEDIFF(DD,fecha_inicio, Fecha_Termino)  
        , 'Apodera1' = ISNULL( @ap1nombre , '' )   
        , 'Cargo1'   = ISNULL( @ap1cargo  , '' )   
        , 'Fono1'    = ISNULL( @ap1fono   , '' )   
        , 'Apodera2' = ISNULL( @ap2nombre , '' )   
        , 'Cargo2'   = ISNULL( @ap2cargo  , '' )   
        , 'Fono2'    = ISNULL( @ap2fono   , '' )   
		, 'Contador' = 0
		, 'CanPag'   = 0 
		, 'CodPais'  = ISNULL(f.codigo_pais,0)  
        , 'NomPais'  = ISNULL(f.nombre,'')    
        , 'EmailApo1'= @cEmailApo1   
        , 'Sector Eco' = b.CLACTIVIDA  
        , 'cod_instru' = Codigo_Inst 
        , 'Prima'     = 0.0     
   FROM #CARTERA 
   INNER JOIN view_cliente b with (nolock) ON  (Rut_Cliente = b.clrut AND Codigo_Cliente = b.clcodigo  )   
   RIGHT OUTER JOIN view_pais  f with (nolock) ON CONVERT(INT,f.codigo_pais ) = b.clpais  
   INNER JOIN bacparamsuda.dbo.moneda  mco with (nolock) on mco.mncodmon          = compra_moneda
   INNER JOIN bacparamsuda.dbo.moneda  mvt with (nolock) on mvt.mncodmon          = venta_moneda
   WHERE NOT(MontoRec = 0 AND MontoEnt =	0)
	AND  ( (b.clpais         <> 6)
         or (b.clpais         = 6 and (mco.mnextranj = 1 or mvt.mnextranj = 1)) )   
   order by  numero_operacion,  numero_flujo

-- FIN INGRESOS SWAP

-- MODIFICACIONES SWAP
/*
   
   CREATE TABLE #CARTERA_MODIF
      (   compra_amortiza          NUMERIC(19,4)   NOT NULL DEFAULT(0.0)  
      ,   compra_interes           NUMERIC(19,4)   NOT NULL DEFAULT(0.0)  
      ,   venta_amortiza           NUMERIC(19,4)   NOT NULL DEFAULT(0.0)  
      ,   venta_interes            NUMERIC(19,4)   NOT NULL DEFAULT(0.0)  
      ,   fecha_inicio             DATETIME     NOT NULL DEFAULT('')  
      ,   tipo_operacion           CHAR(1)      NOT NULL DEFAULT('')  
      ,   tipo_swap                INTEGER      NOT NULL DEFAULT(0)  
      ,	  numero_flujo	           NUMERIC(3)   NOT NULL DEFAULT(0)  
	  ,	  rut_cliente	           NUMERIC(9)   NOT NULL DEFAULT(0)  
	  ,	  Dig_Rut			       CHAR(1)      NOT NULL DEFAULT('')  
      ,	  codigo_cliente	       NUMERIC(9)   NOT NULL DEFAULT(0)  
      ,   Rec_Moneda               NUMERIC(3)   NOT NULL DEFAULT(0)  
      ,   Pag_Moneda               NUMERIC(3)   NOT NULL DEFAULT(0)  
      ,	  Rec_Nemo_Moneda		   CHAR(8)      NOT NULL DEFAULT('')  
      ,	  Pag_Nemo_Moneda		   CHAR(8)      NOT NULL DEFAULT('')  
      ,   fecha_termino            DATETIME     NOT NULL DEFAULT('')  
	  ,	  numero_operacion         NUMERIC(9)   NOT NULL DEFAULT(0)  
      ,   modalidad_pago           CHAR(1)      NOT NULL DEFAULT('')  
      ,   compra_moneda            NUMERIC(3)   NOT NULL DEFAULT(0)  
      ,   venta_moneda             NUMERIC(3)   NOT NULL DEFAULT(0)  
      ,   compra_valor_tasa        NUMERIC(10,6)   NOT NULL DEFAULT(0.0)  
      ,   venta_valor_tasa         NUMERIC(10,6)   NOT NULL DEFAULT(0.0)  
      ,   fecha_cierre             DATETIME     NOT NULL DEFAULT('')  
      ,   compra_saldo             NUMERIC(19,4)   NOT NULL DEFAULT(0.0)
      ,   venta_saldo              NUMERIC(19,4)   NOT NULL DEFAULT(0.0)
      ,   compra_Flujo_adicional   FLOAT        NOT NULL DEFAULT(0.0)  
      ,   venta_Flujo_adicional    FLOAT        NOT NULL DEFAULT(0.0)  
      ,	  SwapCCS_X_Flujo	       NUMERIC(9)   NOT NULL DEFAULT(0)  
      ,   IntercPrincRec           INTEGER      NOT NULL DEFAULT(0)  
      ,   IntercPrincPag           INTEGER      NOT NULL DEFAULT(0)  
      ,   MontoRec                 FLOAT        NOT NULL DEFAULT(0.0)  
      ,   MontoEnt                 FLOAT        NOT NULL DEFAULT(0.0)        
      ,   compra_capital           NUMERIC(19,4)   NOT NULL DEFAULT(0.0)
      ,   venta_capital            NUMERIC(19,4)   NOT NULL DEFAULT(0.0)
      ,   Codigo_Inst              CHAR(3)      NOT NULL DEFAULT('')  
      ,   Estado_Flujo             NUMERIC(1)   NOT NULL DEFAULT(0)
/*
           CONSTRAINT [PK_CARTERA_CNT]   PRIMARY KEY CLUSTERED  
          (   Fecha_Cierre,   Tipo_Swap, Numero_Operacion )   ON [PRIMARY]  
*/
      )--  ON [PRIMARY]   

INSERT INTO #CARTERA_MODIF
SELECT  DISTINCT compra_amortiza      = 0.0
      ,   compra_interes              = 0.0
      ,   venta_amortiza              = 0.0
      ,   venta_interes               = 0.0
      ,   fecha_inicio                = fecha_inicio
      ,   tipo_operacion              = tipo_operacion
      ,   tipo_swap                   = tipo_swap
      ,   numero_flujo				  = numero_flujo
      ,   rut_cliente                 = rut_cliente
      ,   Dig_Rut			          = Cldv
      ,   codigo_cliente              = codigo_cliente
      ,   Rec_Moneda			      = 0
      ,   Pag_Moneda                  = 0
      ,   Rec_Nemo_Moneda		      = ''
      ,   Pag_Nemo_Moneda             = ''
      ,   fecha_termino               = fecha_termino
      ,   numero_operacion            = numero_operacion -- RTRIM(CONVERT(CHAR(5), numero_operacion )) + RTRIM(CONVERT(CHAR(5), numero_flujo ))
      ,   modalidad_pago              = modalidad_pago
      ,   compra_moneda               = 0
      ,   venta_moneda                = 0
      ,   compra_valor_tasa           = 0.0
      ,   venta_valor_tasa            = 0.0
      ,   fecha_cierre                = fecha_cierre
      ,   compra_saldo                = 0.0
      ,   venta_saldo                 = 0.0
      ,   Compra_Flujo_Adicional      = 0.0
      ,   Venta_Flujo_Adicional       = 0.0
      ,   SwapCCS_X_Flujo             = 0
      ,   IntercPrincRec              = 0
      ,   IntercPrincPag              = 0
      ,   MontoRec                    = 0.0
      ,   MontoEnt                    = 0.0
      ,   compra_capital              = 0.0
      ,   venta_capital               = 0.0
      ,   Codigo_Inst                 = '08'      
      ,   Estado_Flujo		          = estado_flujo
   FROM   bacswapsuda.dbo.carteralog with (nolock)
          LEFT JOIN BacParamSuda..CLIENTE   with (nolock) ON clrut = rut_cliente AND clcodigo = codigo_cliente
          LEFT JOIN BacParamSuda..MONEDA  m with (nolock) ON m.mncodmon = compra_moneda
   WHERE     fecha_modifica         = @cfecha  --  @dfecha 
         AND estado                 = 'M'
		 AND estado_flujo			<> 2 -- Excluir los flujos vencidos cuyos Valores Razonables son distintos y duplican los movimientos    

   INSERT  INTO  #CARTERA_MODIF
   SELECT  DISTINCT 
          compra_amortiza             = a.compra_amortiza
      ,   compra_interes              = a.compra_interes
      ,   venta_amortiza              = 0.0
      ,   venta_interes               = 0.0
      ,   fecha_inicio                = fecha_inicio
      ,   tipo_operacion              = tipo_operacion
      ,   tipo_swap                   = tipo_swap
      ,   numero_flujo				  = 0
      ,   rut_cliente                 = rut_cliente
      ,   Dig_Rut			          = Cldv
      ,   codigo_cliente              = codigo_cliente
      ,   Rec_Moneda			      = a.recibimos_moneda
      ,   Pag_Moneda                  = 0
      ,   Rec_Nemo_Moneda		      = Rec.mnnemo
      ,   Pag_Nemo_Moneda             = ''
      ,   fecha_termino               = fecha_termino
      ,   numero_operacion            = a.numero_operacion
      ,   modalidad_pago              = modalidad_pago
      ,   compra_moneda               = a.compra_moneda
      ,   venta_moneda                = 0
      ,   compra_valor_tasa           = a.compra_valor_tasa
      ,   venta_valor_tasa            = 0.0
      ,   fecha_cierre                = fecha_cierre
      ,   compra_saldo                = a.compra_saldo
      ,   venta_saldo                 = 0.0
      ,   Compra_Flujo_Adicional      = a.Compra_Flujo_Adicional
      ,   Venta_Flujo_Adicional       = 0.0
    ,   SwapCCS_X_Flujo             = 0
      ,   IntercPrincRec              = a.IntercPrinc
      ,   IntercPrincPag              = 0
      ,   MontoRec                    = convert(numeric(21,4), a.compra_saldo + a.compra_amortiza )
      ,   MontoEnt                    = 0.0
      ,   compra_capital              = a.compra_capital
      ,   venta_capital               = 0.0
      ,   Codigo_Inst                 = '07'   
      ,   Estado_Flujo                = a.estado_flujo   
   FROM  bacswapsuda.dbo.carteralog  a with (nolock)
         inner join bacparamsuda.dbo.cliente cli with (nolock) on cli.clrut             = rut_cliente and cli.clcodigo = codigo_cliente
         inner join bacparamsuda.dbo.moneda  Rec with (nolock) on Rec.mncodmon          = a.recibimos_moneda
   WHERE  a.fecha_modifica         = @cfecha  -- @dfecha 
    AND   a.tipo_flujo             = 1
    AND   a.estado_flujo		   = 1
    AND   a.tipo_swap              = 2

  
   UPDATE #CARTERA_MODIF
   SET    venta_amortiza              = a.venta_amortiza
      ,   venta_interes               = a.venta_interes
      ,   Pag_Moneda                  = a.pagamos_moneda
      ,   Pag_Nemo_Moneda             = Pag.mnnemo
      ,   venta_moneda                = a.venta_moneda
      ,   venta_valor_tasa            = a.venta_valor_tasa
      ,   venta_saldo                 = a.venta_saldo
      ,   Venta_Flujo_Adicional       = a.Venta_Flujo_Adicional
      ,   IntercPrincPag              = a.IntercPrinc
      ,   MontoEnt                    = convert(numeric(21,4), a.venta_saldo  + a.venta_amortiza )      
      ,   venta_capital               = a.venta_capital
   FROM  bacswapsuda.dbo.carteralog  a with (nolock)
         inner join bacparamsuda.dbo.cliente cli with (nolock) on cli.clrut             = rut_cliente and cli.clcodigo = codigo_cliente
         inner join bacparamsuda.dbo.moneda  Pag with (nolock) on Pag.mncodmon          = a.Pagamos_moneda 
   WHERE #CARTERA_MODIF.numero_operacion = a.numero_operacion   
   AND   #CARTERA_MODIF.numero_flujo     = 0 --a.numero_flujo       
   AND   a.tipo_flujo              = 2
   AND   a.tipo_swap               = 2

-- DETALLE 

   UPDATE #CARTERA_MODIF
   SET    compra_amortiza             = a.compra_amortiza
      ,   compra_interes              = a.compra_interes
      ,   Rec_Moneda			        = a.recibimos_moneda
      ,   Rec_Nemo_Moneda		        = Rec.mnnemo
      ,   compra_moneda                 = a.compra_moneda
      ,   compra_valor_tasa             = a.compra_valor_tasa
      ,   compra_saldo                  = a.compra_saldo
      ,   Compra_Flujo_Adicional        = a.Compra_Flujo_Adicional
      ,   IntercPrincRec                = a.IntercPrinc
      ,   MontoRec                      = convert(numeric(21,4), a.Compra_Flujo_Adicional + (a.compra_amortiza * a.IntercPrinc) + a.compra_interes )
      ,   compra_capital                = a.compra_capital      
   FROM  bacswapsuda.dbo.carteralog   a
         inner join bacparamsuda.dbo.cliente cli with (nolock) on cli.clrut             = rut_cliente and cli.clcodigo = codigo_cliente
         inner join bacparamsuda.dbo.moneda  Rec with (nolock) on Rec.mncodmon          = a.recibimos_moneda
   WHERE #CARTERA_MODIF.numero_operacion       = a.numero_operacion
   AND   #CARTERA_MODIF.numero_flujo = a.numero_flujo        
   AND   a.tipo_flujo             = 1
   AND   a.tipo_swap              = 2

   
   UPDATE #CARTERA_MODIF
   SET    venta_amortiza              = a.venta_amortiza
      ,   venta_interes               = a.venta_interes
      ,   Pag_Moneda                  = a.pagamos_moneda
      ,   Pag_Nemo_Moneda             = Pag.mnnemo
      ,   venta_moneda                = a.venta_moneda
      ,   venta_valor_tasa            = a.venta_valor_tasa
      ,   venta_saldo                 = a.venta_saldo
      ,   Venta_Flujo_Adicional       = a.Venta_Flujo_Adicional
      ,   IntercPrincPag           = a.IntercPrinc
      ,   MontoEnt                    = convert(numeric(21,4), a.venta_Flujo_Adicional  + (a.venta_amortiza  * a.IntercPrinc) + a.venta_interes  )
      ,   venta_capital               = a.venta_capital
      ,   Codigo_Inst                      = '08'    
   FROM  bacswapsuda.dbo.cartera  a
         inner join bacparamsuda.dbo.cliente cli with (nolock) on cli.clrut             = rut_cliente and cli.clcodigo = codigo_cliente
         inner join bacparamsuda.dbo.moneda  Pag with (nolock) on Pag.mncodmon          = a.Pagamos_moneda 
   WHERE #CARTERA_MODIF.numero_operacion       = a.numero_operacion
   AND   #CARTERA_MODIF.numero_flujo = a.numero_flujo       
   AND   a.tipo_flujo             = 2
   AND   a.tipo_swap              = 2
--   order by  numero_operacion, tipo_flujo  , numero_flujo

--- SELECT  '#CARTERA',*  FROM   #CARTERA

 INSERT INTO  #temp  
 SELECT   'TipOpe' = tipo_Operacion 
  , 'NumOpe' = RTRIM(CONVERT(CHAR(5), numero_operacion )) + RTRIM(CONVERT(CHAR(5), numero_flujo ))
  , 'RutCli' = Rut_Cliente   
  , 'DigCli' = Dig_Rut  
  , 'NomCli' = b.Clnombre
  , 'FecIni' = fecha_inicio  -- CONVERT(CHAR(10),fecha_inicio,103)  
  , 'FecTer' = Fecha_Termino -- CONVERT(CHAR(10),Fecha_Termino,103)  
  , 'CpaCodMon' = Rec_Moneda 
  , 'CpaNemMon' = Rec_Nemo_Moneda   
  , 'CpaMonto'  = MontoRec  
  , 'VtaCodMon' = Pag_Moneda  
  , 'VtaNemMon' = Pag_Nemo_Moneda  
  , 'VtaMonto'  = MontoEnt  
  , 'Modal'     = modalidad_pago  
  , 'PreFut' =  case when tipo_swap in ( 1, 4) 
                                        then compra_valor_tasa 
                                   -- MN x MX
                                   when compra_moneda in ( 998, 999 ) and venta_moneda not in ( 998, 999 ) 
               then compra_capital / venta_capital
                                   -- MX x MN
                                   when Venta_moneda in ( 998, 999 ) and compra_moneda not in ( 998, 999 )  
                                        then venta_capital / compra_capital
                                   -- MN x MN
                                   when compra_moneda in ( 999 )
                                        then compra_capital / venta_capital
                                   when venta_moneda in ( 999 )
       then venta_capital / compra_capital
                                   -- MX x USD
				   when compra_moneda not in ( 13 )  and  venta_moneda in ( 13 )
                                        then compra_capital / venta_capital
                                   -- USD x MX
                                   when venta_moneda  not in ( 13 )  and  compra_moneda in  ( 13 )
                                        then compra_capital / venta_capital 
                                   -- MX x MX
                                   else compra_capital / venta_capital
                              end 
        , 'PreSpt'   = 0.0   
        , 'nomprop'  = @cnomprop   
        , 'dirprop'  = @cdirprop    
        , 'rutprop'  = @nrutprop    
        , 'digprop'  = @cdigprop    
        , 'FecInfo'  = @cfecha
        , 'codclie'  = @ncodclie    
        , 'FecPro'  = CONVERT(CHAR(10),@cfecpro,103)     
        , 'Marca'    = 'M'
        , 'Plazo'    = DATEDIFF(DD,fecha_inicio, Fecha_Termino)  
        , 'Apodera1' = ISNULL( @ap1nombre , '' )   
        , 'Cargo1'   = ISNULL( @ap1cargo  , '' )   
        , 'Fono1'    = ISNULL( @ap1fono   , '' )   
        , 'Apodera2' = ISNULL( @ap2nombre , '' )   
        , 'Cargo2'   = ISNULL( @ap2cargo  , '' )   
        , 'Fono2'    = ISNULL( @ap2fono   , '' )   
		, 'Contador' = 0
		, 'CanPag'   = 0 
		, 'CodPais'  = ISNULL(f.codigo_pais,0)  
        , 'NomPais'  = ISNULL(f.nombre,'')    
        , 'EmailApo1'  = @cEmailApo1   
        , 'Sector Eco' = b.CLACTIVIDA  
        , 'cod_instru' = Codigo_Inst -- CodIns -- e.caoperrelaspot --'01'  
        , 'Prima'      = 0.0     
   FROM #CARTERA_MODIF 
   INNER JOIN view_cliente b with (nolock) ON  (Rut_Cliente = b.clrut AND Codigo_Cliente = b.clcodigo  )   
   RIGHT OUTER JOIN view_pais  f with (nolock) ON CONVERT(INT,f.codigo_pais ) = b.clpais  
   INNER JOIN bacparamsuda.dbo.moneda  mco on mco.mncodmon          = compra_moneda
   INNER JOIN bacparamsuda.dbo.moneda  mvt on mvt.mncodmon          = venta_moneda
   WHERE NOT(MontoRec = 0 AND MontoEnt =	0)
	AND  ( (b.clpais         <> 6)
         or (b.clpais         = 6 and (mco.mnextranj = 1 or mvt.mnextranj = 1)) )   
   order by  numero_operacion,  numero_flujo

*/
-- MODIFICACIONES SWAP

-- ANTICIPOS SWAP


   CREATE TABLE #CARTERA_ANTICIPO
      (   compra_amortiza          NUMERIC(19,4)   NOT NULL DEFAULT(0.0)  
      ,   compra_interes           NUMERIC(19,4)   NOT NULL DEFAULT(0.0)  
      ,   venta_amortiza           NUMERIC(19,4)   NOT NULL DEFAULT(0.0)  
      ,   venta_interes            NUMERIC(19,4)   NOT NULL DEFAULT(0.0)  
      ,   fecha_inicio             DATETIME     NOT NULL DEFAULT('')  
      ,   tipo_operacion           CHAR(1)      NOT NULL DEFAULT('')  
      ,   tipo_swap                INTEGER      NOT NULL DEFAULT(0)  
      ,	  numero_flujo	           NUMERIC(3)   NOT NULL DEFAULT(0)  
	  ,	  rut_cliente	           NUMERIC(9)   NOT NULL DEFAULT(0)  
	  ,	  Dig_Rut			       CHAR(1)      NOT NULL DEFAULT('')  
      ,	  codigo_cliente	       NUMERIC(9)   NOT NULL DEFAULT(0)  
      ,   Rec_Moneda               NUMERIC(3)   NOT NULL DEFAULT(0)  
      ,   Pag_Moneda               NUMERIC(3)   NOT NULL DEFAULT(0)  
      ,	  Rec_Nemo_Moneda		   CHAR(8)      NOT NULL DEFAULT('')  
      ,	  Pag_Nemo_Moneda		   CHAR(8)      NOT NULL DEFAULT('')  
      ,   fecha_termino            DATETIME     NOT NULL DEFAULT('')  
	  ,	  numero_operacion         NUMERIC(9)   NOT NULL DEFAULT(0)  
      ,   modalidad_pago           CHAR(1)      NOT NULL DEFAULT('')  
      ,   compra_moneda            NUMERIC(3)   NOT NULL DEFAULT(0)  
      ,   venta_moneda             NUMERIC(3)   NOT NULL DEFAULT(0)  
      ,   compra_valor_tasa        NUMERIC(10,6)   NOT NULL DEFAULT(0.0)  
      ,   venta_valor_tasa         NUMERIC(10,6)   NOT NULL DEFAULT(0.0)  
      ,   fecha_cierre             DATETIME     NOT NULL DEFAULT('')  
      ,   compra_saldo             NUMERIC(19,4)   NOT NULL DEFAULT(0.0)
      ,   venta_saldo              NUMERIC(19,4)   NOT NULL DEFAULT(0.0)
      ,   compra_Flujo_adicional   FLOAT        NOT NULL DEFAULT(0.0)  
      ,   venta_Flujo_adicional    FLOAT        NOT NULL DEFAULT(0.0)  
      ,	  SwapCCS_X_Flujo	       NUMERIC(9)   NOT NULL DEFAULT(0)  
      ,   IntercPrincRec           INTEGER      NOT NULL DEFAULT(0)  
      ,   IntercPrincPag           INTEGER      NOT NULL DEFAULT(0)  
      ,   MontoRec                 FLOAT        NOT NULL DEFAULT(0.0)  
      ,   MontoEnt                 FLOAT        NOT NULL DEFAULT(0.0)        
      ,   compra_capital           NUMERIC(19,4)   NOT NULL DEFAULT(0.0)
      ,   venta_capital            NUMERIC(19,4)   NOT NULL DEFAULT(0.0)
      ,   Codigo_Inst              CHAR(3)      NOT NULL DEFAULT('')  
      ,   Estado_Flujo             NUMERIC(1)   NOT NULL DEFAULT(0)
/*
           CONSTRAINT [PK_CARTERA_CNT]   PRIMARY KEY CLUSTERED  
          (   Fecha_Cierre,   Tipo_Swap, Numero_Operacion )   ON [PRIMARY]  
*/
      )--  ON [PRIMARY]   

-- sp_help cartera

/*

   INSERT  INTO  #CARTERA_ANTICIPO
   SELECT  DISTINCT compra_amortiza   = a.compra_amortiza
      ,   compra_interes              = a.compra_interes
      ,   venta_amortiza              = 0.0
      ,   venta_interes               = 0.0
      ,   fecha_inicio                = fecha_inicio
      ,   tipo_operacion              = tipo_operacion
      ,   tipo_swap                   = tipo_swap
      ,   numero_flujo				  = 0
      ,   rut_cliente                 = rut_cliente
      ,   Dig_Rut			          = Cldv
      ,   codigo_cliente              = codigo_cliente
      ,   Rec_Moneda			      = a.recibimos_moneda
      ,   Pag_Moneda                  = 0
      ,   Rec_Nemo_Moneda		      = Rec.mnnemo
      ,   Pag_Nemo_Moneda             = ''
      ,   fecha_termino               = fecha_termino
      ,   numero_operacion            = a.numero_operacion
      ,   modalidad_pago              = modalidad_pago
      ,   compra_moneda               = a.compra_moneda
      ,   venta_moneda                = 0
      ,   compra_valor_tasa           = a.compra_valor_tasa
      ,   venta_valor_tasa            = 0.0
      ,   fecha_cierre                = fecha_cierre
      ,   compra_saldo                = a.compra_saldo
      ,   venta_saldo                 = 0.0
      ,   Compra_Flujo_Adicional      = a.Compra_Flujo_Adicional
      ,   Venta_Flujo_Adicional       = 0.0
      ,   SwapCCS_X_Flujo             = 0
      ,   IntercPrincRec              = a.IntercPrinc
      ,   IntercPrincPag              = 0
      ,   MontoRec                    = convert(numeric(21,4), a.compra_saldo + a.compra_amortiza )
      ,   MontoEnt                    = 0.0
      ,   compra_capital              = a.compra_capital
      ,   venta_capital               = 0.0
      ,   Codigo_Inst                 = '07'   
      ,   Estado_Flujo                = a.estado_flujo   
   FROM  bacswapsuda.dbo.cartera_UNWIND  a
         inner join bacparamsuda.dbo.cliente cli on cli.clrut             = rut_cliente and cli.clcodigo = codigo_cliente
         inner join bacparamsuda.dbo.moneda  Rec on Rec.mncodmon          = a.recibimos_moneda
   WHERE  a.FechaAnticipo          = @dfecha -- @cfecha 
    AND   a.tipo_flujo             = 1
    AND   a.estado_flujo		   = 1
    AND   a.tipo_swap              = 2
--   order by  numero_operacion, tipo_flujo, numero_flujo
   
   UPDATE #CARTERA_ANTICIPO
   SET    venta_amortiza              = a.venta_amortiza
      ,   venta_interes               = a.venta_interes
      ,   Pag_Moneda                  = a.pagamos_moneda
      ,   Pag_Nemo_Moneda             = Pag.mnnemo
      ,   venta_moneda                = a.venta_moneda
      ,   venta_valor_tasa            = a.venta_valor_tasa
      ,   venta_saldo                 = a.venta_saldo
      ,   Venta_Flujo_Adicional       = a.Venta_Flujo_Adicional
      ,   IntercPrincPag              = a.IntercPrinc
      ,   MontoEnt                    = convert(numeric(21,4), a.venta_saldo  + a.venta_amortiza )      
      ,   venta_capital               = a.venta_capital
   FROM  bacswapsuda.dbo.cartera_UNWIND  a
         inner join bacparamsuda.dbo.cliente cli on cli.clrut             = rut_cliente and cli.clcodigo = codigo_cliente
         inner join bacparamsuda.dbo.moneda  Pag on Pag.mncodmon          = a.Pagamos_moneda 
   WHERE #CARTERA_ANTICIPO.numero_operacion = a.numero_operacion  
   AND   #CARTERA_ANTICIPO.numero_flujo     = 0 --a.numero_flujo       
   AND   a.tipo_flujo              = 2
   AND   a.estado_flujo		       = 1
   AND   a.tipo_swap               = 2
--   order by  numero_operacion, tipo_flujo  , numero_flujo

 INSERT INTO  #temp    
 SELECT  'TipOpe' = tipo_Operacion 
  , 'NumOpe'  = numero_operacion  --    RTRIM(CONVERT(CHAR(5), numero_operacion )) + RTRIM(CONVERT(CHAR(5), numero_flujo ))--numero_operacion   
  , 'RutCli'  = Rut_Cliente   
  , 'DigCli'  = Dig_Rut  
  , 'NomCli'  = b.Clnombre
  , 'FecIni'  = fecha_inicio  -- CONVERT(CHAR(10),fecha_inicio,103)  
  , 'FecTer'  = Fecha_Termino -- CONVERT(CHAR(10),Fecha_Termino,103)  
  , 'CpaCodMon' = Rec_Moneda 
  , 'CpaNemMon' = Rec_Nemo_Moneda   
  , 'CpaMonto'  = MontoRec  
  , 'VtaCodMon' = Pag_Moneda  
  , 'VtaNemMon' = Pag_Nemo_Moneda  
  , 'VtaMonto'  = MontoEnt  
  , 'Modal'     = modalidad_pago  
  , 'PreFut' = case when tipo_swap in ( 1, 4) 
                                        then compra_valor_tasa 
                                   -- MN x MX
                     when compra_moneda in ( 998, 999 ) and venta_moneda not in ( 998, 999 ) 
               then compra_capital / venta_capital
                                   -- MX x MN
                                   when Venta_moneda in ( 998, 999 ) and compra_moneda not in ( 998, 999 )  
                                        then venta_capital / compra_capital
                                   -- MN x MN
                                   when compra_moneda in ( 999 )
                                        then compra_capital / venta_capital
                                   when venta_moneda in ( 999 )
       then venta_capital / compra_capital
                                   -- MX x USD
				   when compra_moneda not in ( 13 )  and  venta_moneda in ( 13 )
                                        then compra_capital / venta_capital
                                   -- USD x MX
                                   when venta_moneda  not in ( 13 )  and  compra_moneda in  ( 13 )
                                        then compra_capital / venta_capital 
                                   -- MX x MX
                                   else compra_capital / venta_capital
                              end 
        , 'PreSpt'   = 0.0   
        , 'nomprop'  = @cnomprop   
        , 'dirprop'  = @cdirprop    
        , 'rutprop'  = @nrutprop    
        , 'digprop'  = @cdigprop    
        , 'FecInfo'  = @cfecha
        , 'codclie'  = @ncodclie    
        , 'FecPro'   = CONVERT(CHAR(10),@cfecpro,103)     
        , 'Marca'    = 'M'
        , 'Plazo'    = DATEDIFF(DD,fecha_inicio, Fecha_Termino)  
        , 'Apodera1' = ISNULL( @ap1nombre , '' )   
        , 'Cargo1'   = ISNULL( @ap1cargo  , '' )   
        , 'Fono1'    = ISNULL( @ap1fono   , '' )   
        , 'Apodera2' = ISNULL( @ap2nombre , '' )   
        , 'Cargo2'   = ISNULL( @ap2cargo  , '' )   
        , 'Fono2'    = ISNULL( @ap2fono   , '' )   
		, 'Contador' = 0
		, 'CanPag'   = 0 
		, 'CodPais'  = ISNULL(f.codigo_pais,0)  
        , 'NomPais'  = ISNULL(f.nombre,'')    
        , 'EmailApo1'  = @cEmailApo1   
        , 'Sector Eco' = b.CLACTIVIDA  
        , 'cod_instru' = Codigo_Inst -- CodIns -- e.caoperrelaspot --'01'  
        , 'Prima'      = 0.0          
   FROM #CARTERA_ANTICIPO
   INNER JOIN view_cliente b with (nolock) ON  (Rut_Cliente = b.clrut AND Codigo_Cliente = b.clcodigo  )   
   RIGHT OUTER JOIN view_pais  f with (nolock) ON CONVERT(INT,f.codigo_pais ) = b.clpais  
   INNER JOIN bacparamsuda.dbo.moneda  mco on mco.mncodmon          = compra_moneda
   INNER JOIN bacparamsuda.dbo.moneda  mvt on mvt.mncodmon          = venta_moneda
   WHERE NOT(MontoRec = 0 AND MontoEnt =	0)
   AND ( (b.clpais         <> 6)
   OR (b.clpais         = 6 and (mco.mnextranj = 1 or mvt.mnextranj = 1)))
   order by  numero_operacion,  numero_flujo
*/


-- ANTICIPOS SWAP



--***************************************SWAP**************************************************************  

  
--***************************************OPCIONES**************************************************************  
  
-- INGRESOS  
  
 SELECT  'TipOpe'     = A.CaCVEstructura  
       , 'NumOpe'     = A.CaNumContrato  
       , 'RutCli'     = ISNULL( CASE WHEN D.clpais = 6 then A.CaRutCliente else D.clrutcliexterno END , 0 )  
       , 'DigCli'     = ISNULL( CASE WHEN D.clpais = 6 then D.cldv         else D.cldvcliexterno  END , 0 )  
       , 'NomCli'     = D.clnombre  
       , 'FecIni'     = CONVERT(CHAR(10), B.CaFechaInicioOpc,103)     
       , 'FecTer'     = CONVERT(CHAR(10), B.CaFechaPagoEjer,103)   
       , 'CodMdaRec'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Call') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Put')  
                                    THEN B.CaCodMon1  
                                    ELSE B.CaCodMon2  
                END  
       , 'NemMonRec'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Call') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Put')  
                             THEN E.mnnemo  
                                    ELSE F.mnnemo  
                         END  
       , 'MtoRecibe'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Call') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Put')  
                           THEN B.CaMontoMon1  
                                   ELSE B.CaMontoMon2  
                         END  
       , 'CodMdaEnt'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Put') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Call')  
                                    THEN B.CaCodMon1  
                                    ELSE B.CaCodMon2   
                         END  
       , 'NemMonEnt'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Put') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Call')  
                                    THEN E.mnnemo  
                                    ELSE F.mnnemo  
                         END  
       , 'MtoEntrega' = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Put') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Call')  
                                   THEN B.CaMontoMon1  
                                   ELSE B.CaMontoMon2   
                         END       
       , 'Modal'      = B.CaModalidad  
       , 'PreFut'     = B.CaStrike  
       , 'PreSpt'     = B.CaStrike  
       , 'nomprop'    = @cnomprop  
       , 'dirprop'    = @cdirprop  
       , 'rutprop'    = @nrutprop  
       , 'digprop'    = @cdigprop  
       , 'FecInfo'    = @cfecha  
       , 'Codcli'     = @ncodclie        
       , 'FecPro'     = @cfecPro  
       , 'Marca'      = 'I'  
       , 'Plazo'      = DATEDIFF(DD,B.CaFechaInicioOpc, B.CaFechaPagoEjer)  
       , 'Apodera1'   = ISNULL( @ap1nombre , '' )  
       , 'Cargo1'     = ISNULL( @ap1cargo  , '' )  
       , 'Fono1'      = ISNULL( @ap1fono   , '' )  
       , 'Apodera2'   = ISNULL( @ap2nombre , '' )  
       , 'Cargo2'     = ISNULL( @ap2cargo  , '' )  
       , 'Fono2'      = ISNULL( @ap2fono   , '' )  
       , 'Contador'   = 0  
       , 'CanPag'     = 0  
       , 'CodPais'    = ISNULL(G.codigo_pais,0)  
       , 'NomPais'    = ISNULL(G.nombre,'')  
       , 'EmailApo1'  = @cEmailApo1  
       , 'Sector'     = D.CLACTIVIDA  
       , 'cod_instru' = (CASE WHEN B.CaCallPut = 'Call' THEN '03' ELSE '04' END)  
       , 'Prima'      = ROUND((H.vmvalor * B.CaPrimaInicialDet / @DoObs),4)  
       , 'CodPagPrima'= A.CaCodMonPagPrima 
 INTO #TEMP_OPC  
   
/* FROM   lnkopc.CbMdbOpc.dbo.CaEncContrato A   -- select * from lnkopc.CbMdbOpc.dbo.CaDetContrato  
      , lnkopc.CbMdbOpc.dbo.CaDetContrato B  
      , VIEW_CLIENTE D     
      , VIEW_MONEDA  E with (nolock)   
      , VIEW_MONEDA  F with (nolock)   
      , VIEW_PAIS    G with (nolock)  
      , #VALOR_MONEDA H  
 WHERE  A.CaNumContrato =  B.CaNumContrato   
   AND  @dfecha         = CONVERT(CHAR(8),A.CaFechaContrato,112)     
   AND (A.CaRutCliente  = D.clrut and A.CaCodigo = D.clcodigo )   
   AND  B.CaCodMon1     = E.mncodmon      
   AND  B.CaCodMon2     = F.mncodmon      
          AND  A.CaCodMonPagPrima  = H.vmcodigo  
   AND  CONVERT(INT,G.codigo_pais) =* D.clpais   
--   AND  B.CaModalidad   = 'C'  
          AND  A.CaTipoTransaccion <> 'ANULA'  
          AND  A.CaEstado <> 'C' */  
  
 -- RQ 7619  
 FROM LNKOPC.CbMdbOpc.dbo.CaEncContrato A --lnkopc.CbMdbOpc.dbo.CaEncContrato A  
  INNER JOIN LNKOPC.CbMdbOpc.dbo.CaDetContrato B/*lnkopc.CbMdbOpc.dbo.CaDetContrato B*/ ON A.CaNumContrato =  B.CaNumContrato   
  INNER JOIN VIEW_CLIENTE   D with (nolock) ON (A.CaRutCliente  = D.clrut and A.CaCodigo = D.clcodigo )  
  INNER JOIN VIEW_MONEDA    E with (nolock) ON  B.CaCodMon1     = E.mncodmon    
  INNER JOIN VIEW_MONEDA    F with (nolock) ON  B.CaCodMon2     = F.mncodmon   
  RIGHT OUTER JOIN VIEW_PAIS  G with (nolock) ON  CONVERT(INT,G.codigo_pais) = D.clpais  
  INNER JOIN  #VALOR_MONEDA H ON A.CaCodMonPagPrima  = H.vmcodigo  
 WHERE @dfecha         = CONVERT(CHAR(8),A.CaFechaContrato,112)  
 AND   A.CaTipoTransaccion <> 'ANULA'  
    AND   A.CaEstado <> 'C'  
  
  
  
-- VENCIDAS  
  
    INSERT INTO  #TEMP_OPC  
 SELECT  'TipOpe'     = A.CaCVEstructura  
       , 'NumOpe'     = A.CaNumContrato  
       , 'RutCli'     = ISNULL( CASE WHEN D.clpais = 6 then A.CaRutCliente else D.clrutcliexterno END , 0 )  
       , 'DigCli'     = ISNULL( CASE WHEN D.clpais = 6 then D.cldv         else D.cldvcliexterno  END , 0 )  
       , 'NomCli'     = D.clnombre  
       , 'FecIni'     = CONVERT(CHAR(10), B.CaFechaInicioOpc,103)     
       , 'FecTer'     = CONVERT(CHAR(10), B.CaFechaPagoEjer,103)   
       , 'CodMdaRec'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Call') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Put')  
                                    THEN B.CaCodMon1  
                              ELSE B.CaCodMon2  
                         END  
       , 'NemMonRec'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Call') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Put')  
                             THEN E.mnnemo  
                                    ELSE F.mnnemo  
                         END  
       , 'MtoRecibe'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Call') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Put')  
                                   THEN B.CaMontoMon1  
                                   ELSE B.CaMontoMon2  
                         END  
       , 'CodMdaEnt'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Put') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Call')  
                                    THEN B.CaCodMon1  
                                    ELSE B.CaCodMon2   
                         END  
       , 'NemMonEnt'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Put') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Call')  
                                    THEN E.mnnemo  
                                    ELSE F.mnnemo  
                         END  
       , 'MtoEntrega' = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Put') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Call')  
                                   THEN B.CaMontoMon1  
                                   ELSE B.CaMontoMon2   
                         END       
       , 'Modal'      = B.CaModalidad  
       , 'PreFut'     = B.CaStrike  
       , 'PreSpt'     = B.CaStrike  
       , 'nomprop'    = @cnomprop  
       , 'dirprop'    = @cdirprop  
       , 'rutprop'    = @nrutprop  
       , 'digprop'    = @cdigprop  
       , 'FecInfo'    = @cfecha  
       , 'Codcli'     = @ncodclie        
       , 'FecPro'     = @cfecPro  
       , 'Marca'      = 'I'  
       , 'Plazo'      = DATEDIFF(DD,B.CaFechaInicioOpc, B.CaFechaPagoEjer)  
       , 'Apodera1'   = ISNULL( @ap1nombre , '' )  
       , 'Cargo1'     = ISNULL( @ap1cargo  , '' )  
       , 'Fono1'      = ISNULL( @ap1fono   , '' )  
       , 'Apodera2'   = ISNULL( @ap2nombre , '' )  
       , 'Cargo2'     = ISNULL( @ap2cargo  , '' )  
       , 'Fono2'      = ISNULL( @ap2fono   , '' )  
       , 'Contador'   = 0  
       , 'CanPag'     = 0  
       , 'CodPais'    = ISNULL(G.codigo_pais,0)  
       , 'NomPais'    = ISNULL(G.nombre,'')  
       , 'EmailApo1'  = @cEmailApo1  
       , 'Sector'     = D.CLACTIVIDA  
       , 'cod_instru' = (CASE WHEN B.CaCallPut = 'Call' THEN '03' ELSE '04' END)  
       , 'Prima'      = ROUND((H.vmvalor * B.CaPrimaInicialDet / @DoObs),4)  
       , 'CodPagPrima'= A.CaCodMonPagPrima 
   
  /*FROM   lnkopc.CbMdbOpc.dbo.CaVenEncContrato A     
      , lnkopc.CbMdbOpc.dbo.CaVenDetContrato B  
      , VIEW_CLIENTE D     
      , VIEW_MONEDA  E with (nolock)   
      , VIEW_MONEDA  F with (nolock)   
      , VIEW_PAIS    G with (nolock)  
      , #VALOR_MONEDA H  
 WHERE  A.CaNumContrato =  B.CaNumContrato   
   AND  @dfecha         = CONVERT(CHAR(8),A.CaFechaContrato,112)    
   AND (A.CaRutCliente  = D.clrut and A.CaCodigo = D.clcodigo )   
   AND  B.CaCodMon1     = E.mncodmon      
   AND  B.CaCodMon2     = F.mncodmon      
          AND  A.CaCodMonPagPrima  = H.vmcodigo  
   AND  CONVERT(INT,G.codigo_pais) =* D.clpais   
--   AND  B.CaModalidad   = 'C'  
          AND  A.CaTipoTransaccion <> 'ANULA'  
          AND  A.CaEstado <> 'C'*/  
  
 --RQ 7619  
 FROM  LNKOPC.CbMdbOpc.dbo.CaVenEncContrato A   
  INNER JOIN  LNKOPC.CbMdbOpc.dbo.CaVenDetContrato B ON A.CaNumContrato =  B.CaNumContrato   
  INNER JOIN  VIEW_CLIENTE D with (nolock) ON (A.CaRutCliente  = D.clrut and A.CaCodigo = D.clcodigo )  
  INNER JOIN  VIEW_MONEDA  E with (nolock) ON  B.CaCodMon1     = E.mncodmon  
  INNER JOIN  VIEW_MONEDA  F with (nolock) ON  B.CaCodMon2     = F.mncodmon   
  RIGHT OUTER JOIN VIEW_PAIS    G with (nolock) ON CONVERT(INT,G.codigo_pais) = D.clpais   
  INNER JOIN  #VALOR_MONEDA H ON  A.CaCodMonPagPrima  = H.vmcodigo  
 WHERE @dfecha = CONVERT(CHAR(8),A.CaFechaContrato,112)  
 AND   A.CaTipoTransaccion <> 'ANULA'  
    AND  A.CaEstado <> 'C'  
  
-- MODIFICADAS   

 INSERT INTO  #TEMP_OPC  
 SELECT  distinct       
         'TipOpe'     = A.MoCVEstructura  
       , 'NumOpe'     = A.MoNumContrato  
       , 'RutCli'     = ISNULL( CASE WHEN D.clpais = 6 then A.MoRutCliente else D.clrutcliexterno END , 0 )  
       , 'DigCli'     = ISNULL( CASE WHEN D.clpais = 6 then D.cldv         else D.cldvcliexterno  END , 0 )  
       , 'NomCli'     = D.clnombre  
       , 'FecIni'     = CONVERT(CHAR(8), B.MoFechaInicioOpc,112)     
       , 'FecTer'     = CASE WHEN CONVERT(CHAR(08),B.MoFechaPagoEjer,112) = CONVERT(CHAR(08),K.MoFechaPagoEjer,112) THEN CONVERT(CHAR(08),'        ',112) ELSE CONVERT(CHAR(08),B.MoFechaPagoEjer,112) END  -- CONVERT(CHAR(8), B.MoFechaPagoEjer,112)
       , 'CodMdaRec'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
                                    THEN Case when  B.MoCodMon1 = K.MoCodMon1 then 0 else  B.MoCodMon1 end  -- B.MoCodMon1  
                              ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then 0 else  B.MoCodMon2 end        -- B.MoCodMon2  
                         END  
       , 'NemMonRec'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
                                    THEN Case when  B.MoCodMon1 = K.MoCodMon1 then ' ' else E.mnnemo end 
                           ELSE          Case when  B.MoCodMon2 = K.MoCodMon2 then ' ' else F.mnnemo end
                         END  
       , 'MtoRecibe'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
                                   THEN Case when  B.MoMontoMon1 = K.MoMontoMon1 then 0 else  B.MoMontoMon1 end   
                                   ELSE Case when  B.MoMontoMon2 = K.MoMontoMon2 then 0 else  B.MoMontoMon2 end
                         END  
       , 'CodMdaEnt'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                    THEN Case when  B.MoCodMon1 = K.MoCodMon1 then 0 else  B.MoCodMon1 end  
                                    ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then 0 else  B.MoCodMon2 end
                         END  
       , 'NemMonEnt'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                    THEN Case when  B.MoCodMon1 = K.MoCodMon1 then ' ' else E.mnnemo end 
                                    ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then ' ' else F.mnnemo end
                         END  
       , 'MtoEntrega' = CASE WHEN (B.MoCVOpc = 'C' AND  B.mOCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                   THEN Case when  B.MoMontoMon1 = K.MoMontoMon1 then 0 else  B.MoMontoMon1 end   
                                   ELSE Case when  B.MoMontoMon2 = K.MoMontoMon2 then 0 else  B.MoMontoMon2 end
                         END       
       , 'Modal'      = Case when B.MoModalidad = K.MoModalidad then ' ' else B.MoModalidad end       -- B.MoModalidad 
       , 'PreFut'     = Case when B.MoStrike  = K.MoStrike      then  0  else B.MoStrike    end       -- B.MoStrike
       , 'PreSpt'     = Case when B.MoStrike  = K.MoStrike      then  0  else B.MoStrike    end       -- B.MoStrike
       , 'nomprop'    = @cnomprop  
       , 'dirprop'    = @cdirprop  
       , 'rutprop'    = @nrutprop  
       , 'digprop'    = @cdigprop  
       , 'FecInfo'    = @cfecha  
       , 'Codcli'     = @ncodclie        
       , 'FecPro'     = @cfecPro  
       , 'Marca'      = 'M'  
       , 'Plazo'      = Case when (DATEDIFF(DD,B.MoFechaInicioOpc, B.MoFechaPagoEjer) = DATEDIFF(DD,K.MoFechaInicioOpc, K.MoFechaPagoEjer)) then 0 else DATEDIFF(DD,B.MoFechaInicioOpc, B.MoFechaPagoEjer)end -- DATEDIFF(DD,B.MoFechaInicioOpc, B.MoFechaPagoEjer)  
       , 'Apodera1'   = ISNULL( @ap1nombre , '' )  
       , 'Cargo1'     = ISNULL( @ap1cargo  , '' )  
       , 'Fono1'      = ISNULL( @ap1fono   , '' )  
       , 'Apodera2'   = ISNULL( @ap2nombre , '' )  
       , 'Cargo2'     = ISNULL( @ap2cargo  , '' )  
       , 'Fono2'      = ISNULL( @ap2fono   , '' )  
       , 'Contador'   = 0  
       , 'CanPag'     = 0  
       , 'CodPais'    = ISNULL(G.codigo_pais,0)  
       , 'NomPais'    = ISNULL(G.nombre,'')  
       , 'EmailApo1'  = @cEmailApo1  
       , 'Sector'     = 0 -- D.CLACTIVIDA  
       , 'cod_instru' = CASE WHEN B.MoCallPut = K.MoCallPut THEN  '00' ELSE   (CASE WHEN B.MoCallPut = 'Call' THEN '03' ELSE '04' END)  END        
       , 'Prima'      = 0.0 -- CASE WHEN B.MoPrimaInicialDet = K.MoPrimaInicialDet THEN 0.0  ELSE B.MoPrimaInicialDet END -- ROUND((A.MoPrimaInicialML * @DoObs),4)  
       , 'CodPagPrima'= A.MoCodMonPagPrima 
 FROM LNKOPC.CbMdbOpc.dbo.MoEncContrato A      
  INNER JOIN LNKOPC.CbMdbOpc.dbo.MoDetContrato B ON A.MoNumFolio =  B.MoNumFolio  
  INNER JOIN VIEW_CLIENTE D with (nolock) ON (A.MoRutCliente  = D.clrut and A.MoCodigo = D.clcodigo )  
  INNER JOIN VIEW_MONEDA  E with (nolock) ON  B.MoCodMon1     = E.mncodmon   
  INNER JOIN VIEW_MONEDA  F with (nolock) ON  B.MoCodMon2     = F.mncodmon  
  RIGHT OUTER JOIN  VIEW_PAIS G with (nolock) ON CONVERT(INT,G.codigo_pais) = D.clpais  
  INNER JOIN #VALOR_MONEDA H ON A.MoCodMonPagPrima  = H.vmcodigo  
  ,LNKOPC.CbMdbOpc.dbo.MoHisEncContrato J 
  INNER JOIN LNKOPC.CbMdbOpc.dbo.MoHisDetContrato K ON J.MoNumFolio =  K.MoNumFolio  
 WHERE @dfecha = CONVERT(CHAR(8),A.MoFechaCreacionRegistro,112)  
 AND  A.MoTipoTransaccion = 'MODIFICA'  
 AND  J.MoTipoTransaccion <> 'MODIFICA'   
 AND  A.MoNumContrato  = J.MoNumContrato  
 AND  B.MoNumEstructura = K.MoNumEstructura
 AND  J.MoNumFolio  =  (SELECT max(MoNumFolio) FROM  lnkopc.CbMdbOpc.dbo.MoHisEncContrato   WHERE  MoTipoTransaccion <> 'MODIFICA'  and  MoNumContrato = A.MoNumContrato)
 AND  A.MoEstado <> 'C'  

 UNION
 SELECT  distinct       
         'TipOpe'     = A.MoCVEstructura  
       , 'NumOpe'     = A.MoNumContrato  
       , 'RutCli'     = ISNULL( CASE WHEN D.clpais = 6 then A.MoRutCliente else D.clrutcliexterno END , 0 )  
       , 'DigCli'     = ISNULL( CASE WHEN D.clpais = 6 then D.cldv         else D.cldvcliexterno  END , 0 )  
       , 'NomCli'     = D.clnombre  
       , 'FecIni'     = CONVERT(CHAR(8), B.MoFechaInicioOpc,112)     
       , 'FecTer'     = CASE WHEN CONVERT(CHAR(08),B.MoFechaPagoEjer,112) = CONVERT(CHAR(08),K.MoFechaPagoEjer,112) THEN CONVERT(CHAR(08),'        ',112) ELSE CONVERT(CHAR(08),B.MoFechaPagoEjer,112) END -- CONVERT(CHAR(8), B.MoFechaPagoEjer,112)   
       , 'CodMdaRec'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
        THEN Case when  B.MoCodMon1 = K.MoCodMon1 then 0 else  B.MoCodMon1 end  -- B.MoCodMon1  
                              ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then 0 else  B.MoCodMon2 end        -- B.MoCodMon2  
                         END  
       , 'NemMonRec'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
                                    THEN Case when  B.MoCodMon1 = K.MoCodMon1 then ' ' else E.mnnemo end 
                           ELSE          Case when  B.MoCodMon2 = K.MoCodMon2 then ' ' else F.mnnemo end
                         END  
       , 'MtoRecibe'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
                                   THEN Case when  B.MoMontoMon1 = K.MoMontoMon1 then 0 else  B.MoMontoMon1 end   
                                   ELSE Case when  B.MoMontoMon2 = K.MoMontoMon2 then 0 else  B.MoMontoMon2 end
                         END  
       , 'CodMdaEnt'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                    THEN Case when  B.MoCodMon1 = K.MoCodMon1 then 0 else  B.MoCodMon1 end  
                                    ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then 0 else  B.MoCodMon2 end
                         END  
       , 'NemMonEnt'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                    THEN Case when  B.MoCodMon1 = K.MoCodMon1 then ' ' else E.mnnemo end 
                                    ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then ' ' else F.mnnemo end
                         END  
       , 'MtoEntrega' = CASE WHEN (B.MoCVOpc = 'C' AND  B.mOCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                   THEN Case when  B.MoMontoMon1 = K.MoMontoMon1 then 0 else  B.MoMontoMon1 end   
                                   ELSE Case when  B.MoMontoMon2 = K.MoMontoMon2 then 0 else  B.MoMontoMon2 end
                         END       
       , 'Modal'      = Case when B.MoModalidad = K.MoModalidad then ' ' else B.MoModalidad end       -- B.CaModalidad 
       , 'PreFut'     = Case when B.MoStrike  = K.MoStrike      then  0  else B.MoStrike    end       -- B.CaStrike
       , 'PreSpt'     = Case when B.MoStrike  = K.MoStrike      then  0  else B.MoStrike    end       -- B.CaStrike
       , 'nomprop'    = @cnomprop  
       , 'dirprop'    = @cdirprop  
       , 'rutprop'    = @nrutprop  
       , 'digprop'    = @cdigprop  
       , 'FecInfo'    = @cfecha  
       , 'Codcli'     = @ncodclie        
       , 'FecPro'     = @cfecPro  
       , 'Marca'      = 'M'  
       , 'Plazo'      = Case when (DATEDIFF(DD,B.MoFechaInicioOpc, B.MoFechaPagoEjer) = DATEDIFF(DD,K.MoFechaInicioOpc, K.MoFechaPagoEjer)) then 0 else DATEDIFF(DD,B.MoFechaInicioOpc, B.MoFechaPagoEjer)end
       , 'Apodera1'   = ISNULL( @ap1nombre , '' )  
       , 'Cargo1'     = ISNULL( @ap1cargo  , '' )  
       , 'Fono1'      = ISNULL( @ap1fono   , '' )  
       , 'Apodera2'   = ISNULL( @ap2nombre , '' )  
       , 'Cargo2'     = ISNULL( @ap2cargo  , '' )  
       , 'Fono2'      = ISNULL( @ap2fono   , '' )  
       , 'Contador'   = 0  
       , 'CanPag'     = 0  
       , 'CodPais'    = ISNULL(G.codigo_pais,0)  
       , 'NomPais'    = ISNULL(G.nombre,'')  
       , 'EmailApo1'  = @cEmailApo1  
       , 'Sector'     = 0 --D.CLACTIVIDA  
       , 'cod_instru' = CASE WHEN B.MoCallPut = K.MoCallPut THEN  '00' ELSE   (CASE WHEN B.MoCallPut = 'Call' THEN '03' ELSE '04' END) END
       , 'Prima'      = 0.0 -- CASE WHEN B.MoPrimaInicialDet = K.MoPrimaInicialDet THEN 0.0  ELSE B.MoPrimaInicialDet END --ROUND((A.MoPrimaInicialML * @DoObs),4)  
       , 'CodPagPrima'= A.MoCodMonPagPrima       
/* FROM   lnkopc.CbMdbOpc.dbo.MoHisEncContrato A   -- select * from lnkopc.CbMdbOpc.dbo.CaDetContrato  
      , lnkopc.CbMdbOpc.dbo.MoHisDetContrato B  
      , VIEW_CLIENTE D     
      , VIEW_MONEDA  E with (nolock)   
      , VIEW_MONEDA  F with (nolock)   
      , VIEW_PAIS    G with (nolock)  
      , #VALOR_MONEDA H  
 WHERE  A.MoNumFolio =  B.MoNumFolio  
   AND  @dfecha         = CONVERT(CHAR(8),A.MoFechaCreacionRegistro,112)     
   AND (A.MoRutCliente  = D.clrut and A.MoCodigo = D.clcodigo )   
   AND  B.MoCodMon1     = E.mncodmon      
   AND  B.MoCodMon2     = F.mncodmon      
      AND  A.MoCodMonPagPrima  = H.vmcodigo  
   AND  CONVERT(INT,G.codigo_pais) =* D.clpais   
--   AND  B.MoModalidad   = 'C'  
          AND  A.MoTipoTransaccion = 'MODIFICA'  
          AND  A.MoEstado <> 'C'*/  
  -- RQ 7619  
 FROM LNKOPC.CbMdbOpc.dbo.MoHisEncContrato A      
  INNER JOIN LNKOPC.CbMdbOpc.dbo.MoHisDetContrato B ON A.MoNumFolio =  B.MoNumFolio  
  INNER JOIN VIEW_CLIENTE D with (nolock) ON (A.MoRutCliente  = D.clrut and A.MoCodigo = D.clcodigo )  
  INNER JOIN VIEW_MONEDA  E with (nolock) ON  B.MoCodMon1     = E.mncodmon   
  INNER JOIN VIEW_MONEDA  F with (nolock) ON  B.MoCodMon2     = F.mncodmon  
  RIGHT OUTER JOIN  VIEW_PAIS G with (nolock) ON CONVERT(INT,G.codigo_pais) = D.clpais  
  INNER JOIN #VALOR_MONEDA H ON A.MoCodMonPagPrima  = H.vmcodigo  
  ,LNKOPC.CbMdbOpc.dbo.MoHisEncContrato J 
  INNER JOIN LNKOPC.CbMdbOpc.dbo.MoHisDetContrato K ON J.MoNumFolio =  K.MoNumFolio  
 WHERE @dfecha = CONVERT(CHAR(8),A.MoFechaCreacionRegistro,112)  
 AND  A.MoTipoTransaccion = 'MODIFICA'  
 AND  J.MoTipoTransaccion <> 'MODIFICA'   
 AND  A.MoNumContrato  = J.MoNumContrato  
 AND  B.MoNumEstructura = K.MoNumEstructura
 AND  J.MoNumFolio  =  (SELECT max(MoNumFolio) FROM  LNKOPC.CbMdbOpc.dbo.MoHisEncContrato   WHERE  MoTipoTransaccion <> 'MODIFICA'  and  MoNumContrato = A.MoNumContrato)
 AND  A.MoEstado <> 'C'  


-- ANTICIPADAS

	 
	 SELECT  Distinct
             'TipOpe'     = A.MoCVEstructura         
		   , 'NumOpe'     = A.MoNumContrato  
		   , 'RutCli'     = ISNULL( CASE WHEN D.clpais = 6 then A.MoRutCliente else D.clrutcliexterno END , 0 )  
		   , 'DigCli'     = ISNULL( CASE WHEN D.clpais = 6 then D.cldv         else D.cldvcliexterno  END , 0 )  
		   , 'NomCli'     = D.clnombre  
		   , 'FecIni'     = CONVERT(CHAR(8), B.MoFechaInicioOpc,112)     
		   , 'FecTer'     = CONVERT(CHAR(8), A.MoFechaUnwind,112)    -- CONVERT(CHAR(8), B.MoFechaPagoEjer,112)
		   , 'CodMdaRec'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
								  THEN Case when  B.MoCodMon1 = K.MoCodMon1 then 0 else  B.MoCodMon1 end
								  ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then 0 else  B.MoCodMon2 end
							 END  
		   , 'NemMonRec'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
								  THEN Case when  B.MoCodMon1 = K.MoCodMon1 then ' ' else E.mnnemo end
							      ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then ' ' else F.mnnemo end
							 END  
		   , 'MtoRecibe'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
                                   THEN Case when  B.MoMontoMon1 = K.MoMontoMon1 then 0 else  B.MoMontoMon1 end   
                                   ELSE Case when  B.MoMontoMon2 = K.MoMontoMon2 then 0 else  B.MoMontoMon2 end
							 END  
		   , 'CodMdaEnt'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                    THEN Case when  B.MoCodMon1 = K.MoCodMon1 then 0 else  B.MoCodMon1 end  
                                    ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then 0 else  B.MoCodMon2 end
                            END  
		   , 'NemMonEnt'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
							        THEN Case when  B.MoCodMon1 = K.MoCodMon1 then ' ' else E.mnnemo end 
                        ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then ' ' else F.mnnemo end

							 END  
		   , 'MtoEntrega' = CASE WHEN (B.MoCVOpc = 'C' AND  B.mOCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                   THEN Case when  B.MoMontoMon1 = K.MoMontoMon1 then 0 else  B.MoMontoMon1 end   
                                   ELSE Case when  B.MoMontoMon2 = K.MoMontoMon2 then 0 else  B.MoMontoMon2 end
							 END       
		   , 'Modal'      = Case when B.MoModalidad = K.MoModalidad then ' ' else B.MoModalidad end       -- B.MoModalidad 
		   , 'PreFut'     = Case when B.MoStrike  = K.MoStrike      then  0  else B.MoStrike    end       -- B.MoStrike
		   , 'PreSpt'     = Case when B.MoStrike  = K.MoStrike      then  0  else B.MoStrike    end       -- B.MoStrike
		   , 'nomprop'    = @cnomprop  
		   , 'dirprop'    = @cdirprop  
		   , 'rutprop'    = @nrutprop  
		   , 'digprop'    = @cdigprop  
		   , 'FecInfo'    = @cfecha  
		   , 'Codcli'     = @ncodclie        
		   , 'FecPro'     = @cfecPro  
		   , 'Marca'      = 'M'  
		   , 'Plazo'      = DATEDIFF(DD,B.MoFechaInicioOpc, B.MoFechaPagoEjer)  
		   , 'Apodera1'   = ISNULL( @ap1nombre , '' )  
		   , 'Cargo1'     = ISNULL( @ap1cargo  , '' )  
		   , 'Fono1'      = ISNULL( @ap1fono   , '' )  
		   , 'Apodera2'   = ISNULL( @ap2nombre , '' )  
		   , 'Cargo2'     = ISNULL( @ap2cargo  , '' )  
		   , 'Fono2'      = ISNULL( @ap2fono   , '' )  
		   , 'Contador'   = 0  
		   , 'CanPag'     = 0  
		   , 'CodPais'    = ISNULL(G.codigo_pais,0)  
		   , 'NomPais'    = ISNULL(G.nombre,'')  
		   , 'EmailApo1'  = @cEmailApo1  
		   , 'Sector'     = D.CLACTIVIDA  
		   , 'cod_instru' = (CASE WHEN B.MoCallPut = 'Call' THEN '03' ELSE '04' END)  
		   , 'Prima'      = 0.0 -- B.MoPrimaInicialDet --ROUND((A.MoPrimaInicialML * @DoObs),4)  
           , 'CodPagPrima'= A.MoCodMonPagPrima 	
	INTO  #TEMP_OPC_ANT  
	FROM LNKOPC.CbMdbOpc.dbo.MoEncContrato A   
	  INNER JOIN LNKOPC.CbMdbOpc.dbo.MoDetContrato B ON A.MoNumFolio =  B.MoNumFolio  
	  INNER JOIN VIEW_CLIENTE D with (nolock) ON (A.MoRutCliente  = D.clrut and A.MoCodigo = D.clcodigo )  
	  INNER JOIN VIEW_MONEDA  E with (nolock) ON  B.MoCodMon1     = E.mncodmon   
	  INNER JOIN VIEW_MONEDA  F with (nolock) ON  B.MoCodMon2     = F.mncodmon  
	  RIGHT OUTER JOIN  VIEW_PAIS G with (nolock) ON CONVERT(INT,G.codigo_pais) = D.clpais  
	  INNER JOIN #VALOR_MONEDA H ON A.MoCodMonPagPrima  = H.vmcodigo  
      ,LNKOPC.CbMdbOpc.dbo.MoHisEncContrato J 
      INNER JOIN LNKOPC.CbMdbOpc.dbo.MoHisDetContrato K ON J.MoNumFolio =  K.MoNumFolio  
	WHERE @dfecha = CONVERT(CHAR(8),A.MoFechaUnwind,112)  
	 AND  A.MoTipoTransaccion = 'ANTICIPA'  	 
     AND  J.MoTipoTransaccion <> 'ANTICIPA'   
     AND  A.MoNumContrato  = J.MoNumContrato  
     AND  B.MoNumEstructura = K.MoNumEstructura
     AND  J.MoNumFolio  =  (SELECT max(MoNumFolio) FROM  LNKOPC.CbMdbOpc.dbo.MoHisEncContrato   WHERE  MoTipoTransaccion <> 'ANTICIPA'  and  MoNumContrato = A.MoNumContrato )
	 AND  A.MoEstado <> 'C'  
    UNION
	SELECT  Distinct
             'TipOpe'     = A.MoCVEstructura         
		   , 'NumOpe'     = A.MoNumContrato
		   , 'RutCli'     = ISNULL( CASE WHEN D.clpais = 6 then A.MoRutCliente else D.clrutcliexterno END , 0 )  
		   , 'DigCli'     = ISNULL( CASE WHEN D.clpais = 6 then D.cldv         else D.cldvcliexterno  END , 0 )  
		   , 'NomCli'     = D.clnombre  
		   , 'FecIni'     = CONVERT(CHAR(8), B.MoFechaInicioOpc,112)     
		   , 'FecTer'     = CONVERT(CHAR(8), A.MoFechaUnwind,112)    -- CONVERT(CHAR(8), B.MoFechaPagoEjer,112)   
		   , 'CodMdaRec'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
								  THEN Case when  B.MoCodMon1 = K.MoCodMon1 then 0 else  B.MoCodMon1 end
								  ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then 0 else  B.MoCodMon2 end
							 END  
		   , 'NemMonRec'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
								  THEN Case when  B.MoCodMon1 = K.MoCodMon1 then ' ' else E.mnnemo end
							      ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then ' ' else F.mnnemo end
							 END  
		   , 'MtoRecibe'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Call') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Put')  
                                   THEN Case when  B.MoMontoMon1 = K.MoMontoMon1 then 0 else  B.MoMontoMon1 end   
                                   ELSE Case when  B.MoMontoMon2 = K.MoMontoMon2 then 0 else  B.MoMontoMon2 end
							 END  
		   , 'CodMdaEnt'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                    THEN Case when  B.MoCodMon1 = K.MoCodMon1 then 0 else  B.MoCodMon1 end  
                                    ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then 0 else  B.MoCodMon2 end
                            END  
		   , 'NemMonEnt'  = CASE WHEN (B.MoCVOpc = 'C' AND  B.MoCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
							        THEN Case when  B.MoCodMon1 = K.MoCodMon1 then ' ' else E.mnnemo end 
                                    ELSE Case when  B.MoCodMon2 = K.MoCodMon2 then ' ' else F.mnnemo end

							 END  
		   , 'MtoEntrega' = CASE WHEN (B.MoCVOpc = 'C' AND  B.mOCallPut = 'Put') OR (B.MoCVOpc = 'V' AND  B.MoCallPut = 'Call')  
                                   THEN Case when  B.MoMontoMon1 = K.MoMontoMon1 then 0 else  B.MoMontoMon1 end   
                                   ELSE Case when  B.MoMontoMon2 = K.MoMontoMon2 then 0 else  B.MoMontoMon2 end
							 END       
		   , 'Modal'      = Case when B.MoModalidad = K.MoModalidad then ' ' else B.MoModalidad end       -- B.MoModalidad 
		   , 'PreFut'     = Case when B.MoStrike  = K.MoStrike      then  0  else B.MoStrike    end       -- B.MoStrike
		   , 'PreSpt'     = Case when B.MoStrike  = K.MoStrike      then  0  else B.MoStrike    end       -- B.MoStrike
		   , 'nomprop'    = @cnomprop  
		   , 'dirprop'    = @cdirprop  
		   , 'rutprop'    = @nrutprop  
		   , 'digprop'    = @cdigprop  
		   , 'FecInfo'    = @cfecha  
		   , 'Codcli'     = @ncodclie        
		   , 'FecPro'     = @cfecPro  
		   , 'Marca'      = 'M'  
		   , 'Plazo'      =  DATEDIFF(DD,B.MoFechaInicioOpc, A.MoFechaUnwind)  
		   , 'Apodera1'   = ISNULL( @ap1nombre , '' )  
		   , 'Cargo1'     = ISNULL( @ap1cargo  , '' )  
		   , 'Fono1'      = ISNULL( @ap1fono   , '' )  
		   , 'Apodera2'   = ISNULL( @ap2nombre , '' )  
		   , 'Cargo2'     = ISNULL( @ap2cargo  , '' )  
		   , 'Fono2'      = ISNULL( @ap2fono   , '' )  
		   , 'Contador'   = 0  
		   , 'CanPag'     = 0  
		   , 'CodPais'    = ISNULL(G.codigo_pais,0)  
		   , 'NomPais'    = ISNULL(G.nombre,'')  
		   , 'EmailApo1'  = @cEmailApo1  
		   , 'Sector'     = D.CLACTIVIDA  
		   , 'cod_instru' = (CASE WHEN B.MoCallPut = 'Call' THEN '03' ELSE '04' END)  
		   , 'Prima'      = 0.0 -- B.MoPrimaInicialDet-- ROUND((A.MoPrimaInicialML * @DoObs),4)   
           , 'CodPagPrima'= A.MoCodMonPagPrima 
	 FROM LNKOPC.CbMdbOpc.dbo.MoHisEncContrato A   
	  INNER JOIN LNKOPC.CbMdbOpc.dbo.MoHisDetContrato B ON A.MoNumFolio =  B.MoNumFolio  
	  INNER JOIN VIEW_CLIENTE D with (nolock) ON (A.MoRutCliente  = D.clrut and A.MoCodigo = D.clcodigo )  
	  INNER JOIN VIEW_MONEDA  E with (nolock) ON  B.MoCodMon1     = E.mncodmon   
	  INNER JOIN VIEW_MONEDA  F with (nolock) ON  B.MoCodMon2     = F.mncodmon  
	  RIGHT OUTER JOIN  VIEW_PAIS G with (nolock) ON CONVERT(INT,G.codigo_pais) = D.clpais  
	  INNER JOIN #VALOR_MONEDA H ON A.MoCodMonPagPrima  = H.vmcodigo  
      ,LNKOPC.CbMdbOpc.dbo.MoHisEncContrato J 
      INNER JOIN LNKOPC.CbMdbOpc.dbo.MoHisDetContrato K ON J.MoNumFolio =  K.MoNumFolio  
	 WHERE @dfecha = CONVERT(CHAR(8),A.MoFechaUnwind,112)  
	 AND  A.MoTipoTransaccion = 'ANTICIPA'  
     AND  J.MoTipoTransaccion <> 'ANTICIPA'   
     AND  A.MoNumContrato  = J.MoNumContrato  -- 
     AND  B.MoNumEstructura = K.MoNumEstructura
     AND  J.MoNumFolio  =  (SELECT max(MoNumFolio) FROM  LNKOPC.CbMdbOpc.dbo.MoHisEncContrato   WHERE  MoTipoTransaccion <> 'ANTICIPA'  and  MoNumContrato = A.MoNumContrato )
     AND  A.MoEstado <> 'C'  


 INSERT INTO  #TEMP_OPC  
 SELECT      TipOpe
		   , NumOpe
		   , RutCli
		   , DigCli
		   , NomCli
		   , FecIni
		   , FecTer
		   , CodMdaRec
		   , NemMonRec
		   , MtoRecibe
		   , CodMdaEnt
		   , NemMonEnt
		   , MtoEntrega
		   , Modal
		   , PreFut
		   , PreSpt
		   , nomprop
		   , dirprop
		   , rutprop
		   , digprop
		   , FecInfo
		   , Codcli
		   , FecPro
		   , Marca
		   , Plazo
		   , Apodera1
		   , Cargo1
		   , Fono1
		   , Apodera2
		   , Cargo2
		   , Fono2
		   , Contador
		   , CanPag
		   , CodPais
		   , NomPais
		   , EmailApo1
		   , Sector
		   , cod_instru
		   , 'Prima' = 0.0 -- CASE WHEN CodPagPrima <> 999 THEN Prima ELSE  ROUND((Prima / @DoObs),4) END  
           , CodPagPrima
 FROM  #TEMP_OPC_ANT  



-- ANTICIPADAS
  
  
 INSERT INTO  #temp            
 SELECT    TipOpe   
  , NumOpe   
  , RutCli   
  , DigCli  
  , NomCli  
  , FecIni  
  , FecTer  
  , CodMdaRec  
  , NemMonRec  
  , MtoRecibe  
  , CodMdaEnt  
  , NemMonEnt  
  , MtoEntrega  
  , Modal  
  , PreFut  
  , PreSpt   
  , nomprop  
  , dirprop  
  , rutprop  
  , digprop  
  , FecInfo   
  , Codcli  
  , FecPro  
  , Marca  
  , Plazo   
  , Apodera1  
  , Cargo1  
  , Fono1  
  , Apodera2  
  , Cargo2  
  , Fono2  
  , Contador  
  , CanPag  
  , CodPais  
  , NomPais  
  , EmailApo1  
  , Sector  
  , cod_instru  
        , Prima   
        FROM #TEMP_OPC  
  



   
--***************************************OPCIONES**************************************************************  

    
  
    Select @cuenta = 1    
    While (1=1) Begin  
       If not Exists (Select 1 from #temp Where contador=0 ) Begin  
          Break   
       End  
       Set Rowcount 15  
       Update #temp set contador=@cuenta Where Contador =0  
       Set Rowcount 0  
       Select @cuenta =@cuenta +1  
     END  
    UPDATE #temp set CanPag=@cuenta -1  
  
    IF NOT EXISTS( SELECT 1 FROM #temp )   
 INSERT INTO  #temp            
 SELECT  'TipOpe'   = ' ',  
   'NumOpe'   = 0,  
   'RutCli'   = 0,  
   'DigCli'   = 0,  
   'NomCli'   = ' ',  
   'FecIni'   = @cfecha ,  
   'FecTer'   = ' '  ,  
   'CpaCodMon'     = 0  ,       
   'CpaNemMon'     = ' '  ,  
   'CpaMonto'      = 0 ,  
   'VtaCodMon'     = 0 ,  
   'VtaNemMon'     = ' ' ,  
   'VtaMonto'      = 0 ,  
   'Modal'    = ' '  ,  
   'PreFut'   = 0 ,  
   'PreSpt'   = 0 ,  
   'nomprop'  = @cnomprop  ,  
   'dirprop'  = @cdirprop  ,  
   'rutprop'  = @nrutprop  ,  
   'digprop'  = @cdigprop  ,  
   'FecInfo'  = @cfecha  ,  
   'codclie'  = @ncodclie      ,  
   'FecPro'   = @cfecpro    ,  
   'Marca'    = ' '    ,   
   'Plazo'    = 0,  
   'Apodera1'  = ISNULL( @ap1nombre , '' ) ,  
   'Cargo1'    = ISNULL( @ap1cargo  , '' ) ,  
   'Fono1'     = ISNULL( @ap1fono   , '' ) ,  
   'Apodera2'  = ISNULL( @ap2nombre , '' ) ,  
   'Cargo2'    = ISNULL( @ap2cargo  , '' ) ,  
   'Fono2'     = ISNULL( @ap2fono   , '' ) ,  
   'Contador'      = 0 ,  
   'CanPag'        = 0 ,  
   'CodPais'       = 0 ,  
   'NomPais'       = ' ' ,  
   'EmailApo1'     = @cEmailApo1 ,  
   'Sector Eco'    = 0,  
   'cod_instru'    = '01',  
   'Prima'         = 0.0    


-- INI COMDER
IF EXISTS(SELECT 1 FROM BDBOMESA.dbo.COMDER_RelacionMarcaComder a, #temp b WHERE a.nReNumOper = b.NumOpe AND a.iReNovacion = 1 AND a.vReEstado = 'V' AND a.dReFecha = @dfecha )
BEGIN
	UPDATE #temp
	SET	NOMCLI	= b.Clnombre
		,DIGCLI	= b.Cldv
		,RUTCLI	= b.Clrut
		--,SectorEco = b.clactivida
   FROM		BDBOMESA.dbo.COMDER_RelacionMarcaComder a, VIEW_CLIENTE b  
   WHERE	a.nReNumOper = #temp.NumOpe
   AND		#temp.RUTCLI = (select acRutComder from MFAC)  
   AND		(a.nReRutCliente = b.clrut and a.nReCodCliente=b.clcodigo )
   AND		a.iReNovacion = 1 
   AND		a.vReEstado = 'V' 
   AND		a.dReFecha = @dfecha
END
-- FIN COMDER


    SELECT *, 
	       'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales), 
		   'RutEntidad' = (SELECT RutEntidad FROM BacParamSuda..Contratos_ParametrosGenerales),
		   'DigitoVerificador' = (SELECT DigitoVerificador FROM BacParamSuda..Contratos_ParametrosGenerales)
	  FROM #temp  
  
  
 END  


GO
