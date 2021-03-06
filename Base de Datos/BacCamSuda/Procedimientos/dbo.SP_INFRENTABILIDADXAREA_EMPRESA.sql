USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFRENTABILIDADXAREA_EMPRESA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFRENTABILIDADXAREA_EMPRESA]
     ( @Fecha_Inicio  DATETIME ,
      @Fecha_Termino  DATETIME ,
      @Dolar   FLOAT )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @Hora_Proceso CHAR(08)
 SELECT @Hora_Proceso  = CONVERT(CHAR(08),GETDATE(),108)
 SELECT  'Fecha_Proceso'  = mofech    ,
  'Rut_Cliente'  = morutcli    ,
  'Digito_ver'  = cldv     ,
  'Nombre_Cliente' = clnombre    ,
  'Producto'  = '88111'    ,
  'Utili'   = CONVERT(FLOAT,0)   ,
  'Signo'   = SPACE(1)    ,
  'Remunera'  = CONVERT(FLOAT,0)   , --valor absoluto de utili, largo 15 con ceros,
  'Filler'  = SPACE(4)        ,
  'Monto_ComprasUSD' = CASE  WHEN mocodmon =  'USD' AND motipope = 'C'    THEN ( motctra-moticam )*moussme/@Dolar
         WHEN mocodmon <> 'USD' AND motipope = 'C' AND mocodcnv = 'CLP' THEN ( motctra-moticam )*moussme/@Dolar 
        ELSE 0 
       END ,
  'Monto_VentasUSD' = CASE  WHEN mocodmon =  'USD' AND motipope = 'V'    THEN ( moticam-motctra )*moussme/@Dolar
         WHEN mocodmon <> 'USD' AND motipope = 'V' AND mocodcnv = 'CLP' THEN ( moticam-motctra )*moussme/@Dolar 
        ELSE 0 
       END ,
  'Monto_ComprasMX' = CASE  WHEN mocodmon <> 'USD' AND motipope = 'C' AND mnrrda = 'D' THEN ( ( (1/mopartr)-(1/moparme) )* momonmo )
      WHEN mocodmon <> 'USD' AND motipope = 'C' AND mnrrda = 'M' THEN ( ( mopartr - moparme )* momonmo )
      ELSE 0 
       END ,
  'Monto_VentasMX' = CASE  WHEN mocodmon <> 'USD' AND motipope = 'V' AND mnrrda = 'D' THEN ( ( (1/moparme)-(1/mopartr) )* momonmo )
      WHEN mocodmon <> 'USD' AND motipope = 'V' AND mnrrda = 'M' THEN ( ( moparme - mopartr ) * momonmo )
      ELSE 0 
       END ,
        'Tipo_Cambio'  = ISNULL( MOTICAM, 0 )  ,
  'Tasa_Contrato'  = ISNULL( MOTCTRA, 0 )  ,
  'MoParTr'  = ISNULL( MOPARTR, 0 )  ,
  'MoParMe'  = ISNULL( MOPARME, 0 )  ,
  'Monto_en_Dolares' = ISNULL( MOUSSME, 0 )  ,
  'Monto_en_Moneda' = ISNULL( MOMONMO, 0 )  ,
  'Tipo_Operacion' = motipope  ,
  'Codigo_Moneda'  = mocodmon  ,
  'Codigo_Cnv'  = mocodcnv
 INTO #Temporal
 FROM  memo  ,
  view_cliente ,
  view_moneda
 WHERE   (morutcli = clrut  AND
  mocodcli = clcodigo ) AND
  motipmer = 'EMPR' AND
  moestatus <> 'A'  AND
  moestatus <> 'P'  AND
  mnnemo = mocodmon AND
  mofech >= @Fecha_Inicio AND
  mofech <= @fecha_termino
   
 INSERT #TEMPORAL
 SELECT  'Fecha_Proceso'  = mofech    ,
  'Rut_Cliente'  = morutcli    ,
  'Digito_ver'  = cldv     ,
  'Nombre_Cliente' = clnombre    ,
  'Producto'  = '88111'    ,
  'Utili'   = CONVERT(FLOAT,0)   ,
  'Signo'   = SPACE(1)    ,
  'Remunera'  = CONVERT(FLOAT,0)   , --valor absoluto de utili, largo 15 con ceros,
  'Filler'  = SPACE(4)        ,
  'Monto_ComprasUSD' = CASE  WHEN mocodmon =  'USD' AND motipope = 'C'    THEN ( motctra-moticam )*moussme/@Dolar
         WHEN mocodmon <> 'USD' AND motipope = 'C' AND mocodcnv = 'CLP' THEN ( motctra-moticam )*moussme/@Dolar 
        ELSE 0 
       END ,
  'Monto_VentasUSD' = CASE  WHEN mocodmon =  'USD' AND motipope = 'V'    THEN ( moticam-motctra )*moussme/@Dolar
         WHEN mocodmon <> 'USD' AND motipope = 'V' AND mocodcnv = 'CLP' THEN ( moticam-motctra )*moussme/@Dolar 
        ELSE 0 
       END ,
  'Monto_ComprasMX' = CASE  WHEN mocodmon <> 'USD' AND motipope = 'C' AND mnrrda = 'D' THEN ( ( (1/mopartr)-(1/moparme) )* momonmo ) 
      WHEN mocodmon <> 'USD' AND motipope = 'C' AND mnrrda = 'M' THEN ( ( mopartr - moparme ) * momonmo ) 
      ELSE 0 
       END ,
  'Monto_VentasMX' = CASE  WHEN mocodmon <> 'USD' AND motipope = 'V' AND mnrrda = 'D' THEN ( ( (1/moparme)-(1/mopartr) )* momonmo ) 
      WHEN mocodmon <> 'USD' AND motipope = 'V' AND mnrrda = 'M' THEN ( ( moparme - mopartr ) * momonmo ) 
      ELSE 0 
       END ,
        'Tipo_Cambio'  = ISNULL( MOTICAM, 0 )  ,
  'Tasa_Contrato'  = ISNULL( MOTCTRA, 0 )  ,
  'MoParTr'  = ISNULL( MOPARTR, 0 )  ,
  'MoParMe'  = ISNULL( MOPARME, 0 )  ,
  'Monto_en_Dolares' = ISNULL( MOUSSME, 0 )  ,
  'Monto_en_Moneda' = ISNULL( MOMONMO, 0 )  ,
  'Tipo_Operacion' = motipope  ,
  'Codigo_Moneda'  = mocodmon  ,
  'Codigo_Cnv'  = mocodcnv
 FROM  memoh  ,
  view_cliente ,
  view_moneda
 WHERE  ( mofech >= @Fecha_Inicio
  AND    mofech <= @Fecha_Termino )
  AND    (morutcli = clrut
  AND    mocodcli = clcodigo  )
  AND mnnemo = mocodmon 
  AND motipmer = 'EMPR' 
  AND moestatus <> 'A'  
  AND moestatus <> 'P'  
 UPDATE  #TEMPORAL 
  SET  Monto_ComprasUSD = Monto_ComprasUSD * @Dolar /2 ,
  Monto_VentasUSD  = Monto_VentasUSD  * @Dolar /2 ,
  Monto_ComprasMX = Monto_ComprasMX  * @Dolar /2 ,
  Monto_VentasMX   = Monto_VentasMX   * @Dolar /2 
 SELECT  'Fecha_Proceso'  = CONVERT(CHAR(04),DATEPART(year,Fecha_Proceso)) + CASE WHEN DATEPART(month,Fecha_Proceso) < 10 THEN '0' + RTRIM(CONVERT(CHAR(02),DATEPART(month,Fecha_Proceso))) ELSE RTRIM(CONVERT(CHAR(02),DATEPART(month,Fecha_Proceso))) END,
  Rut_Cliente       ,
  Digito_ver       ,
  Nombre_Cliente       ,
  Producto       ,
  'signo'   = SPACE(1)    ,
  'Remuneracion'  = ((ISNULL(SUM(Monto_ComprasUSD),0)+ISNULL(SUM(Monto_ComprasMX),0)+ISNULL(SUM(Monto_VentasUSD),0)+ISNULL(SUM(Monto_VentasMX),0))),
  Filler
 INTO #TEMPORAL1
 FROM #TEMPORAL
 GROUP BY Fecha_Proceso ,
   Rut_Cliente   ,
   Digito_ver    ,
   Nombre_Cliente ,
   producto      ,
   filler
 ORDER BY Nombre_Cliente
 SET NOCOUNT OFF  
 SELECT  Fecha_Proceso  ,
  Rut_Cliente  ,
  Digito_ver  ,
  Nombre_Cliente  ,
  Producto  , 
  Signo = CASE WHEN SUM(Remuneracion) >= 0 THEN '+' ELSE '-' END ,
  ABS(SUM(Remuneracion))
 FROM  #TEMPORAL1
 GROUP BY Fecha_Proceso ,
   Rut_Cliente   ,
   Digito_ver    ,
   Nombre_Cliente ,
   producto      ,
   filler  ,  
   signo
 ORDER BY Nombre_Cliente
END

GO
