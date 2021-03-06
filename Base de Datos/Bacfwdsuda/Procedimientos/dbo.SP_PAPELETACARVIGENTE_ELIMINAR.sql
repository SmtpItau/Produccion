USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELETACARVIGENTE_ELIMINAR]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- PAPELETA CAMBIADA 
-- Sp_PapeletaCarVigente_Eliminar 9525 , '1553' , '204' , '1552' , '1111' , '1554'
CREATE PROCEDURE [dbo].[SP_PAPELETACARVIGENTE_ELIMINAR]	(	@numOper	NUMERIC(19)	
						,	@CatAreaResp	CHAR(10)
						,	@CatCartFin	CHAR(10)
						,	@CatLibro	CHAR(10)
						,	@CatCartNorm	CHAR(10)
						,	@CatSubCart	CHAR(10)
						)
AS
BEGIN

   SET NOCOUNT ON

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
	  Select @firma1=res.Firma1,
		 @firma2=res.Firma2
	   From BacLineas..detalle_aprobaciones res
	   Where res.Numero_Operacion=@numOper
 /*=======================================================================*/

  SELECT @cnomprop = acnomprop   
   ,     @cdirprop = acdirprop   
   ,     @cfecproc = CONVERT(Char(10),acfecproc,103) 
   ,     @nvaluf   = vmvalor
  FROM   MFAC, VIEW_VALOR_MONEDA
  WHERE  vmcodigo  = accodmonuf     
  AND    vmfecha   = '20070111' -- SACAR y one acfecproc   select * from mfcares where canumoper = 9525 and cafechaProceso = '20070111'

 SELECT @cestado= ' ' 
 SELECT @cEstado = 'PENDIENTE' from MFMO where monumoper = @numOper and moestado='P'
 SELECT @cEstado = 'MODIFICADO' from MFCA_LOG where canumoper = @numOper and caestado='M'
 SELECT @cEstado = 'ANULADA' from MFCA_LOG where canumoper = @numOper and caestado='A'
 SELECT @cEstado = 'ANTICIPADA' from MFCA where canumoper = @numOper and caantici='A' 
 SELECT @cEstado = 'ANTICIPADA' from MFCAH where canumoper = @numOper and caantici='A' 

