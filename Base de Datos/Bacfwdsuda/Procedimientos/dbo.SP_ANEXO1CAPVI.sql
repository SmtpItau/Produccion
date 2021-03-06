USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ANEXO1CAPVI]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ANEXO1CAPVI]
            (
  @cfecinimes CHAR(10),  
  @cfecfinmes CHAR(10),
                @cmes       CHAR(2) ,
                @cano       CHAR(4) 
            )
AS
BEGIN
   SET NOCOUNT ON    
   
   DECLARE @dfecproc    DATETIME
   DECLARE @cnomprop    CHAR(40)
   DECLARE @cdirprop    CHAR(40)
   DECLARE @ctelefono   CHAR(10)
   DECLARE @nrut        NUMERIC(9)
   DECLARE @cdig        CHAR(1)
   DECLARE @ncod        NUMERIC(2)
   SELECT      @dfecproc  = acfecproc  ,
               @cnomprop  = acnomprop  ,
               @cdirprop  = acdirprop  ,
               @ctelefono = actelefono , 
               @nrut      = acrutprop  , 
               @cdig      = acdigprop  ,
               @ncod      = 81
   FROM MFAC
   SELECT DISTINCT  'Nombre'        = @cnomprop                         , --01
                    'Domicilio'     = @cdirprop                         , --02
                    'CodigoCom'     = @ncod                             , --03
                    'Rut'           = @nrut                             , --04
                    'Digito'        = @cdig                             , --05
                    'Telefono'      = @ctelefono                        , --06 
                    'Moneda'        = a.cacodmon1                       , --07
                    'NemoMon'       = ' '                               , --08
                    'SaldoInicialC' = CONVERT(NUMERIC(18,4),0)          , --09
                    'SaldoInicialV' = CONVERT(NUMERIC(18,4),0)          , --10
                    'MonoSuscritoC' = CONVERT(NUMERIC(18,4),0)          , --11
                    'MonoSuscritoV' = CONVERT(NUMERIC(18,4),0)          , --12
                    'MontoVencidoC' = CONVERT(NUMERIC(18,4),0)          , --13
                    'MontoVencidoV' = CONVERT(NUMERIC(18,4),0)          , --14
                    'SaldoFinalC'   = CONVERT(NUMERIC(21,4),0)          , --15
                    'SaldoFinalV'   = CONVERT(NUMERIC(21,4),0)          , --16
                    'Instrumento'   = 'FORWARD'                         , --17 
                    'GlosaMoneda'   = SPACE(35)                         , --18
                    'Producto'      = a.cacodpos1                       , --19
                    'Mes'           = @cmes                             ,
                    'Año'           = @cano 
   INTO             #tmpMFCA1
   FROM             MFCA a
   ORDER BY         a.cacodmon1
   INSERT INTO     #TMPMFCA1
   SELECT DISTINCT @cnomprop,
    @cdirprop,
    @ncod,
    @nrut,
    @cdig,
    @ctelefono,
    cacodmon2,
    ' ',
    0,
    0,
    0,
    0,
    0,
    0, 
    0,
    0,
    'FORWARD',
    SPACE(35),
    cacodpos1,
    @cmes,
    @cano
   FROM MFCA, 
    #TMPMFCA1, 
    VIEW_CLIENTE
   WHERE ( cacodigo = clrut 
       AND cacodcli = clcodigo 
       AND cltipcli = 6 )                         
       AND NOT EXISTS( SELECT * FROM #TMPMFCA1 
      WHERE #TMPMFCA1.moneda   = MFCA.cacodmon2 
        AND #TMPMFCA1.producto = MFCA.cacodpos1 )
     INSERT INTO #TMPMFCA1
         SELECT DISTINCT 
               @cnomprop  ,
               @cdirprop  ,
               @ncod      ,
               @nrut      ,
               @cdig      ,
               @ctelefono ,
               cacodmon1  ,
               ' '        ,
               0          ,
               0          ,
               0          ,
               0          ,
               0          ,
               0          ,
               0          ,
               0          ,
               'FORWARD'  ,
               SPACE(35)  ,
               cacodpos1  ,
               @cmes      ,
               @cano 
            FROM  MFCAH       , 
                  #TMPMFCA1   , 
                  VIEW_CLIENTE
            WHERE ( cacodigo = clrut AND cacodcli = clcodigo AND cltipcli = 6 )
              AND ( cafecvcto >= @cfecinimes AND cafecvcto <= @cfecfinmes )
               OR ( cafecha   >= @cfecinimes AND cafecha   <= @cfecfinmes )
               OR ( cafecvcto >= @cfecinimes AND cafecha   <  @cfecinimes )
             AND NOT EXISTS( SELECT * 
                                 FROM #TMPMFCA1 
                                 WHERE  #TMPMFCA1.moneda = MFCAH.cacodmon1 
                                    AND #TMPMFCA1.producto = MFCAH.cacodpos1
                           )
     INSERT INTO  #TMPMFCA1  SELECT DISTINCT @cnomprop,@cdirprop,@ncod,@nrut,@cdig,@ctelefono,cacodmon2,' ',0,0,0,0,0,0,0,0,'FORWARD',SPACE(35),cacodpos1,@cmes,@cano 
            FROM  MFCAH, #TMPMFCA1, VIEW_CLIENTE
            WHERE ( cacodigo = clrut AND cacodcli = clcodigo AND cltipcli = 6 )
              AND ( ( cafecvcto >= @cfecinimes AND cafecvcto <= @cfecfinmes )
               OR (cafecha >= @cfecinimes AND cafecha <= @cfecfinmes ) 
               OR ( cafecvcto >= @cfecinimes And  cafecha < @cfecinimes) )
              AND NOT EXISTS( SELECT * FROM #TMPMFCA1 WHERE #TMPMFCA1.moneda = MFCAH.cacodmon2 AND #TMPMFCA1.producto = MFCAH.cacodpos1)
-- LAS LINEAS DE MAS ABAJO, SE COMENTARON PORQUE EL PROCEDIMIENTO SE CAIA. 
-- (MAGO) 28/05/2001   
/*
     UPDATE #TMPMFCA1 SET 
               nemomon     = mnnemo, 
               glosamoneda = mnglosa  
         FROM VIEW_CLIENTE,VIEW_MONEDA 
         WHERE mncodmon=moneda 
     UPDATE #TMPMFCA1 SET 
               glosamoneda = 'DOLAR USA ($ /UF)' 
         WHERE moneda =13 AND producto = 1
*/
--==========================================================================================================*/
--               *** Saldo Inicial de COMPRAS***
--==========================================================================================================*/
     UPDATE #TMPMFCA1 SET 
               saldoinicialc = (ISNULL(saldoinicialc,0) + ISNULL((SELECT SUM(camtomon1)
         FROM  MFCA,VIEW_CLIENTE
         WHERE (moneda = cacodmon1 AND producto = cacodpos1)
            AND cafecha < @cfecinimes AND catipoper = 'C'
            AND (cacodigo=clrut AND cacodcli = clcodigo ) and cltipcli =6 ), 0 ) )
     UPDATE #TMPMFCA1 SET saldoinicialc  = (ISNULL(saldoinicialc,0) + ISNULL((SELECT SUM(camtomon2) 
                      FROM MFCA, VIEW_CLIENTE
                      WHERE (moneda = cacodmon2 AND producto = cacodpos1)
                      AND cafecha < @cfecinimes AND catipoper = 'V'
                      AND (cacodigo=clrut AND cacodcli=clcodigo) AND cltipcli =6),0) )
     UPDATE #TMPMFCA1 SET saldoinicialc  = (ISNULL(saldoinicialc,0) + ISNULL((SELECT SUM(camtomon1) 
                      FROM MFCAH, VIEW_CLIENTE
                      WHERE (moneda = cacodmon1     AND producto = cacodpos1)
                      AND (cafecvcto >= @cfecinimes AND cafecha < @cfecinimes)
                      AND catipoper = 'C'
                      AND (cacodigo=clrut AND cacodcli=clcodigo) AND cltipcli =6),0) )
     UPDATE #TMPMFCA1 SET saldoinicialc  = (ISNULL(saldoinicialc,0) + ISNULL((SELECT SUM(camtomon2) 
                      FROM MFCAH, VIEW_CLIENTE
                      WHERE (moneda = cacodmon2     AND producto = cacodpos1)
                      AND (cafecvcto >= @cfecinimes AND cafecha < @cfecinimes)
                      AND catipoper = 'V'
                      AND (cacodigo=clrut AND cacodcli=clcodigo) AND cltipcli = 6 ), 0 ) )
