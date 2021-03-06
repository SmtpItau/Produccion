USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_LEEROPPENDIENTES]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_LEEROPPENDIENTES]
    (
    @cFecha DATETIME,
    @ID CHAR(5) = ''
    )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @cFecha_BTR DATETIME
 DECLARE @cFecha_BFW DATETIME
 DECLARE @cFecha_BCC DATETIME
 SELECT @cFecha_BTR = acfecproc FROM view_mdac
 SELECT @cFecha_BFW = acfecproc FROM view_mfac
 SELECT @cFecha_BCC = acfecpro  FROM view_meac
 CREATE TABLE
 #Temp1
  (
  Sistema  CHAR(05) ,
  Cod_Producto CHAR(05) ,
  Glo_Producto CHAR(30) ,
  numoper  NUMERIC(10) ,
  rutcli  NUMERIC(09) ,
  codcli  NUMERIC(09) ,
  cliente  CHAR(80) ,
  Monto  NUMERIC(19,4) ,
  Operador CHAR(15) ,
  ErrorG  CHAR(2)  ,
  Pendiente CHAR(1)  ,
  Moneda  CHAR(3)  ,
  plazo  NUMERIC(5) ,
  linea_total NUMERIC(21,04) ,
  Forma_Pago CHAR(30) ,
  fecha  DATETIME ,
  fecha_sistema   DATETIME
  )
 INSERT INTO #temp1
 SELECT A.Id_Sistema  ,
  A.Codigo_Producto ,
  ''   ,
  A.NumeroOperacion ,
  0   ,
  0   ,
  ''   ,
  A.MontoOriginal  ,
  A.Operador  ,
  'NO'   ,
  'N'   ,
  ''   ,
  DATEDIFF(DAY,a.FechaInicio,a.FechaVencimiento) ,
  0   ,
  ''   ,
  FechaInicio  ,
  CASE  WHEN A.Id_Sistema = 'BTR' THEN @cFecha_BTR
   WHEN A.Id_Sistema = 'BFW' THEN @cFecha_BFW
   WHEN A.Id_Sistema = 'BCC' THEN @cFecha_BCC
   ELSE FechaInicio
  END
 FROM LINEA_TRANSACCION  A ,
  LINEA_TRANSACCION_DETALLE B
 WHERE  A.NumeroOperacion = B.NumeroOperacion
 AND A.NumeroDocumento = B.NumeroDocumento
 AND A.NumeroCorrelativo = B.NumeroCorrelativo
 AND A.Id_Sistema  = B.Id_Sistema
 AND ( ( A.Id_Sistema = 'BTR' AND FechaInicio = @cFecha_BTR ) OR 
  ( A.Id_Sistema = 'BFW' AND FechaInicio = @cFecha_BFW ) OR 
  ( A.Id_Sistema = 'BCC' AND FechaInicio = @cFecha_BCC )    )
 GROUP
 BY A.Id_Sistema  ,
  A.Codigo_Producto ,
  A.NumeroOperacion ,
  A.Operador  ,
  A.MontoOriginal  ,
  a.FechaVencimiento ,
  a.FechaInicio
 INSERT INTO #temp1
 SELECT Id_Sistema  ,
  Codigo_Producto ,
  ''  ,
  NumeroOperacion ,
  0  ,
  0  ,
  ''  ,
  MontoTransaccion,
  Operador ,
  'NO'  ,
  'N'  ,
  ''  ,
  DATEDIFF(DAY,acfecproc,FechaVencimiento) ,
  0  ,
  ''  ,
  FechaOperacion ,
  acfecproc
 FROM LIMITE_TRANSACCION ,
  view_mdac
 WHERE NOT EXISTS( SELECT * FROM LINEA_TRANSACCION WHERE LINEA_TRANSACCION.NumeroOperacion = LIMITE_TRANSACCION.NumeroOperacion AND LINEA_TRANSACCION.FechaInicio = @cFecha_BTR )
 AND Check_Operacion   ='S'
 AND FechaOperacion = @cFecha_BTR
 AND LIMITE_TRANSACCION.ID_sistema = 'BTR'
 GROUP 
 BY  LIMITE_TRANSACCION.Id_Sistema  ,
  Codigo_Producto ,
  NumeroOperacion ,
  MontoTransaccion,
  Operador ,
  FechaVencimiento,
  FechaOperacion ,
  acfecproc
 INSERT INTO #temp1
 SELECT LIMITE_TRANSACCION.Id_Sistema  ,
  Codigo_Producto ,
  ''  ,
  NumeroOperacion ,
  0  ,
  0  ,
  ''  ,
  MontoTransaccion,
  Operador ,
  'NO'  ,
  'N'  ,
  ''  ,
  DATEDIFF(DAY,acfecproc,FechaVencimiento) ,
  0  ,
  ''  ,
  cafecha  ,
  acfecproc
 FROM LIMITE_TRANSACCION ,
  view_mfac  ,
  view_mfca 
 WHERE NOT EXISTS( SELECT * FROM LINEA_TRANSACCION WHERE LINEA_TRANSACCION.NumeroOperacion = LIMITE_TRANSACCION.NumeroOperacion AND LINEA_TRANSACCION.FechaInicio = @cFecha_BFW )
 AND Check_Operacion   ='S'
 AND FechaOperacion = @cFecha_BFW
 AND LIMITE_TRANSACCION.ID_sistema = 'BFW'
 AND  NumeroOperacion = canumoper
 GROUP 
 BY  LIMITE_TRANSACCION.Id_Sistema  ,
  Codigo_Producto ,
  NumeroOperacion ,
  MontoTransaccion,
  Operador ,
  FechaVencimiento,
  acfecproc ,
  cafecha
 INSERT INTO #temp1
 SELECT LIMITE_TRANSACCION.Id_Sistema  ,
  Codigo_Producto ,
  ''  ,
  NumeroOperacion ,
  0  ,
  0  ,
  ''  ,
  MontoTransaccion,
  Operador ,
  'NO'  ,
  'N'  ,
  ''  ,
  DATEDIFF(DAY,acfecpro,FechaVencimiento) ,
  0  ,
  ''  ,
  FechaOperacion ,
  acfecpro
 FROM LIMITE_TRANSACCION ,
  view_meac
 WHERE NOT EXISTS( SELECT * FROM LINEA_TRANSACCION WHERE LINEA_TRANSACCION.NumeroOperacion = LIMITE_TRANSACCION.NumeroOperacion AND LINEA_TRANSACCION.FechaInicio = @cFecha_BCC )
 AND Check_Operacion   ='S'
 AND FechaOperacion = @cFecha_BCC
 AND LIMITE_TRANSACCION.ID_sistema = 'BCC'
 GROUP 
 BY  LIMITE_TRANSACCION.Id_Sistema  ,
  Codigo_Producto ,
  NumeroOperacion ,
  MontoTransaccion,
  Operador ,
  FechaVencimiento,
  FechaOperacion ,
  acfecpro
 UPDATE #temp1
 SET errorG = 'SI'
