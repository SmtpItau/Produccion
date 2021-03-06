USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Cuentas_Producto_Rpt]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Sp_Cuentas_Producto_Rpt]
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


DECLARE     @acfecproc      CHAR(10)
   ,        @acfecprox      CHAR(10)
   ,        @uf_hoy         FLOAT
   ,        @uf_man         FLOAT
   ,        @ivp_hoy        FLOAT
   ,        @ivp_man        FLOAT
   ,        @do_hoy         FLOAT
   ,        @do_man         FLOAT
   ,        @da_hoy         FLOAT
   ,        @da_man         FLOAT
   ,        @acnomprop      CHAR(40)
   ,        @rut_empresa    CHAR(12)
   ,        @hora           CHAR(8)
   ,        @fecha_busqueda DATETIME 
   ,        @fec            CHAR(10)
   
  SELECT @fecha_busqueda = (SELECT fecha_proceso FROM DATOS_GENERALES) 

  EXECUTE Sp_Base_Del_Informe
           @acfecproc   OUTPUT
   ,       @acfecprox   OUTPUT
   ,       @uf_hoy      OUTPUT
   ,       @uf_man      OUTPUT
   ,       @ivp_hoy     OUTPUT
   ,       @ivp_man     OUTPUT
   ,       @do_hoy      OUTPUT
   ,       @do_man      OUTPUT
   ,       @da_hoy      OUTPUT
   ,       @da_man      OUTPUT
   ,       @acnomprop   OUTPUT
   ,       @rut_empresa OUTPUT
   ,       @hora        OUTPUT     
   ,       @fecha_busqueda

IF EXISTS (SELECT 1 FROM PRODUCTO_CUENTA )
   BEGIN
   SELECT 
              'SISTEMA'            = Id_sistema
          ,   'CODIGO_PRODUCTO'    = (SELECT descripcion FROM PRODUCTO WHERE codigo_producto = P.codigo_producto)
          ,   'MONEDA1'            = (SELECT mnsimbol FROM MONEDA WHERE P.codigo_moneda1 = mncodmon)     
          ,   'MONEDA2'            = (SELECT mnsimbol FROM MONEDA WHERE P.codigo_moneda2 = mncodmon)     
          ,   'CODIGO_INSTRUMENTO' = ISNULL((SELECT inserie  FROM INSTRUMENTO WHERE P.codigo_instrumento = inserie),' ')
          ,   'TIPO_OPERACION'     = CASE WHEN tipo_operacion = 'C'  THEN 'COMPRA'
                                          WHEN tipo_operacion = 'V'  THEN 'VENTA'
                                          ELSE ' '
                                          END    
          ,   'RUT_EMISOR'         = rut_emisor
          ,   'TIPO_EMISOR'        = ISNULL(( SELECT descripcion FROM TIPO_EMISOR WHERE codigo_tipo = P.tipo_emisor ),' ')
          ,   'PLAZO'              = ISNULL(( SELECT descripcion FROM PLAZO_PACTO A WHERE A.codigo_plazo = P.codigo_plazo ),' ')   
          ,   'TIPO_CLIENTE'       = ISNULL(( SELECT descripcion FROM TIPO_CLIENTE WHERE codigo_tipo_cliente  = P.tipo_cliente ),' ')
          ,   'MODALIDAD'          = CASE WHEN modalidad = 'F'  THEN 'FISICA'
                                          WHEN modalidad = 'C'  THEN 'COMPENSACION'
                                          ELSE ' '
                                          END
          ,   'TIPO_MERCADO'       =ISNULL(( SELECT descripcion FROM TIPO_MERCADO WHERE codigo_mercado  = P.tipo_mercado ),' ')
          ,   'CARTERA_SUPER'      = ( SELECT nombre_carterasuper FROM CATEGORIA_CARTERASUPER WHERE codigo_carterasuper  =P.codigo_carterasuper    )
          ,   'DESCRIPCION'        = descripcion  
          ,   'CUENTA_CAPITAL'     = cuenta_capital
          ,   'CUENTA_INTERES'     = cuenta_interes
          ,   'CUENTA_REAJUSTE'    = cuenta_reajuste  
          ,   'CUENTA_RES_INTER'   = cuenta_res_interes
          ,   'CUENTA_RES_REAJ'    = cuenta_res_reajuste
          ,   'PRODUCTO_INTERFAZ'  = ' '--( SELECT descripcion FROM PRODUCTO_CODIGO_RCC WHERE producto_interfaz = P.producto_interfaz )
          ,   'HORA'               = @hora
          ,   'UF_HOY'             = @uf_hoy  
          ,   'UF_MAN'             = @uf_man  
          ,   'DO_HOY'             = @do_hoy
          ,   'DO_MAN'             = @do_man
          ,   'IVP_HOY'            = @ivp_hoy
          ,   'TITULO'             = 'INFORME DE CUENTAS POR PRODUCTOS'  
          ,   'FECHA_PROCESO'      = @ACFECPROC

          ,   'FORMA_PAGO'         =  ISNULL(( SELECT perfil FROM FORMA_DE_PAGO WHERE codigo = P.FORMA_PAGO ),' ')
          ,   'CUENTA_P17'         =  ISNULL(P.cuenta_p17,' ')          
          ,   'PRODUCTO_P17'       =  ISNULL(P.producto_p17,' ')        
          ,   'CODIGO_P17'         =  ISNULL(P.codigo_p17,' ')          
          ,   'MONEDA_CONTABLE'    =  ISNULL(P.moneda_contable,0)          
          ,   'PRODUCTO_INTERFAZCOD' =  P.producto_interfaz 

	 FROM PRODUCTO_CUENTA P

