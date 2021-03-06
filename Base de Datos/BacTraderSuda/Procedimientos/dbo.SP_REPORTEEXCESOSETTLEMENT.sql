USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTEEXCESOSETTLEMENT]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_REPORTEEXCESOSETTLEMENT]
AS
BEGIN
 DECLARE @Cont     INTEGER
 DECLARE @TotReg     INTEGER
 DECLARE @RutCliente NUMERIC(10)
 DECLARE @Codigo     NUMERIC(05)
 DECLARE @Dolar      FLOAT
 DECLARE @Dia3     FLOAT
 DECLARE @Dia4     FLOAT
 DECLARE @Sistema    CHAR(3)
 SELECT @Dolar = vmvalor from VIEW_VALOR_MONEDA, mdac where vmfecha = acfecproc AND
            vmcodigo =988
 IF @Dolar = 0 OR @Dolar IS NULL
  SELECT @Dolar = 1
 SELECT distinct 'Rut_Grupo'=CONVERT(CHAR(12),Rut),
   'Nombre_Grupo'=Space(50)  ,
   'Rut'= CONVERT(CHAR(12),Rut) ,
   'Nombre'=Space(50)   ,
   'Sistema'=CASE productos WHEN 'BCC' THEN 'FX Spot' 
       WHEN 'BTR' THEN 'Securities' END,
   'Riesgo'=Space(5)   ,
   'Operacion'=Space(50)   ,
   'Dia0'= dia0_ocupado   ,
   'Dia1'= dia1_ocupado   ,
   'Dia2'= dia2_ocupado   ,
   'Dia3'= dia3_ocupado   ,
   'DiaN'= dia4_ocupado   ,
   'Rut_Cliente'=Rut   ,
   'Monto_Aprobado'=monto_asignado  ,
   'Codigo'=Codigo    ,
   'Producto'=productos
   INTO #ExcesoSettle
   FROM MD_SETTLEMENT
   WHERE (monto_asignado - dia0_ocupado) < 0
                 AND rut  <> 97029000 
 SELECT @Cont = 1
 SELECT @TotReg = COUNT(*) FROM #ExcesoSettle
 WHILE @Cont <= @TotReg
 BEGIN
  SET ROWCOUNT @Cont
   
  SELECT  @RutCliente = Rut_Cliente ,
   @Codigo  = Codigo ,
   @Sistema = Producto
    FROM #ExcesoSettle         
   ORDER BY rut_cliente
  
  SET ROWCOUNT  0
  
  SELECT @Cont = @Cont + 1
  SELECT @Dia3 = 0.0
  SELECT @Dia4 = 0.0
    
  IF @Sistema = 'BCC'
     EXECUTE SP_VCTOS_FWD_SETTLEMENT @RutCliente  ,
         @Codigo  ,
         @Dia3 OUTPUT ,
         @Dia4 OUTPUT
  UPDATE #ExcesoSettle SET dia3 = @Dia3  ,
      diaN = @Dia4  
      WHERE Rut_Cliente = @RutCliente AND
       Codigo  = @Codigo
  UPDATE #ExcesoSettle SET rut      = RTRIM(CONVERT(CHAR(09),clrut)) + '/' + RTRIM(CONVERT(CHAR(03),clcodigo)),
      rut_grupo = RTRIM(CONVERT(CHAR(09),clrut)) + '/' + RTRIM(CONVERT(CHAR(03),clcodigo)),
      nombre = clnombre , 
             riesgo = rtrim(isnull(CLCRF,''))+ '/' +rtrim(isnull(CLERF,'')),     
      nombre_grupo = clnombre
      FROM VIEW_CLIENTE_RELACIONADO 
      WHERE  clrut = rut_cliente  AND
       clrut = @RutCliente
 
  UPDATE #ExcesoSettle SET Rut_Grupo  = RTRIM(CONVERT(CHAR(09),clrut)) + '/' + RTRIM(CONVERT(CHAR(03),clcodigo)),
      Nombre_Grupo  = clnombre 
     FROM  VIEW_CLIENTE_RELACIONADO, VIEW_CLIENTE
     WHERE VIEW_CLIENTE_relacionado.clrut_hijo = @RutCliente AND
           VIEW_CLIENTE_relacionado.clrut_padre= VIEW_CLIENTE.clrut  AND
           #ExcesoSettle.Rut_Cliente      = @RutCliente
 END
 SELECT  rut_grupo  ,
  nombre_grupo  ,
  rut   ,
  nombre   ,
  riesgo   ,
  #excesosettle.operacion ,
  dia0/1000  ,
  dia1/1000  ,
  dia2/1000  ,
  dia3 /1000  ,
  dian /1000  ,
  monto_aprobado/1000 ,
  sistema
  FROM #ExcesoSettle
  WHERE ((monto_aprobado - dia0 < 0) OR (monto_aprobado - dia1 < 0) OR (monto_aprobado - dia2 < 0) or (monto_aprobado - dia3 < 0) or (monto_aprobado - dian < 0))
END
--Sp_ReporteExcesoSettlement


GO
