USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZRENTABILIDAD]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZRENTABILIDAD](  @dDesde  CHAR(8)  ,
      @dHasta  CHAR(8)  ,
      @nDolarObs  FLOAT
     )
AS
BEGIN
SET NOCOUNT ON
DECLARE @dFecproc     AS DATETIME
DECLARE @nregs        AS INT
DECLARE @ncont        AS INT
DECLARE @nMonto       AS NUMERIC(12,2) 
DECLARE @nMonto1      AS NUMERIC(12,2) 
DECLARE @nMontoTot    AS NUMERIC(18,2) 
DECLARE @nCDia        AS INT
DECLARE @dInicio      AS DATETIME
DECLARE @dVcto        AS DATETIME
DECLARE @nProd        AS NUMERIC(2,0)
DECLARE @nCodM        AS NUMERIC(3,0)
DECLARE @nPorcentaje  AS NUMERIC(3,0)
DECLARE @nTasLin      AS NUMERIC(10,4)  
DECLARE @nDia         AS NUMERIC(2)  
DECLARE @numoper      AS NUMERIC(10) 
declare  @entidad    char(40) 
declare @nPro numeric(19)
SELECT  @dFecproc = ( SELECT acfecproc FROM mfac )
SELECT  @entidad= ( SELECT acnomprop FROM mfac )
----------------------------------------- Cartera Vigente --------------------------------------------------
SELECT 'Numero' =b.CANUMOPER, 
       'Numdia' =CASE WHEN caantici='A' and b.cafecha <= @dDesde  and b.cafecvenor > @dHasta  THEN DATEDIFF(dd,@dDesde,b.cafecvenor)
                      WHEN caantici='A' and b.cafecha > @dDesde  and b.cafecvenor > @dHasta   THEN DATEDIFF(dd,b.cafecha,b.cafecvenor)                        
                      WHEN caantici='A' and b.cafecha <= @dDesde  and b.cafecvenor <= @dHasta THEN DATEDIFF(dd,@dDesde,b.cafecvenor)                        
                      WHEN caantici='A' and b.cafecha > @dDesde  and b.cafecvenor <= @dHasta  THEN DATEDIFF(dd,b.cafecha,b.cafecvenor)
                      WHEN b.cafecha <= @dDesde and b.cafecvcto <= @dHasta  THEN DATEDIFF(dd,@dDesde,b.cafecvcto)
                      WHEN b.cafecha > @dDesde  and b.cafecvcto <= @dHasta  THEN DATEDIFF(dd,b.cafecha,b.cafecvcto)
                      WHEN b.cafecha <= @dDesde  and b.cafecvcto > @dHasta  THEN DATEDIFF(dd,@dDesde,@dHasta)+1
                      WHEN b.cafecha > @dDesde  and  b.cafecvcto > @dHasta  THEN DATEDIFF(dd,b.cafecha,@dHasta)+1
                      ELSE 0 END,       
       'LinDia'=CASE  WHEN caantici='A' and b.cafecha <= @dDesde and b.cafecvenor > @dHasta THEN DATEDIFF(dd,@dDesde,b.cafecvcto)
                      WHEN caantici='A' and b.cafecha > @dDesde  and b.cafecvenor > @dHasta THEN DATEDIFF(dd,b.cafecha,b.cafecvcto) 
                      WHEN caantici='A' and b.cafecha <= @dDesde and b.cafecvenor<= @dHasta THEN DATEDIFF(dd,@dDesde,b.cafecvcto)                        
                      WHEN caantici='A' and b.cafecha > @dDesde  and b.cafecvenor <= @dHasta  THEN DATEDIFF(dd,b.cafecha,b.cafecvcto)                        
                      WHEN b.cafecha <= @dDesde  and b.cafecvcto <= @dHasta THEN DATEDIFF(dd,@dDesde,b.cafecvcto)
                      WHEN b.cafecha > @dDesde  and b.cafecvcto <= @dHasta  THEN DATEDIFF(dd,b.cafecha,b.cafecvcto)
                      WHEN b.cafecha <= @dDesde  and b.cafecvcto > @dHasta  THEN DATEDIFF(dd,@dDesde,@dHasta)+1
                      WHEN b.cafecha > @dDesde  and  b.cafecvcto > @dHasta  THEN DATEDIFF(dd,b.cafecha,@dHasta)+1
                      ELSE 0 END,       
        'MontoOcu'  = CASE WHEN b.cacodpos1 = 2 THEN b.camtomon2
      ELSE b.camtomon1 
        END ,
        'TasaLin'   = CASE WHEN b.caremunera_linea <> 0 THEN (b.caremunera_linea/100) ELSE 0 END,
        'ValSpread' = CASE WHEN b.caspread <> 0 THEN (b.caspread /b.caplazo ) ELSE 0 END     ,
        'Producto'  = CASE WHEN (b.cacodpos1=1 or  b.cacodpos1=7 ) and cacodmon2= 999 THEN '33105'
                           WHEN (b.cacodpos1=1 or  b.cacodpos1=7 ) and cacodmon2= 998 THEN '33205'
                           WHEN (b.cacodpos1=2) THEN '33405' ELSE '00000' END,       
        'Rut'       = c.clrut,    
        'Dig'       = c.cldv ,
        'Nombre'    = LEFT(c.clnombre,40),
        'Inicio'    = b.cafecha,
        'vcto'      = b.cafecvcto,
        'CodPro'    = b.cacodpos1,
        'CodMon1'   = b.cacodmon1
