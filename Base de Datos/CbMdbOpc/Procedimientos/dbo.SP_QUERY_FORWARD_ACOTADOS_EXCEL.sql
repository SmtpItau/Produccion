USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_QUERY_FORWARD_ACOTADOS_EXCEL]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE PROCEDURE [dbo].[SP_QUERY_FORWARD_ACOTADOS_EXCEL]    
AS    
BEGIN    
    
 SET NOCOUNT ON    
--se puede hacer con un left join en vez de Union    
--Quedan fuera:    
-- Código 1 Straddle    
-- Código 3 Butterfly    
-- Código 7 Strangle    
    
  SELECT RUT      = e.CaRutCliente    
   , NombreCliente   = cl.clnombre      
   , NumeroContrato   = e.CaNumContrato      
   , FechaInicio    = CONVERT(varchar,e.CaFechaContrato,105)       
   , FechaVencimiento  = CONVERT(varchar,fwd.CaFechaVcto,105)       
   , CompraVenta    = case when e.CaCVEstructura ='C' then 'Compra' else 'Venta' end       
   , Estructura    = o.OpcEstDsc    
   , Glosa     = e.CaGlosa      
   , MontoUSD    = Replace(CONVERT(varchar,fwd.CaMontoMon1),'.',',')      
   , PrecioFW    = fwd.CaStrike     
   , PrecioCota    = ''--NULL --cota.CaStrike     
   FROM CaEncContrato           e with(nolock)    
    INNER JOIN CaDetContrato         fwd with(nolock) ON e.CaNumcontrato  = fwd.CaNumcontrato    
                     AND  fwd.CaNumEstructura = 1    
    INNER JOIN OpcionEstructura        o with(nolock) ON e.CaCodEstructura = o.OpcEstCod    
    INNER JOIN LnkBac.BacParamSuda.dbo.View_CLIENTEParaOpc cl with(nolock) ON cl.clrut   = e.CaRutCliente    
                     AND  cl.clcodigo   = e.CaCodigo    
   WHERE --grupo de estructuras con 1 detalle    
    e.CaCodEstructura IN(0,6,8) --Vanilla, Forward Asiático, Forward Americano    
   OR e.CaCodEstructura IN(9,10) --Strip Asiático Call, Strip Asiático Put    
    
 UNION    
    
  SELECT RUT      = e.CaRutCliente    
    , NombreCliente   = cl.clnombre      
    , NumeroContrato   = e.CaNumContrato      
    , FechaInicio    = CONVERT(varchar,e.CaFechaContrato,105)       
    , FechaVencimiento  = CONVERT(varchar,fwd.CaFechaVcto,105)       
    , CompraVenta    = case when e.CaCVEstructura ='C' then 'Compra' else 'Venta' end       
    , Estructura    = o.OpcEstDsc    
    , Glosa     = e.CaGlosa      
    , MontoUSD    = Replace(CONVERT(varchar,fwd.CaMontoMon1),'.',',')      
    , PrecioFW    = fwd.CaStrike     
    , PrecioCota    = cota.CaStrike     
   FROM CaEncContrato           e with(nolock)    
    INNER JOIN CaDetContrato         fwd with(nolock) ON e.CaNumcontrato  = fwd.CaNumcontrato    
                     AND  fwd.CaNumEstructura = 1    
    INNER JOIN CaDetContrato        cota with(nolock) ON e.CaNumcontrato  = cota.CaNumcontrato    
                     AND  cota.CaNumEstructura= 2    
    INNER JOIN OpcionEstructura        o with(nolock) ON e.CaCodEstructura = o.OpcEstCod    
    INNER JOIN LnkBac.BacParamSuda.dbo.View_CLIENTEParaOpc cl with(nolock) ON cl.clrut   = e.CaRutCliente    
                     AND  cl.clcodigo   = e.CaCodigo    
   WHERE --grupo de estructuras con 2 detalles    
    e.CaCodEstructura IN(2)  --Collar    
    OR e.CaCodEstructura IN(11,12) --Call Spread, Put Spread    
    
 UNION    
     
  SELECT RUT      = e.CaRutCliente    
    , NombreCliente   = cl.clnombre      
    , NumeroContrato   = e.CaNumContrato      
    , FechaInicio    = CONVERT(varchar,e.CaFechaContrato,105)       
    , FechaVencimiento  = CONVERT(varchar,fwd.CaFechaVcto,105)       
    , CompraVenta    = case when e.CaCVEstructura ='C' then 'Compra' else 'Venta' end       
    , Estructura    = o.OpcEstDsc    
    , Glosa     = e.CaGlosa      
    , MontoUSD    = Replace(CONVERT(varchar,fwd.CaMontoMon1),'.',',')      
    , PrecioFW    = fwd.CaStrike     
    , PrecioCota    = cota.CaStrike     
  FROM CaEncContrato           e with(nolock)    
    INNER JOIN CaDetContrato         fwd with(nolock) ON e.CaNumcontrato  = fwd.CaNumcontrato    
                     AND  fwd.CaNumEstructura = 1    
    INNER JOIN CaDetContrato        cota with(nolock) ON e.CaNumcontrato  = cota.CaNumcontrato    
                     AND  cota.CaNumEstructura= 3    
    INNER JOIN OpcionEstructura        o with(nolock) ON e.CaCodEstructura = o.OpcEstCod    
    INNER JOIN LnkBac.BacParamSuda.dbo.View_CLIENTEParaOpc cl with(nolock) ON cl.clrut   = e.CaRutCliente    
              AND  cl.clcodigo   = e.CaCodigo    
  WHERE --grupo de estructuras con 3 detalles    
   e.CaCodEstructura IN(4,5) --Forward Utilidad Acotada, Forward Perdida Acotada    
    
     ORDER BY NumeroContrato    
         
     
END
GO
