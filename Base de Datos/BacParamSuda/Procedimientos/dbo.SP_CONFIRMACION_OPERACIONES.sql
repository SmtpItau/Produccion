USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONFIRMACION_OPERACIONES]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_CONFIRMACION_OPERACIONES]
   (   @iSistema   CHAR(3)   
   ,   @iRut       NUMERIC(10) = 0
   ,   @iCodCli    NUMERIC(9)  = 0
   ,   @iTipCli    NUMERIC(9)  = 0
   ,   @cTipOper   VARCHAR(5)  = ''
   ,   @EstadoConf CHAR(1)     = ''
   ,   @Agrupado   NUMERIC(1)  = -1
   ,   @iNumOper   NUMERIC(9)  = 0 
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iSistema = 'BCC'
   BEGIN
      SELECT /*001*/ 'Confirmacion' = CASE WHEN Dcrp_Confirmador = 'N' THEN 'NO'
                                           WHEN Dcrp_Confirmador = 'S' THEN 'SI'
                                           WHEN Dcrp_Confirmador = ' ' THEN 'NO'
                                      END
      ,      /*002*/ 'Mercado'      = pro.descripcion
      ,      /*003*/ 'Operacion'    = CASE WHEN motipope = 'C'    THEN 'COMPRA'
                                           WHEN motipope = 'V'    THEN 'VENTA'
                                      END
      ,      /*004*/ 'Numero'       = monumope
      ,      /*005*/ 'Cliente'      = ltrim(rtrim(convert(char(10),clrut))) + '-' + convert(char(1),cldv) + ' ' + substring(clnombre,1,30)
      ,      /*006*/ 'MonedaOpe'    = convert(char(3),op.mncodmon) + '- ' + mocodmon
      ,      /*007*/ 'MonedaCnv'    = convert(char(3),cn.mncodmon) + '- ' + mocodcnv
      ,      /*008*/ 'Monto'        = momonmo
      ,      /*009*/ 'TipoCambio'   = moticam
      ,      /*010*/ 'Paridad'      = moparme
      ,      /*011*/ 'Pesos'        = convert(numeric(21,0),momonpe)
      ,      /*012*/ 'Entregamos'   = convert(char(3),entre.codigo) + ' - ' + entre.glosa
      ,      /*013*/ 'Recibimos'    = convert(char(3),recib.codigo) + ' - ' + recib.glosa
      ,      /*014*/ 'Hora'         = Dcrp_HoraConfirm
      ,      /*015*/ 'Operador'     = Dcrp_OperConfirm
      ,      /*016*/ 'ConfirmaCon'  = Dcrp_OpeCnvConfirm
      ,      /*017*/ 'CodDiscrep'   = Dcrp_Codigo
      ,      /*018*/ 'Tipodiscrp'   = Dcrp_Glosa
      FROM   baccamsuda..MEMO       LEFT JOIN bacparamsuda..CLIENTE             ON morutcli = clrut AND mocodcli = clcodigo
                                    LEFT JOIN bacparamsuda..MONEDA op           ON mocodmon = op.mnnemo
                                    LEFT JOIN bacparamsuda..MONEDA cn           ON mocodcnv = cn.mnnemo
                                    LEFT JOIN bacparamsuda..FORMA_DE_PAGO entre ON moentre  = entre.codigo
                                    LEFT JOIN bacparamsuda..FORMA_DE_PAGO recib ON morecib  = recib.codigo
                                    LEFT JOIN bacparamsuda..PRODUCTO pro        ON pro.id_sistema = 'BCC' AND motipmer = pro.codigo_producto
      WHERE  moestatus              = ''
      AND   (Dcrp_Confirmador       = @EstadoConf OR @EstadoConf = '')
      AND   (morutcli               = @iRut       OR @iRut       = 0)
      AND   (mocodcli               = @iCodCli    OR @iCodCli    = 0)
      AND   (cltipcli               = @iTipCli    OR @iTipCli    = 0)
      AND   (motipmer               = @cTipOper   OR @cTipOper   = '')
      RETURN
   END

   IF @iSistema = 'BTR'
   BEGIN

      IF @Agrupado = -1
      BEGIN

         SELECT     motipoper            as motipoper
         ,          monumoper            as monumoper
         ,      min(monumdocu)           as monumdocu
         ,      min(mocorrela)           as mocorrela
         ,          morutcli             as morutcli
         ,          mocodcli             as mocodcli
         ,      min(moinstser)           as moinstser
         ,      sum(monominal)           as monominal
         ,      sum(movalcomp)           as movalcomp
         ,      sum(movalinip)           as movalinip
         ,      sum(movpresen)           as movpresen
         ,      sum(movalven)            as movalven
         ,      sum(movalvenp)           as movalvenp
         ,         (moforpagi)           as moforpagi
         ,         (moforpagv)           as moforpagv
         ,      min(Dcrp_Confirmador)    as Dcrp_Confirmador
         ,      min(Dcrp_HoraConfirm)    as Dcrp_HoraConfirm
         ,      min(Dcrp_OperConfirm)    as Dcrp_OperConfirm
         ,      min(Dcrp_OpeCnvConfirm)  as Dcrp_OpeCnvConfirm
         ,      min(Dcrp_Codigo)         as Dcrp_Codigo
         ,      min(Dcrp_Glosa)          as Dcrp_Glosa
         ,      min(momonemi)            as momonemi
         ,      min(momonpact)           as momonpact
         ,      sum(motir * monominal) / sum(monominal) as motir
         ,         (mostatreg)           as mostatreg 
         INTO   #PASO
         FROM   bactradersuda..MDMO
         WHERE  mostatreg              = ''
         AND   (Dcrp_Confirmador       = @EstadoConf OR @EstadoConf = '')
         AND   (morutcli               = @iRut       OR @iRut       = 0)
         AND   (mocodcli               = @iCodCli    OR @iCodCli    = 0)
         AND   (motipoper              = @cTipOper   OR @cTipOper   = '')
         AND   (monumoper              = @iNumOper   or @iNumOper   = 0)
         AND    motipoper         NOT IN('TM')
         GROUP BY motipoper , monumoper , morutcli , mocodcli , moforpagi , moforpagv , mostatreg

         SELECT /*001*/ 'Confirmacion' = CASE WHEN Dcrp_Confirmador = 'N' THEN 'NO'
                                              WHEN Dcrp_Confirmador = 'S' THEN 'SI'
                                              WHEN Dcrp_Confirmador = ' ' THEN 'NO'
                                         END
         ,      /*002*/ 'TipOper'      = pro.descripcion -- motipoper
         ,      /*003*/ 'NumOPer'      = monumoper
         ,      /*004*/ 'NumDocu'      = 0 --(monumdocu)
         ,      /*005*/ 'Correla'      = 0 --(mocorrela)
         ,      /*006*/ 'Cliente'      = ISNULL( ltrim(rtrim(convert(char(10),clrut))) + '-' + convert(char(1),cldv) + ' ' + substring(clnombre,1,30), '0-0  Cliente no encontrado')
         ,      /*007*/ 'MonedaOp'     = CASE WHEN motipoper = 'CP' THEN convert(char(3),emi.mncodmon) + ' - ' + emi.mnnemo
                                              WHEN motipoper = 'CI' THEN convert(char(3),pac.mncodmon) + ' - ' + pac.mnnemo
                                              WHEN motipoper = 'VP' THEN convert(char(3),emi.mncodmon) + ' - ' + emi.mnnemo
                                              WHEN motipoper = 'VI' THEN convert(char(3),pac.mncodmon) + ' - ' + pac.mnnemo
                                              ELSE                       convert(char(3),emi.mncodmon) + ' - ' + emi.mnnemo
                                         END
         ,      /*008*/ 'Instrumento'  = ' ' -- moinstser
         ,      /*009*/ 'Nominal'      = (monominal)
         ,      /*010*/ 'ValorInicio'  = CASE WHEN motipoper = 'CP'  THEN (movalcomp)
                                              WHEN motipoper = 'CI'  THEN (movalinip)
                                              WHEN motipoper = 'VP'  THEN (movpresen)
                                              WHEN motipoper = 'VI'  THEN (movalinip)
                                              WHEN motipoper = 'IB'  THEN (movalinip)
                                              WHEN motipoper = 'FLI' THEN (movalinip)
                                              WHEN motipoper = 'RC'  THEN (movalinip)
                                              WHEN motipoper = 'RV'  THEN (movalinip)
                                         END
         ,      /*011*/ 'Tir'          = (motir)
         ,      /*012*/ 'ValorFinal'   = CASE WHEN motipoper = 'CP'  THEN (movpresen)
                                              WHEN motipoper = 'CI'  THEN (movalvenp)
                                              WHEN motipoper = 'VP'  THEN (movalven)
                                              WHEN motipoper = 'VI'  THEN (movalvenp)
                                              WHEN motipoper = 'IB'  THEN (movalvenp)
                                              WHEN motipoper = 'FLI' THEN (movalvenp)
                                              WHEN motipoper = 'RC'  THEN (movalvenp)
                                              WHEN motipoper = 'RV'  THEN (movalvenp)
                                         END
         ,      /*013*/ 'FPagoInicio'  = convert(char(3),isnull(ini.codigo,0)) + ' - ' + isnull(ini.glosa,'')
         ,      /*014*/ 'FPagoFinal'   = convert(char(3),isnull(ven.codigo,0)) + ' - ' + isnull(ven.glosa,'')
         ,      /*015*/ 'Hora'         = Dcrp_HoraConfirm
         ,      /*016*/ 'Operador'     = Dcrp_OperConfirm
         ,      /*017*/ 'ConfirmaCon'  = Dcrp_OpeCnvConfirm
         ,      /*018*/ 'CodDiscrep'   = Dcrp_Codigo
         ,      /*019*/ 'Tipodiscrp'   = Dcrp_Glosa
         FROM   #PASO                  LEFT JOIN bacparamsuda..CLIENTE            ON morutcli  = clrut AND mocodcli = clcodigo
                                       LEFT JOIN bacparamsuda..MONEDA emi         ON momonemi  = emi.mncodmon
                                       LEFT JOIN bacparamsuda..MONEDA pac         ON momonpact = pac.mncodmon
                                       LEFT JOIN bacparamsuda..FORMA_DE_PAGO ini  ON moforpagi = ini.codigo
                                       LEFT JOIN bacparamsuda..FORMA_DE_PAGO ven  ON moforpagv = ven.codigo
                                       LEFT JOIN bacparamsuda..PRODUCTO pro       ON pro.id_sistema = 'BTR' and pro.codigo_producto = case when motipoper = 'IB' then moinstser else motipoper end
         WHERE  mostatreg              = ''
         AND   (Dcrp_Confirmador       = @EstadoConf OR @EstadoConf = '')
         AND   (morutcli               = @iRut       OR @iRut       = 0)
         AND   (mocodcli               = @iCodCli    OR @iCodCli    = 0)
         AND   (cltipcli               = @iTipCli    OR @iTipCli    = 0)
         AND   (motipoper              = @cTipOper   OR @cTipOper   = '')
         AND   (monumoper              = @iNumOper   or @iNumOper   = 0)

         RETURN
      END 

      IF @Agrupado = 0
      BEGIN
         SELECT /*001*/ 'Confirmacion' = CASE WHEN Dcrp_Confirmador = 'N' THEN 'NO'
                                              WHEN Dcrp_Confirmador = 'S' THEN 'SI'
                                              WHEN Dcrp_Confirmador = ' ' THEN 'NO'
                                         END
         ,      /*002*/ 'TipOper'      = pro.descripcion -- motipoper
         ,      /*003*/ 'NumOPer'      = monumoper
         ,      /*004*/ 'NumDocu'      = monumdocu
         ,      /*005*/ 'Correla'      = mocorrela
         ,      /*006*/ 'Cliente'      = ISNULL( ltrim(rtrim(convert(char(10),clrut))) + '-' + convert(char(1),cldv) + ' ' + substring(clnombre,1,30), '0-0  Cliente no encontrado')
         ,      /*007*/ 'MonedaOp'     = CASE WHEN motipoper = 'CP' THEN convert(char(3),emi.mncodmon) + ' - ' + emi.mnnemo
                                              WHEN motipoper = 'CI' THEN convert(char(3),pac.mncodmon) + ' - ' + pac.mnnemo
                                              WHEN motipoper = 'VP' THEN convert(char(3),emi.mncodmon) + ' - ' + emi.mnnemo
                                              WHEN motipoper = 'VI' THEN convert(char(3),pac.mncodmon) + ' - ' + pac.mnnemo
                                              ELSE                       convert(char(3),emi.mncodmon) + ' - ' + emi.mnnemo
                                         END
         ,      /*008*/ 'Instrumento'  = moinstser
         ,      /*009*/ 'Nominal'      = monominal
         ,      /*010*/ 'ValorInicio'  = CASE WHEN motipoper = 'CP'  THEN movalcomp
                                              WHEN motipoper = 'CI'  THEN movalinip
                                              WHEN motipoper = 'VP'  THEN movpresen
                                              WHEN motipoper = 'VI'  THEN movalinip
                                              WHEN motipoper = 'IB'  THEN movalinip
                                              WHEN motipoper = 'FLI' THEN movalinip
                                       WHEN motipoper = 'RC'  THEN movalinip
                                              WHEN motipoper = 'RV'  THEN movalinip
                                         END
         ,      /*011*/ 'Tir'          = motir
         ,      /*012*/ 'ValorFinal'   = CASE WHEN motipoper = 'CP'  THEN movpresen
                                              WHEN motipoper = 'CI'  THEN movalvenp
                                              WHEN motipoper = 'VP'  THEN movalven
                                              WHEN motipoper = 'VI'  THEN movalvenp
                                              WHEN motipoper = 'IB'  THEN movalvenp
                                              WHEN motipoper = 'FLI' THEN movalvenp
                                              WHEN motipoper = 'RC'  THEN movalvenp
                                              WHEN motipoper = 'RV'  THEN movalvenp
                                         END
         ,      /*013*/ 'FPagoInicio'  = convert(char(3),isnull(ini.codigo,0)) + ' - ' + isnull(ini.glosa,'')
         ,      /*014*/ 'FPagoFinal'   = convert(char(3),isnull(ven.codigo,0)) + ' - ' + isnull(ven.glosa,'')
         ,      /*015*/ 'Hora'         = Dcrp_HoraConfirm
         ,      /*016*/ 'Operador'     = Dcrp_OperConfirm
         ,      /*017*/ 'ConfirmaCon'  = Dcrp_OpeCnvConfirm
         ,      /*018*/ 'CodDiscrep'   = Dcrp_Codigo
         ,      /*019*/ 'Tipodiscrp'   = Dcrp_Glosa
         FROM   bactradersuda..MDMO    LEFT JOIN bacparamsuda..CLIENTE            ON morutcli  = clrut AND mocodcli = clcodigo
                                       LEFT JOIN bacparamsuda..MONEDA emi         ON momonemi  = emi.mncodmon
                                       LEFT JOIN bacparamsuda..MONEDA pac         ON momonpact = pac.mncodmon
                                       LEFT JOIN bacparamsuda..FORMA_DE_PAGO ini  ON moforpagi = ini.codigo
                                       LEFT JOIN bacparamsuda..FORMA_DE_PAGO ven  ON moforpagv = ven.codigo
                                       LEFT JOIN bacparamsuda..PRODUCTO pro       ON pro.id_sistema = 'BTR' and pro.codigo_producto = case when motipoper = 'IB' then moinstser else motipoper end
         WHERE  mostatreg              = ''
         AND   (Dcrp_Confirmador       = @EstadoConf OR @EstadoConf = '')
         AND   (morutcli               = @iRut       OR @iRut       = 0)
         AND   (mocodcli               = @iCodCli    OR @iCodCli    = 0)
         AND   (cltipcli               = @iTipCli    OR @iTipCli    = 0)
         AND   (motipoper              = @cTipOper   OR @cTipOper   = '')
         AND   (monumoper              = @iNumOper   or @iNumOper   = 0)
         AND    motipoper         NOT IN('TM')
         RETURN
      END 
   END

END


GO
