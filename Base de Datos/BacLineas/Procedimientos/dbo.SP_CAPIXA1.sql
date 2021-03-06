USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAPIXA1]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CAPIXA1](
                            @dfecha  	CHAR(08)	,
		            @nrutapo1	float	,
                            @nrutapo2 	float
       			  )
AS
BEGIN
SET NOCOUNT ON
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


   /*=======================================================================*/
   /*=======================================================================*/
   SELECT      @cfecha = CONVERT( CHAR(10), convert(datetime,@dfecha), 103 ) 	,
               @nvaluf = b.vmvalor 				,
               @nvalob = c.vmvalor 				,
	       @cnomprop = (Select acnomprop from mfac),
               @cdirprop = d.acdirprop				,
               @nrutprop = d.acrutprop				,
               @cdigprop = d.acdigprop				,
	       @ncodclie = 21                          ,
	       @cfecpro = CONVERT( CHAR(10), d.acfecproc, 103 ) 
              -- select * from view_valor_moneda 

          FROM view_valor_moneda b ,
               view_valor_moneda c ,
	       mfac d

          WHERE b.vmcodigo = 998	AND
                convert(char(08),b.vmfecha,112)  = @dfecha	AND
                c.vmcodigo = 994	AND
                convert(char(08),c.vmfecha,112)  = @dfecha   

   /*=======================================================================*/
   /* Selecciona los Apoderados						    */	
   /*=======================================================================*/

   SELECT       @ap1nombre  = a.apnombre  	,
	  	@ap1cargo   = a.apcargo   	,
        	@ap1fono    = a.apfono   	,
		@cEmailApo1 = a.apemail


	  FROM view_cliente_apoderado a,
	       mfac b

	  WHERE @nrutapo1 = a.aprutapo AND b.acrutprop = a.aprutcli

   SELECT       @ap2nombre = a.apnombre  	,
	  	@ap2cargo  = a.apcargo   	,
        	@ap2fono   = a.apfono   

	  FROM view_cliente_apoderado a,
	       mfac b

	  WHERE @nrutapo2 = a.aprutapo AND b.acrutprop = a.aprutcli

   /*=======================================================================*/
   /* llena los datos desde la Cartera					    */	
   /*=======================================================================*/
   SELECT     'TipOpe'  	= a.catipoper    ,
              'NumOpe'  	= a.canumoper    ,
              'RutCli'  	= a.cacodigo     ,
	      'DigCli'  	= b.cldv	 ,
              'NomCli'  	= b.clnombre     ,
              'FecIni'  	= CONVERT(CHAR(10),a.cafecha  ,103) ,
              'FecTer'  	= CONVERT(CHAR(10),a.cafecvcto,103) ,
              'CpaCodMon' 	= case a.catipoper when 'C' then a.cacodmon1 else a.cacodmon2 End 	,    
              'CpaNemMon' 	= case a.catipoper when 'C' then c.mnnemo else d.mnnemo End 		,    
              'CpaMonto'  	= case a.catipoper when 'C' then a.camtomon1 else a.camtomon2 End 	,    
              'VtaCodMon' 	= case a.catipoper when 'V' then a.cacodmon1 else a.cacodmon2 End 	,    
              'VtaNemMon' 	= case a.catipoper when 'V' then c.mnnemo else d.mnnemo End 		,    
              'VtaMonto'  	= case a.catipoper when 'V' then a.camtomon1 else a.camtomon2 End 	,    
              'Modal'   	= a.catipmoda    ,			-- select * from mfca
              'PreFut'  	= CASE WHEN a.cacodpos1=3 THEN a.capremon2 ELSE
                                  CASE WHEN a.cacodpos1=2 THEN a.caparbcch ELSE  a.caprecal END END,
              'PreSpt'  	= a.precio_spot, --a.caTcSpot     ,

	      'nomprop' 	= @cnomprop	 ,
	      'dirprop' 	= @cdirprop	 ,
	      'rutprop' 	= @nrutprop	 ,
	      'digprop' 	= @cdigprop	 ,
	      'FecInfo' 	= @cfecha	 ,
	      'codclie' 	= @ncodclie      ,
	      'FecPro'  	= @cfecpro       ,
	      'Marca'   	= 'I'		 ,	
	      'Plazo'   	= a.caplazo      ,
              'Apodera1' 	= ISNULL( @ap1nombre , '' ) ,
              'Cargo1'   	= ISNULL( @ap1cargo  , '' ) ,
              'Fono1'    	= ISNULL( @ap1fono   , '' ) ,
              'Apodera2' 	= ISNULL( @ap2nombre , '' ) ,
              'Cargo2'   	= ISNULL( @ap2cargo  , '' ) ,
              'Fono2'    	= ISNULL( @ap2fono   , '' ) ,
              'Contador'        = 0,
              'CanPag'          = 0,
  	      'CodPais'     = ISNULL(e.codigo_pais,0)   ,
       	      'NomPais'     = ISNULL(e.nombre,'')  ,
              'EmailApo1'   = @cEmailApo1,
              'Sector Eco'  = b.CLACTIVIDA


         INTO  #temp
