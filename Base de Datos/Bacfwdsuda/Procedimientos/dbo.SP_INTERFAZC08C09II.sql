USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZC08C09II]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZC08C09II]
AS
BEGIN
SET NOCOUNT ON
/*
 Por cambios Solicitados para cumplir con normativa de la SBIF se modificó la interfaz de C08-C09 se Informan 
 los Flujos de la Siguiente Forma
 1.- Entrega Fisica y Operaciones de Arbitrajes debe ir en campo Flujo 0 (cero)
 2.- Primera Parte de Compensaciones debe ir en campo Flujo M 
 3.- Segunda Parte de Compensaciones debe ir en campo Flujo I , el Monto y la Moneda Debe Estar expresado en la moneda compensación, 
     que por el momento en el caso del SCOTIABANK son sólo pesos.
*/
DECLARE @dFecPro  DATETIME ,
 @pais     INTEGER  ,
 @monedaflujo NUMERIC(3) ,
 @valorobservado NUMERIC(15,4) ,
 @valoruf NUMERIC(15,4) ,
 @monedaobs    NUMERIC(3) ,
 @monedauf     NUMERIC(3)  
SELECT  @dFecPro     = acfecproc ,
 @pais      = acpais  ,
 @monedaflujo = accodmonloc ,
 @monedaobs   = accodmondolobs ,
 @monedauf    = accodmonuf
FROM  mfac
SELECT  @valorobservado = a.vmvalor ,
 @valoruf = b.vmvalor  
FROM view_valor_moneda a ,
 view_valor_moneda b 
WHERE ( a.vmcodigo = @monedaobs  AND
   a.vmfecha  = @dFecPro   ) AND
 ( b.vmcodigo = @monedaobs  AND
   b.vmfecha  = @dFecPro   )
----- Flujos de la entrega Física y de las Compensaciones 
SELECT  'Fecha'    =   CONVERT (CHAR(02),@dFecPro,103)     ,
        'FW'       =   'FW'                                ,
        'Cuenta'   = CASE  WHEN a.catipoper='C' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=999 THEN  '2127630189'
                           WHEN a.catipoper='C' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=998 THEN  '2127630189'
                           WHEN a.catipoper='V' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=999 THEN  '4127630084'
                           WHEN a.catipoper='V' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=998 THEN  '4127630084'
                           WHEN a.catipoper='C' and  a.cacodpos1=2 and b.clpais = @pais    THEN  '2127631088'
                           WHEN a.catipoper='C' and  a.cacodpos1=2 and b.clpais<> @pais    THEN  '2127631282'
                           WHEN a.catipoper='V' and  a.cacodpos1=2 and b.clpais = @pais    THEN  '4127631080'
                           WHEN a.catipoper='V' and  a.cacodpos1=2 and b.clpais<> @pais THEN  '4127631285'
                           WHEN a.catipoper='C' and  a.cacodpos1=3  THEN  '2127633013'
                           WHEN a.catipoper='V' and  a.cacodpos1=3  THEN  '4127635019'
                           ELSE '0000000000'
   END       ,
        'Moneda'   =   a.cacodmon1                         ,
        'Tasa'     =   0                                   ,
        'FechaVcto'=  CONVERT (CHAR(08),a.cafecvcto,112)   ,
        'Monto'    =   a.camtomon1                         ,
        'Numero'   =   a.canumoper                         ,
 'Flujo'    =    CASE  WHEN a.cacodpos1 = 2  THEN '0' 
      WHEN a.catipmoda = 'C'  THEN 'M' 
    ELSE '0' 
   END
INTO  #tmp
FROM   mfca a ,view_cliente b
WHERE  a.cafecvcto > @dFecPro  AND
       a.cacodpos1<>4   AND  
 a.cacodpos1<>5   AND  
 a.cacodpos1<>6   AND 
 (a.cacodigo= b.clrut and a.cacodcli=b.clcodigo )
INSERT INTO #tmp
SELECT  'Fecha'    =   CONVERT (CHAR(02),@dFecPro,103)    ,
        'FW'       =   'FW'                                , 
        'Cuenta'   = CASE  WHEN a.catipoper='C' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=999 THEN  '4127630106'
                           WHEN a.catipoper='C' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=998 THEN  '4127630114'
                           WHEN a.catipoper='V' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=999 THEN  '2127630006'
                           WHEN a.catipoper='V' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=998 THEN  '2127630014'
                           WHEN a.catipoper='C' and  a.cacodpos1=2 and b.clpais = @pais    THEN  '4127631080'
                           WHEN a.catipoper='C' and  a.cacodpos1=2 and b.clpais<> @pais    THEN  '4127631285'
                           WHEN a.catipoper='V' and  a.cacodpos1=2 and b.clpais = @pais    THEN  '2127631080'
                           WHEN a.catipoper='V' and  a.cacodpos1=2 and b.clpais<> @pais THEN  '2127631282'
                           WHEN a.catipoper='C' and  a.cacodpos1=3  THEN  '4127633008'
                           WHEN a.catipoper='V' and  a.cacodpos1=3  THEN  '2127635008'
                           ELSE '0000000000' 
   END       ,
        'Moneda'   =   a.cacodmon2                         ,
        'Tasa'     =   0                                   ,
        'FechaVcto'=  CONVERT (CHAR(08),a.cafecvcto,112)   ,
        'Monto'    =   a.camtomon2                         ,
        'Numero'   =   a.canumoper                         ,
 'Flujo'    =    CASE  WHEN a.cacodpos1 = 2  THEN '0' 
      WHEN a.catipmoda = 'C'  THEN 'M' 
    ELSE '0' 
   END
