USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAPVII]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CAPVII](
                            @dfecha   CHAR(08)  ,
                            @nrutapo1 NUMERIC(9),
                            @nrutapo2  NUMERIC(9)
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
   declare @estado     char(1) 
   
   select @estado = caestado from mfca_log
   /*=======================================================================*/
   /*               CODIGO DE PAIS SEGUN INSTALACION                        */
   /*=======================================================================*/
   DECLARE @CodPais    INT  
   
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
               @ncodclie = d.accodclie                          ,
               @cfecpro = CONVERT( CHAR(10), d.acfecproc, 103 ) 
              
          FROM  VIEW_VALOR_MONEDA b ,
                VIEW_VALOR_MONEDA c ,
                MFAC d
          WHERE b.vmcodigo = 998 AND
                convert(char(08),b.vmfecha,112)  = @dfecha AND
                c.vmcodigo = 994 AND
                convert(char(08),c.vmfecha,112)  = @dfecha   
   /*=======================================================================*/
   /* Selecciona los Apoderados          */ 
   /*=======================================================================*/
   SELECT       @ap1nombre = a.apnombre   ,
                @ap1cargo  = a.apcargo    ,
                @ap1fono   = a.apfono   
   FROM VIEW_CLIENTE_APODERADO a,
        MFAC b
   WHERE @nrutapo1 = a.aprutapo AND b.acrutprop = a.aprutcli
   SELECT       @ap2nombre = a.apnombre   ,
    @ap2cargo  = a.apcargo    ,
         @ap2fono   = a.apfono   
   FROM VIEW_CLIENTE_APODERADO a,
        MFAC b
   WHERE @nrutapo2 = a.aprutapo AND b.acrutprop = a.aprutcli
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
              'SectorEconomico' = b.clsector ,
              'CodigoIns'       = '01'        ,
              'Instrumento'     = 'Forward'  ,
              'Estado'          = a.caestado
             
         INTO  #temp
         FROM  MFCA  a,
               VIEW_CLIENTE  b,
               VIEW_MONEDA   c,
               VIEW_MONEDA   d
         WHERE  a.cafecha  = @dFecha      AND
  a.catipoper IN ('C','V')   AND
  a.cacodpos1 IN (1,2,7)       AND        -- falta discriminar s«lo mercado local
  (a.cacodigo = b.clrut      AND
                a.cacodcli  = b.clcodigo  ) AND
--                b.clpais    = @CodPais  )  AND
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
              'SectorEconomico' = b.clsector   ,
              'CodigoIns'       = '01'        ,
              'Instrumento'     = 'Forward' ,
              'Estado'          = a.caestado
         FROM  MFCAH         a,
               VIEW_CLIENTE  b,
               VIEW_MONEDA   c,
               VIEW_MONEDA   d
         WHERE  a.cafecha   = @cFecha      and
  a.catipoper IN ('C','V')   AND
  a.cacodpos1 IN (1,2,7 )    AND        -- falta discriminar s«lo mercado local
  (a.cacodigo = b.clrut      AND
                a.cacodcli  = b.clcodigo ) AND
--                b.clpais    = @CodPais  )  AND
  a.cacodmon1 = c.mncodmon   AND
  a.cacodmon2 = d.mncodmon
 /*=======================================================================*/
