USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOSGENERALES]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DATOSGENERALES]
AS
BEGIN
SET NOCOUNT ON
   DECLARE @Banco CHAR(40)
   SELECT @Banco  = ISNULL(rcnombre,'') from VIEW_ENTIDAD
   /*=======================================================================*/
   SELECT       'rutprop'   = acrutprop                                      ,   	--1
                'dvprop'    = acdigprop                                      ,		--2
                'nomprop'   = @Banco                                         ,		--3
                'fecante'   = CONVERT( CHAR(10), acfecante, 103 )            ,		--4
                'fecproc'   = CONVERT( CHAR(10), acfecproc, 103 )            ,		--5
                'fecprox'   = CONVERT( CHAR(10), acfecprox, 103 )            ,		--6
                'sucmesa'   = acsucmesa                                      ,      --7
                'ofimesa'   = acofimesa                                      ,		--8
                'codmdaloc' = accodmonloc                                    ,		--9
                'codmdadol' = accodmondol                                    ,		--10
                'codmdauf'  = accodmonuf                                     ,		--11
                'codmdaobs' = accodmondolobs                                 ,		--12	
                'codnumdec' = acnumdecimales                                 ,		--13
                'codpais'   = acpais                                         ,		--14
                'codplaza'  = acplaza                                        ,		--15
                'codempres' = accodempresa                                   ,		--16
                'sw_inicio' = acsw_pd                                        ,		--17
                'sw_final'  = acsw_fd                                        ,		--18
                'sw_ciemes' = acsw_ciemefwd                                  ,		--19
                'sw_deveng' = acsw_devenfwd                                  ,		--20
                'sw_contab' = acsw_contafwd                                  ,		--21
                'ValUF'     = ISNULL( ( SELECT       vmvalor
                                               FROM  VIEW_VALOR_MONEDA
                                               WHERE vmfecha  = acfecproc  AND
                                                     vmcodigo = accodmonuf ), 0 ),	--22
                'ValDolObs' = ISNULL( ( SELECT       vmvalor
                                               FROM  VIEW_VALOR_MONEDA
                                               WHERE vmfecha  = acfecproc  AND
                                                     vmcodigo = accodmondolobs ), 0 ) ,	--23
                'CodClient' = accodclie                                      ,			--24
                'dirprop'   = Cldirecc,--acdirprop                           ,			--25
                'fono'      = clfono                                         ,			--26
                'fax'       = clfax											 ,			--27
				'nombre_notaria'=nombre_notaria								 ,			--28
				'comuna'    =	(select nom_ciu from view_ciudad_comuna where cod_com=Clcomuna)	, --29
				'ciudad'    =	(select nom_ciu from view_ciudad_comuna where cod_com=Clciudad)	, --30
				'fecha_escritura'= fecha_escritura   											, --31
				'RutComder' = acRutComder														, --32 Prd_19416 Comder
				'ActivaComder' = acswActivaComder												  --33 Prd_19416 Comder
				
          FROM  mfac        ,
                view_cliente  
          WHERE clrut = acrutprop AND
                cldv  = acdigprop AND
  				clcodigo = 1	    
                
                
SET NOCOUNT OFF
END


GO