--************** Solo hasta que se habilite el modulo completo
--  ,Pendiente = 'S'
--**************despues borrar
 FROM LINEA_TRANSACCION_DETALLE
 WHERE  numoper = NumeroOperacion
 AND Sistema = Id_Sistema
 AND Error = 'S'
 UPDATE #temp1
 SET Glo_Producto = descripcion
 FROM PRODUCTO
 WHERE id_sistema  = Sistema
 AND codigo_producto = Cod_Producto
 UPDATE #temp1
 SET rutcli = morutcli,
  codcli = mocodcli,
  moneda = ISNULL( ( CASE WHEN motipoper IN( 'VP' , 'CP' ) THEN 'CLP' ELSE ( SELECT DISTINCT mnnemo FROM moneda,view_mdmo WHERE numoper = monumoper AND momonpact = mncodmon ) END ) , '' ),
  linea_total = ISNULL( TotalOcupado , 0 ) ,
  forma_pago  = ISNULL( ( SELECT DISTINCT glosa FROM forma_de_pago,view_mdmo WHERE numoper = monumoper AND moforpagI = codigo ) , '' )
 FROM view_mdmo 
      LEFT JOIN linea_general ON morutcli = Rut_Cliente AND  mocodcli  = Codigo_Cliente
 WHERE numoper = monumoper  
  AND Sistema = 'BTR'
 UPDATE #temp1
 SET rutcli = morutcli,
  codcli = mocodcli,
  Moneda = mocodmon,
  linea_total = ISNULL( TotalOcupado , 0 ) ,
  forma_pago  = ISNULL( ( SELECT glosa FROM forma_de_pago,view_memo WHERE numoper = monumope AND morecib= codigo ) , '' )
 FROM view_memo 
     LEFT JOIN linea_general ON morutcli = Rut_Cliente AND mocodcli = Codigo_Cliente
 WHERE numoper = monumope    
 AND Sistema = 'BCC'
 UPDATE #temp1
 SET rutcli = cacodigo,
  codcli = cacodcli,
  moneda = mnnemo,
  linea_total = ISNULL( TotalOcupado , 0 ) ,
  forma_pago  = ISNULL( ( SELECT glosa FROM forma_de_pago,view_mfca WHERE numoper = canumoper AND cafpagomn = codigo ) , '' )
 FROM view_mfca 
	  LEFT JOIN linea_general ON cacodigo = Rut_Cliente AND  cacodcli = Codigo_Cliente
    , moneda    
 WHERE numoper = canumoper AND
  mncodmon = cacodmon1    AND 
  Sistema = 'BFW'
 UPDATE #temp1
 SET pendiente = 'S'
 FROM view_mdmo
 WHERE Sistema   = 'BTR'
 AND monumoper = numoper
 AND mostatreg = 'P'
 UPDATE #temp1
 SET pendiente = 'N'
 FROM view_mdmo
 WHERE Sistema = 'BTR'
 AND monumoper = numoper
 AND mostatreg = 'R'
 UPDATE #Temp1
 SET pendiente = 'S'
 FROM view_memo
 WHERE Sistema='BCC' AND CONVERT(NUMERIC(10),monumope)=numoper AND
  moestatus='P'
 UPDATE #Temp1
 SET pendiente = 'N'
 FROM view_memo
 WHERE Sistema='BCC' AND CONVERT(NUMERIC(10),monumope)=numoper AND
  moestatus='R'
 UPDATE #Temp1
 SET pendiente = 'S'
 FROM view_mfca
 WHERE Sistema='BFW' AND CONVERT(NUMERIC(10),canumoper)=numoper AND
  caestado='P'
 UPDATE #Temp1
 SET pendiente = 'N'
 FROM view_mfca
 WHERE Sistema='BFW' AND CONVERT(NUMERIC(10),canumoper)=numoper AND
  caestado='R'
 UPDATE #temp1
 SET cliente = LEFT(clnombre,50)
 FROM cliente
 WHERE clrut  = rutcli
 AND clcodigo = codcli
 SELECT Sistema  ,
  Glo_Producto ,
  numoper  ,
  cliente  ,
  Monto  ,
  Operador ,
  ErrorG  ,
  Moneda  ,
  Plazo  ,
  linea_total ,
  Forma_Pago ,
  fecha  ,
  fecha_sistema   
 FROM #temp1
 WHERE pendiente = 'S'
 AND  (Sistema = @ID OR @ID = ' ')
 ORDER BY Sistema ,
   numoper
 SET NOCOUNT OFF