INTO #tmp
FROM  mfca b , view_cliente c
WHERE ( b.cacodpos1=1 or b.cacodpos1=7 or b.cacodpos1=2 ) AND    
      ( b.cacodigo=c.clrut and b.cacodcli= c.clcodigo) and 
        c.clpais=6 and 
      ( c.cltipcli<>1 and c.cltipcli<>2 ) and  
      @dFecproc<>b.cafecvcto and
      ( (b.cafecha <= @dDesde  and b.cafecvcto >= @dHasta) or 
        (b.cafecha <= @dDesde  and b.cafecvcto >= @dDesde) or
        (b.cafecha >= @dDesde  and b.cafecha <= @dHasta)       )
-- Cartera Vencida --------------------------------------------------
SELECT 'Numero' =b.CANUMOPER, 
       'Numdia' =CASE WHEN caantici='A' and b.cafecha <= @dDesde  and b.cafecvenor > @dHasta  THEN DATEDIFF(dd,@dDesde,b.cafecvenor)
                      WHEN caantici='A' and b.cafecha > @dDesde  and b.cafecvenor > @dHasta   THEN DATEDIFF(dd,b.cafecha,b.cafecvenor)                        
                      WHEN caantici='A' and b.cafecha <= @dDesde  and b.cafecvenor <= @dHasta THEN DATEDIFF(dd,@dDesde,b.cafecvenor)                        
                      WHEN caantici='A' and b.cafecha > @dDesde  and b.cafecvenor <= @dHasta  THEN DATEDIFF(dd,b.cafecha,b.cafecvenor)
                      WHEN b.cafecha <= @dDesde and b.cafecvcto <= @dHasta  THEN DATEDIFF(dd,@dDesde,b.cafecvcto)
                      WHEN b.cafecha > @dDesde  and b.cafecvcto <= @dHasta  THEN DATEDIFF(dd,b.cafecha,b.cafecvcto)
                      WHEN b.cafecha <= @dDesde  and b.cafecvcto > @dHasta  THEN DATEDIFF(dd,@dDesde,@dHasta)+1
                      WHEN b.cafecha > @dDesde  and  b.cafecvcto > @dHasta  THEN DATEDIFF(dd,b.cafecha,@dHasta)+1
                      ELSE 0 END,       
       'LinDia'=CASE  WHEN caantici='A' and b.cafecha <= @dDesde and b.cafecvenor > @dHasta THEN DATEDIFF(dd,@dDesde,b.cafecvcto)
                      WHEN caantici='A' and b.cafecha > @dDesde  and b.cafecvenor > @dHasta THEN DATEDIFF(dd,b.cafecha,b.cafecvcto) 
                      WHEN caantici='A' and b.cafecha <= @dDesde and b.cafecvenor<= @dHasta THEN DATEDIFF(dd,@dDesde,b.cafecvcto)                        
                      WHEN caantici='A' and b.cafecha > @dDesde  and b.cafecvenor <= @dHasta  THEN DATEDIFF(dd,b.cafecha,b.cafecvcto)                        
                      WHEN b.cafecha <= @dDesde  and b.cafecvcto <= @dHasta THEN DATEDIFF(dd,@dDesde,b.cafecvcto)
                      WHEN b.cafecha > @dDesde  and b.cafecvcto <= @dHasta  THEN DATEDIFF(dd,b.cafecha,b.cafecvcto)
                      WHEN b.cafecha <= @dDesde  and b.cafecvcto > @dHasta  THEN DATEDIFF(dd,@dDesde,@dHasta)+1
                      WHEN b.cafecha > @dDesde  and  b.cafecvcto > @dHasta  THEN DATEDIFF(dd,b.cafecha,@dHasta)+1
                      ELSE 0 END,       
        'MontoOcu'  = CASE WHEN b.cacodpos1 = 2 THEN b.camtomon2
      ELSE b.camtomon1 
        END ,
        'TasaLin'   = CASE WHEN b.caremunera_linea <> 0 THEN (b.caremunera_linea/100) ELSE 0 END,
        'ValSpread' = CASE WHEN b.caspread <> 0 THEN (b.caspread /b.caplazo ) ELSE 0 END     ,
        'Producto'  = CASE WHEN (b.cacodpos1=1 or  b.cacodpos1=7 ) and cacodmon2= 999 THEN '33105'
                           WHEN (b.cacodpos1=1 or  b.cacodpos1=7 ) and cacodmon2= 998 THEN '33205'
                           WHEN (b.cacodpos1=2) THEN '33405' ELSE '00000' END,       
        'Rut'       = c.clrut,    
        'Dig'       = c.cldv ,
        'Nombre'    = LEFT(c.clnombre,40),
        'Inicio'    = b.cafecha,
        'vcto'      = b.cafecvcto,
        'CodPro'    = b.cacodpos1,
        'CodMon1'   = b.cacodmon1
