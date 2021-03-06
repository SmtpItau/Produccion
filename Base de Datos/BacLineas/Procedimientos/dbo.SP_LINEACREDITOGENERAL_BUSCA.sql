USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_BUSCA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
  
CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_BUSCA]  
   (   @rut_cli   NUMERIC(9)  
   ,   @cod_cli   NUMERIC(9)  
   )  
AS   
BEGIN  
  
   SET NOCOUNT ON  
  
   SELECT 'RutClienteDv'      = LTRIM(RTRIM(CONVERT(CHAR(12),c.clrut))) + '-' + c.cldv  
   ,      'NombreCliente'     = CONVERT(CHAR(30),c.clnombre)  
   ,      'RutCliente'        = a.rut_cliente  
   ,      'CodigoCliente'     = a.codigo_cliente  
   ,      'FechaAsignacion'   = b.fechaasignacion  
   ,      'FechaVcto'         = b.fechavencimiento  
   ,      'FechaFinContrato'  = b.fechafincontrato  
   ,      'EstBloqueado'      = b.bloqueado  
   ,      'TotalAsignado'     = b.totalasignado  
   ,      'TotalOcupado'      = b.totalocupado  
   ,      'TotalDisponible'   = b.totaldisponible  
   ,      'TotalExcedido'     = b.totalexceso  
   -->    Grilla  
   ,      'Sistema'           = a.id_sistema  
   ,      'Asignacion'        = a.fechaasignacion  
   ,      'Fencimiento'       = a.fechavencimiento  
   ,      'FinContrato'       = a.fechafincontrato  
   ,      'Bloqueado'         = a.bloqueado  
   ,      'Asignado'          = a.totalasignado  
   ,      'Ocupado'           = a.totalocupado  
   ,      'Disponible'        = a.totaldisponible  
   ,      'Excedido'          = a.totalexceso  
   ,      'MonedaGen'         = b.moneda  
   ,      'Moneda'            = a.moneda  
   ,      'GlosaMonGen'       = CONVERT(CHAR(15),m.mnglosa)  
   ,      'GlosaMonSis'       = CONVERT(CHAR(15),n.mnglosa)  
   ,      'GlosaSistema'      = CONVERT(CHAR(15),s.nombre_sistema)  
   ,	  'MonedaThreshold'   = MonThr.mnnemo	--> 27 <-- iMonedaThreshold
   ,      'CodMetodologia'    = d.RecMtdCod                           -- PRD8800
   ,      'DescMetodologia'   = d.RecMtdDsc                          -- PRD8800

   ,      'DescSegmentoComercial' = ISNULL(e.SgmDesc,'')              -- PRD8800
   ,      'EjecutivoComercial'    = ISNULL(c. ejecutivo_comercial,'') -- PRD8800

   FROM   LINEA_SISTEMA                        a with (nolock)   
          INNER JOIN LINEA_GENERAL             b with (nolock) ON b.rut_cliente = a.rut_cliente AND b.Codigo_Cliente = a.Codigo_Cliente  
          INNER JOIN VIEW_CLIENTE              c with (nolock) ON c.clrut = a.rut_cliente AND c.clcodigo      = a.Codigo_Cliente  
          INNER JOIN TBL_METODOLOGIAREC              d with (nolock) ON d.RecMtdCod = c.ClRecMtdCod                    -- PRD8800
          LEFT  JOIN BacParamSuda.dbo.TBL_SEGMENTOSCOMERCIALES  e with (nolock) ON e.SgmCod = c.seg_comercial          -- PRD8800          
          LEFT  JOIN BacParamSuda.DBO.MONEDA      m with (nolock) ON LTRIM(RTRIM(CONVERT(CHAR,m.mncodmon)))    = b.moneda  
          LEFT  JOIN BacParamSuda.dbo.SISTEMA_CNT s with (nolock) ON s.id_sistema =  a.id_sistema  
          LEFT  JOIN BacParamSuda.DBO.MONEDA      n with (nolock) ON LTRIM(RTRIM(CONVERT(CHAR,n.mncodmon)))    = a.moneda  
          LEFT  JOIN BacParamSuda.dbo.MONEDA MonThr with (nolock) ON MonThr.mncodmon = b.iMonedaThreshold  
   WHERE  a.rut_cliente     = @rut_cli  
   AND    a.Codigo_Cliente  = @cod_cli  
  order by s.nombre_sistema
END  
GO
