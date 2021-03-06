USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DETALLEMTM]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--SP_DETALLEMTM 97004000,1
CREATE PROCEDURE [dbo].[SP_DETALLEMTM] (  @rutcli FLOAT,
     @codigo FLOAT
    )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @nfecproc        DATETIME
 DECLARE @observado    NUMERIC(12,04) ,
         @uf      NUMERIC(12,04) ,
    @fecha_observado  CHAR(10) ,
  @fecha_uf    CHAR(10) ,
  @entidad               CHAR(40)
select  @entidad = acnomprop from mfac 
 EXECUTE sp_parametros_reporte @observado OUTPUT ,
           @uf  OUTPUT ,
           @fecha_observado OUTPUT ,
           @fecha_uf  OUTPUT
 SELECT  @nfecproc = acfecproc
 FROM mfac
 IF EXISTS(  SELECT * 
   FROM  mfca  ,  
    mfac  ,
    view_cliente ,
    View_Linea_Sistema a
   WHERE ( cacodigo=@rutcli AND
    cacodcli=@codigo) AND
    ( cacodigo=clrut  AND
    cacodcli=clcodigo) AND
    ( cacodigo = a.rut_cliente AND
    cacodcli = a.codigo_cliente AND
    'BFW' = a.id_sistema ) AND
    cafecvcto>acfecproc
     ) 
  BEGIN
   SELECT  'N_Operacion'  = canumoper         , 
    'Monto Comprado' = CASE WHEN catipoper = 'C' OR catipoper = 'O' THEN (camtomon1) ELSE 0 END ,
    'Monto Vendido'  = CASE WHEN catipoper = 'V' OR catipoper = 'A' THEN (camtomon1) ELSE 0 END ,
    'MTM por Compra' = CASE WHEN catipoper = 'C' OR catipoper = 'O' THEN (mtm_hoy_moneda1+mtm_hoy_moneda2) ELSE 0 END ,
    'MTM por Venta'  = CASE WHEN catipoper = 'V' OR catipoper = 'A' THEN (mtm_hoy_moneda1+mtm_hoy_moneda2) ELSE 0 END ,
    'Plazo Residual Compra' = CASE WHEN catipoper = 'C' OR catipoper = 'O' THEN (caplazovto) ELSE 0 END ,
    'Plazo Residual Venta'  = CASE WHEN catipoper = 'V' OR catipoper = 'A' THEN (caplazovto) ELSE 0 END ,
    'MTM Pesos' = (mtm_hoy_moneda1+mtm_hoy_moneda2)      ,
    'MTM USD'   = (ROUND((mtm_hoy_moneda1+mtm_hoy_moneda2)/@observado,0))   ,
    'Linea Otorgada'  = TotalAsignado        ,
    'Linea Ocupada'   = TotalOcupado        ,
    'Exceso Linea'   = TotalExceso         ,
    'Exceso Sobre'   = 0          ,
    'Nombre'   = clnombre         ,
    'Fecha Proceso'   = CONVERT(CHAR(10), @nfecproc, 103 )       ,
    'Hora'            = CONVERT(CHAR(5), getdate(),108)      ,
    'Observado'       = @observado          ,
    'valor UF'        = @uf          ,
    'fecha_Observado' = @fecha_observado         ,
    'fecha_UF'        = @fecha_uf                ,
    'entidad'       = @entidad 
   FROM  mfca  ,  
    mfac  ,
    view_cliente ,
    View_Linea_Sistema a
   WHERE ( cacodigo=@rutcli AND
    cacodcli=@codigo) AND
         ( cacodigo=clrut  AND
    cacodcli=clcodigo) AND
         ( cacodigo = a.rut_cliente AND
    cacodcli = a.codigo_cliente AND
    a.id_sistema = 'BFW' ) AND
    cafecvcto>acfecproc
   ORDER BY N_Operacion
  END
 ELSE
  BEGIN
   SELECT  'N_Operacion'  = 0, 
    'Monto Comprado' = 0,
    'Monto Vendido'  = 0,
    'MTM por Compra' = 0,
    'MTM por Venta'  = 0,
    'Plazo Residual Compra' = 0,
    'Plazo Residual Venta'  = 0,
    'MTM Pesos' = 0,
    'MTM USD'   = 0,
    'Linea Otorgada'  = 0          ,
    'Linea Ocupada'   = 0          ,
    'Exceso Linea'   = 0          ,
    'Exceso Sobre'   = 0          ,
    'Nombre'   = '',
    'Fecha Proceso'   = CONVERT(CHAR(10), @nfecproc, 103 )       ,
    'Hora'            = CONVERT(CHAR(5), GETDATE(),108)      ,
    'Observado'       = @observado          ,
    'valor UF'        = @uf          ,
    'fecha_Observado' = @fecha_observado         ,
    'fecha_UF'        = @fecha_uf,
    'entidad'       = @entidad 
  END 
 SET NOCOUNT OFF   
END

GO