END ELSE BEGIN
      
   SELECT 
              'SISTEMA'            = ' '
          ,   'CODIGO_PRODUCTO'    = ' '
          ,   'MONEDA1'            = ' '
          ,   'MONEDA2'            = ' '
          ,   'CODIGO_INSTRUMENTO' = ' '
          ,   'TIPO_OPERACION'     = ' '
          ,   'RUT_EMISOR'         = 0.0
          ,   'TIPO_EMISOR'        = ' '
          ,   'PLAZO'              = ' '
          ,   'TIPO_CLIENTE'       = ' '
          ,   'MODALIDAD'          = ' '
          ,   'TIPO_MERCADO'       = ' '
          ,   'CARTERA_SUPER'      = ' '
          ,   'DESCRIPCION'        = ' '
          ,   'CUENTA_CAPITAL'     = ' '
          ,   'CUENTA_INTERES'     = ' '
          ,   'CUENTA_REAJUSTE'    = ' '
          ,   'CUENTA_RES_INTER'   = ' '
          ,   'CUENTA_RES_REAJ'    = ' '
          ,   'PRODUCTO_INTERFAZ'  = ' '
          ,   'HORA'               = @hora
          ,   'UF_HOY'             = @uf_hoy  
          ,   'UF_MAN'             = @uf_man  
          ,   'DO_HOY'             = @do_hoy
          ,   'DO_MAN'             = @do_man
          ,   'IVP_HOY'            = @ivp_hoy
          ,   'TITULO'             = 'INFORME DE CUENTAS POR PRODUCTOS'  
          ,   'FECHA_PROCESO'      = @ACFECPROC
          ,   'FORMA_PAGO'         =  ' '
          ,   'CUENTA_P17'         =  ' '
          ,   'PRODUCTO_P17'       =  ' '
          ,   'CODIGO_P17'         =  ' '
          ,   'MONEDA_CONTABLE'    =  ' '
	  ,   'PRODUCTO_INTERFAZCOD' = ' ' 
END
END

-- SELECT * FROM PRODUCTO  
-- SELECT * FROM MONEDA
-- SELECT * FROM INSTRUMENTO
-- SELECT * FROM CLIENTE




GO
