USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELCARVIGENSINTE]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[SP_PAPELCARVIGENSINTE] 
       (
	@numOper FLOAT
	
       )
AS
BEGIN
 SET NOCOUNT ON
 /*=======================================================================*/
DECLARE @Firma1 char(15)
DECLARE @firma2 char(15)	


 DECLARE @nvaluf          FLOAT
 DECLARE @cnomprop        CHAR(40)
 DECLARE @cdirprop        CHAR(40)
 DECLARE @cSettlement  CHAR(50)
 DECLARE @cPFE     CHAR(50)
 DECLARE @cCCE     CHAR(50)
 DECLARE @cEmisorInstPlazo CHAR(50)
 DECLARE @cEstado                 CHAR(15)
 DECLARE @cFecproc                CHAR(10)
 DECLARE @cadena   CHAR(1) 
 DECLARE @cadena1  CHAR(1) 
 SELECT  @cadena1 = CHAR(1) 
 SELECT  @cadena = ' '
 /*=======================================================================*/
	   Select @firma1=res.Firma1,
		 @firma2=res.Firma2
	   From BacLineas..detalle_aprobaciones res
	   Where res.Numero_Operacion=@numOper
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
    	     'Fecha Inicio'       = CONVERT(CHAR(10), a.cafecha, 103 )                                ,--2
                  'Fecha Vcto'         = CONVERT(CHAR(10), a.cafecvcto, 103 )                              ,--3
                  'Plazo'               = a.caplazo                                                         ,--4
    	    'Rut Cliente'       = a.cacodigo                                                        ,--5
                 'Nombre Cliente'      = b.clnombre                                                        ,--6
                  'Tc Inicial'          = a.capremon1                                                       ,--7
                  'Precio'              = a.caprecal                                                        ,--8
                  'Monto MX'            = CASE cacodpos1 WHEN 4 THEN a.camtomon1 ELSE camtomon1fin END      ,--9
                  'Precio Futuro'       = a.catipcam                                                        ,--10
                  'Monto Final'         = CASE cacodpos1 WHEN 4 THEN a.camtomon2 ELSE camtomon1fin END      ,--11
                  'Pago MN'             =(SELECT glosa FROM  VIEW_FORMA_DE_PAGO WHERE codigo = a.cafpagomn ),--12
                  'Pago MX'             =(SELECT glosa FROM  VIEW_FORMA_DE_PAGO WHERE codigo = a.cafpagomx ),--13
    	    'Modalidad'           = a.catipmoda                                                       ,--14
                  'Mto Dolar Inicial'   = a.camtomon1ini                                                    ,--15
                  'Monto CLP'           = CASE a.cacodpos1  WHEN 2 THEN 0 ELSE a.caequmon2 END              ,--16
    	     'Articulo84'          = a.cadiferen                                                       ,--17
                  'Observacion'         = a.caobserv                                                        ,--18
                  'Retito'              = a.caretiro                                                        ,--19
                  'Operador'            = a.caoperador                                                      ,--20
                  'Moneda MX'           = c.mnnemo                               ,--21
    	     'Moneda MN'           = d.mnnemo                              ,--22
    	    'Digito V'            = b.cldv                                                            ,--23
    	    'UF del Dia'          = @nvaluf                                                           ,--24
    	    'Tipo Operacion'      = catipoper                                                         ,--25
                  'Producto'            = e.descripcion                              ,--27
    	     'Nombre Porpietario'  = @cnomprop                                                         ,--28
    	    'Direccion'           = @cdirprop                                                         ,--29
                  'Entidad'             =( SELECT rcnombre FROM VIEW_ENTIDAD WHERE rccodcar=cacodsuc1 )     ,--30
                  'Moneda Mercado'      = CASE cacodpos1 WHEN 3 THEN 'UF' ELSE g.mnglosa END                ,--31
    	    'Tasa USD'       = a.catasausd         ,
      	    'Tasa CNV'       = a.catasacon         ,
    	    'TC Referencia'       =(SELECT mdmn.mnglosa FROM MFCA, VIEW_MONEDA mdmn WHERE MFCA.camdausd = mdmn.mncodmon AND MFCA.canumoper = @numoper ),
                  'Cartera'             = f.rcnombre                                     ,
                  'Mercado'             = CASE b.clpais WHEN 1 THEN 'L' ELSE 'E' END                        ,
                  'Estado'              = @cEstado                                                          ,
                  'Hora'                = convert(char(10), getdate(),108)                                  ,
                  'FechaProceso'        = @cfecproc                                                         ,
                  'Equivalente Inicial' = CASE
                                          WHEN a.cacodmon2 = 998 THEN
                                             ( a.capremon1 / a.capremon2 ) * a.camtomon1ini
                                          WHEN a.cacodmon2 = 999 THEN
                                             a.camtomon1ini * a.capremon1
                                          ELSE
                                             0
                                          END                                                               ,
             'codigo conversion'    = a.cacodmon2         ,
    	'Codigo Producto'      = a.cacodpos1         ,
    	'Observa_lineas'      = REPLACE( a.caobservlin , @cadena1 , @cadena )     ,
    	'Observa_limites'     = REPLACE( a.caobservlim , @cadena1 , @cadena )     ,
    	'Aprobador'       = a.caautoriza ,
	'Firma1'= @Firma1,
	'Firma2' =@Firma2

            FROM    MFCA_LOG           a,
                    VIEW_CLIENTE      b,
	      VIEW_MONEDA       c, 
	      VIEW_MONEDA       d,
	      view_producto     e,
	      VIEW_TIPO_CARTERA f,
                    VIEW_MONEDA       g
                   
            WHERE   a.canumoper       = @numoper    AND
	      A.caestado        = 'A'         AND
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
             'Monto MX'            = CASE cacodpos1 WHEN 4 THEN a.camtomon1 ELSE camtomon1fin END      ,--9
             'Precio Futuro'       = a.catipcam                                                        ,--10
             'Monto Final'         = CASE cacodpos1 WHEN 4 THEN a.camtomon2 ELSE camtomon1fin END      ,--11
             'Pago MN'             =(SELECT glosa FROM  VIEW_FORMA_DE_PAGO WHERE codigo = a.cafpagomn ),--12
             'Pago MX'             =(SELECT glosa FROM  VIEW_FORMA_DE_PAGO WHERE codigo = a.cafpagomx ),--13
    	'Modalidad'           = a.catipmoda                                                       ,--14
             'Mto Dolar Inicial'   = a.camtomon1ini                                                    ,--15
             'Monto CLP'           = CASE a.cacodpos1  WHEN 2 THEN 0 ELSE a.caequmon2 END              ,--16
    	'Articulo84'          = a.cadiferen                                                       ,--17
             'Observacion'         = a.caobserv                                                        ,--18
             'Retito'              = a.caretiro                                                        ,--19
             'Operador'            = a.caoperador                                                      ,--20
    	'Moneda MX'           = c.mnnemo                               ,--21
    	'Moneda MN'           = d.mnnemo                              ,--22
    	'Digito V'            = b.cldv                                                            ,--23
    	'UF del Dia'          = @nvaluf                                                           ,--24
    	'Tipo Operacion'      = catipoper                                                         ,--25
             'Producto'            = e.descripcion                              ,--27
    	'Nombre Porpietario'  = @cnomprop                                                         ,--28
    	'Direccion'           = @cdirprop                                                         ,--29
             'Entidad'             =( SELECT rcnombre FROM VIEW_ENTIDAD WHERE rccodcar=cacodsuc1 )     ,--30
             'Moneda Mercado'      = CASE cacodpos1 WHEN 3 THEN 'UF' ELSE g.mnglosa END                ,--31
    	'Tasa USD'       = a.catasausd         ,
    	'Tasa CNV'       = a.catasacon         ,
    	'TC Referencia'       =(SELECT mdmn.mnglosa FROM MFCA, VIEW_MONEDA mdmn WHERE MFCA.camdausd = mdmn.mncodmon AND MFCA.canumoper = @numoper ),
             'Cartera'             = f.rcnombre                                     ,
         'Mercado'             = CASE b.clpais WHEN 1 THEN 'L' ELSE 'E' END                        ,
             'Estado'              = @cEstado                                                          ,
             'Hora'                = convert(char(10), getdate(),108)                                  ,
             'FechaProceso'        = @cfecproc                                                         ,
             'Equivalente Inicial' = CASE
                                          WHEN a.cacodmon2 = 998 THEN
                                             ( a.capremon1 / a.capremon2 ) * a.camtomon1ini
                                          WHEN a.cacodmon2 = 999 THEN
                                             a.camtomon1ini * a.capremon1
                                          ELSE
                                             0
                                          END                                                               ,
             'codigo conversion'   = a.cacodmon2         ,
    	'Codigo Producto'     = a.cacodpos1         ,
    	'Observa_lineas'      = REPLACE( a.caobservlin , @cadena1 , @cadena )     ,
    	'Observa_limites'     = REPLACE( a.caobservlim , @cadena1 , @cadena )     ,
    	'Aprobador'       = a.caautoriza ,
	'Firma1'= @Firma1,
	'Firma2' =@Firma2

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
