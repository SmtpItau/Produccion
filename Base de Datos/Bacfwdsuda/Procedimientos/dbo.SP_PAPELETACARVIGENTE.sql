USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELETACARVIGENTE]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PAPELETACARVIGENTE]      
( @numOper NUMERIC(19)     
      , @CatAreaResp CHAR(10)    
      , @CatCartFin CHAR(10)    
      , @CatLibro CHAR(10)    
      , @CatCartNorm CHAR(10)    
      , @CatSubCart CHAR(10)    
      )    
AS    
BEGIN    
    
   SET NOCOUNT ON    
    
   DECLARE @MensajeThreshold   VARCHAR(150)    
       SET @MensajeThreshold   = ''    
       SET @MensajeThreshold   = isnull((SELECT TOP 1 SUBSTRING(Mensaje, 1, 150)    
                                     FROM BacParamSuda.dbo.TBL_MENSAJES_OPERACION_THRESHOLD with(nolock)    
                                    WHERE Id_Sistema   = 'BFW'    
                                            AND Id_Mensaje   = (SELECT MAX(Id_Mensaje) FROM BacParamSuda.dbo.TBL_MENSAJES_OPERACION_THRESHOLD  
                                                                                      WHERE Id_Sistema    = 'BFW' AND Num_Contrato = @numOper)  
                                      AND Num_Contrato = @numOper),'')    
    
   /*=======================================================================*/    
 DECLARE @firma1 char(15)    
 DECLARE @firma2 char(15)    
 DECLARE @nvaluf           FLOAT    
 DECLARE @cnomprop         CHAR(40)    
 DECLARE @cdirprop         CHAR(40)    
 DECLARE @cSettlement      CHAR(50)    
 DECLARE @cPFE             CHAR(50)    
 DECLARE @cCCE             CHAR(50)    
 DECLARE @cEmisorInstPlazo CHAR(50)    
 DECLARE @cEstado          CHAR(15)    
 DECLARE @cFecproc         CHAR(10)    
 DECLARE @cadena           CHAR(1)     
 DECLARE @cadena1          CHAR(1)     
    
  SELECT @cadena1          = ' '      
  SELECT @cadena           = ' '    
 /*=======================================================================*/    
   SELECT @firma1               = res.Firma1  
      ,   @firma2               = res.Firma2  
    FROM  BacLineas..detalle_aprobaciones res    
   WHERE  res.Numero_Operacion  = @numOper    
            AND  Id_Sistema       = 'BFW'    
 /*=======================================================================*/    
    
   DECLARE @dFechaHoy   DATETIME  
  
  SELECT @cnomprop = acnomprop       
   ,     @cdirprop = acdirprop       
   ,     @cfecproc = CONVERT(Char(10),acfecproc,103)     
   ,     @nvaluf   = vmvalor    
      ,   @dFechaHoy = acfecproc  
   FROM   MFAC  
      ,   VIEW_VALOR_MONEDA  
  WHERE  vmcodigo  = accodmonuf         
  AND    vmfecha   = acfecproc    

  set @cnomprop = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
    
 SELECT @cestado= ' '     
 SELECT @cEstado = 'PENDIENTE'  from MFMO     where monumoper = @numOper and moestado='P'    
 SELECT @cEstado = 'MODIFICADO' FROM MFCA_LOG where canumoper = @numOper and caestado='M'    
 SELECT @cEstado = 'ANULADA'    from MFCA_LOG where canumoper = @numOper and caestado='A' and caantici <>'A'   
 SELECT @cEstado = 'ANTICIPADA' from MFCA     where canumoper = @numOper and caantici='A'     
 SELECT @cEstado = 'ANTICIPADA' from MFCAH    where canumoper = @numOper and caantici='A'     

/*****   COMDER *************/
DECLARE @idNovada INT
DECLARE @idEstado INT
DECLARE @NomComDer CHAR(10)
DECLARE @CliOriComDer CHAR(35)

SET @idNovada = 0
SET @NomComDer = ''
SET @CliOriComDer = ''

