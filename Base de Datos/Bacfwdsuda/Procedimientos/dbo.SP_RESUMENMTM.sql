USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESUMENMTM]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RESUMENMTM]
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @nfecproc       CHAR(10)
 DECLARE @observado    NUMERIC(12,04) ,
    @uf      NUMERIC(12,04) ,
    @fecha_observado  CHAR(10) ,
    @fecha_uf    CHAR(10) ,
    @TotalCompras    NUMERIC(10) ,
    @Dias_Compras    NUMERIC(10) ,
    @totalventas    NUMERIC(10) ,
  @dias_ventas    NUMERIC(10),
  @entidad  char(40)
 EXECUTE sp_parametros_reporte  @observado  OUTPUT ,
     @uf   OUTPUT ,
     @fecha_observado OUTPUT ,
     @fecha_uf  OUTPUT
 SELECT  @nfecproc = CONVERT(CHAR(10), acfecproc, 103 ),@entidad =  acnomprop
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
 SELECT  'Monto_Comprado' = CASE WHEN catipoper = 'C' OR catipoper = 'O' THEN SUM(camtomon1) ELSE 0 END ,
  'Monto_Vendido'  = CASE WHEN catipoper = 'V' OR catipoper = 'A' THEN SUM(camtomon1) ELSE 0 END ,
  'MTM_por_Compra' = CASE WHEN catipoper = 'C' OR catipoper = 'O' THEN SUM(mtm_hoy_moneda1+mtm_hoy_moneda2) ELSE 0 END ,
  'MTM_por_Venta'  = CASE WHEN catipoper = 'V' OR catipoper = 'A' THEN SUM(mtm_hoy_moneda1+mtm_hoy_moneda2) ELSE 0 END ,
  'Plazo_Residual_Compra' = CASE WHEN catipoper = 'C' OR catipoper = 'O' THEN SUM(caplazovto) ELSE 0 END ,
  'Plazo_Residual_Venta'  = CASE WHEN catipoper = 'V' OR catipoper = 'A' THEN SUM(caplazovto) ELSE 0 END ,
  'Cantidad_Operaciones_Compra' = COUNT(*)        ,
  'Cantidad_Operaciones_Venta' = COUNT(*)        ,
  'MTM_Pesos' = SUM(mtm_hoy_moneda1+mtm_hoy_moneda2)      ,
  'MTM_USD' = SUM(ROUND((mtm_hoy_moneda1+mtm_hoy_moneda2)/@observado,0))   ,
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
 WHERE  (cacodpos1<>2   AND
  cacodpos1<>3)  AND
  (cacodigo=clrut  AND
   cacodcli=clcodigo) AND
  cafecvcto>acfecproc
 GROUP BY cacodigo,cacodcli,clnombre,catipoper
 ORDER BY clnombre
 SELECT  'Monto Comprado' = SUM(monto_comprado)     , 
  'Monto Vendido'  = SUM(monto_vendido)     ,
  'MTM por Compra' = SUM(mtm_por_compra)     ,
  'MTM por Venta'  = SUM(mtm_por_venta)     ,
  'Plazo Residual Compra' = SUM(Plazo_Residual_Compra)   ,
  'Plazo Residual Venta'  = SUM(Plazo_Residual_venta)   ,
  'Cantidad Operaciones Compra' = SUM(Cantidad_Operaciones_Compra) ,
  'Cantidad Operaciones Venta' = SUM(Cantidad_Operaciones_venta) ,
  'MTM Pesos' = SUM(mtm_pesos)     ,
  'MTM_USD' = SUM(mtm_usd)      ,
  'Nombre' = Nombre      ,
  'Rut'  = Rut       ,
  'Codigo' = codigo      ,
  'Linea_Otorgada' = 0       ,
  'Linea_Ocupada'  = 0       ,
  'Exceso_Linea'  = 0       ,
  'Exceso_Sobre'  = 0       ,
  'Exceso_90'  = 0,
  'entidad ' =  @entidad
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
 SET  Exceso_Sobre  = CASE WHEN MTM_USD > Linea_Ocupada THEN ( MTM_USD - Linea_Otorgada ) + Exceso_Linea ELSE Exceso_Linea END ,
  Exceso_90  = CASE WHEN MTM_USD > ( Linea_Ocupada * 0.9 ) THEN MTM_USD - ( Linea_Ocupada * 0.9 ) ELSE 0       END 
 SELECT  *        ,
	'Fecha Proceso'  = @nfecproc    ,
	'Hora'           = CONVERT(CHAR(5), getdate(),108) ,
	'Observado'      = @observado     ,
	'valor UF'       = @uf     ,
	'fecha_Observado' = @fecha_observado   ,
	'fecha_UF'        = @fecha_uf    ,
	'PonderadoCompra' = CASE @TotalCompras WHEN 0 THEN 0 ELSE @Dias_Compras / @TotalCompras END,
	'PonderadoVenta'  = CASE @totalventas  WHEN 0 THEN 0 ELSE @dias_ventas / @totalventas   END ,
	'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)     
 FROM    #temporalMTM1 
 SET NOCOUNT OFF   
END

GO
