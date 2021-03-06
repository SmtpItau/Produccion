USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_VctosMovimientos]    Script Date: 16-05-2022 11:18:12 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_VctosMovimientos] 
                  (	@fecha	        CHAR(10)
	           )
AS
BEGIN
set dateformat dmy
set nocount on

   DECLARE  @Fecha_proceso      CHAR(10)
   ,        @Fecha_proxima      CHAR(10)
   ,        @uf_hoy         NUMERIC(21,4)
   ,        @uf_man         NUMERIC(21,4)
   ,        @ivp_hoy        NUMERIC(21,4)
   ,        @ivp_man        NUMERIC(21,4)
   ,        @do_hoy         NUMERIC(21,4)
   ,        @do_man         NUMERIC(21,4)
   ,        @da_hoy         NUMERIC(21,4)
   ,        @da_man         NUMERIC(21,4)
   ,        @Nombre_entidad      CHAR(40)
   ,        @rut_empresa    CHAR(12)
   ,        @hora           CHAR(8)
   ,        @fecha_busqueda DATETIME
   ,        @Xfecha         DATETIME
   SET      @Xfecha        = @fecha 
   
  SELECT @fecha_busqueda= (SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES)
 
  EXECUTE Sp_Base_Del_Informe
           @Fecha_proceso   OUTPUT
   ,       @Fecha_proxima   OUTPUT
   ,       @uf_hoy      OUTPUT
   ,       @uf_man      OUTPUT
   ,       @ivp_hoy     OUTPUT
   ,       @ivp_man     OUTPUT
   ,       @do_hoy      OUTPUT
   ,       @do_man      OUTPUT
   ,       @da_hoy      OUTPUT
   ,       @da_man      OUTPUT
   ,       @Nombre_entidad   OUTPUT
   ,       @rut_empresa OUTPUT
   ,       @hora        OUTPUT     
   ,       @fecha_busqueda

   SELECT 
           'Fecha_proceso'   =@Fecha_proceso   
   ,       'Fecha_proxima'   =@Fecha_proxima   
   ,       'uf_hoy'      =@uf_hoy      
   ,       'uf_man'      =@uf_man      
   ,       'ivp_hoy'     =@ivp_hoy     
   ,       'ivp_man'     =@ivp_man     
   ,       'do_hoy'      =@do_hoy      
   ,       'do_man'      =@do_man      
   ,       'da_hoy'      =@da_hoy      
   ,       'da_man'      =@da_man      
   ,       'Nombre_entidad'   =@Nombre_entidad   
   ,       'rut_empresa' =@rut_empresa 
   ,       'hora'        =@hora        
       
   INTO #BASE
 



     IF EXISTS(  SELECT 1 FROM MOVIMIENTO_TRADER
                  WHERE  motipoper IN('RC','RV','VIB','VCI','VBC','VRP', 'VFL', 'VFP' )
                    AND  mofecpro  = @Xfecha
               ) 
     BEGIN

           SELECT 
                  'numdocu'          = RTRIM(CONVERT(CHAR(10),monumoper)) + "-" + CONVERT(CHAR(5),mocorrela)
               ,  'Titulo'           = 'VENCIMIENTOS DEL DIA ' + CONVERT(CHAR(10),@Xfecha,103)
	       ,  'cliente'          = c.clnombre
	       ,  'producto'         = CASE WHEN motipoper ='VIB' THEN p.descripcion + ' (' + RTRIM(momascara) + ')'  
                                            ELSE CASE 	WHEN	p.descripcion like 'VENCIMIENTO%' THEN SUBSTRING( p.descripcion,13,30)
							ELSE	p.descripcion
							END
                                            END

	       ,  'instser'          = SPACE(50)
	       ,  'nominal'          = SUM(r.monominal)
               ,  'rut_cliente'      = CONVERT(VARCHAR(10),r.morutcli) + '- ' + c.cldv
               ,  'forma_Pago'       = ISNULL(f.glosa,' ')
               ,  'cuenta_corriente' = ISNULL(r.Cuenta_Corriente_Final,' ')
               ,  'sucursal'         = CASE WHEN moforpagv = 15 THEN ISNULL(s.nombre,' ')
                                            WHEN moforpagv =  4 THEN ISNULL(r.Cuenta_Corriente_Final,' ')
                                            ELSE ' '
                                            END 
	       ,  'montoinicio'      = CASE WHEN motipoper ='VCI' THEN SUM(r.movalcomp) 
                                            ELSE SUM(r.movalinip) 
                                            END
               ,  'montopago'        = CASE WHEN motipoper ='VIB' OR motipoper  ='VBC' THEN SUM(r.movpresen) 
                                            WHEN motipoper ='VCI'                      THEN SUM(r.movpresen)
                                            ELSE SUM(r.movalvenp)
                                            END
               , 'Tipo_moneda'       = CASE WHEN motipoper ='VCI' and mnextranj ='0' THEN '0' else '1' END 

             INTO #TMPH
             FROM 
                  MOVIMIENTO_TRADER                 r
                , VIEW_FORMA_DE_PAGO   f
                , VIEW_SUCURSAL        s   
                , VIEW_CLIENTE         c
                , VIEW_PRODUCTO        p
                , VIEW_MONEDA

            WHERE
                  motipoper           IN('RC','RV','VIB','VCI','VBC','VRP', 'VFL', 'VFP')
              AND r.moforpagv        *=  f.codigo
              AND s.codigo_sucursal   =* r.Sucursal_Final
              AND c.clrut             =* r.morutcli
              AND c.clcodigo          =* r.mocodcli
              AND p.codigo_producto   =* r.motipoper
              AND r.mofecpro          =  @Xfecha
              AND mncodmon            = momonemi 

            GROUP BY r.monumoper
                   , r.motipoper
                   , r.morutcli
                   , f.glosa            
                   , r.Cuenta_Corriente_Final
                   , s.nombre
                   , c.clnombre
                   , p.descripcion
                   , r.momascara
                   , c.cldv
                   , r.moforpagv
                   ,r.mocorrela
                   , mnextranj                             

           SELECT 'numdocu'               = numdocu
                , 'Titulo'                = Titulo
                , 'cliente'               = cliente
                , 'producto'              = producto
                , 'instser'               = instser
                , 'nominal'               = SUM(nominal)
                , 'rut_cliente'           = rut_cliente
                , 'forma_Pago'            = forma_Pago
                , 'cuenta_corriente'      = cuenta_corriente
                , 'sucursal'              = sucursal              
                , 'montoinicio'           = SUM(montoinicio)           
                , 'montopago'             = SUM(montopago)
                , 'tipo_moneda'           = tipo_moneda
                , #BASE.*
             FROM #TMPH
                , #BASE

            GROUP BY
                  numdocu
                , Titulo
                , cliente 
                , producto
                , instser 
                , rut_cliente
                , forma_Pago 
                , cuenta_corriente
                , sucursal
                   , Fecha_proceso
                   , Fecha_proxima
                   , uf_hoy
                   , uf_man
                   , ivp_hoy
                   , ivp_man
                   , do_hoy
                   , do_man
                   , da_hoy
                   , da_man
                   , Nombre_entidad
                   , rut_empresa
                   , hora
                   , tipo_moneda 

             ORDER 
                BY numdocu



      END 		
      ELSE BEGIN
           SELECT 
                  'numdocu'          = convert(char(16),'')
               ,  'Titulo'           = 'VENCIMIENTOS DEL DIA ' + CONVERT(CHAR(10),@Xfecha,103)
	       ,  'cliente'          = ''
	       ,  'producto'         = ''
	       ,  'instser'          = ''
	       ,  'nominal'          = 0.0
               ,  'rut_cliente'      = ''
               ,  'forma_Pago'       = ''
               ,  'cuenta_corriente' = ''
               ,  'sucursal'         = ''
	       ,  'montoinicio'      = 0.0
               ,  'montopago'        = 0.0
               ,  'Tipo_moneda'      = '1' 
               ,  * 
            FROM  #BASE               
   END
END

GO