--==========================================================================================================*/
--               *** Saldo Inicial de VENTAS***
--==========================================================================================================*/
     UPDATE #TMPMFCA1 SET saldoinicialv  = (ISNULL(saldoinicialv,0) + ISNULL((SELECT SUM(camtomon1) 
                      FROM  MFCA, VIEW_CLIENTE
                      WHERE (moneda = cacodmon1 AND producto = cacodpos1)
                      AND cafecha < @cfecinimes AND catipoper = 'V'
                      AND ( cacodigo = clrut AND cacodcli = clcodigo) AND cltipcli = 6 ), 0 ) )
     UPDATE #TMPMFCA1 SET saldoinicialv  = (ISNULL(saldoinicialv,0) + ISNULL((SELECT SUM(camtomon2) 
                      FROM MFCA, VIEW_CLIENTE
                      WHERE (moneda = cacodmon2  AND producto = cacodpos1)
                      AND  cafecha < @cfecinimes AND catipoper = 'C'
                      AND (cacodigo=clrut AND cacodcli=clcodigo) AND cltipcli = 6 ), 0 ) )
     UPDATE #TMPMFCA1 SET saldoinicialv  = (isnull(saldoinicialv,0) + isnull((select sum(camtomon1) 
                      From MFCAH, VIEW_CLIENTE
                      where (moneda = cacodmon1     and producto = cacodpos1)
                      and (cafecvcto >= @cfecinimes and cafecha < @cfecinimes )
                      and catipoper = 'V'
                      and (cacodigo=clrut and cacodcli=clcodigo) and cltipcli =6),0) )
     UPDATE #TMPMFCA1 SET saldoinicialv  = (isnull(saldoinicialv,0) + isnull((select sum(camtomon2) 
                      From MFCAH, VIEW_CLIENTE
                      where (moneda = cacodmon2     and producto = cacodpos1)
                      and (cafecvcto >= @cfecinimes and cafecha < @cfecinimes)
                      and catipoper = 'C'
                      and (cacodigo=clrut and cacodcli=clcodigo) and cltipcli =6),0) )
