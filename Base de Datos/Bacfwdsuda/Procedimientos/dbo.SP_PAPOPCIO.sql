USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPOPCIO]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[SP_PAPOPCIO]
       (
	@numoper	FLOAT )

AS
BEGIN
 SET NOCOUNT ON
 /*=======================================================================*/
   DECLARE @Firma1 Char(15)
   DECLARE @Firma2 Char(15)

    DECLARE @nvaluf          FLOAT
    DECLARE @cnomprop        CHAR(40)
    DECLARE @cdirprop        CHAR(40)
    DECLARE @cSettlement  CHAR(50)
    DECLARE @cPFE     CHAR(50)
    DECLARE @cCCE     CHAR(50)
    DECLARE @cEmisorInstPlazo CHAR(50)
    DECLARE @cEstado                 CHAR(15)
    DECLARE @cFecproc                CHAR(10)
 /*=======================================================================*/
    	   Select @firma1=res.Firma1,
		 @firma2=res.Firma2
	   From BacLineas..detalle_aprobaciones res
	   Where res.Numero_Operacion=@numoper
  
 /*=======================================================================*/
    SELECT @cnomprop = acnomprop   , 
        @cdirprop = acdirprop   ,
               @cfecproc =CONVERT(Char(10),acfecproc,103) ,  
               @nvaluf = vmvalor
     FROM MFAC,
   VIEW_VALOR_MONEDA
     WHERE vmcodigo = accodmonuf     AND
           vmfecha = acfecproc
   select @cestado= ' ' 
   select @cEstado = 'PENDIENTE' from MFMO where monumoper = @numOper and moestado='P'
   select @cEstado = 'MODIFICADO' from MFCA_LOG where canumoper = @numOper and caestado='M'
   select @cEstado = 'ANULADA' from MFCA_LOG where canumoper = @numOper and caestado='A'
   select @cEstado = 'ANTICIPADA' from MFCA where canumoper = @numOper and caantici='A' 
   select @cEstado = 'ANTICIPADA' from MFCAH where canumoper = @numOper and caantici='A' 
 IF EXISTS( SELECT * FROM MFCA_LOG WHERE canumoper = @numOper and caestado='A' ) 
  BEGIN
     /*=======================================================================*/
     /*=======================================================================*/
     SELECT       'Numero Operacion'    = a.canumoper                                                       ,--1
    		'Fecha Inicio'        = CONVERT(CHAR(10), a.cafecha, 103 )                                ,--2
                  	'Fecha Vcto'          = CONVERT(CHAR(10), a.cafecvcto, 103 )                              ,--3
                  	'Plazo'               = a.caplazo                                                         ,--4
		'Rut Cliente'         = a.cacodigo                                                        ,--5
                  	'Nombre Cliente'      = b.clnombre                                                        ,--6
                  	'Tc Inicial'          = a.capremon1                                                       ,--7
           		'Precio'              = a.caprecal                                                        ,--8
                  	'Monto MX'            = a.camtomon1                                                       ,--9
                  	'Precio Futuro'       = a.catipcam                                                        ,--10
                  	'Monto Final'         = a.camtomon2                                                       ,--11
                  	'Pago MN'              =(SELECT glosa FROM  VIEW_FORMA_DE_PAGO WHERE codigo = a.cafpagomn ),--12
                  	'Pago MX'              =(SELECT glosa FROM  VIEW_FORMA_DE_PAGO WHERE codigo = a.cafpagomx ),--13
    		'Modalidad'           = a.catipmoda                                                       ,--14
                  	'Mto Dolar Inicial'   = a.caequmon1                                                       ,--15
                  	'Monto CLP'           = CASE a.cacodpos1  WHEN 2 THEN 0 ELSE a.caequmon2 END              ,--16
    		'Articulo84'          = a.cadiferen                                                       ,--17
                  	'Observacion'         = a.caobserv                                                        ,--18
                  	'Retito'              = a.caretiro                                                        ,--19
                  	'Operador'            = a.caoperador                                                      ,--20
    		'Moneda MX'           = c.mnnemo                                      ,--21
    		'Moneda MN'          = d.mnnemo                                     ,--22
    		'Digito V'            = b.cldv                                                            ,--23
    		'UF del Dia'          = @nvaluf                                                           ,--24
    		'Tipo Operacion'      = a.catipoper,
                  	'Operacion Moneda'      = a.catipopc ,  
    		'Spot'   = a.caparmon1,
                  	'Strike'  = a.catipcam,
    		'Costo'   = a.caparmon2,
    		'Prima'   = a.capremio               ,--25      
                  	'Producto'            = e.descripcion                             ,--27
    		'Nombre Porpietario'  = @cnomprop                                                         ,--28
    		'Direccion'           = @cdirprop                                                         ,--29
                  	'Entidad'             =( SELECT rcnombre FROM VIEW_ENTIDAD WHERE rccodcar=cacodsuc1 )     ,--30
          	'Moneda Mercado'      = CASE cacodpos1 WHEN 3 THEN 'UF' ELSE g.mnglosa END                ,--31
                  	'Cartera'             = f.rcnombre                                    ,--32
          	'Mercado'             = CASE b.clpais WHEN 6 THEN 'L' ELSE 'E' END                        , --35 -- Tipo de Cliente 'L'ocal / 'E'xterno
                  	'Estado'              = @cEstado                                                          ,
                  	'Hora'                = CONVERT(char(10), GETDATE(),108)                                  ,
                  	'FechaProceso'        = @cfecproc, 
    		'MonedaOrig'  = ( SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon = a.cacodmon1) ,
    		'MonedaConv'  = ( SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon = a.cacodmon2 ) ,
    		'Aprobador'       = a.caautoriza,
		'Firma1' = @Firma1,
		'Firma2' = @Firma2
		
            FROM    MFCA_LOG          a,
                    	VIEW_CLIENTE      b,
      		VIEW_MONEDA       c,
     		VIEW_MONEDA       d,
      		view_producto     e,
      		VIEW_TIPO_CARTERA f,
                    	VIEW_MONEDA       g                  
            WHERE   a.canumoper       = @numoper    AND
      		a.caestado        = 'A'   AND
                    	(a.cacodigo       = clrut       AND
                    	a.cacodcli        = clcodigo  ) AND  
      		c.mncodmon        = a.cacodmon1 AND
      		d.mncodmon        = a.cacodmon2 AND
      		e.id_sistema      = 'BFW'       AND 
                    	e.codigo_producto = a.cacodpos1 AND
        	f.rcsistema       = 'BFW'       AND
                    	f.rccodpro        = a.cacodpos1 AND
                    	f.rcrut           = a.cacodcart AND
                    	g.mncodmon        = 994
  END
 ELSE
  BEGIN
     /*=======================================================================*/
     /*=======================================================================*/
     SELECT       'Numero Operacion'    = a.canumoper                                                       ,--1
    		'Fecha Inicio'        = CONVERT(CHAR(10), a.cafecha, 103 )                                ,--2
                  	'Fecha Vcto'          = CONVERT(CHAR(10), a.cafecvcto, 103 )                              ,--3
                  	'Plazo'               = a.caplazo                                                         ,--4
		'Rut Cliente'         = a.cacodigo                                                        ,--5
                  	'Nombre Cliente'      = b.clnombre                                                        ,--6
                  	'Tc Inicial'          = a.capremon1                                                       ,--7
           		'Precio'              = a.caprecal                                                        ,--8
                  	'Monto MX'            = a.camtomon1                                                       ,--9
                  	'Precio Futuro'       = a.catipcam                                                        ,--10
                  	'Monto Final'         = a.camtomon2                                                       ,--11
                  	'Pago MN'              =(SELECT glosa FROM  VIEW_FORMA_DE_PAGO WHERE codigo = a.cafpagomn ),--12
                  	'Pago MX'              =(SELECT glosa FROM  VIEW_FORMA_DE_PAGO WHERE codigo = a.cafpagomx ),--13
    		'Modalidad'           = a.catipmoda                                                       ,--14
                  	'Mto Dolar Inicial'   = a.caequmon1                                                       ,--15
                  	'Monto CLP'           = CASE a.cacodpos1  WHEN 2 THEN 0 ELSE a.caequmon2 END              ,--16
    		'Articulo84'          = a.cadiferen                                                       ,--17
                  	'Observacion'         = a.caobserv                                                        ,--18
                  	'Retito'              = a.caretiro                                                        ,--19
                  	'Operador'            = a.caoperador                                                      ,--20
    		'Moneda MX'           = c.mnnemo                                      ,--21
    		'Moneda MN'          = d.mnnemo                                     ,--22
    		'Digito V'            = b.cldv                                                            ,--23
    		'UF del Dia'          = @nvaluf                                                           ,--24
    		'Tipo Operacion'      = a.catipoper,
                  	'Operacion Moneda'      = a.catipopc ,  
    		'Spot'   = a.caparmon1,
                  	'Strike'  = a.catipcam,
    		'Costo'   = a.caparmon2,
    		'Prima'   = a.capremio               ,--25      
                  	'Producto'            = e.descripcion                             ,--27
    		'Nombre Porpietario'  = @cnomprop                                                         ,--28
    		'Direccion'           = @cdirprop                                                         ,--29
                  	'Entidad'             =( SELECT rcnombre FROM VIEW_ENTIDAD WHERE rccodcar=cacodsuc1 )     ,--30
          	'Moneda Mercado'      = CASE cacodpos1 WHEN 3 THEN 'UF' ELSE g.mnglosa END                ,--31
                  	'Cartera'             = f.rcnombre                                    ,--32
          	'Mercado'             = CASE b.clpais WHEN 6 THEN 'L' ELSE 'E' END                        , --35 -- Tipo de Cliente 'L'ocal / 'E'xterno
                  	'Estado'              = @cEstado                                                          ,
                  	'Hora'                = CONVERT(char(10), GETDATE(),108)                                  ,
                  	'FechaProceso'        = @cfecproc, 
    		'MonedaOrig'  = ( SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon = a.cacodmon1)  ,
    		'MonedaConv'  = ( SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon = a.cacodmon2 ) ,
    		'Aprobador'       = a.caautoriza		,
		'Firma1' = @Firma1,
		'Firma2' = @Firma2

            FROM    MFCA              a,
                    	VIEW_CLIENTE      b,
     		VIEW_MONEDA       c,
      		VIEW_MONEDA       d,
      		view_producto     e,
      		VIEW_TIPO_CARTERA f,
                    	VIEW_MONEDA       g                  
            WHERE   a.canumoper       = @numoper    AND
                    	(a.cacodigo       = clrut       AND
                    	a.cacodcli        = clcodigo  ) AND  
      		c.mncodmon        = a.cacodmon1 AND
      		d.mncodmon        = a.cacodmon2 AND
      		e.id_sistema      = 'BFW'       AND 
                    	e.codigo_producto = a.cacodpos1 AND
        	f.rcsistema       = 'BFW'       AND
                    	f.rccodpro        = a.cacodpos1 AND
                    	f.rcrut           = a.cacodcart AND
                    	g.mncodmon        = 994
  END
   /*=======================================================================*/
   /*=======================================================================*/
   SET NOCOUNT OFF
END





GO
