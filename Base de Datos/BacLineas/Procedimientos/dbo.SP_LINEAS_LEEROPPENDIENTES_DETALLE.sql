USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_LEEROPPENDIENTES_DETALLE]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_LINEAS_LEEROPPENDIENTES_DETALLE]
   ( @cSistema CHAR (03) ,
    @nNumoper NUMERIC(10) )
AS
BEGIN
 SET NOCOUNT ON
 CREATE TABLE #temp1(
  Sistema  CHAR(03) ,
  numoper  NUMERIC(06) ,
  numdocu  NUMERIC(06) ,
  correla  NUMERIC(06) ,
  rut_cli  NUMERIC(09) ,
  cod_cli  NUMERIC(09) ,
  cliente  CHAR(50) ,
  Monto  NUMERIC(19,04) ,
  Fecha  CHAR(10) ,
  ErrorG  CHAR(2)  ,
  MontoEx_Sis NUMERIC(19,04) ,
  MontoEx_Gen NUMERIC(19,04) )
 INSERT INTO #temp1
 SELECT @cSistema  ,
  NumeroOperacion  ,
  NumeroDocumento  ,
  NumeroCorrelativo ,
  rut_cliente  ,
  codigo_cliente  ,
  ''   ,
  MontoTransaccion ,
  CONVERT(CHAR(10),FechaVencimiento,103),
  'NO'   ,
  0   ,
  0
 FROM LINEA_TRANSACCION
 WHERE  NumeroOperacion = @nNumoper
 AND Id_Sistema = @cSistema
 UPDATE #temp1
 SET ErrorG = 'SI'
 FROM LINEA_TRANSACCION_DETALLE
 WHERE  numoper = NumeroOperacion
 AND numdocu = NumeroDocumento
 AND correla = NumeroCorrelativo
 AND Sistema = Id_Sistema
 AND Error   = 'S'
 UPDATE #temp1
 SET MontoEx_Sis = MontoExceso
 FROM LINEA_TRANSACCION_DETALLE
 WHERE  numoper = NumeroOperacion
 AND numdocu = NumeroDocumento
 AND correla = NumeroCorrelativo
 AND Sistema = Id_Sistema
 AND Error   = 'S'
 AND Linea_Transsaccion = 'LINSIS'
 AND MontoExceso > 0
 UPDATE #temp1
 SET MontoEx_Gen = MontoExceso
 FROM LINEA_TRANSACCION_DETALLE
 WHERE  numoper = NumeroOperacion
 AND numdocu = NumeroDocumento
 AND correla = NumeroCorrelativo
 AND Sistema = Id_Sistema
 AND Error   = 'S'
 AND Linea_Transsaccion = 'LINGEN'
 AND MontoExceso > 0
 SELECT Numoper  ,
  numdocu  ,
  correla  ,
  rut_cli  ,
  cod_cli  ,
  clnombre ,
  Monto  ,
  fecha  ,
  ErrorG  ,
  MontoEx_Sis ,
  MontoEx_Gen
 FROM #temp1  ,
  cliente
 WHERE clrut = rut_cli
 AND clcodigo = cod_cli
 ORDER
 BY Numoper  ,
  numdocu  ,
  correla
 SET NOCOUNT OFF
END
-- Sp_Lineas_LeerOpPendientes_Detalle 'BTR', 10
-- EXECUTE Sp_Lineas_LeerOpPendientes
--  select * from linea_transaccion
--  select * from linea_transaccion_detalle
-- select momtps from view_mdmo
-- sp_help
-- select * from cliente
GO