-- select * from mfca
         FROM  mfca  a,
               view_cliente  b,
	       view_moneda c , --mdmn  c,
	       view_moneda d , --mdmn  d , 
	       view_pais e       -- Tabla de Paises
		 LEFT OUTER JOIN view_cliente vc ON CONVERT(INTEGER, e.codigo_pais) = vc.clpais	
         WHERE  SUBSTRING(CONVERT(CHAR(10),a.cafecha,103),1,6) = SUBSTRING(@cFecha,1,6) AND
		a.catipoper IN ('C','V')   AND
		a.cacodpos1 IN (1,2,3)     AND        -- falta discriminar s«lo mercado local
		(a.cacodigo = b.clrut      AND
                a.cacodcli  = b.clcodigo )  AND
		a.cacodmon1 = c.mncodmon   AND
		a.cacodmon2 = d.mncodmon   ---AND
   		---e.tbcateg     = 180        AND  
		--- CONVERT(INTEGER,e.codigo_pais ) =* b.clpais -- tbcodigo1                  
				--select * from pais
   INSERT INTO  #temp

      SELECT  'TipOpe'  	= a.catipoper    ,
              'NumOpe'  	= a.canumoper    ,
              'RutCli'  	= a.cacodigo     ,
	      'DigCli'  	= b.cldv	 ,
              'NomCli'  	= b.clnombre     ,
              'FecIni'  	= CONVERT(CHAR(10),a.cafecha  ,103) ,
              'FecTer'  	= CONVERT(CHAR(10),a.cafecvcto,103) ,
              'CpaCodMon' 	= case a.catipoper when 'C' then a.cacodmon1 else a.cacodmon2 End 	,    
              'CpaNemMon' 	= case a.catipoper when 'C' then c.mnnemo else d.mnnemo End 		,    
              'CpaMonto'  	= case a.catipoper when 'C' then a.camtomon1 else a.camtomon2 End 	,    
              'VtaCodMon' 	= case a.catipoper when 'V' then a.cacodmon1 else a.cacodmon2 End 	,    
              'VtaNemMon' 	= case a.catipoper when 'V' then c.mnnemo else d.mnnemo End 		,    
              'VtaMonto'  	= case a.catipoper when 'V' then a.camtomon1 else a.camtomon2 End 	,    
              'Modal'   	= a.catipmoda    ,
              'PreFut'  	= CASE WHEN a.cacodpos1=3 THEN a.capremon2 ELSE
                                  CASE WHEN a.cacodpos1=2 THEN a.catipcam  ELSE a.caprecal END END, -- caparbcch
              'PreSpt'  	= a.capremon1    ,	      
	      'nomprop' 	= @cnomprop	 ,
	      'dirprop' 	= @cdirprop	 ,
	      'rutprop' 	= @nrutprop	 ,
	      'digprop' 	= @cdigprop	 ,
	      'FecInfo' 	= @cfecha	 ,
	      'codclie' 	= @ncodclie      ,
	      'FecPro'  	= @cfecpro  	 ,
      	      'Marca'   	= 'I' 		 ,	
	      'Plazo'   	= a.caplazo      ,
              'Apodera1' 	= ISNULL( @ap1nombre , '' ) ,
              'Cargo1'   	= ISNULL( @ap1cargo  , '' ) ,
              'Fono1'    	= ISNULL( @ap1fono   , '' ) ,
              'Apodera2' 	= ISNULL( @ap2nombre , '' ) ,
              'Cargo2'   	= ISNULL( @ap2cargo  , '' ) ,
              'Fono2'    	= ISNULL( @ap2fono   , '' ) ,
              'Contador'        = 0 ,
              'CanPag'          = 0  ,
  	      'CodPais'     = ISNULL(e.codigo_pais,0)   ,
       	      'NomPais'     = ISNULL(e.nombre,'')  ,
              'EmailApo1'   = @cEmailApo1 ,
              'Sector Eco'  = b.CLACTIVIDA

         FROM  mfcah a,
               view_cliente  b,
 	       view_moneda c , -- mdmn  c,
	       view_moneda d , -- mdmn  d ,
               view_pais e       -- Tabla de Paises 
			LEFT OUTER JOIN view_cliente vc ON CONVERT(INTEGER, e.codigo_pais) = vc.clpais   



         WHERE  SUBSTRING(CONVERT(CHAR(10),a.cafecha,103),1,6) = SUBSTRING(@cFecha,1,6) AND
		a.catipoper IN ('C','V')   AND
		a.cacodpos1 IN (1,2,3 )    AND    
		(a.cacodigo = b.clrut      AND
                a.cacodcli  = b.clcodigo)  AND
		a.cacodmon1 = c.mncodmon   AND
		a.cacodmon2 = d.mncodmon   AND  
		e.tbcateg     = 180	   ---AND  
 ---               CONVERT(INTEGER,e.codigo_pais) =* b.clpais  -- tbcodigo1                  
 /*=======================================================================*/
--   Modificaaciones para ese dia
 /*=======================================================================*/