--   Modificaaciones para ese dia
 /*=======================================================================*/
 INSERT INTO  #temp    
      
 SELECT       'TipOpe'   = a.catipoper    ,
              'NumOpe'   = a.canumoper    ,
              'RutCli'   = a.cacodigo     ,
              'DigCli'   = b.cldv  ,
              'NomCli'   = b.clnombre     ,
              'FecIni'   = CONVERT(CHAR(10),a.cafecha  ,103) ,
              'FecTer'   = CONVERT(CHAR(10),a.cafecvcto,103) ,
              'CpaCodMon'  = case a.catipoper when e.catipoper then 0 else  case a.catipoper when  'C' then a.cacodmon1 else a.cacodmon2 End End    ,    
           
              'CpaNemMon'  = case a.catipoper when 'C' then          
                                      case a.cacodmon1 when e.cacodmon1 then ' ' else c.mnnemo  End   
                                  Else    
                                      case a.cacodmon2 when e.cacodmon2 then ' ' else d.mnnemo End    
                                  End     ,    
              'CpaMonto'   = case a.catipoper when 'C' then 
                                       case a.camtomon1 when e.camtomon1 then  0 else a.camtomon1 End
                                  Else 
                                       case a.camtomon2 when e.camtomon2 then  0 else a.camtomon2 End        
                                  End ,
              'VtaCodMon'  = Case a.catipoper when 'V' then
                                       case  a.cacodmon1 when e.cacodmon1 then 0 else a.cacodmon1 End
                                  Else   
                                       case  a.cacodmon2 when e.cacodmon2 then 0 else a.cacodmon2 End     
                                  End,    
              'VtaNemMon'  = Case a.catipoper when 'V' then 
                                       case  a.cacodmon1 when e.cacodmon1 then ' ' else  c.mnnemo  End
                                  Else 
                                       case  a.cacodmon2 when e.cacodmon2 then ' ' else  d.mnnemo  End    
                                  End , 
   
              'VtaMonto'   = Case a.catipoper when 'V' then 
                                       case  a.camtomon1 when e.camtomon1 then 0 else a.camtomon1 End
                                  Else 
                                       case  a.camtomon2 when e.camtomon2 then 0 else a.camtomon2 End
                                  End , 
   
              'Modal'    = Case a.catipmoda when e.catipmoda then ' ' else e.catipmoda end     ,
              'PreFut'   = Case a.caprecal  when e.caprecal  then  0  else e.caprecal  end     ,
              'PreSpt'   = Case a.capremon1 when e.capremon1 then  0  else e.capremon1 end     ,          
              'nomprop'  = @cnomprop  ,
              'dirprop'  = @cdirprop  ,
              'rutprop'  = @nrutprop  ,
              'digprop'  = @cdigprop  ,
              'FecInfo'  = @cfecha  ,
              'codclie'  = @ncodclie      ,
              'FecPro'   = @cfecpro    ,
              'Marca'    = 'M'    , 
              'Plazo'    = case a.caplazo when e.caplazo then 0 else e.caplazo    end ,
              'Apodera1'  = ISNULL( @ap1nombre , '' ) ,
              'Cargo1'    = ISNULL( @ap1cargo  , '' ) ,
              'Fono1'     = ISNULL( @ap1fono   , '' ) ,
              'Apodera2'  = ISNULL( @ap2nombre , '' ) ,
              'Cargo2'    = ISNULL( @ap2cargo  , '' ) ,
              'Fono2'     = ISNULL( @ap2fono   , '' ) ,
              'Contador'        = 0 ,
              'CanPag'          = 0  ,
              'SectorEconomico' = b.clsector   ,
              'CodigoIns'       = '01'        ,
              'Instrumento'     = 'Forward'  ,
              'Estado'          = a.caestado
    
     
         FROM  MFCA_LOG a,
               VIEW_CLIENTE  b,
               VIEW_MONEDA   c,
               VIEW_MONEDA   d,
               MFCA e
 
         WHERE  a.cafecmod  = @cFecha      AND
                NOT EXISTS( select * from #temp where #temp.NumOpe = a.canumoper) and               
                a.cafecmod > a.cafecha     And
                a.canumoper = e.canumoper  And             
                a.catipoper IN ('C','V')   AND
				a.cacodpos1 IN (1,2,3 )    AND        
			   (a.cacodigo = b.clrut      AND
                a.cacodcli = b.clcodigo )   And -- b.cltipcli <> 6 ) and
				a.cacodmon1 = c.mncodmon   AND
				a.cacodmon2 = d.mncodmon
 
   -- Select @cuenta = 1  
    
     While @estado = 'M' Begin
       If not Exists(Select 1 from #temp Where contador=0 ) 
       Begin
   SET NOCOUNT OFF
   Set Rowcount 0
   SELECT      'TipOpe'   = '',
               'NumOpe'   = '',
               'RutCli'   = '',
	       'DigCli'   = '',
               'NomCli'   = '',
               'FecIni'   = '',
               'FecTer'   = '',
               'CpaCodMon'  = '',
               'CpaNemMon'  = 'CLP', 
               'CpaMonto'   = 0,
               'VtaCodMon'  = 0,
               'VtaNemMon'  = 'UF',
               'VtaMonto'   = 0,
               'Modal'    = '',
               'PreFut'   = '',
               'PreSpt'   = '',
               'nomprop'  = '',
	       'dirprop'  = '',
               'rutprop'  = '',
               'digprop'  = '',
               'FecInfo'  = '',
               'codclie'  = 0,
               'FecPro'   = '',
               'Marca'    = '',
               'Plazo'    = '',
               'Apodera1'  = '',
               'Cargo1'    = '',
               'Fono1'     = '',
               'Apodera2'  = '',
               'Cargo2'    = '',
               'Fono2'     = '',
               'Contador'        = '',
               'CanPag'          = ''
   RETURN
       End
       Set Rowcount 15
       Update #temp set contador=@cuenta Where Contador =0
       Set Rowcount 0
       Select @cuenta =@cuenta +1
     END
    UPDATE #temp set CanPag=@cuenta -1
    SELECT * FROM #temp order by numope
SET NOCOUNT OFF
END

GO
