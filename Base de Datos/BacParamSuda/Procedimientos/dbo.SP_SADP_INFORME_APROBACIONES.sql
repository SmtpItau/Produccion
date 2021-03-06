USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_INFORME_APROBACIONES]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SADP_INFORME_APROBACIONES]  
 ( @dFecha  DATETIME  
 , @cUsuario VARCHAR(15)  
 )  
AS  
BEGIN  
  
 SET NOCOUNT ON  
  
 SELECT Fecha   = md.fecha  
  , Modulo   = md.sistema  
  , GlosaModulo  = me.Descripcion  
  , Folio   = dp.nContrato  
  , IdReg   = dp.Id_Detalle_Pago  
  , Moneda   = mn.mnnemo  
  , FPago   = ISNULL( fp.glosa , 'SIN FORMA DE PAGO')  
  , Monto   = dp.nMonto  
  , Usuario   = dp.sUsuario  
  , Firma1   = dp.sFirma1  
  , Firma2   = dp.sFirma2  
  , Estado   = UPPER( ee.sDescripcion )   
  , Observaciones = dp.cObservaciones  
  , FechaProceso = CONVERT(CHAR(10), sc.dFechaProceso , 103)  
  , FechaEmision = CONVERT(CHAR(10), GETDATE(), 103)  
  , HoraEmision  = CONVERT(CHAR(10), GETDATE(), 108)  
  , UsuarioProceso = @cUsuario  
 INTO #tmpsadp_retorno  
 FROM BacParamSuda.dbo.MDLBTR        md  
   INNER JOIN BacParamSuda.dbo.SADP_DETALLE_PAGOS		dp ON dp.cModulo	= md.sistema AND dp.nContrato = md.numero_operacion AND dp.iSecuencia = md.Secuencia
   INNER JOIN BacParamSuda.dbo.SADP_MODULOS_EXTERNOS me ON me.Nemo  = dp.cModulo  
   LEFT  JOIN BacParamSuda.dbo.MONEDA     mn ON mn.mncodmon = dp.iMoneda  
   LEFT  JOIN BacParamSuda.dbo.FORMA_DE_PAGO   fp ON fp.codigo  = dp.iFormaPago  
   LEFT  JOIN BacParamSuda.dbo.SADP_ESTADOSENVIO  ee ON EE.sCodigo = dp.cEstado  
  , BacParamSuda.dbo.SADP_CONTROL      sc  
 WHERE md.fecha  = @dFecha  
 AND  dp.cEstado  NOT IN('APM')  
 ORDER BY dp.cModulo, dp.nContrato, dp.Id_Detalle_Pago   
  
 IF (SELECT COUNT(1) FROM #tmpsadp_retorno ) = 0  
 BEGIN  
  SELECT Fecha   = ''  
   , Modulo   = ''  
   , GlosaModulo  = ''  
   , Folio   = ''  
   , IdReg   = ''  
   , Moneda   = ''  
   , FPago   = ''  
   , Monto   = 0  
   , Usuario   = ''  
   , Firma1   = ''  
   , Firma2   = ''  
   , Estado   = ''   
   , Observaciones = ''  
   , FechaProceso = CONVERT(CHAR(10), dFechaProceso , 103)  
   , FechaEmision = CONVERT(CHAR(10), GETDATE(), 103)  
   , HoraEmision  = CONVERT(CHAR(10), GETDATE(), 108)  
   , UsuarioProceso = @cUsuario  
  FROM BacParamSuda.dbo.SADP_CONTROL  
  
 END ELSE  
 BEGIN  
    
  SELECT Fecha  
   , Modulo  
   , GlosaModulo  
   , Folio  
   , IdReg  
   , Moneda  
   , FPago  
   , Monto  
   , Usuario  
   , Firma1  
   , Firma2  
   , Estado   
   , Observaciones  
   , FechaProceso   
   , FechaEmision  
   , HoraEmision  
   , UsuarioProceso  
  FROM #tmpsadp_retorno  
    
 END  
   
END

GO