END
-- SELECT * FROM LINEA_TRANSACCION where Id_Sistema = 'BFW' and NumeroOperacion = 28989
-- SELECT * FROM LINEA_TRANSACCION_DETALLE where Id_Sistema = 'BFW' and NumeroOperacion = 28989
-- SELECT * FROM LINEA_TRANSACCION_DETALLE
-- SELECT * FROM VIEW_MFca
-- SELECT * FROM PARAMTROS
-- SELECT * FROM LIMITE_TRANSACCION
-- SELECT MOESTADO,* FROM VIEW_MFMO
-- SELECT MOSTATREG,* FROM VIEW_MDMO
-- SELECT MORUTCLI,MOCODCLI,MOTIPOPER,MONUMOPER FROM VIEW_MDMO
-- SELECT MOSTATREG,MONUMOPER,MOINSTSER FROM VIEW_MDMO
-- EXECUTE SP_LINEAS_LEEROPPENDIENTES '20010628'
-- EXECUTE SP_LINEAS_AUTORIZA 'BCC', 46232
-- EXECUTE SP_LINEAS_LEEROPPENDIENTES
-- SP_HELP
-- SP_HELP VIEW_MFMO
-- SP_LINEAS_LEEROPPENDIENTES '20010628' ,'BCC'
-- select * from moneda
-- select * from view_mfmo
-- EXECUTE Sp_Lineas_LeerOpPendientes '20011120', ' '

GO