--SET ROWCOUNT 1
 INSERT INTO  #temp    
      
 SELECT       'TipOpe'  	= a.catipoper    ,
              'NumOpe'  	= a.canumoper    ,
              'RutCli'  	= a.cacodigo     ,
	      'DigCli'  	= b.cldv	 ,
              'NomCli'  	= b.clnombre     ,
              'FecIni'  	= CONVERT(CHAR(10),a.cafecha  ,103) ,
              'FecTer'  	= CONVERT(CHAR(10),a.cafecvcto,103) ,
              'CpaCodMon' 	= case a.catipoper when e.catipoper then 0 else  case a.catipoper when  'C' then a.cacodmon1 else a.cacodmon2 End End    ,    
           
              'CpaNemMon' 	= case a.catipoper when 'C' then          
                                      case a.cacodmon1 when e.cacodmon1 then ' ' else c.mnnemo  End   
                                  Else    
                                      case a.cacodmon2 when e.cacodmon2 then ' ' else d.mnnemo End    
                                  End     ,    

              'CpaMonto'  	= case a.catipoper when 'C' then 
                                       case a.camtomon1 when e.camtomon1 then  0 else a.camtomon1 End
                                  Else 
                                       case a.camtomon2 when e.camtomon2 then  0 else a.camtomon2 End        
                                  End ,

              'VtaCodMon' 	= Case a.catipoper when 'V' then
                                       case  a.cacodmon1 when e.cacodmon1 then 0 else a.cacodmon1 End
                                  Else   
                                       case  a.cacodmon2 when e.cacodmon2 then 0 else a.cacodmon2 End     
                                  End,    

              'VtaNemMon' 	= Case a.catipoper when 'V' then 
                                       case  a.cacodmon1 when e.cacodmon1 then ' ' else  c.mnnemo  End
                                  Else 
                                       case  a.cacodmon2 when e.cacodmon2 then ' ' else  d.mnnemo  End    
                                  End , 
   
              'VtaMonto'  	= Case a.catipoper when 'V' then 
                                       case  a.camtomon1 when e.camtomon1 then 0 else a.camtomon1 End
                                  Else 
                                       case  a.camtomon2 when e.camtomon2 then 0 else a.camtomon2 End
                                  End , 
   
              'Modal'   	= Case a.catipmoda when e.catipmoda then ' ' else e.catipmoda end     ,
              'PreFut'  	= Case a.caprecal  when e.caprecal  then  0  else e.caprecal  end     ,
              'PreSpt'  	= Case a.capremon1 when e.capremon1 then  0  else e.capremon1 end     ,	         
              'nomprop' 	= @cnomprop	 ,
	      'dirprop' 	= @cdirprop	 ,
	      'rutprop' 	= @nrutprop	 ,
	      'digprop' 	= @cdigprop	 ,
	      'FecInfo' 	= @cfecha	 ,
	      'codclie' 	= @ncodclie      ,
	      'FecPro'  	= @cfecpro  	 ,
      	      'Marca'   	= 'M' 		 ,	
	      'Plazo'   	= case a.caplazo when e.caplazo then 0 else e.caplazo    end ,
              'Apodera1' 	= ISNULL( @ap1nombre , '' ) ,
              'Cargo1'   	= ISNULL( @ap1cargo  , '' ) ,
              'Fono1'    	= ISNULL( @ap1fono   , '' ) ,
              'Apodera2' 	= ISNULL( @ap2nombre , '' ) ,
              'Cargo2'   	= ISNULL( @ap2cargo  , '' ) ,
              'Fono2'    	= ISNULL( @ap2fono   , '' ) ,
              'Contador'        = 0 ,
              'CanPag'          = 0 ,
  	      'CodPais'     	= ISNULL(f.codigo_pais,0)   ,
       	      'NomPais'     	= ISNULL(f.nombre,'')  ,
              'EmailApo1'   	= @cEmailApo1 ,
              'Sector Eco'  	= b.CLACTIVIDA
	   
     

         FROM  mfca_log a,
               view_cliente  b,
	       view_moneda  c , --mdmn  c,
	       view_moneda  d , --mdmn  d,
               mfca e ,
               view_pais f       -- Tabla de Paises
			 LEFT OUTER JOIN view_cliente vc ON CONVERT(INTEGER, f.tbcodigo1) = vc.clpais   


         WHERE  SUBSTRING(CONVERT(CHAR(10),a.cafecmod,103),1,6) = SUBSTRING(@cFecha,1,6) AND
                NOT EXISTS( select * from #temp where #temp.NumOpe = a.canumoper) and               
                a.cafecmod > a.cafecha     And
                a.canumoper = e.canumoper  And             
		a.catipoper IN ('C','V')   AND
		a.cacodpos1 IN (1,2,3 )    AND        
		(a.cacodigo = b.clrut      AND
                a.cacodcli = b.clcodigo  ) and
		a.cacodmon1 = c.mncodmon   AND
		a.cacodmon2 = d.mncodmon   ---and
		--f.tbcateg     = 180        AND  
		---CONVERT(INTEGER,f.tbcodigo1) =* b.clpais                  
 

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

-- sp_autoriza_ejecutar 'bacuser'
GO