--/*==========================================================================================================*/
--                 *** Volumen Suscrito en el mes que se informa de COMPRAS***
--/*==========================================================================================================*/
     UPDATE #TMPMFCA1 SET monosuscritoc  = (isnull(monosuscritoc,0) + isnull((select sum(camtomon1) 
                      FROM  MFCA,VIEW_CLIENTE   
                      WHERE (moneda = cacodmon1    and producto = cacodpos1)
                      and (cafecha >= @cfecinimes and cafecha <= @cfecfinmes)
                      and catipoper = 'C'
                      and (cacodigo = clrut and cacodcli=clcodigo) and cltipcli =6),0) )
     UPDATE #TMPMFCA1 SET monosuscritoc  = (isnull(monosuscritoc,0) + isnull((select sum(camtomon2) 
                      From MFCA,VIEW_CLIENTE 
                      where (moneda = cacodmon2    and producto = cacodpos1)
                      and (cafecha >= @cfecinimes and cafecha <= @cfecfinmes)
                      and catipoper = 'V'   
                      and (cacodigo=clrut and cacodcli=clcodigo) and cltipcli =6),0) )
     UPDATE #TMPMFCA1 SET monosuscritoc  = (isnull(monosuscritoc,0) + isnull((select sum(camtomon1) 
                      From MFCAH,VIEW_CLIENTE 
                      where (moneda = cacodmon1    and producto = cacodpos1)
                      and (cafecha >= @cfecinimes and cafecha <= @cfecfinmes)
                      and catipoper = 'C'   
                      and (cacodigo = clrut and cacodcli=clcodigo) and cltipcli =6),0) )
     UPDATE #TMPMFCA1 SET monosuscritoc  = (isnull(monosuscritoc,0) + isnull((select sum(camtomon2) 
                      From MFCAH,VIEW_CLIENTE 
                      where (moneda = cacodmon2   and producto = cacodpos1)
                      and (cafecha >= @cfecinimes and cafecha <= @cfecfinmes)
                      and catipoper='V'
                      and (cacodigo=clrut and cacodcli=clcodigo) and cltipcli =6),0) )