FROM   mfca a ,view_cliente b
WHERE  a.cafecvcto > @dFecPro  and
       a.cacodpos1<>4   and  
 a.cacodpos1<>5   and  
 a.cacodpos1<>6   and 
 (a.cacodigo=b.clrut and a.cacodcli=b.clcodigo )
----- Flujos de la Compensación expresados en la Moneda de Compensación
INSERT INTO #tmp
SELECT  'Fecha'    =   CONVERT (CHAR(02),@dFecPro,103)     ,
        'FW'       =   'FW'                                ,
        'Cuenta'   = CASE  WHEN a.catipoper='C' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=999 THEN  '2127630189'
                           WHEN a.catipoper='C' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=998 THEN  '2127630189'
                           WHEN a.catipoper='V' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=999 THEN  '4127630084'
                           WHEN a.catipoper='V' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=998 THEN  '4127630084'
                           WHEN a.catipoper='C' and  a.cacodpos1=2 and b.clpais = @pais    THEN  '2127631088'
                           WHEN a.catipoper='C' and  a.cacodpos1=2 and b.clpais<> @pais    THEN  '2127631282'
                           WHEN a.catipoper='V' and  a.cacodpos1=2 and b.clpais = @pais    THEN  '4127631080'
                           WHEN a.catipoper='V' and  a.cacodpos1=2 and b.clpais<> @pais THEN  '4127631285'
                           WHEN a.catipoper='C' and  a.cacodpos1=3  THEN  '2127633013'
                           WHEN a.catipoper='V' and  a.cacodpos1=3  THEN  '4127635019'
                           ELSE '0000000000'
   END       ,
        'Moneda'   =   @monedaflujo      ,
        'Tasa'     =   0                                   ,
        'FechaVcto'=  CONVERT (CHAR(08),a.cafecvcto,112)   ,
        'Monto'    =   a.caclpmoneda1      ,
        'Numero'   =   a.canumoper                         ,
 'Flujo'    =    'I'
FROM   mfca a ,view_cliente b
WHERE  a.cafecvcto > @dFecPro  AND
       a.cacodpos1<>4   AND  
 a.cacodpos1<>5   AND  
 a.cacodpos1<>6   AND 
 a.cacodpos1<>2   AND 
 a.catipmoda = 'C'  AND 
 (a.cacodigo= b.clrut and a.cacodcli=b.clcodigo )
INSERT INTO #tmp
SELECT  'Fecha'    =   CONVERT (CHAR(02),@dFecPro,103)    ,
        'FW'       =   'FW'                                , 
        'Cuenta'   = CASE  WHEN a.catipoper='C' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=999 THEN  '4127630106'
                           WHEN a.catipoper='C' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=998 THEN  '4127630114'
                           WHEN a.catipoper='V' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=999 THEN  '2127630006'
                           WHEN a.catipoper='V' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=998 THEN  '2127630014'
                           WHEN a.catipoper='C' and  a.cacodpos1=2 and b.clpais = @pais    THEN  '4127631080'
                           WHEN a.catipoper='C' and  a.cacodpos1=2 and b.clpais<> @pais    THEN  '4127631285'
                           WHEN a.catipoper='V' and  a.cacodpos1=2 and b.clpais = @pais    THEN  '2127631080'
                           WHEN a.catipoper='V' and  a.cacodpos1=2 and b.clpais<> @pais THEN  '2127631282'
                           WHEN a.catipoper='C' and  a.cacodpos1=3  THEN  '4127633008'
                           WHEN a.catipoper='V' and  a.cacodpos1=3  THEN  '2127635008'
                           ELSE '0000000000' 
   END       ,
        'Moneda'   =   @monedaflujo      ,
        'Tasa'     =   0                                   ,
        'FechaVcto'=  CONVERT (CHAR(08),a.cafecvcto,112)   ,
        'Monto'    =   a.caclpmoneda2      ,
        'Numero'   =   a.canumoper                         ,
 'Flujo'    =    'I'
FROM   mfca a ,view_cliente b
WHERE  a.cafecvcto > @dFecPro  AND
       a.cacodpos1<>4   AND  
 a.cacodpos1<>5   AND  
 a.cacodpos1<>6   AND 
 a.cacodpos1<>2   AND 
 a.catipmoda = 'C'  AND 
 (a.cacodigo=b.clrut and a.cacodcli=b.clcodigo )
SELECT * FROM #tmp ORDER BY numero
SET NOCOUNT OFF
END

GO