if exists (select 1 from BDBOMESA.dbo.COMDER_RelacionMarcaComder WITH(NOLOCK) WHERE nReNumOper = @numOper AND cReSistema = 'BFW')
BEGIN
			set @idEstado = (select id_estado
					from BDBOMESA.dbo.COMDER_SolicitudEstado t WITH(NOLOCK)
						inner join (
									select  max(id) as maxid
									from BDBOMESA.dbo.COMDER_SolicitudEstado WITH(NOLOCK)
									where numero_operacion = @numOper
									) as max
					on t.id = maxid) 
			
			if  @idEstado IN (1,2,3,8,7,9,10,17) 
				BEGIN
					SET @idNovada = 0
					SET @NomComDer = '  (ComDer)'
				END 
			ELSE
			BEGIN
				if  @idEstado = 6	-- NOVADA
				BEGIN	
					SET @idNovada = 1
					SELECT @CliOriComDer = SUBSTRING(c.clnombre,0,35)
					FROM   BacFwdSuda..MFCA mfca                 with(nolock)
						  INNER JOIN BDBOMESA.dbo.COMDER_RelacionMarcaComDer mc ON mc.nReNumOper = mfca.canumoper   
						  INNER JOIN BacParamSuda..CLIENTE  C with(nolock) ON mc.nReRutCliente     = c.clrut AND mc.nReCodCliente = c.clcodigo
					WHERE  mfca.canumoper =  @numOper
					AND mfca.caantici <> 'A'
					AND mc.cReSistema = 'BFW'
					AND mc.iReNovacion = 1
					AND mc.vReEstado = 'V'
				END					
			END
END