--/*==========================================================================================================
--             *** Volumen Suscrito en el mes que se informa de VENTAS***
--/*==========================================================================================================
     UPDATE #TMPMFCA1 SET monosuscritov  = (isnull(monosuscritov,0) + isnull((select sum(camtomon1) 
                      FROM  MFCA,VIEW_CLIENTE   
                      where (moneda = cacodmon1    and producto = cacodpos1 )
                      and ( cafecha >= @cfecinimes and cafecha <= @cfecfinmes )
                      and catipoper = 'V' 
                      and (cacodigo=clrut and cacodcli=clcodigo) and cltipcli =6),0) )
     UPDATE #TMPMFCA1 SET monosuscritov  = (isnull(monosuscritov,0) + isnull((select sum(camtomon2) 
                      FROM MFCA,VIEW_CLIENTE 
                      where (moneda = cacodmon2   and producto = cacodpos1)
                      and (cafecha >= @cfecinimes and cafecha <= @cfecfinmes)
                      and catipoper = 'C'   
                      and (cacodigo=clrut and cacodcli=clcodigo) and cltipcli =6),0) )
     UPDATE #TMPMFCA1 SET monosuscritov  = (isnull(monosuscritov,0) + isnull((select sum(camtomon1) 
                      FROM MFCAH,VIEW_CLIENTE  
                      where (moneda = cacodmon1   and producto = cacodpos1)
                      and (cafecha >= @cfecinimes and cafecha <= @cfecfinmes)
                      and catipoper = 'V'
                      and (cacodigo = clrut and cacodcli=clcodigo) and cltipcli =6),0) )
     UPDATE #TMPMFCA1 SET monosuscritov  = (isnull(monosuscritov,0) + isnull((select sum(camtomon2) 
                      FROM MFCAH,VIEW_CLIENTE 
                      where (moneda = cacodmon2    and producto = cacodpos1)
                      and (cafecha >= @cfecinimes and cafecha <= @cfecfinmes)
                      and catipoper='C'
                      and (cacodigo=clrut and cacodcli=clcodigo) and cltipcli =6),0) )
--/*==========================================================================================================
--       *** Volumen VENCIDO en el mes que se informa de COMPRAS***
--/*==========================================================================================================
     UPDATE #TMPMFCA1 SET montovencidoc  = (isnull(montovencidoc,0) + isnull((select sum(camtomon1) 
                      FROM  MFCA,VIEW_CLIENTE   
                      where (moneda = cacodmon1      and producto = cacodpos1)
                      and (cafecvcto >= @cfecinimes and cafecvcto <= @cfecfinmes)
                      and catipoper='C'
                      and (cacodigo=clrut and cacodcli=clcodigo) and cltipcli =6),0) )
     UPDATE #TMPMFCA1 SET montovencidoc  = (isnull(montovencidoc,0) + isnull((select sum(camtomon2) 
                      From MFCA, VIEW_CLIENTE 
                      where (moneda = cacodmon2      and producto = cacodpos1)
                      and (cafecvcto >= @cfecinimes and cafecvcto <= @cfecfinmes)
                      and catipoper='V'   
                      and (cacodigo=clrut and cacodcli=clcodigo) and cltipcli =6),0) )
     UPDATE #TMPMFCA1 SET montovencidoc  = (isnull(montovencidoc,0) + isnull((select sum(camtomon1) 
                      From MFCAH, VIEW_CLIENTE 
                      where (moneda = cacodmon1      and producto = cacodpos1)
                      and (cafecvcto >= @cfecinimes and cafecvcto <= @cfecfinmes)
                      and catipoper='C'   
                      and (cacodigo=clrut and cacodcli=clcodigo) and cltipcli =6),0) )
     UPDATE #TMPMFCA1 SET montovencidoc  = (isnull(montovencidoc,0) + isnull((select sum(camtomon2) 
                      From MFCAH, VIEW_CLIENTE  
                      where (moneda = cacodmon2     and producto = cacodpos1)
                      and (cafecvcto >= @cfecinimes and cafecvcto <= @cfecfinmes)
                      and catipoper='V'
                      and (cacodigo=clrut and cacodcli=clcodigo) and cltipcli =6),0) )
--/*==========================================================================================================
--     *** Volumen VENCIDO en el mes que se informa de VENTAS***
--/*==========================================================================================================
     UPDATE #TMPMFCA1 SET montovencidov  = (isnull(montovencidov,0) + isnull((select sum(camtomon1) 
                      FROM  MFCA, VIEW_CLIENTE   
                      where (moneda = cacodmon1      and producto = cacodpos1)
                      and (cafecvcto >= @cfecinimes and cafecvcto <= @cfecfinmes)
                      and catipoper='V'
                      and (cacodigo=clrut and cacodcli=clcodigo) and cltipcli =6),0) )
     UPDATE #TMPMFCA1 SET montovencidov  = (isnull(montovencidov,0) + isnull((select sum(camtomon2) 
                      FROM MFCA, VIEW_CLIENTE 
                      where (moneda = cacodmon2     and producto = cacodpos1)
                      and (cafecvcto >= @cfecinimes and cafecvcto <= @cfecfinmes)
                      and catipoper='C'
                      and (cacodigo=clrut and cacodcli=clcodigo) and cltipcli =6),0) )
     UPDATE #TMPMFCA1 SET montovencidov  = (isnull(montovencidov,0) + isnull((select sum(camtomon1) 
                      FROM MFCAH, VIEW_CLIENTE 
                      where ( moneda = cacodmon1    and producto = cacodpos1 )
                      and (cafecvcto >= @cfecinimes and cafecvcto <= @cfecfinmes)
                      and catipoper='V'
                      and (cacodigo=clrut and cacodcli=clcodigo) and cltipcli =6),0) )
     UPDATE #TMPMFCA1 SET montovencidov  = (isnull(montovencidov,0) + isnull((select sum(camtomon2) 
                      FROM MFCAH, VIEW_CLIENTE 
                      where (moneda = cacodmon2      and producto = cacodpos1 )
                      and (cafecvcto >= @cfecinimes  and cafecvcto <= @cfecfinmes)
                      and catipoper='C'
                      and (cacodigo=clrut and cacodcli=clcodigo) and cltipcli =6),0) )
--/*==========================================================================================================
--     *** Saldo Final de COMPRAS***-
--/*==========================================================================================================
     UPDATE #TMPMFCA1 SET saldofinalc  = isnull(saldoinicialc + monosuscritoc - montovencidoc,0) 
--/*==========================================================================================================
--     *** Saldo Final de VENTAS***
--/*==========================================================================================================
    UPDATE #TMPMFCA1 SET saldofinalv  = isnull(saldoinicialv + monosuscritov - montovencidov,0) 
   SELECT * FROM #TMPMFCA1 
   SET NOCOUNT OFF
END

GO
