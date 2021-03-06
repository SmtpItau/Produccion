USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTESETTLEMENT]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_REPORTESETTLEMENT]
AS
BEGIN
 DECLARE @Cont  INTEGER
 DECLARE @TotReg  INTEGER
 DECLARE @RutCliente  NUMERIC(10)
 DECLARE @Codigo  NUMERIC(5)
 DECLARE @Sistema CHAR(3)
 DECLARE @Dolar   FLOAT
 DECLARE @Dia3  FLOAT   
 DECLARE @Dia4  FLOAT
 DECLARE @Fec_Prox       DATETIME
 DECLARE @Fec_Prox10 DATETIME
 SELECT @Dolar = vmvalor FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA, MDAC WHERE vmfecha = acfecproc AND vmcodigo = 988
        IF @Dolar = 0.0 OR @Dolar = NULL
           SELECT @Dolar = 1.0
 /* Busca vctos. de forward ---------------------------------------- */
 CREATE TABLE #Forward( rut_cliente  NUMERIC(10) NULL DEFAULT 0 ,
                               codigo       NUMERIC(5)  NULL DEFAULT 0 ,
                               dia3         FLOAT       NULL DEFAULT 0 ,
                               dia4         FLOAT       NULL DEFAULT 0 )
 SELECT @Fec_Prox = ACFECPROX FROM VIEW_MFAC
 SELECT @Fec_Prox10 = DATEADD(day, 10, @Fec_Prox)
 INSERT #Forward( rut_cliente,
                  codigo,
                  dia3,
                  dia4 )
           SELECT cacodigo,
                  cacodcli,
                  ISNULL(SUM(CASE WHEN CAFECVCTO = @Fec_Prox THEN CAEQUUSD1 ELSE 0.0 END),0.0),
                  ISNULL(SUM(CASE WHEN CAFECVCTO > @Fec_Prox AND CAFECVCTO <= @Fec_Prox10 THEN CAEQUUSD1 ELSE 0.0 END),0.0)
             FROM VIEW_MFCA, VIEW_CLIENTE
     WHERE VIEW_CLIENTE.clrut         = cacodigo
       AND VIEW_CLIENTE.clcodigo      = cacodcli
       AND VIEW_CLIENTE.clvalidalinea = 'S'
            GROUP BY cacodigo, cacodcli
 DELETE #Forward WHERE Dia3 = 0 AND Dia4 = 0
 /* Busca lineas settlement ocupadas ------------------------------- */
 SELECT DISTINCT 'rut_grupo' =CONVERT(CHAR(12),rut) ,
   'nombre_grupo' =SPACE(50)  ,
   'rut'= CONVERT(CHAR(12),rut)  ,
   'nombre' =SPACE(50)   ,
   'riesgo' =SPACE(5)   ,
   'operacion' =SPACE(50)   ,
   'dia0'= CONVERT(FLOAT,0.0)  ,
   'dia1'= CONVERT(FLOAT,0.0)  ,
   'dia2'= CONVERT(FLOAT,0.0)  ,
   'dia3'= CONVERT(FLOAT,0.0)  ,
   'dian'= CONVERT(FLOAT,0.0)  ,
   'rut_cliente' =rut   ,
   'monto_aprobado' =monto_asignado  ,
   'sistema' =productos   ,
   'producto' =SPACE(10)   ,
   'codigo' =Codigo
   INTO #Settle
   FROM MD_SETTLEMENT
                       WHERE (Dia0_Ocupado + Dia1_Ocupado + Dia2_Ocupado) > 0
           AND rut  <> 97029000 
 SELECT @Cont = 1
 SELECT @TotReg = COUNT(*) FROM #Settle 
 WHILE @Cont <= @TotReg
 BEGIN
  SET ROWCOUNT @Cont
   
  SELECT  @RutCliente = Rut_Cliente ,
   @Codigo     = Codigo  ,
   @Sistema    = Sistema
    FROM #Settle
   ORDER BY rut_cliente
  
  SET ROWCOUNT  0
  SELECT @Cont = @Cont + 1
    
  UPDATE #Settle SET  dia0 = dia0_ocupado  ,
     dia1 = dia1_ocupado  ,
     dia2 = dia2_ocupado  
     FROM MD_SETTLEMENT
       WHERE rut_cliente = MD_SETTLEMENT.rut AND
      sistema     = MD_SETTLEMENT.productos
  UPDATE #Settle SET Producto = CASE Sistema WHEN 'BCC' THEN 'FX SPOT' 
          WHEN 'BTR' THEN 'SECURITIES' END
 END
 /* Une lineas settlement ocupadas con operaciones forward --------- */
 
 SELECT @Cont = 1
 SELECT @TotReg = COUNT(*) FROM #Forward
 WHILE @Cont <= @TotReg
 BEGIN
  SET ROWCOUNT @Cont
   
  SELECT  @RutCliente = Rut_Cliente,
   @Codigo     = Codigo,
   @Dia3     = Dia3,
   @Dia4     = Dia4
  FROM #Forward
  SET ROWCOUNT  0
  SELECT @Cont = @Cont + 1
  IF EXISTS(SELECT * FROM #Settle WHERE Rut_Cliente = @RutCliente AND Codigo = @Codigo AND Sistema = 'BCC')
      UPDATE #Settle SET Dia3 = @Dia3, DiaN = @Dia4 WHERE Rut_Cliente = @RutCliente AND Codigo = @Codigo AND Sistema = 'BCC'
  ELSE
                   INSERT #Settle( rut_grupo,
              nombre_grupo,
              rut,
              nombre,
              riesgo,
              operacion,
              dia0,
              dia1,
              dia2,
              dia3,
              dian,
              rut_cliente,
              monto_aprobado,
              sistema,
              producto,
              codigo )
                           VALUES( CONVERT(CHAR(12),@RutCliente),
              SPACE(50),
              CONVERT(CHAR(12),@RutCliente),
              SPACE(50),
              SPACE(5),
              SPACE(50),
              CONVERT(FLOAT,0.0),
              CONVERT(FLOAT,0.0),
              CONVERT(FLOAT,0.0),
                     @Dia3,
              @Dia4,
       @RutCliente,
       0.0,
       'BCC',
       'FX SPOT',
       @Codigo )
 END
 UPDATE #Settle SET  rut      = RTRIM(CONVERT(CHAR(09),clrut)) + '/' + RTRIM(CONVERT(CHAR(03),clcodigo)),
    rut_grupo = RTRIM(CONVERT(CHAR(09),clrut)) + '/' + RTRIM(CONVERT(CHAR(03),clcodigo)),
    nombre = clnombre , 
    riesgo = rtrim(isnull(CLCRF,''))+ '/' +rtrim(isnull(CLERF,'')),
    nombre_grupo = clnombre
    FROM VIEW_CLIENTE
    WHERE clrut = #Settle.Rut_Cliente
 
 UPDATE #Settle SET  rut_grupo = RTRIM(CONVERT(CHAR(09),clrut)) + '/' + RTRIM(CONVERT(CHAR(03),clcodigo)),
    nombre_grupo = clnombre 
   FROM VIEW_CLIENTE_relacionado, VIEW_CLIENTE 
   WHERE VIEW_CLIENTE_relacionado.CLRUT_HIJO  = #Settle.Rut_Cliente AND
          VIEW_CLIENTE_relacionado.CLRUT_PADRE = VIEW_CLIENTE.CLRUT
 SELECT  rut_grupo  ,
  nombre_grupo  ,
  rut   ,
  nombre   ,
  riesgo   ,
  operacion  ,
  dia0 /1000         ,
  dia1 /1000         ,
  dia2 /1000         ,
  dia3 /1000         ,
  dian /1000         ,
  monto_aprobado/1000 ,
  producto
  FROM #Settle
END
--Sp_ReporteSettlement


GO