/*****   COMDER *************/

    
   IF EXISTS( SELECT 1 FROM BacFwdSuda.dbo.MFCAH WHERE canumoper = @numOper AND cafecvcto < @dFechaHoy AND caantici <> 'A' AND @numOper > 0)  
   BEGIN  
  
      SELECT 'Numero Operacion'         = car.canumoper  
         ,   'Fecha Inicio'             = CONVERT(CHAR(10), car.cafecha,   103)  
         ,   'Fecha Vcto'               = CONVERT(CHAR(10), car.cafecvcto, 103)  
         ,   'Plazo'                    = car.caplazo  
         ,   'Rut Cliente'              = car.cacodigo  
         ,   'Nombre Cliente'           = LTRIM(RTRIM(cli.clnombre))  + @NomComDer	-- COMDER
         ,   'Tc Inicial'               = car.capremon1  
         ,   'Precio'                   = CASE WHEN car.cacodpos1 = 2 THEN car.caparmon1 ELSE car.caprecal END  
         ,   'Monto MX'                 = car.camtomon1  
         ,   'Precio Futuro'            = CONVERT(NUMERIC(21,8), car.catipcam )  
         ,   'Monto Final'              = car.camtomon2  
         ,   'Pago MN'   = ISNULL(fpm.glosa, ' ')  
         ,   'Pago MX'                  = ISNULL(fpx.glosa, ' ')  
         ,   'Modalidad'                = car.catipmoda  
		 ,   'Equivalente M/X'          = car.caequmon1  
         ,   'Monto CLP'                = CASE WHEN car.cacodpos1 = 2 THEN 0 ELSE car.caequmon2 END  
         ,   'Articulo84'               = car.cadiferen  
         ,   'Observacion'              = car.caobserv  
         ,   'Retito'                   = car.caretiro  
         ,   'Operador'                 = car.caoperador  
         ,   'Moneda MX'                = mn1.mnnemo  
         ,   'Moneda MN'                = mn2.mnnemo  
         ,   'Digito V'                 = cli.cldv  
         ,   'UF del Dia'               = @nvaluf  
         ,   'Tipo Operacion'           = catipoper  
         ,   'Producto'                 = prd.descripcion  
         ,   'Nombre Porpietario'       = @cnomprop  
         ,   'Direccion'                = @cdirprop  
         ,   'Entidad'                  = (SELECT rcnombre FROM VIEW_ENTIDAD WHERE rccodcar=cacodsuc1 )  
         ,   'Moneda Mercado'           = CASE WHEN car.cacodpos1 = 2  THEN 'T/C Referencial'  
                                               WHEN car.cacodpos1 = 3  THEN 'UF'  
                                               WHEN car.camdausd  = 0  THEN ISNULL( rdd.mnglosa, ' ')  
                                               ELSE                         ISNULL( rdd.mnglosa, ' ')  
             END  
         ,   'Cartera'                  = ISNULL( cfin.tbglosa, ' ')  
         ,   'Mercado'                  = CASE WHEN cli.clpais = 1 THEN 'L' ELSE 'E' END  
         ,   'Estado'                   = 'VENCIDA'  
         ,   'Hora'                     = CONVERT(CHAR(10), GETDATE(), 108)  
         ,   'FechaProceso'             = @cfecproc  
         ,   'Codigo Conversion'        = car.cacodmon2  
         ,   'Codigo Producto'          = car.cacodpos1  
         ,   'Equivalente M/N'          = car.caequmon2  
         ,   'Observa_lineas'           = @MensajeThreshold + CHAR(10)  
                                        + REPLACE( ' ' , @cadena1 , @cadena )  
         ,   'Observa_limites'          = REPLACE( ' ' , @cadena1 , @cadena )  
         ,   'Aprobador'                = car.caautoriza  
         ,   'Firma1'                   = @Firma1  
         ,   'Firma2'                   = @Firma2  
     ,   'TasaMon1'                 = car.catasaEfectMon1  
         ,   'TasaMon2'    = car.catasaEfectMon2  
         ,   'TCSpot'                   = car.catipcamSpot  
         ,   'TCFwd'                    = CONVERT(NUMERIC(21,8), car.catipcamFwd )  
         ,   'FecEfect'                 = car.cafecEfectiva  
         ,   'Area_Responsable'         = ISNULL( care.tbglosa, ' ')  
         ,   'Libro'     = ISNULL( clib.tbglosa, ' ')  
         ,   'Cartera_Normativa'  = ISNULL( nnor.tbglosa, ' ')  
         ,   'SubCartera_Normativa'  = ISNULL( scar.tbglosa, ' ')  
         ,   'caFechaCierre'      = CONVERT(CHAR(10), car.caFecha,103)  
         ,   'caPuntoFwd'              = car.capuntosfwdcierre
         ,   'novada'					= @idNovada		-- COMDER  
         ,	 'contraparte_original'		= @CliOriComDer	-- COMDER
         ,	 'RutCli'					= convert(varchar(10),car.cacodigo) --+ '-' + cli.cldv	-- COMDER
		 ,   'Digito'                 = cli.cldv 
		 ,   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
      FROM   BacFwdSuda.dbo.MFCAH       car  
             INNER JOIN BacParamSuda.dbo.CLIENTE                cli ON cli.clrut      = car.cacodigo and cli.clcodigo = car.cacodcli  
             LEFT  JOIN BacParamSuda.dbo.MONEDA                 mn1 ON mn1.mncodmon   = car.cacodmon1  
             LEFT  JOIN BacParamSuda.dbo.MONEDA                 mn2 ON mn2.mncodmon   = car.cacodmon2  
             LEFT  JOIN BacParamSuda.dbo.PRODUCTO               prd ON prd.id_sistema = 'BFW' AND prd.codigo_producto = car.cacodpos1  
             LEFT  JOIN BacParamSuda.dbo.FORMA_DE_PAGO          fpm ON fpm.codigo     = car.cafpagomn  
             LEFT  JOIN BacParamSuda.dbo.FORMA_DE_PAGO          fpx ON fpx.codigo     = car.cafpagomx  
             LEFT  JOIN BacParamSuda.dbo.MONEDA                 rdd ON rdd.mncodmon   = CASE WHEN car.camdausd = 0 THEN 994 ELSE car.camdausd END   
             LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE cfin ON cfin.tbcateg   = @CatCartFin  AND cfin.tbcodigo1 = car.cacodcart  
             LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE care ON care.tbcateg   = @CatAreaResp AND care.tbcodigo1 = car.caArea_Responsable  
             LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE clib ON clib.tbcateg   = @CatLibro    AND clib.tbcodigo1 = car.caLibro  
             LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE nnor ON nnor.tbcateg   = @CatCartNorm AND nnor.tbcodigo1 = car.caCartera_Normativa  
             LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE scar ON scar.tbcateg   = @CatSubCart  AND scar.tbcodigo1 = car.caSubCartera_Normativa  
      WHERE  car.canumoper              = @numoper  
  
      RETURN  
   END  
    
 IF EXISTS( SELECT 1 FROM MFCA_LOG WHERE canumoper = @numOper and caestado='A'AND caantici <> 'A')    
 BEGIN    
   SELECT  'Numero Operacion'  = a.canumoper                                                       ,--1    
     'Fecha Inicio'       = CONVERT(CHAR(10), a.cafecha, 103 )                                ,--2    
     'Fecha Vcto'         = CONVERT(CHAR(10), a.cafecvcto, 103 )                              ,--3    
     'Plazo'              = a.caplazo                                                         ,--4    
     'Rut Cliente'        = a.cacodigo                                                        ,--5    
     'Nombre Cliente'     = LTRIM(RTRIM(b.clnombre))  + @NomComDer                                          ,--6    COMDER
     'Tc Inicial'         = a.capremon1                                                       ,--7    
     'Precio'             = CASE a.cacodpos1 WHEN 2 THEN a.caparmon1 ELSE a.caprecal END      ,--8    
     'Monto MX'           = a.camtomon1                                                       ,--9    
     'Precio Futuro'      = convert(numeric(21,8),a.catipcam)                                  ,--10    
     'Monto Final'        = a.camtomon2     ,--11    
   'Pago MN'            =ISNULL((SELECT glosa FROM  VIEW_FORMA_DE_PAGO WHERE codigo = a.cafpagomn ),'X'),--12    
     'Pago MX'            =ISNULL((SELECT glosa FROM  VIEW_FORMA_DE_PAGO WHERE codigo = a.cafpagomx ),'X'),--13    
     'Modalidad'          = a.catipmoda        ,--14    
     'Equivalente M/X'    = a.caequmon1                                                       ,--15    
     'Monto CLP'          = CASE a.cacodpos1  WHEN 2 THEN 0 ELSE a.caequmon2 END              ,--16    
     'Articulo84'         = a.cadiferen   ,--17    
     'Observacion'        = a.caobserv                                                        ,--18    
     'Retito'             = a.caretiro                                                        ,--19    
     'Operador'           = a.caoperador             ,--20    
     'Moneda MX'          = c.mnnemo                                      ,--21    
     'Moneda MN'          = d.mnnemo                                     ,--22    
     'Digito V'           = b.cldv   ,--23    
     'UF del Dia'         = @nvaluf                                                           ,--24    
     'Tipo Operacion'     = catipoper                                                         ,--25    
    -- 'Producto'         = e.descripcion                             ,--27
      'Producto'		  = CASE WHEN cacalvtadol = 14 THEN 'FORWARD STARTING'
								 WHEN cacalvtadol = 15 THEN 'FORWARD ASIATICO'
								 WHEN cacalvtadol = 16 THEN 'SPOT OBSERVADO'
								 ELSE						 e.descripcion 
							END	   	, 
     'Nombre Porpietario' = @cnomprop                                                         ,--28    
     'Direccion'          = @cdirprop                                                         ,--29    
     'Entidad'            =( SELECT rcnombre FROM VIEW_ENTIDAD WHERE rccodcar=cacodsuc1 )     ,--30    
     'Moneda Mercado'     = CASE WHEN a.cacodpos1 = 2  THEN 'T/C Referencial'    
                                        WHEN a.cacodpos1 = 3  THEN 'UF'    
                                        WHEN a.camdausd  = 0  THEN (SELECT g.mnglosa FROM VIEW_MONEDA g WHERE g.mncodmon = 994)     
                                        ELSE                       (SELECT g.mnglosa FROM VIEW_MONEDA g WHERE g.mncodmon = a.camdausd)     
       END                ,--31    
     'Cartera'            = (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatCartFin AND TBCODIGO1 = a.cacodcart) ,--32    
     'Mercado'            = CASE b.clpais WHEN 1 THEN 'L' ELSE 'E' END                        , --35 -- Tipo de Cliente 'L'ocal / 'E'xterno    
     'Estado'             = @cEstado                                                          ,    
     'Hora'               = convert(char(10), getdate(),108)                                  ,    
     'FechaProceso'       = @cfecproc                                                         ,    
     'Codigo Conversion'  = a.cacodmon2                                                       ,    
     'Codigo Producto'    = a.cacodpos1                                                       ,    
     'Equivalente M/N'    = a.caequmon2        ,    
     'Observa_lineas'     = @MensajeThreshold + CHAR(10)    
                                 + REPLACE( a.caobservlin , @cadena1 , @cadena ) ,    
     'Observa_limites'    = REPLACE( a.caobservlim , @cadena1 , @cadena )    ,    
     'Aprobador'      = a.caautoriza ,    
        'Firma1' = @Firma1 ,    
     'Firma2' = @Firma2 ,    
            'TasaMon1'= a.catasaEfectMon1,    
            'TasaMon2'= a.catasaEfectMon2,    
            'TCSpot'  = a.catipcamSpot,    
            'TCFwd'   = convert(numeric(21,8),a.catipcamFwd),    
            'FecEfect' = a.cafecEfectiva    
  , 'Area_Responsable' = (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatAreaResp AND TBCODIGO1 = a.caArea_Responsable )    
  , 'Libro'   = (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatLibro AND TBCODIGO1 = a.caLibro )    
  , 'Cartera_Normativa' = (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatCartNorm AND TBCODIGO1 = a.caCartera_Normativa )    
  , 'SubCartera_Normativa' = (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatSubCart AND TBCODIGO1 = a.caSubCartera_Normativa )    
  , 'caFechaCierre'     = convert(char(10), a.caFecha,103)    
  , 'caPuntoFwd'      = a.caPuntosFwdCierre   
  , 'novada'					= @idNovada		-- COMDER  
  ,	'contraparte_original'		= @CliOriComDer	-- COMDER
  ,	 'RutCli'					= convert(varchar(10),a.cacodigo)-- + '-' + b.cldv	-- COMDER
  ,   'Digito'                 = b.cldv 
  , 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
  FROM MFCA_LOG          a    
  , VIEW_CLIENTE      b    
  , VIEW_MONEDA       c     
  , VIEW_MONEDA       d    
  , VIEW_PRODUCTO     e    
  WHERE a.canumoper       = @numoper        
  AND a.caestado        = 'A'             
  AND    (a.cacodigo        = clrut AND a.cacodcli = clcodigo)  
  AND   c.mncodmon        = a.cacodmon1     
  AND d.mncodmon        = a.cacodmon2     
  AND e.id_sistema      = 'BFW'           
  AND  e.codigo_producto = a.cacodpos1     
    
  END ELSE  
  BEGIN    
     
   SELECT   'Numero Operacion'  = a.canumoper                                                        ,--1    
       'Fecha Inicio'       = CONVERT(CHAR(10), a.cafechaStarting, 103 )                        ,--2    
     'Fecha Vcto'         = CONVERT(CHAR(10), a.cafecvcto, 103 )                              ,--3    
     'Plazo'              = a.caplazo                                                         ,--4    
     'Rut Cliente'        = a.cacodigo                                                        ,--5    
     'Nombre Cliente'     = LTRIM(RTRIM(b.clnombre))  + @NomComDer                                          ,--6    COMDER
     'Tc Inicial'         = a.capremon1                                                       ,--7    
     'Precio'             = CASE a.cacodpos1 WHEN 2 THEN a.caparmon1 ELSE a.caprecal END      ,--8    
     'Monto MX'           = a.camtomon1                                                       ,--9    
     'Precio Futuro'      = convert(numeric(21,8),a.catipcam)                                 ,--10    
     'Monto Final'        = a.camtomon2                                                       ,--11    
     'Pago MN'            =ISNULL((SELECT glosa FROM  VIEW_FORMA_DE_PAGO WHERE codigo = a.cafpagomn ),'X'),--12    
     'Pago MX'            =ISNULL((SELECT glosa FROM  VIEW_FORMA_DE_PAGO WHERE codigo = a.cafpagomx ),'X'),--13    
     'Modalidad'          = a.catipmoda                                                       ,--14    
     'Equivalente M/X'    = a.caequmon1                                                       ,--15    
     'Monto CLP'          = CASE a.cacodpos1  WHEN 2 THEN 0 ELSE a.caequmon2 END              ,--16    
     'Articulo84'         = a.cadiferen                                                       ,--17    
     'Observacion'        = a.caobserv                                                        ,--18    
     'Retito'             = a.caretiro                                                        ,--19    
     'Operador'           = a.caoperador                                                      ,--20    
     'Moneda MX'          = c.mnnemo                                                          ,--21    
     'Moneda MN'          = d.mnnemo                                                          ,--22    
     'Digito V'           = b.cldv                                                            ,--23    
     'UF del Dia'         = @nvaluf                                                           ,--24    
     'Tipo Operacion'     = catipoper                                                         ,--25    
     'Producto'           = CASE WHEN cacalvtadol = 14 THEN 'FORWARD STARTING'
								 WHEN cacalvtadol = 15 THEN 'FORWARD ASIATICO'
								 WHEN cacalvtadol = 16 THEN 'SPOT OBSERVADO'
								 ELSE						e.descripcion 
							END	                                                     ,--27  
     'Nombre Porpietario' = @cnomprop      ,--28    
     'Direccion'          = @cdirprop ,--29    
     'Entidad'            =( SELECT rcnombre FROM VIEW_ENTIDAD WHERE rccodcar=cacodsuc1 )     ,--30  
     'Moneda Mercado'     = CASE WHEN a.cacodpos1 = 2  THEN 'T/C Referencial'    
                                        WHEN a.cacodpos1 = 3  THEN 'UF'    
                                        WHEN a.cacodpos1 = 13 THEN 'UF'    
                   WHEN a.camdausd  = 0  THEN (SELECT g.mnglosa FROM VIEW_MONEDA g WHERE g.mncodmon = 994)     
                                        ELSE                       (SELECT g.mnglosa FROM VIEW_MONEDA g WHERE g.mncodmon = a.camdausd)     
                                   END                ,--31    
     'Cartera'            = (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatCartFin AND TBCODIGO1 = a.cacodcart) ,--32    
     'Mercado'            = CASE b.clpais WHEN 1 THEN 'L' ELSE 'E' END                        , --35 -- Tipo de Cliente 'L'ocal / 'E'xterno    
     'Estado'             = @cEstado                                                          ,    
     'Hora'               = convert(char(10), getdate(),108)                                  ,    
     'FechaProceso'       = @cfecproc                                                         ,    
     'Codigo Conversion'  = a.cacodmon2                                                       ,    
     'Codigo Producto'    = a.cacodpos1             ,    
     'Equivalente M/N'    = a.caequmon2        ,    
     'Observa_lineas'     = @MensajeThreshold + char(10)    
                                 + REPLACE( a.caobservlin , @cadena1 , @cadena ) ,    
     'Observa_limites'    = REPLACE( a.caobservlim , @cadena1 , @cadena )    ,    
     'Aprobador'      = a.caautoriza ,    
        'Firma1' = @Firma1 ,    
     'Firma2' = @Firma2 ,    
            'TasaMon1'= a.catasaEfectMon1,    
            'TasaMon2'= a.catasaEfectMon2,    
            'TCSpot'  = a.catipcamSpot,    
            'TCFwd'   = convert(numeric(21,8),a.catipcamFwd),    
            'FecEfect' = a.cafecEfectiva    
  , 'Area_Responsable' = (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatAreaResp AND TBCODIGO1 = a.caArea_Responsable )    
  , 'Libro'   = (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatLibro AND TBCODIGO1 = a.caLibro )    
  , 'Cartera_Normativa' = (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatCartNorm AND TBCODIGO1 = a.caCartera_Normativa )    
  , 'SubCartera_Normativa' = (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatSubCart AND TBCODIGO1 = a.caSubCartera_Normativa )    
  , 'caFechaCierre'      = convert(char(10), a.caFecha,103)    
  , 'caPuntoFwd'  = a.caPuntosFwdCierre               
  , 'novada'					= @idNovada		-- COMDER  
  ,	'contraparte_original'		= @CliOriComDer	-- COMDER         
  ,	'RutCli'					= convert(varchar(10),a.cacodigo)-- + '-' + b.cldv	-- COMDER
  , 'Digito'                 	= b.cldv 
  , 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
  FROM    MFCA              a    
  , VIEW_CLIENTE      b    
  , VIEW_MONEDA       c    
  , VIEW_MONEDA       d    
  , view_producto     e    
     
  WHERE   a.canumoper       = @numoper        
  AND (a.cacodigo       = clrut           
  AND a.cacodcli        = clcodigo  )     
  AND c.mncodmon        = a.cacodmon1     
  AND d.mncodmon        = a.cacodmon2     
  AND e.id_sistema      = 'BFW'           
  AND e.codigo_producto = a.cacodpos1     
    
  END    
  END  


GO
