USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGAARBVCTO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGAARBVCTO]  

   (   @cfecha   DATETIME   )    

AS    

BEGIN    

    

   SET NOCOUNT ON    

    

   SELECT 'NumOpe'      = a.canumoper    

   ,      'Cliente'     = ISNULL(b.clnombre, '' )    

   ,      'TipOper'     = a.catipoper              

   ,      'FecIni'      = CONVERT(CHAR(10),a.cafecha,103)    

   ,      'FecVen'      = CONVERT(CHAR(10),a.cafecvcto,103)    

   ,      'MtoMex'      = a.camtomon1    

   ,      'MtoUsd'      = a.camtomon2    

   ,      'Parvcto'     = a.caprecal    

   ,      'ParSpt'      = a.caparmon1    

   ,      'ParFwd'      = caparmon2    

   ,      'CodMon'      = c.mnnemo    

   --     Relación Tasas BenchMarck     

   ,      'Caprod'      = a.cacodpos1    

   ,      'CaInst'      = a.cabroker    

   ,      'CaMone'      = a.cacodmon1    

   ,      'Cafech'      = a.cafecvcto    

   ,      'FecEmiInt'   = GETDATE()    

   ,      'FecVenInt'   = GETDATE()    

   ,      'CaSerie'     = a.caserie    

   ,      'CodigoMoneda'= cacodmon1    

   ,   'OperMxCLP'   = a.var_moneda2    

   ,   'cacalvtadol' = CASE WHEN a.cacalvtadol = 15 THEN 'FW ASIATICO' ELSE pr.descripcion END  

   INTO   #ParidadesVcto    

   FROM   MFCA                             a with (nolock)    

          INNER JOIN BacParamSuda..CLIENTE b with (nolock) ON b.clrut    = a.cacodigo  AND b.clcodigo = a.cacodcli    

          INNER JOIN BacParamSuda..MONEDA  c with (nolock) ON c.mncodmon = a.cacodmon1    

    LEFT  JOIN BacParamSuda.dbo.PRODUCTO pr with (nolock) ON pr.id_sistema = 'bfw' AND pr.codigo_producto = cacodpos1    

   WHERE  a.cacodpos1  IN(2, 10, 11, 12)    

   AND    a.cafecvcto   = @cfecha    

   AND    a.caantici   <> 'A'  

   AND    a.catipmoda   = 'C'    

    

 INSERT INTO #ParidadesVcto  

 SELECT 'NumOpe'      = canumoper  

 , 'Cliente'     = ISNULL(cli.clnombre, '' )  

 , 'TipOper'     = catipoper            

 , 'FecIni'      = CONVERT(CHAR(10), cafecha,103)  

 , 'FecVen'      = CONVERT(CHAR(10), cafecvcto,103)  

 , 'MtoMex'      = camtomon1  

 , 'MtoUsd'      = camtomon2  

 , 'Parvcto'     = caprecal  

 , 'ParSpt'      = caparmon1  

 , 'ParFwd'      = caparmon2  

 , 'CodMon'      = mon.mnnemo  

 , 'Caprod'      = cacodpos1  

 , 'CaInst'      = cabroker  

 , 'CaMone'      = cacodmon1  

 , 'Cafech'      = cafecvcto  

 , 'FecEmiInt'   = GETDATE()  

 , 'FecVenInt'   = GETDATE()  

 , 'CaSerie'     = caserie  

 ,   'CodigoMoneda'= cacodmon1  

 , 'OperMxCLP'   = var_moneda2  

 ,   'cacalvtadol' = CASE WHEN cacalvtadol = 15 THEN 'FW ASIATICO' ELSE pr.descripcion END  

 FROM BacFwdSuda.dbo.MFCA      with (nolock)   

            INNER JOIN BacParamSuda..CLIENTE cli with (nolock) ON cli.clrut    = cacodigo  AND cli.clcodigo = cacodcli  

            INNER JOIN BacParamSuda..MONEDA  mon with (nolock) ON mon.mncodmon = cacodmon1  

            LEFT  JOIN BacParamSuda.dbo.PRODUCTO pr with (nolock) ON pr.id_sistema = 'bfw' AND pr.codigo_producto = cacodpos1  

 WHERE cacalvtadol    = 15   --> Fw Asiatico  

 AND  cafecvcto    = @cfecha --> Vence Hoy  

 AND     caantici    <> 'A'  --> No Anticipado  

 AND     catipmoda    = 'C'  --> Solo modalidad Compensacion  

 AND  cacodpos1    = 1   --> Seguros de Cambio  

  

 UPDATE #ParidadesVcto    

    SET  Parvcto       = 0.0    

    ,  ParSpt        = 0.0    

    WHERE CodigoMoneda  = 994    

    AND  Caprod        = 12    

  

   UPDATE #ParidadesVcto    

   SET    FecEmiInt     = ser.sefecemi    

   ,      FecVenInt     = ser.sefecven    

   FROM   BacParamSuda..SERIE ser with (nolock)    

   WHERE  ser.secodigo  = cainst    

   AND    ser.semascara = caserie    

  

   UPDATE #ParidadesVcto    

   SET    Parvcto       = ISNULL(Tasa,Parvcto)    

   FROM   BENCH_MARCK   with (nolock)    

   WHERE  Fecha      = cafech    

   AND    Instrumento   = cainst    

   AND    Moneda        = camone    

   AND    Caprod        = 10    

   AND    DATEDIFF(DAY,@cfecha,FecVenInt)/360 BETWEEN Desde AND Hasta    

  

   UPDATE #ParidadesVcto    

   SET    Parvcto       = ISNULL(Tasa,Parvcto)    

   FROM   BENCH_MARCK   with (nolock)    

   WHERE  Fecha      = cafech    

  AND    Instrumento   = cainst    

   AND    CaSerie       IN('BCU0500912')--, 'BCU0501113')    

   AND    Moneda        = camone    

   AND    Caprod        = 10    

   AND    7             BETWEEN Desde AND Hasta    

  

   -->    ERROR EN PAPEL POSISIONADO EN OTRO PLAZO   

   UPDATE #ParidadesVcto    

   SET    Parvcto       = ISNULL(Tasa,Parvcto)    

   FROM   BENCH_MARCK   with (nolock)    

   WHERE  Fecha         = cafech    

   AND    Instrumento   = cainst    

   AND    CaSerie       IN('BCU0500116')    

   AND    Moneda        = camone    

   AND    Caprod        = 10    

   AND    5             BETWEEN Desde AND Hasta    

   -->    ERROR EN PAPEL POSISIONADO EN OTRO PLAZO   

  

   -->    ERROR EN PAPEL POSISIONADO EN OTRO PLAZO   

   UPDATE #ParidadesVcto    

   SET    Parvcto       = ISNULL(Tasa,Parvcto)    

   FROM   BENCH_MARCK   with (nolock)    

   WHERE  Fecha         = cafech    

   AND    Instrumento   = cainst    

   AND    CaSerie       IN('BTU0150326')  

   AND    Moneda        = camone    

   AND    Caprod        = 10    

   AND    10            BETWEEN Desde AND Hasta    

   -->    ERROR EN PAPEL POSISIONADO EN OTRO PLAZO   

     

     -->    ERROR EN PAPEL POSISIONADO EN OTRO PLAZO -- PMASM

   UPDATE #ParidadesVcto  

   SET    Parvcto       = ISNULL(Tasa,Parvcto)  

   FROM   BENCH_MARCK   with (nolock)  

   WHERE  Fecha         = cafech  

   AND    Instrumento   = cainst  

   AND    CaSerie       IN('BCP0600221')

   AND    Moneda        = camone  

   AND    Caprod        = 10  

   AND    5            BETWEEN Desde AND Hasta  

   -->    ERROR EN PAPEL POSISIONADO EN OTRO PLAZO   

   

   UPDATE #ParidadesVcto    

   SET    Parvcto       = ISNULL(Tasa,Parvcto)    

   FROM   BENCH_MARCK_INVEX with (nolock)    

   WHERE  Fecha         = cafech    

   AND    Instrumento   = caserie    

   AND    Moneda        = camone    

   AND    Caprod        = 11    

  

   SELECT NumOpe    as NumOpe_01    

   ,      Cliente   as Cliente_02    

   ,      TipOper   as TipOper_03    

   ,      FecIni    as FecIni_04    

   ,      FecVen    as FecVen_05    

   ,      MtoMex    as MtoMex_06    

   ,      MtoUsd    as MtoUsd_07    

   ,      Parvcto   as Parvcto_08    

   ,      ParSpt    as ParSpt_09    

   ,      ParFwd    as ParFwd_10    

   ,      CodMon    as CodMon_11    

   ,      Caprod    as Caprod_12    

   ,      CaInst    as CaInst_13    

   ,      CaMone    as CaMone_14    

   ,      Cafech    as Cafech_15    

   ,      FecEmiInt as FecEmiInt_16    

   ,      FecVenInt as FecVenInt_17    

   ,      CaSerie   as CaSerie_18    

   ,   OperMxCLP as OpMxClp_19    

   ,   cacalvtadol AS cacalvtadol   

   FROM   #ParidadesVcto    

   ORDER BY Caprod    

    

END  

GO
