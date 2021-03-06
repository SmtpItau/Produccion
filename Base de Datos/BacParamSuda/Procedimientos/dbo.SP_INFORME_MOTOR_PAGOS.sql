USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_MOTOR_PAGOS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_INFORME_MOTOR_PAGOS]
   (   @cUsuario   VARCHAR(15) )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso   DATETIME
   SELECT  @dFechaProceso = acfecproc
   FROM    bactradersuda..MDAC

   IF EXISTS(SELECT 1 FROM bacparamsuda..MDLBTR WHERE fecha_vencimiento = @dFechaProceso)
   BEGIN

      SELECT 'FechaLiquidacion' = convert(char(10),lbtr.fecha_vencimiento,103)
      ,      'Sistema'          = sis.id_sistema
      ,      'GlosaSistema'     = convert(varchar(15),sis.nombre_sistema)
      ,      'TipoOpe_BAC'      = lbtr.tipo_mercado
      ,      'TipoOpe_IBS'      = lbtr.tipo_operacion
      ,      'EstadoEnvio'      = lbtr.estado_envio
      ,      'GlosaEstadoEnvio' = CASE WHEN lbtr.estado_envio = 'P' THEN 'Pendiente'
                                       WHEN lbtr.estado_envio = 'E' THEN 'Enviado'
                                       WHEN lbtr.estado_envio = 'I' THEN 'Impreso'
                                       WHEN lbtr.estado_envio = 'A' THEN 'Anulado'
                                       WHEN lbtr.estado_envio = ' ' THEN 'Vigente'
                                  END
      ,      'NumOperacion'     = lbtr.numero_operacion
      ,      'RutCliente'       = convert(varchar(12),replicate('0',10-len(ltrim(rtrim(convert(char(10),lbtr.rut_cliente))))) + ltrim(rtrim(convert(char(10),rut_cliente))) + '-' + convert(char(1),cli.cldv))
      ,      'NombreCliente'    = convert(varchar(32),ltrim(rtrim(cli.clnombre)))
      ,      'Moneda'           = mon.mnnemo
      ,      'MontoLiquidación' = lbtr.monto_operacion
      ,      'Forma_Pago'       = fpag.glosa
      ,      'FechaProceso'     = convert(char(10),@dFechaProceso,103)
      ,      'FechaEmision'     = convert(char(10),getdate(),103)
      ,      'HoraEmision'      = convert(char(10),getdate(),108)
      ,      'Usuario'          = @cUsuario
	  ,      'Logo' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)
      FROM   bacparamsuda..MDLBTR lbtr
                                LEFT JOIN bacparamsuda..SISTEMA_CNT sis    ON lbtr.sistema     = sis.id_sistema 
                                LEFT JOIN bacparamsuda..CLIENTE     cli    ON lbtr.rut_cliente = cli.clrut and lbtr.codigo_cliente = cli.clcodigo
                                LEFT JOIN bacparamsuda..MONEDA      mon    ON lbtr.moneda      = mon.mncodmon
                                LEFT JOIN bacparamsuda..FORMA_DE_PAGO fpag ON lbtr.forma_pago  = fpag.codigo
      WHERE  lbtr.fecha_vencimiento  = @dFechaProceso
      ORDER BY lbtr.forma_pago , lbtr.sistema , lbtr.estado_envio , lbtr.tipo_mercado

   END ELSE
   BEGIN

      SELECT 'FechaLiquidacion' = @dFechaProceso
      ,      'Sistema'          = ''
      ,      'GlosaSistema'     = 'NO EXISTEN DATOS'
      ,      'TipoOpe_BAC'      = ''
      ,      'TipoOpe_IBS'      = ''
      ,      'EstadoEnvio'      = ''
      ,      'GlosaEstadoEnvio' = ''
      ,      'NumOperacion'     = 0
      ,      'RutCliente'       = '0-0'
      ,      'NombreCliente'    = ''
      ,      'Moneda'           = ''
      ,      'MontoLiquidación' = 0.0
      ,      'Forma_Pago'       = ''
      ,      'FechaProceso'     = convert(char(10),@dFechaProceso,103)
      ,      'FechaEmision'     = convert(char(10),getdate(),103)
      ,      'HoraEmision'      = convert(char(10),getdate(),108)
      ,      'Usuario'          = @cUsuario
	  ,      'Logo' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)

   END
END


GO
