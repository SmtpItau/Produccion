USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_CuentasXproducto_LeerTabla]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_CuentasXproducto_LeerTabla]
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

      SELECT 

             A.id_sistema
      ,      'sistema'            = ISNULL(( SELECT nombre_sistema FROM SISTEMA S WHERE S.id_sistema = A.id_sistema ),' ')
      ,      codigo_producto
      ,      'producto'           = ISNULL(( SELECT descripcion FROM PRODUCTO P WHERE P.codigo_producto = A.codigo_producto ),' ')   
      ,      codigo_moneda1
      ,      'moneda1'            = ISNULL(( SELECT mnnemo FROM MONEDA WHERE mncodmon = A.codigo_moneda1 ),' ')
      ,      codigo_moneda2
      ,      'moneda2'            = ISNULL(( SELECT mnnemo FROM MONEDA WHERE mncodmon = A.codigo_moneda2 ),' ')
      ,      codigo_instrumento
      ,      'instrumento'        = ISNULL(( SELECT inglosa FROM INSTRUMENTO WHERE codigo_instrumento = inserie ),' ')
      ,      tipo_operacion       = CASE WHEN tipo_operacion = 'C'  THEN 'COMPRA'
                                         WHEN tipo_operacion = 'V'  THEN 'VENTA'
                                         WHEN tipo_operacion = 'A'  THEN 'CAPTACION'
                                         WHEN tipo_operacion = 'O'  THEN 'COLOCACION'
                                         ELSE ' '
                                         END
      ,      rut_emisor
      ,      'emisor'             = ISNULL(( SELECT emnombre FROM EMISOR WHERE emrut = A.rut_emisor ),' ')
      ,      tipo_emisor          
      ,      'descripcion'        = ISNULL(( SELECT descripcion FROM TIPO_EMISOR WHERE codigo_tipo = A.tipo_emisor ),' ')
      ,      codigo_plazo         
      ,      'plazo'              = ISNULL(( SELECT descripcion FROM PLAZO_PACTO P WHERE P.codigo_plazo = A.codigo_plazo ),' ')
      ,      tipo_cliente         
      ,      'tipo'               = ISNULL(( SELECT descripcion FROM TIPO_CLIENTE WHERE Codigo_Tipo_Cliente = A.tipo_cliente ),' ')

      ,      modalidad            = CASE WHEN modalidad = 'F'  THEN 'FISICA'
                                         WHEN modalidad = 'E'  THEN 'FISICA'
                                         WHEN modalidad = 'C'  THEN 'COMPENSACION'
                                         ELSE ' '
                                         END


      ,      tipo_mercado         = CASE WHEN tipo_mercado = 2  THEN 'EXTERNO'
                                         WHEN tipo_mercado = 1  THEN 'LOCAL'
                                         ELSE ' '
                                         END
      ,      codigo_carterasuper  
      ,      'Cartera_Super'      = ISNULL(( SELECT nombre_carterasuper FROM CATEGORIA_CARTERASUPER C WHERE C.codigo_carterasuper = A.codigo_carterasuper ),' ')
      ,      descripcion
      ,      cuenta_capital
      ,      cuenta_interes
      ,      cuenta_reajuste
      ,      cuenta_res_interes
      ,      cuenta_res_reajuste
      ,      producto_interfaz      
--      ,      'descr.interfaz'     = ISNULL(( SELECT descripcion FROM PRODUCTO_CODIGO_RCC P WHERE P.producto_interfaz = A.producto_interfaz ),'N/A')
      ,      'descr.interfaz'     = descripcion

      ,      formapago            = ISNULL(( SELECT codigo FROM FORMA_DE_PAGO WHERE codigo = A.FORMA_PAGO AND ESTADO<>'A'  ),0)
      ,      'formapago'          = ISNULL(( SELECT perfil FROM FORMA_DE_PAGO WHERE codigo = A.FORMA_PAGO AND ESTADO<>'A'  ),' ')

      ,      cuenta_p17           =  A.cuenta_p17          
      ,      producto_p17         =  A.producto_p17        
      ,      codigo_p17           =  A.codigo_p17          
      ,      moneda_contable

      FROM PRODUCTO_CUENTA A
   


   SET NOCOUNT OFF

END




GO