-- SACAR 
select @cEstado = ' '

 IF EXISTS( SELECT 1 FROM MFCA_LOG WHERE canumoper = @numOper and caestado='A' )
 BEGIN
   /*=======================================================================*/
   /*=======================================================================*/
   SELECT  'Numero Operacion'  = a.canumoper                                                       ,--1
	    'Fecha Inicio'       = CONVERT(CHAR(10), a.cafecha, 103 )                                ,--2
	    'Fecha Vcto'         = CONVERT(CHAR(10), a.cafecvcto, 103 )                              ,--3
	    'Plazo'              = a.caplazo                                                         ,--4
	    'Rut Cliente'        = a.cacodigo                                                        ,--5
	    'Nombre Cliente'     = b.clnombre                                                        ,--6
	    'Tc Inicial'         = a.capremon1                                                       ,--7
	    'Precio'             = CASE a.cacodpos1 WHEN 2 THEN a.caparmon1 ELSE a.caprecal END      ,--8
	    'Monto MX'           = a.camtomon1                                                       ,--9
	    'Precio Futuro'      = convert(numeric(21,8),a.catipcam)                                  ,--10
	    'Monto Final'        = a.camtomon2                                                       ,--11
	    'Pago MN'            =ISNULL((SELECT glosa FROM  VIEW_FORMA_DE_PAGO WHERE codigo = a.cafpagomn ),'X'),--12
	    'Pago MX'            =ISNULL((SELECT glosa FROM  VIEW_FORMA_DE_PAGO WHERE codigo = a.cafpagomx ),'X'),--13
	    'Modalidad'          = a.catipmoda                                                       ,--14
	    'Equivalente M/X'    = a.caequmon1                                                       ,--15
	    'Monto CLP'          = CASE a.cacodpos1  WHEN 2 THEN 0 ELSE a.caequmon2 END              ,--16
	    'Articulo84'         = a.cadiferen                                                       ,--17
	    'Observacion'        = a.caobserv                                                        ,--18
	    'Retito'             = a.caretiro                                                        ,--19
	    'Operador'           = a.caoperador            	,--20
	    'Moneda MX'          = c.mnnemo                                      ,--21
	    'Moneda MN'          = d.mnnemo                                     ,--22
	    'Digito V'           = b.cldv   ,--23
	    'UF del Dia'         = @nvaluf                                                           ,--24
	    'Tipo Operacion'     = catipoper                                                         ,--25
	    'Producto'           = e.descripcion                             ,--27
	    'Nombre Porpietario' = @cnomprop                                                         ,--28
	    'Direccion'          = @cdirprop                                                         ,--29
	    'Entidad'            =( SELECT rcnombre FROM VIEW_ENTIDAD WHERE rccodcar=cacodsuc1 )     ,--30
	    'Moneda Mercado'     = ( CASE	WHEN cacodpos1 = 3 THEN 'UF' 
					        WHEN a.camdausd = 0  THEN ( SELECT g.mnglosa FROM VIEW_MONEDA g WHERE g.mncodmon = 994 ) 
         					ELSE ( SELECT g.mnglosa FROM VIEW_MONEDA g WHERE g.mncodmon = a.camdausd ) 
						END )                ,--31
	    'Cartera'            = (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatCartFin AND TBCODIGO1 = a.cacodcart) ,--32
	    'Mercado'            = CASE b.clpais WHEN 1 THEN 'L' ELSE 'E' END                        , --35 -- Tipo de Cliente 'L'ocal / 'E'xterno
	    'Estado'             = @cEstado                                                          ,
	    'Hora'               = convert(char(10), getdate(),108)                                  ,
	    'FechaProceso'       = @cfecproc                                                         ,
	    'Codigo Conversion'  = a.cacodmon2                                                       ,
	    'Codigo Producto'    = a.cacodpos1                                                       ,
	    'Equivalente M/N'    = a.caequmon2        ,
	    'Observa_lineas'     = REPLACE( a.caobservlin , @cadena1 , @cadena )    ,
	    'Observa_limites'    = REPLACE( a.caobservlim , @cadena1 , @cadena )    ,
	    'Aprobador'      = a.caautoriza ,
   	    'Firma1' = @Firma1	,
	    'Firma2' = @Firma2 ,
            'TasaMon1'= a.catasaEfectMon1,
            'TasaMon2'= a.catasaEfectMon2,
            'TCSpot'  = a.catipcamSpot,
            'TCFwd'   = convert(numeric(21,8),a.catipcamFwd),
            'FecEfect' = a.cafecEfectiva
		,	'Area_Responsable'	= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatAreaResp AND TBCODIGO1 = a.caArea_Responsable )
		,	'Libro'			= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatLibro AND TBCODIGO1 = a.caLibro )
		,	'Cartera_Normativa'	= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatCartNorm AND TBCODIGO1 = a.caCartera_Normativa )
		,	'SubCartera_Normativa'	= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatSubCart AND TBCODIGO1 = a.caSubCartera_Normativa )
		FROM	MFCA_LOG          a
		,	VIEW_CLIENTE      b
		,	VIEW_MONEDA       c 
		,	VIEW_MONEDA       d
		,	VIEW_PRODUCTO     e
		WHERE	a.canumoper       = @numoper    
		AND	a.caestado        = 'A'         
		AND	(a.cacodigo       = clrut       
		AND	a.cacodcli        = clcodigo  ) 
		AND  	c.mncodmon        = a.cacodmon1 
		AND	d.mncodmon        = a.cacodmon2 
		AND	e.id_sistema      = 'BFW'       
		AND 	e.codigo_producto = a.cacodpos1 

  END
 ELSE
  BEGIN
 
   /*=======================================================================*/
   /*=======================================================================*/
   SELECT  'Numero Operacion'  = a.canumoper                                                       ,--1
	    'Fecha Inicio'       = CONVERT(CHAR(10), a.cafecha, 103 )          ,--2
	    'Fecha Vcto'         = CONVERT(CHAR(10), a.cafecvcto, 103 )                              ,--3
	    'Plazo'              = a.caplazo                                                         ,--4
	    'Rut Cliente'        = a.cacodigo                                                        ,--5
	    'Nombre Cliente'     = b.clnombre                                                        ,--6
	    'Tc Inicial'         = a.capremon1                                                       ,--7
	    'Precio'             = CASE a.cacodpos1 WHEN 2 THEN a.caparmon1 ELSE a.caprecal END      ,--8
	    'Monto MX'           = a.camtomon1                                                       ,--9
	    'Precio Futuro'      = convert(numeric(21,8),a.catipcam)                          ,--10
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
	    'Moneda MX'          = c.mnnemo                                      ,--21
	    'Moneda MN'          = d.mnnemo                                     ,--22
	    'Digito V'           = b.cldv                                                            ,--23
	    'UF del Dia'         = @nvaluf                                                           ,--24
	    'Tipo Operacion'     = catipoper                                                         ,--25
	    'Producto'           = e.descripcion                             ,--27
	    'Nombre Porpietario' = @cnomprop                                                         ,--28
	    'Direccion'          = @cdirprop                                                         ,--29
	    'Entidad'            =( SELECT rcnombre FROM VIEW_ENTIDAD WHERE rccodcar=cacodsuc1 )     ,--30
	    'Moneda Mercado'     = ( CASE	WHEN cacodpos1  = 3 THEN 'UF' 
						WHEN a.camdausd = 0  THEN ( SELECT g.mnglosa FROM VIEW_MONEDA g WHERE g.mncodmon = 994 ) 
						ELSE ( SELECT g.mnglosa FROM VIEW_MONEDA g WHERE g.mncodmon = a.camdausd ) 
						END )                ,--31
	    'Cartera'            = (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatCartFin AND TBCODIGO1 = a.cacodcart) ,--32
	    'Mercado'            = CASE b.clpais WHEN 1 THEN 'L' ELSE 'E' END                        , --35 -- Tipo de Cliente 'L'ocal / 'E'xterno
	    'Estado'             = @cEstado                                                          ,
	    'Hora'               = convert(char(10), getdate(),108)                                  ,
	    'FechaProceso'       = @cfecproc                                                         ,
	    'Codigo Conversion'  = a.cacodmon2                                                       ,
	    'Codigo Producto'    = a.cacodpos1                                                       ,
	    'Equivalente M/N'    = a.caequmon2        ,
	    'Observa_lineas'     = REPLACE( a.caobservlin , @cadena1 , @cadena )    ,
	    'Observa_limites'    = REPLACE( a.caobservlim , @cadena1 , @cadena )    ,
	    'Aprobador'      = a.caautoriza ,
   	    'Firma1' = @Firma1	,
	    'Firma2' = @Firma2	,
            'TasaMon1'= a.catasaEfectMon1,
            'TasaMon2'= a.catasaEfectMon2,
            'TCSpot'  = a.catipcamSpot,
            'TCFwd'   = convert(numeric(21,8),a.catipcamFwd),
            'FecEfect' = a.cafecEfectiva
		,	'Area_Responsable'	= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatAreaResp AND TBCODIGO1 = a.caArea_Responsable )
		,	'Libro'			= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatLibro AND TBCODIGO1 = a.caLibro )
		,	'Cartera_Normativa'	= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatCartNorm AND TBCODIGO1 = a.caCartera_Normativa )
		,	'SubCartera_Normativa'	= (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatSubCart AND TBCODIGO1 = a.caSubCartera_Normativa )

		FROM    MFCARES              a   -- SACAR y poner: MFCA              a
		,	VIEW_CLIENTE      b
		,	VIEW_MONEDA       c
		,	VIEW_MONEDA       d
		,	view_producto     e
	
		WHERE   a.canumoper       = @numoper    
		AND	(a.cacodigo       = clrut       
		AND	a.cacodcli        = clcodigo  ) 
		AND	c.mncodmon        = a.cacodmon1 
		AND	d.mncodmon        = a.cacodmon2 
		AND	e.id_sistema      = 'BFW'       
		AND	e.codigo_producto = a.cacodpos1 
-- SACAR
AND CaFechaProceso = '20070111'


  END
   SET NOCOUNT OFF
END


GO