INTO #tmp1
FROM  mfcah b , view_cliente c
WHERE ( b.cacodpos1=1 or b.cacodpos1=7 or b.cacodpos1=2 ) AND    
      ( b.cacodigo=c.clrut and b.cacodcli= c.clcodigo) and 
        c.clpais=6 and 
      ( c.cltipcli<>1 and c.cltipcli<>2 ) and  
      @dFecproc<>b.cafecvcto and
      ( (b.cafecha <= @dDesde  and b.cafecvcto >= @dHasta) or 
        (b.cafecha <= @dDesde  and b.cafecvcto >= @dDesde) or
        (b.cafecha >= @dDesde  and b.cafecha <= @dHasta)       )
----------------- Se Une la Cartera Vigente y la Cartera Vencida -----------------------------
SELECT  * 
INTO  #tmp3
FROM  #tmp
INSERT INTO   #tmp3
SELECT * FROM #tmp1
SELECT 'Fecha'= CONVERT(DATETIME,'19000101' ),
       'MontoAfe' = 10000000000.00,
       'Dias'     = 1,
       'Porc'     = 100
INTO #tmpdias
------------------------ Proceso de Recalculo de los Montos de las Líneas de Acuerdo al Tramo ----------------
DELETE #tmpdias
SELECT @nregs = COUNT(*) FROM #tmp3
SELECT @ncont = 1
WHILE @ncont <= @nregs   BEGIN  
   SET ROWCOUNT @ncont
       SELECT @nMonto  = MontoOcu,
              @dInicio = Inicio  ,
              @dVcto   = Vcto    ,
              @nProd   = CodPro  ,
              @nCodM   = CodMon1 ,
              @nTasLin = TasaLin ,
              @nDia    = 0  ,
       @numoper = Numero
 FROM #tmp3
   SET ROWCOUNT 0
   /*Segundo clicli */    
   SELECT @nCDia    = 0
   DELETE #tmpdias  
   SELECT @nMontoTot=0
   WHILE DATEDIFF(dd,@dDesde,@dHasta) >=@nCDia  BEGIN
         SELECT @nPorcentaje=ISNULL((SELECT porcentaje FROM VIEW_MATRIZ_RIESGO WHERE  DATEDIFF(DAY,DATEADD(DAY,@nCDia,@dDesde),@dVcto )>=diasdesde and datediff(day,dateadd(day,@nCDia,@dDesde),@dVcto )<=diashasta and moneda=@nCodM and codigo_producto=@nProd ),100)
         SELECT @nDia  = 1
         SELECT @nMonto1=(@nMonto*@nporcentaje)/100
         SELECT @nMonto1=ISNULL( @nMonto1 *( @nTasLin * @nDia/360 ),0)
         INSERT INTO  #tmpdias  VALUES (DATEADD(DAY,@nCDia,@dDesde),@nMonto1 ,@ndia , @nPorcentaje)                                   
         SELECT @nCDia=@nCDia+1
         SELECT @nMontoTot=@nMontoTot+@nMonto1
   END
 UPDATE  #tmp3 
 SET  MontoOcu = @nMontoTot     ,
  ValSpread = ISNULL( ( ValSpread * NumDia ) , 0 ) 
 WHERE  @numoper = Numero
    
   /*Termino Ciclo */    
   SELECT @ncont = @ncont + 1
   
