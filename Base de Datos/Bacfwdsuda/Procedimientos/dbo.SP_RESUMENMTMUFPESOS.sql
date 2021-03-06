USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESUMENMTMUFPESOS]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RESUMENMTMUFPESOS]
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @nfecproc       DATETIME
 DECLARE @observado  NUMERIC(12,04) ,
    @uf   NUMERIC(12,04) ,
    @fecha_observado CHAR(10) ,
    @fecha_uf  CHAR(10) ,
    @TotalCompras   NUMERIC(10) ,
    @Dias_Compras   NUMERIC(10) ,
    @totalventas  NUMERIC(10) ,
    @dias_ventas   NUMERIC(10) ,
  @entidad char(40)
 EXECUTE sp_parametros_reporte  @observado  OUTPUT ,
         @uf   OUTPUT ,
         @fecha_observado OUTPUT ,
         @fecha_uf  OUTPUT
 SELECT @nfecproc = acfecproc , @entidad = acnomprop
 FROM mfac
 SELECT  @TotalCompras = COUNT(*) ,
  @Dias_Compras = SUM(caplazovto)
 FROM mfca  ,
  mfac
 WHERE  catipoper = 'C' OR catipoper = 'O'  AND
   (cacodpos1<>2   AND
  cacodpos1<>3)  AND
  cafecvcto>acfecproc
 SELECT  @Totalventas = COUNT(*) ,
  @Dias_Ventas = SUM(caplazovto)
 FROM mfca  ,
  mfac
 WHERE  catipoper = 'V' OR catipoper = 'A'  AND
  (cacodpos1<>2   AND
  cacodpos1<>3)  AND
  cafecvcto>acfecproc
 SELECT  'Monto_Comprado' = CASE WHEN catipoper = 'C' THEN SUM(camtomon1) ELSE 0 END ,
  'Monto_Vendido'  = CASE WHEN catipoper = 'V' THEN SUM(camtomon1) ELSE 0 END ,
  'MTM_por_Compra' = CASE WHEN catipoper = 'C' THEN SUM(camarktomarket) ELSE 0 END ,
  'MTM_por_Venta'  = CASE WHEN catipoper = 'V' THEN SUM(camarktomarket) ELSE 0 END ,
  'Plazo_Residual_Compra' = CASE WHEN catipoper = 'C' THEN SUM(caplazovto) ELSE 0 END ,
  'Plazo_Residual_Venta'  = CASE WHEN catipoper = 'V' THEN SUM(caplazovto) ELSE 0 END ,
  'Cantidad_Operaciones_Compra' = COUNT(*)        ,
  'Cantidad_Operaciones_Venta' = COUNT(*)        ,
  'MTM_Pesos' = SUM(camarktomarket)      ,
  'MTM_USD' = SUM(ROUND(camarktomarket/@observado,0))   ,
  'Linea_Otorgada' = 0          ,
  'Linea_Ocupada'  = 0          ,
  'Exceso_Linea'  = 0          ,
  'Exceso_Sobre'  = 0          ,
  'Nombre'  = clnombre         ,
  'Rut'   = cacodigo         ,
  'Codigo'  = cacodcli
 INTO #temporalMTM
 FROM  mfca  ,  
  mfac  ,
  view_cliente
 WHERE  
  cacodpos1=3  AND
  (cacodigo=clrut  AND
   cacodcli=clcodigo) AND
  cafecvcto>acfecproc
 GROUP BY cacodigo,cacodcli,clnombre,catipoper
 ORDER BY clnombre
 SELECT   'Monto Comprado' = SUM(monto_comprado)     , 
    'Monto Vendido'  = SUM(monto_vendido)     ,
    'MTM por Compra' = SUM(mtm_por_compra)     ,
    'MTM por Venta'  = SUM(mtm_por_venta)     ,
    'Plazo Residual Compra' = SUM(Plazo_Residual_Compra)   ,
    'Plazo Residual Venta'  = SUM(Plazo_Residual_venta)   ,
    'Cantidad Operaciones Compra' = SUM(Cantidad_Operaciones_Compra) ,
    'Cantidad Operaciones Venta' = SUM(Cantidad_Operaciones_venta) ,
    'MTM Pesos' = SUM(mtm_pesos)     ,
    'MTM USD' = SUM(mtm_usd)      ,
    'MTM_USD' = SUM(mtm_usd)      ,
    'Nombre'  = Nombre      ,
    'Rut'  = Rut       ,
    'Codigo' = codigo      ,
    'Linea_Otorgada' = 0       ,
    'Linea_Ocupada'  = 0       ,
    'Exceso_Linea'  = 0       ,
    'Exceso_Sobre'  = 0       ,
    'Exceso_90'  = 0
 INTO #temporalMTM1
 FROM #temporalMTM GROUP BY nombre,rut,codigo
 UPDATE  #temporalMTM1 
 SET  Linea_Otorgada = TotalAsignado ,
  Linea_Ocupada  = TotalOcupado ,
  Exceso_Linea   = TotalExceso 
 FROM view_linea_sistema
 WHERE Rut = Rut_Cliente AND
  Codigo = Codigo_Cliente AND
  id_sistema = 'BFW'
 UPDATE  #temporalMTM1 
 SET  Exceso_Sobre  = CASE WHEN MTM_USD > Exceso_Linea THEN ( MTM_USD - Linea_Otorgada ) + Exceso_Linea ELSE Exceso_Linea END ,
  Exceso_90  = CASE WHEN MTM_USD > ( Exceso_Linea * 0.9 ) THEN MTM_USD - ( Exceso_Linea * 0.9 ) ELSE 0       END 
 IF EXISTS( SELECT * FROM #temporalMTM1 )
  BEGIN
   SELECT  *         ,
     'Fecha Proceso'  = CONVERT(CHAR(10), @nfecproc, 103 )   ,
     'Hora'           = CONVERT(CHAR(5), getdate(),108)  ,
     'Observado'      = @observado     ,
     'valor UF'       = @uf      ,
     'fecha_Observado' = @fecha_observado    ,
     'fecha_UF'        = @fecha_uf     ,
     'PonderadoCompra' = CASE @TotalCompras WHEN 0 THEN 0 ELSE @Dias_Compras / @TotalCompras END,
     'PonderadoVenta'  = CASE @totalventas  WHEN 0 THEN 0 ELSE @dias_ventas / @totalventas   END,
        'entidad' = @entidad       
   FROM #temporalMTM1
  END
 ELSE
  BEGIN
   SELECT  'Monto Comprado' = 0, 
    'Monto Vendido'  = 0,
    'MTM por Compra' = 0,
    'MTM por Venta'  = 0,
    'Plazo Residual Compra' = 0,
    'Plazo Residual Venta'  = 0,
    'Cantidad Operaciones Compra' = 0,
    'Cantidad Operaciones Venta' = 0,
    'MTM Pesos' = 0,
    'MTM USD' = 0,
    'MTM_USD' = 0,
    'Nombre'  = '',
    'Rut'  = 0,
    'Codigo' = '',
    'Linea_Otorgada' = 0       ,
    'Linea_Ocupada'  = 0       ,
    'Exceso_Linea'  = 0       ,
    'Exceso_Sobre'  = 0       ,
    'Exceso_90'  = 0       ,
    'Fecha Proceso'  = CONVERT(CHAR(10), @nfecproc, 103 )   ,
    'Hora'           = CONVERT(CHAR(5), getdate(),108)  ,
    'Observado'      = @observado     ,
    'valor UF'       = @uf      ,
    'fecha_Observado' = @fecha_observado    ,
    'fecha_UF'        = @fecha_uf     ,
    'PonderadoCompra' = 0,
    'PonderadoVenta'  = 0,
    'entidad' = @entidad 
  END
 SET NOCOUNT OFF   
END

GO