END   
SELECT  'Fecha'        = SPACE(06)      ,
        'RutCli'       = Rut       ,
        'DigCli'       = Dig       ,
        'NomCli'       = Nombre      ,
        'Producto'     = Producto      ,
        'Monto'        = SUM( ROUND((MontoOcu*@nDolarObs) + ValSpread,0) ) ,
        'Remunera'     = 0       ,
        'Signo'        = SPACE(01)      ,
        'Filler'       = SPACE(04)      ,
  'RemuneraUSD'   = SUM( MontoOcu )     ,
  'RemuneraCLP'  = SUM( ROUND( MontoOcu*@nDolarObs , 0 ) )  ,
  'Utilidad'  = SUM( ValSpread )     ,
  'desde'   = CONVERT(CHAR(10),CONVERT(DATETIME,@dDesde),103) ,
  'hasta'   = CONVERT(CHAR(10),CONVERT(DATETIME,@dHasta),103) ,
  'observado'  = @nDolarObs      ,
  'Hora'   = CONVERT(CHAR(5),GETDATE(),108 )   ,
  'Fecha_Proceso' = CONVERT(CHAR(10),@dFecproc,103),
 'entidad'       = @entidad
INTO  #tmp4
FROM  #tmp3
GROUP BY rut,dig,nombre,producto
UPDATE  #tmp4
SET  Remunera = ABS(monto)     ,
 Signo    = CASE WHEN  monto >= 0 THEN '+' ELSE '-' END ,
 Fecha    = CONVERT(CHAR(6),@dDesde,112)
SELECT  * 
FROM  #tmp4 
ORDER BY nomcli
SET NOCOUNT OFF
END
-- sp_InterfazRentabilidad '20010801', '20010830', 657
-- SELECT * FROM MFCA 
-- SELECT * FROM VIEW_LINEA_TRANSACCION

GO
