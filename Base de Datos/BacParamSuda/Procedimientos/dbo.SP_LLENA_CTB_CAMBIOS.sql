USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_CTB_CAMBIOS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LLENA_CTB_CAMBIOS]
   (   @dFecha   DATETIME   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @nRutBCCH       	NUMERIC(09)
   DECLARE @ncont 	   	INTEGER
   DECLARE @fecha_chile	   	DATETIME
   DECLARE @fecha_usa	   	DATETIME
   DECLARE @lFlag  		INTEGER
   DECLARE @nregs	   	INTEGER
   DECLARE @fecha 	   	DATETIME
   DECLARE @Dias_ext 	   	INTEGER
   DECLARE @tipo_operacion 	CHAR(5)
   DECLARE @operacion	   	NUMERIC(10)
   DECLARE @dias_valuta	   	INTEGER
   DECLARE @Forma_de_Pago  	NUMERIC(3)
   DECLARE @Rut_Corre_Corp 	NUMERIC(10)
   DECLARE @Rut_bCo_Corp 	NUMERIC(10)
   DECLARE @Cod_Corre_Corp 	NUMERIC(10)
   DECLARE @Cod_bCo_Corp 	NUMERIC(10)

       SET @nRutBCCH       = 97029000   -- Rut Banco Central
       SET @Rut_Corre_Corp = 96665450   -- Rut Corredora CorpBanca
       SET @Cod_Corre_Corp = 1          -- Codigo Corredora CorpBanca
       SET @Rut_BCo_Corp   = 97023000   -- Rut Banco CorpBanca
       SET @Cod_bCo_Corp   = 1          -- Codigo Banco CorpBanca

   SELECT monumope  AS Operacion
   INTO   #Arbi_Empresas
   FROM   MEMO
   WHERE  motipmer   = 'EMPR'
   AND    mocodcnv   = 'USD'
   AND    mocodmon  <> 'USD'
   AND    moestatus <> 'A'


   -->     Tipo de Cambio Contable para Pesos en Arbitraje 
   DECLARE @dFechaProceso   DATETIME
       SET @dFechaProceso   = (SELECT acfecpro FROM MEAC)
   DECLARE @DolarContable   FLOAT
       SET @DolarContable   = (SELECT Tipo_Cambio FROM BacParamSuda..VALOR_MONEDA_CONTABLE WHERE Fecha = @dFechaProceso and codigo_moneda = 994)

   IF @DolarContable = 0 OR @DolarContable  IS NULL 
   BEGIN 
      RETURN -5
   END

   CREATE INDEX #ixcnt_Arbi_Empresas ON #Arbi_Empresas (Operacion)

   SELECT motipmer
        , monumope
        , motipope
        , morutcli
        , mocodcli
        , mocodmon
        , mocodcnv
        , momonmo
        , moticam
        , motctra
        , moussme
        , momonpe
        , moentre
        , morecib
        , movaluta1
        , movaluta2
        , mooper
        , mofech
        , mocodoma
        , moestatus
        , monumfut
        , swift_corresponsal
        , swift_recibimos
        , swift_entregamos
        , forma_pago_cli_nac
        , forma_pago_cli_ext
        , valuta_cli_nac
        , valuta_cli_ext
        , anula_usuario
        , anula_fecha
        , anula_hora
        , anula_motivo
        , mofecvcto
        , cltipcli
     INTO #TMP_MEMO
     FROM MEMO
          LEFT JOIN BacParamSuda..CLIENTE ON morutcli   = clrut AND mocodcli = clcodigo
    WHERE moestatus <> 'A'

   CREATE INDEX #ixt_TMP_MEMO ON #TMP_MEMO (motipmer, mocodcnv, morutcli)

   SELECT tbcodigo1 = CONVERT(INTEGER,tbcodigo1)
        , tbtasa    = CONVERT(INTEGER,tbtasa)
        , tbvalor   = CONVERT(INTEGER,tbvalor)
     INTO #TMP_TABLA_GENERAL_DETALLE
     FROM BacParamSuda..TABLA_GENERAL_DETALLE
    WHERE tbcateg = 400

   CREATE INDEX #ixt_TMP_TABLA_GENERAL_DETALLE ON #TMP_TABLA_GENERAL_DETALLE (tbcodigo1, tbtasa, tbvalor)



   TRUNCATE TABLE BAC_CNT_CONTABILIZA

   /*====================================================================================================================*/
   /* Operaciones de Punta (PERFIL 1, 2)                                                                                 */
   /*====================================================================================================================*/

   INSERT INTO  bac_cnt_contabiliza
   (   id_sistema
   ,   tipo_movimiento
   ,   tipo_operacion
   ,   operacion
   ,   correlativo
   ,   Documento
   ,   codigo_instrumento
   ,   moneda_instrumento
   ,   Codigo_Moneda
   ,   Monto_Origen
   ,   Monto_Dolar
   ,   Monto_Pesos
   ,   Forma_Pago_Mn
   ,   Forma_Pago_Mx
   ,   Forma_Pago_Us
   ,   Fecha_Proceso
   ,   Fecha_Contable
   ,   Tipo_Mercado
   ,   Rut_Cliente
   ,   codigo_cliente
   ,   tipo_cambio
   ,   Moneda_Conversion
   )
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = CASE WHEN cltipcli = 4   THEN 'MCB'  ELSE 'MOV'  END -- CASE WHEN motipmer = 'EMPR' AND cltipcli NOT IN(1,2,3,4) THEN 'MVE' ELSE 'MOV' END
   ,      'tipo_operacion'     = CASE WHEN motipope = 'C' THEN 'CMXN' ELSE 'VMXN' END
   ,      'operacion'          = monumope
   ,      'correlativo'        = isnull(tbcodigo1,0)
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,      'Codigo_Moneda'      = F.mncodmon -- mocodmon
   ,      'Monto_Origen'       = momonmo
   ,      'Monto_Dolar'        = moussme
   ,      'Monto_Pesos'        = momonpe
   ,      'Forma_Pago_Mn'      = CASE WHEN motipope = 'C' THEN moentre ELSE morecib END
   ,      'Forma_Pago_Mx'      = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END
   ,      'Forma_Pago_Us'      = 0
   ,      'Fecha_Proceso'      = mofech
   ,      'Fecha_Contable'     = mofech
   ,      'Tipo_Mercado'       = motipmer
   ,      'Rut_Cliente'        = morutcli
   ,      'codigo_cliente'     = mocodcli
   ,      'tipo_cambio'        = moticam
   ,      'Moneda_Conversion'  = cnv.mncodmon
   FROM    #TMP_MEMO           AS ME --> (INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
           LEFT JOIN #TMP_TABLA_GENERAL_DETALLE ON tbtasa     = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END AND tbvalor = anula_motivo
           LEFT JOIN BacParamSuda..MONEDA F     ON F.mnnemo   = mocodmon
           LEFT JOIN BacParamSuda..MONEDA cnv   ON cnv.mnnemo = mocodcnv
   WHERE   motipmer           IN('PTAS','EMPR')
   and     mocodcnv            = 'CLP'
   and     morutcli       NOT IN(1,2,3,4,5,70, @nRutBCCH)
   and     cltipcli           IN(1,2,3,4)
   AND     monumope       NOT IN(SELECT Operacion FROM #Arbi_Empresas)

   /*====================================================================================================================*/
   /* Operaciones de Punta y Empresa Reversa M/X                                                                                      */
   /*====================================================================================================================*/


 INSERT INTO bac_cnt_contabiliza
   (   id_sistema
   ,   tipo_movimiento
   ,   tipo_operacion
   ,   operacion
   ,   correlativo
   ,   Documento
   ,   codigo_instrumento
   ,   moneda_instrumento
   ,   Codigo_Moneda
   ,   Monto_Origen
   ,   Monto_Dolar
   ,   Monto_Pesos
   ,   Forma_Pago_Mn
   ,   Forma_Pago_Mx
   ,   Forma_Pago_Us
   ,   Fecha_Proceso
   ,   Fecha_Contable
   ,   Tipo_Mercado
   ,   Rut_Cliente
   ,   codigo_cliente
   ,   tipo_cambio
   ,   Moneda_Conversion
   )
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = CASE WHEN cltipcli = 4   THEN 'MCB'  ELSE 'MOV'  END --> CASE WHEN motipmer = 'EMPR' AND cltipcli NOT IN(1,2,3,4) THEN 'MVE' ELSE 'MOV' END
   ,      'tipo_operacion'     = CASE WHEN motipope = 'C' THEN 'ACMX' ELSE 'AVMX' END
   ,      'operacion'          = monumope
   ,      'correlativo'        = isnull(tbcodigo1,0)
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,      'Codigo_Moneda'      = F.mncodmon -- mocodmon
   ,      'Monto_Origen'       = momonmo
   ,      'Monto_Dolar'        = moussme
   ,      'Monto_Pesos'        = momonpe
   ,      'Forma_Pago_Mn'      = CASE WHEN motipope = 'C' THEN moentre ELSE morecib END
   ,      'Forma_Pago_Mx'      = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END
   ,      'Forma_Pago_Us'      = 0
   ,      'Fecha_Proceso'      = mofech
   ,      'Fecha_Contable'     = mofech
   ,      'Tipo_Mercado'       = motipmer
   ,      'Rut_Cliente'        = morutcli
   ,      'codigo_cliente'     = mocodcli
   ,      'tipo_cambio'        = moticam
   ,      'Moneda_Conversion'  = cnv.mncodmon
   FROM   #TMP_MEMO            AS ME --> (INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
          LEFT JOIN #TMP_TABLA_GENERAL_DETALLE    ON tbtasa     = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END and tbvalor = anula_motivo
          LEFT JOIN BacParamSuda..MONEDA          ON mocodcnv   = mnnemo
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO   ON Codigo     = (CASE WHEN motipope = 'C' THEN moentre ELSE morecib END) --> AND cc2756 = 'N'
          LEFT JOIN BacParamSuda..MONEDA F        ON F.mnnemo   = mocodmon
          LEFT JOIN BacParamSuda..MONEDA cnv      ON cnv.mnnemo = mocodcnv
   WHERE  mocodcnv             = 'CLP'
   and    morutcli       NOT IN(@nRutBCCH)
   and    motipmer           IN('PTAS','EMPR')
   and    morutcli       NOT IN(1,2,3,4,5,6,70)
   and    cltipcli           IN(1,2,3,4)
   and   (diasvalor          >= 1 or Codigo IN(101,131))
   AND     monumope      NOT IN(SELECT Operacion FROM #Arbi_Empresas)



   /*====================================================================================================================*/
   /* Operaciones de Punta y Empresa Reversa M/N    */
   /*====================================================================================================================*/

   INSERT INTO bac_cnt_contabiliza
   (   id_sistema
   ,   tipo_movimiento
   ,   tipo_operacion
   ,   operacion
   ,   correlativo
   ,   Documento
   ,   codigo_instrumento
   ,   moneda_instrumento
   ,   Codigo_Moneda
   ,   Monto_Origen
   ,   Monto_Dolar
   ,   Monto_Pesos
   ,   Forma_Pago_Mn
   ,   Forma_Pago_Mx
   ,   Forma_Pago_Us
   ,   Fecha_Proceso
   ,   Fecha_Contable
   ,   Tipo_Mercado
   ,   Rut_Cliente
   ,   codigo_cliente
   ,   tipo_cambio
   ,   Moneda_Conversion
   )
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = CASE WHEN cltipcli = 4   THEN 'MCB'  ELSE 'MOV'  END --> CASE WHEN motipmer = 'EMPR' AND cltipcli NOT IN(1,2,3,4) THEN 'MVE' ELSE 'MOV' END
   ,      'tipo_operacion'     = CASE WHEN motipope = 'C' THEN 'ACMN' ELSE 'AVMN' END
   ,      'operacion'          = monumope
   ,      'correlativo'        = isnull(tbcodigo1,0)
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,      'Codigo_Moneda'      = F.mncodmon -- mocodcnv
   ,      'Monto_Origen'       = momonmo
   ,      'Monto_Dolar'        = moussme
   ,      'Monto_Pesos'        = momonpe
   ,      'Forma_Pago_Mn'      = CASE WHEN motipope = 'C' THEN moentre ELSE morecib END
   ,      'Forma_Pago_Mx'      = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END
   ,      'Forma_Pago_Us'      = 0
   ,      'Fecha_Proceso'      = mofech
   ,      'Fecha_Contable'     = mofech
   ,      'Tipo_Mercado'       = motipmer
   ,      'Rut_Cliente'        = morutcli
   ,      'codigo_cliente'     = mocodcli
   ,      'tipo_cambio'        = moticam
   ,      'Moneda_Conversion'  = cnv.mncodmon
   FROM   #TMP_MEMO            AS ME --> (INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
          LEFT JOIN #TMP_TABLA_GENERAL_DETALLE   ON tbtasa     = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END and tbvalor = anula_motivo
          LEFT JOIN BacParamSuda..MONEDA         ON mocodcnv   = mnnemo
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO  ON Codigo     = (CASE WHEN motipope = 'C' THEN moentre ELSE morecib END) -- AND cc2756 = 'N'
          LEFT JOIN BacParamSuda..MONEDA F       ON F.mnnemo   = mocodcnv
          LEFT JOIN BacParamSuda..MONEDA cnv     ON cnv.mnnemo = mocodcnv
   WHERE  mocodcnv             = 'CLP'
   AND    morutcli        NOT IN(@nRutBCCH)
   AND   (motipmer             = 'PTAS' 
      OR (motipmer             = 'EMPR' AND (monumfut = 0 OR (cltipcli IN(1,4) AND morutcli <> 96665450))))
   AND    morutcli        NOT IN(1,2,3,4,5,70)
   and    cltipcli            IN(1,2,3,4)
   AND    codigo              <> 5
   AND   (diasvalor           >= 1 or Codigo IN(104,106))
   AND    monumope        NOT IN(SELECT Operacion FROM #Arbi_Empresas)

   /*====================================================================================================================*/
   /* Operaciones de Punta Cupo - Canje                                 */
   /*====================================================================================================================*/

   INSERT INTO bac_cnt_contabiliza
   (   id_sistema
   ,   tipo_movimiento
   ,   tipo_operacion
   ,   operacion
   ,   correlativo
   ,   Documento
   ,   codigo_instrumento
   ,   moneda_instrumento
   ,   Codigo_Moneda
   ,   Monto_Origen
   ,   Monto_Dolar
   ,   Monto_Pesos
   ,   Forma_Pago_Mn
   ,   Forma_Pago_Mx
   ,   Forma_Pago_Us
   ,   Fecha_Proceso
   ,   Fecha_Contable
   ,   Tipo_Mercado
   ,   rut_cliente
   ,   codigo_cliente
   ,   tipo_cambio
   ,   Moneda_Conversion
   )
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = CASE WHEN cltipcli = 4   THEN 'MCB'  ELSE 'MOV'  END
   ,      'tipo_operacion'     = 'CMXN'
   ,      'operacion'          = monumope
   ,      'correlativo'        = isnull(tbcodigo1,0)
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,      'Codigo_Moneda'      = F.mncodmon -- mocodmon
   ,      'Monto_Origen'       = momonmo
   ,      'Monto_Dolar'        = moussme
   ,      'Monto_Pesos'        = (momonmo * motctra)
   ,      'Forma_Pago_Mn'      = moentre
   ,      'Forma_Pago_Mx'      = morecib
   ,      'Forma_Pago_Us'      = 0
   ,      'Fecha_Proceso'      = mofech
   ,      'Fecha_Contable'     = mofech
   ,      'Tipo_Mercado'       = motipmer
   ,      'Rut_Cliente'        = morutcli
   ,      'codigo_cliente'     = mocodcli
   ,      'tipo_cambio'        = motctra
   ,      'Moneda_Conversion'  = cnv.mncodmon
   FROM   #TMP_MEMO            AS ME --> (INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
          LEFT JOIN #TMP_TABLA_GENERAL_DETALLE    ON tbtasa     = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END and tbvalor = anula_motivo
          LEFT JOIN BacParamSuda..MONEDA F        ON F.mnnemo   = mocodmon
          LEFT JOIN BacParamSuda..MONEDA cnv      ON cnv.mnnemo = mocodcnv
   WHERE  motipmer            IN('CUPO','CANJ')
   AND    cltipcli            IN(1,2,3)
   AND    monumope        NOT IN(SELECT Operacion FROM #Arbi_Empresas)

   /*====================================================================================================================*/
   /* Operaciones de Cupo - Canje                                */
   /*====================================================================================================================*/

   INSERT INTO bac_cnt_contabiliza
   (   id_sistema
   ,   tipo_movimiento
   ,   tipo_operacion
   ,   operacion
   ,   correlativo
   ,   Documento
   ,   codigo_instrumento
   ,   moneda_instrumento
   ,   Codigo_Moneda
   ,   Monto_Origen
   ,   Monto_Dolar
   ,   Monto_Pesos
   ,   Forma_Pago_Mn
   ,   Forma_Pago_Mx
   ,   Forma_Pago_Us
   ,   Fecha_Proceso
   ,   Fecha_Contable
   ,   Tipo_Mercado
   ,   rut_cliente
   ,   codigo_cliente
   ,   tipo_cambio
   ,   Moneda_Conversion
   )
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = CASE WHEN cltipcli = 4   THEN 'MCB' ELSE 'MOV' END
   ,      'tipo_operacion'     = 'VMXN'
   ,      'operacion'          = monumope
   ,      'correlativo'        = isnull(tbcodigo1,0)
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,      'Codigo_Moneda'      = F.mncodmon -- mocodmon
   ,      'Monto_Origen'       = momonmo
   ,      'Monto_Dolar'        = moussme
   ,      'Monto_Pesos'        = momonpe
   ,      'Forma_Pago_Mn'      = forma_pago_cli_nac
   ,      'Forma_Pago_Mx'      = forma_pago_cli_ext
   ,      'Forma_Pago_Us'      = 0
   ,      'Fecha_Proceso'      = mofech
   ,      'Fecha_Contable'     = mofech
   ,      'Tipo_Mercado'       = motipmer
   ,      'Rut_Cliente'        = morutcli
   ,      'codigo_cliente'     = mocodcli
   ,      'tipo_cambio'        = moticam
   ,      'Moneda_Conversion'  = cnv.mncodmon
   FROM   #TMP_MEMO            AS ME --> (INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
          LEFT JOIN #TMP_TABLA_GENERAL_DETALLE ON tbtasa     = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END and tbvalor = anula_motivo
          LEFT JOIN BacParamSuda..MONEDA F     ON F.mnnemo   = mocodmon
          LEFT JOIN BacParamSuda..MONEDA cnv   ON cnv.mnnemo = mocodcnv
   WHERE  motipmer            IN('CUPO','CANJ')
   AND    cltipcli            IN(1,2,3)
   AND    monumope        NOT IN(SELECT Operacion FROM #Arbi_Empresas)

   /*====================================================================================================================*/
   /* Operaciones de Punta Arriendo                                                                                      */
   /*====================================================================================================================*/

   INSERT INTO bac_cnt_contabiliza
   (   id_sistema
   ,   tipo_movimiento
   ,   tipo_operacion
   ,   operacion
   ,   correlativo
   ,   Documento
   ,   codigo_instrumento
   ,   moneda_instrumento
   ,   Codigo_Moneda
   ,   Monto_Origen
   ,   Monto_Dolar
   ,   Monto_Pesos
   ,   Forma_Pago_Mn
   ,   Forma_Pago_Mx
   ,   Forma_Pago_Us
   ,   Fecha_Proceso
   ,   Fecha_Contable
   ,   Tipo_Mercado
   ,   rut_cliente
   ,   codigo_cliente
   ,   tipo_cambio
   ,   Moneda_Conversion
   )
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = CASE WHEN cltipcli = 4   THEN 'MCB'  ELSE 'MOV'  END
   ,      'tipo_operacion'     = CASE WHEN motipope = 'C' THEN 'CMXN' ELSE 'VMXN' END
   ,      'operacion'          = monumope
   ,      'correlativo'        = isnull(tbcodigo1,0)
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,      'Codigo_Moneda'      = F.mncodmon -- mocodmon
   ,      'Monto_Origen'       = momonmo
   ,      'Monto_Dolar'        = moussme
   ,      'Monto_Pesos'        = momonpe
   ,      'Forma_Pago_Mn'      = CASE WHEN motipope = 'C' THEN moentre ELSE morecib END
   ,      'Forma_Pago_Mx'      = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END
   ,      'Forma_Pago_Us'      = 0
   ,      'Fecha_Proceso'      = mofech
   ,      'Fecha_Contable'     = mofech
   ,      'Tipo_Mercado'       = motipmer
   ,      'Rut_Cliente'        = morutcli
   ,      'codigo_cliente'     = mocodcli
   ,      'tipo_cambio'        = moticam
   ,      'Moneda_Conversion'  = cnv.mncodmon
   FROM   #TMP_MEMO            AS ME --> (INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
          LEFT JOIN #TMP_TABLA_GENERAL_DETALLE ON tbtasa     = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END and tbvalor = anula_motivo
          LEFT JOIN BacParamSuda..MONEDA F     ON F.mnnemo   = mocodmon
          LEFT JOIN BacParamSuda..MONEDA cnv   ON cnv.mnnemo = mocodcnv
   WHERE  motipmer            IN('ARRI')
   AND    monumope        NOT IN(SELECT Operacion FROM #Arbi_Empresas)

   /*====================================================================================================================*/
   /* Operaciones de Arbitraje (PERFIL 3, 4)                                                                             */
   /*====================================================================================================================*/

   INSERT INTO bac_cnt_contabiliza
   (   id_sistema
   ,   tipo_movimiento
   ,   tipo_operacion
   ,   operacion
   ,   correlativo
   ,   Documento
   ,   codigo_instrumento
   ,   moneda_instrumento
   ,   Codigo_Moneda
   ,   Monto_Origen
   ,   Monto_Dolar
   ,   Monto_Pesos
   ,   Forma_Pago_Mn
   ,   Forma_Pago_Mx
   ,   Forma_Pago_Us
   , Fecha_Proceso
   ,   Fecha_Contable
   ,   Tipo_Mercado
   ,   rut_cliente
   ,   codigo_cliente
   ,   tipo_cambio
   ,   Moneda_Conversion
   )
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = CASE WHEN cltipcli = 4   THEN 'MCB'  ELSE 'MOV'  END
   ,      'tipo_operacion'     = CASE WHEN motipope = 'C' THEN 'CMXA' ELSE 'VMXA' END
   ,      'operacion'          = monumope
   ,      'correlativo'        = isnull(C.tbcodigo1,0)
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,      'Codigo_Moneda'      = F.mncodmon -- mocodmon
   ,      'Monto_Origen'       = momonmo 
   ,      'Monto_Dolar'        = moussme
   ,      'Monto_Pesos'        = CASE WHEN monumfut = 0 THEN ROUND(moussme * @DolarContable,0) -->  momonpe 
                                      ELSE                   ROUND((moussme * moticam),0) 
                                 END
   ,      'Forma_Pago_Mn'      = isnull(D.tbcodigo1,0)
   ,      'Forma_Pago_Mx'      = CASE WHEN motipope = 'C' THEN moentre ELSE morecib END
   ,      'Forma_Pago_Us'      = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END
   ,      'Fecha_Proceso'      = mofech
   ,      'Fecha_Contable'     = mofech
   ,      'Tipo_Mercado'       = motipmer
   ,      'Rut_Cliente'        = morutcli
   ,      'codigo_cliente'     = mocodcli
   ,      'tipo_cambio'        = moticam
   ,      'Moneda_Conversion'  = cnv.mncodmon
   FROM   #TMP_MEMO            AS ME --> (INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
          LEFT JOIN BacParamSuda..CORRESPONSAL A ON CONVERT(CHAR(10),A.cod_corresponsal) = CASE WHEN motipope = 'C' THEN Swift_Corresponsal ELSE Swift_Entregamos   END
          LEFT JOIN BacParamSuda..CORRESPONSAL B ON CONVERT(CHAR(10),B.cod_corresponsal) = CASE WHEN motipope = 'C' THEN Swift_Entregamos   ELSE Swift_Corresponsal END
          LEFT JOIN #TMP_TABLA_GENERAL_DETALLE C ON C.tbtasa = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END and C.tbvalor = A.codigo_contable --anula_motivo
          LEFT JOIN #TMP_TABLA_GENERAL_DETALLE D ON D.tbtasa = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END and D.tbvalor = B.codigo_contable --anula_motivo
          LEFT JOIN BacParamSuda..MONEDA F       ON F.mnnemo = mocodmon
          LEFT JOIN BacParamSuda..MONEDA cnv     ON cnv.mnnemo = mocodcnv
   WHERE  motipmer            IN('ARBI')
   AND    morutcli        NOT IN(1,2)
   AND    cltipcli            IN(1,2,3)
   AND    monumope        NOT IN(SELECT Operacion FROM #Arbi_Empresas)

   /*=============================================================================================================*/
   /*===== Operaciones de Arbitraje Reversa ======================================================================*/
   /*=============================================================================================================*/

   INSERT INTO bac_cnt_contabiliza
   (   id_sistema
   ,   tipo_movimiento
   ,   tipo_operacion
   ,   operacion
   ,   correlativo
   ,   Documento
   ,   codigo_instrumento
   ,   moneda_instrumento
   ,   Codigo_Moneda
   ,   Monto_Origen
   ,   Monto_Dolar
   ,   Monto_Pesos
   ,   Forma_Pago_Mn
   ,   Forma_Pago_Mx
   ,   Forma_Pago_Us
   ,   Fecha_Proceso
   ,   Fecha_Contable
   ,   Tipo_Mercado
   ,   rut_cliente
   ,   codigo_cliente
   ,   tipo_cambio
   ,   Moneda_Conversion
   )
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = CASE WHEN cltipcli = 4   THEN 'MCB'  ELSE 'MOV'  END
   ,      'tipo_operacion'     = CASE WHEN motipope = 'C' THEN 'ACAR' ELSE 'AVAR' END
   ,      'operacion'          = monumope
   ,      'correlativo'        = isnull(C.tbcodigo1,0)
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,      'Codigo_Moneda'      = F.mncodmon -- mocodmon
   ,      'Monto_Origen'       = momonmo
   ,      'Monto_Dolar'        = moussme
   ,      'Monto_Pesos'        = CASE WHEN monumfut = 0 THEN ROUND(moussme * @DolarContable,0) --> momonpe 
                                      ELSE                   ROUND((moussme * moticam),0) 
                                 END
   ,      'Forma_Pago_Mn'      = isnull(D.tbcodigo1,0)
   ,      'Forma_Pago_Mx'      = CASE WHEN motipope = 'C' THEN moentre ELSE morecib END
   ,      'Forma_Pago_Us'      = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END
   ,      'Fecha_Proceso'      = mofech
   ,      'Fecha_Contable'     = mofech
   ,      'Tipo_Mercado'       = motipmer
   ,      'Rut_Cliente'        = morutcli
   ,      'codigo_cliente'     = mocodcli
   ,      'tipo_cambio'        = moticam
   ,      'Moneda_Conversion'  = cnv.mncodmon
   FROM   #TMP_MEMO            AS ME --> (INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
          LEFT JOIN BacParamSuda..CORRESPONSAL A ON CONVERT(CHAR(10),A.cod_corresponsal) = CASE WHEN motipope = 'C' THEN Swift_Corresponsal ELSE Swift_Entregamos   END
          LEFT JOIN BacParamSuda..CORRESPONSAL B ON CONVERT(CHAR(10),B.cod_corresponsal) = CASE WHEN motipope = 'C' THEN Swift_Entregamos   ELSE Swift_Corresponsal END
          LEFT JOIN #TMP_TABLA_GENERAL_DETALLE C ON C.tbtasa   = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END and C.tbvalor = A.codigo_contable --anula_motivo
          LEFT JOIN #TMP_TABLA_GENERAL_DETALLE D ON D.tbtasa   = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END and D.tbvalor = B.codigo_contable --anula_motivo
          LEFT JOIN BacParamSuda..MONEDA F       ON F.mnnemo   = mocodmon
          LEFT JOIN BacParamSuda..MONEDA cnv     ON cnv.mnnemo = mocodcnv
   WHERE  motipmer            IN('ARBI')
   AND    morutcli        NOT IN(1,2)
   AND    cltipcli            IN(1,2,3)
   AND    monumope        NOT IN(SELECT Operacion FROM #Arbi_Empresas)

   /*====================================================================================================================*/
   /* Operaciones Overnight / Weekend 	Inicio								    	 	 */
   /*====================================================================================================================*/

   INSERT INTO  bac_cnt_contabiliza
   (   id_sistema
   ,   tipo_movimiento
   ,   tipo_operacion
   ,   operacion
   ,   correlativo
   ,   Documento
   ,   codigo_instrumento
   ,   moneda_instrumento
   ,   Codigo_Moneda
   ,   Monto_Origen
   ,   Monto_Dolar
   ,   Monto_Pesos
   ,   Forma_Pago_Mn
   ,   Forma_Pago_Mx
   ,   Forma_Pago_Us
   ,   Fecha_Proceso
   ,   Fecha_Contable
   ,   Tipo_Mercado
   ,   Rut_Cliente
   ,   codigo_cliente
   ,   tipo_cambio
   ,   Moneda_Conversion
   )
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = CASE WHEN cltipcli = 4   THEN 'MCB'  ELSE 'MOV'  END
   ,      'tipo_operacion'     = 'OVER'
   ,      'operacion'          = monumope
   ,      'correlativo'        = Swift_Corresponsal
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,      'Codigo_Moneda'      = F.mncodmon -- mocodmon
   ,      'Monto_Origen'       = ROUND(momonmo,2,0)
   ,      'Monto_Dolar'        = 0.0
   ,      'Monto_Pesos'        = 0.0
   ,      'Forma_Pago_Mn'      = CASE WHEN motipope = 'C' THEN moentre ELSE morecib END
   ,      'Forma_Pago_Mx'      = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END
   ,      'Forma_Pago_Us'      = 0
   ,      'Fecha_Proceso'      = mofech
   ,      'Fecha_Contable'     = mofech
   ,      'Tipo_Mercado'       = motipmer
   ,      'Rut_Cliente'        = morutcli
   ,      'codigo_cliente'     = mocodcli
   ,      'tipo_cambio'        = moticam
   ,      'Moneda_Conversion'  = cnv.mncodmon
   FROM   #TMP_MEMO            AS ME --> (INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
          LEFT JOIN #TMP_TABLA_GENERAL_DETALLE ON tbtasa     = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END and tbvalor = anula_motivo
          LEFT JOIN BacParamSuda..MONEDA F     ON F.mnnemo  = mocodmon
          LEFT JOIN BacParamSuda..MONEDA cnv   ON cnv.mnnemo = mocodcnv
   WHERE  motipmer            IN('OVER','WEEK')
   AND    monumope        NOT IN(SELECT Operacion FROM #Arbi_Empresas)

   /*====================================================================================================================*/
   /* Operaciones Overnight / Weekend 	Ajuste al Vencimiento							    	 */
   /*====================================================================================================================*/

   INSERT INTO bac_cnt_contabiliza
   (   id_sistema
   ,   tipo_movimiento
   ,   tipo_operacion
   ,   operacion
   ,   correlativo
   ,   Documento
   ,   codigo_instrumento
   ,   moneda_instrumento
   ,   Codigo_Moneda
   ,   Monto_Origen
   ,   Monto_Dolar
   ,   Monto_Pesos
   ,   Forma_Pago_Mn
   ,   Forma_Pago_Mx
   ,   Forma_Pago_Us
   ,   Fecha_Proceso
   ,   Fecha_Contable
   ,   Tipo_Mercado
   ,   Rut_Cliente
   ,   codigo_cliente
   ,   tipo_cambio
   ,   Moneda_Conversion
   )
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = CASE WHEN cltipcli = 4 THEN 'MCB' ELSE 'MOV' END
   ,      'tipo_operacion'     = 'AOVE'
   ,      'operacion'          = monumope
   ,      'correlativo'        = Swift_Corresponsal
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,      'Codigo_Moneda'      = F.mncodmon -- mocodmon
   ,      'Monto_Origen'       = ROUND(momonmo,2,0)
   ,      'Monto_Dolar'        = ROUND(moussme,2,0)
   ,      'Monto_Pesos'        = ROUND(ROUND(moussme,2,0) - ROUND(momonmo,2,0),2,0)
   ,      'Forma_Pago_Mn'      = CASE WHEN motipope = 'C' THEN moentre ELSE morecib END
   ,      'Forma_Pago_Mx'      = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END
   ,      'Forma_Pago_Us'      = 0
   ,      'Fecha_Proceso'      = mofech
   ,      'Fecha_Contable'     = mofecvcto
   ,      'Tipo_Mercado'       = motipmer
   ,      'Rut_Cliente'        = morutcli
   ,      'codigo_cliente'     = mocodcli
   ,      'tipo_cambio'        = moticam
   ,      'Moneda_Conversion'  = cnv.mncodmon
   FROM   #TMP_MEMO            AS ME --> (INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
          LEFT JOIN #TMP_TABLA_GENERAL_DETALLE ON tbtasa     = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END and tbvalor = anula_motivo
          LEFT JOIN BacParamSuda..MONEDA F     ON F.mnnemo   = mocodmon
          LEFT JOIN BacParamSuda..MONEDA cnv   ON cnv.mnnemo = mocodcnv
   WHERE  motipmer           IN('OVER','WEEK')
   AND    monumope       NOT IN(SELECT Operacion FROM #Arbi_Empresas)

   /*===============================================================================================================*/
   /*===== Cambio en las Forma de Pago (Cuando es Viernes y Telex 48 Horas (13), Cambia por Telex 24 Horas (12).====*/
   /*===============================================================================================================*/
   UPDATE BAC_CNT_CONTABILIZA
   SET    Forma_Pago_Mn = CASE WHEN DATEPART(WEEKDAY, Fecha_Proceso) = 6 AND Forma_Pago_Mn = 13 THEN 12 
                               ELSE                                                                  Forma_Pago_Mn
                          END,
          Forma_Pago_Mx = CASE WHEN DATEPART(WEEKDAY, Fecha_Proceso) = 6 AND Forma_Pago_Mx = 13 THEN 12
                               ELSE                                                                  Forma_Pago_Mx
                          END
   WHERE  BAC_CNT_CONTABILIZA.tipo_operacion NOT IN('CMXA','VMXA')
   AND    Tipo_Mercado                       NOT IN('CANJ')

   DELETE FROM BAC_CNT_CONTABILIZA 
         WHERE Forma_Pago_Mx   = 15 
           AND tipo_operacion IN('ACMX','AVMX') -- OP con Cheque no genera Ajuste segun hugo

   /***********************************************************************/
   DELETE FROM BAC_CNT_CONTABILIZA 
         WHERE (rut_cliente = @Rut_Corre_Corp AND Codigo_cliente = @Cod_Corre_Corp)

   DELETE FROM BAC_CNT_CONTABILIZA 
         WHERE (rut_cliente = @Rut_bCo_Corp   AND Codigo_cliente = @Cod_bCo_Corp)

   /****** no van las operaciones que son con la corredora del banco ******/
   /******************* Vencimientos de Valutas MX y MN *******************/
   --Contabilización Valutas $$ --Agrega la Fecha Contable
   /******************** Feriado Plaza EEUU ***********************************/


   DECLARE @iMax        INTEGER
   DECLARE @iMin        INTEGER

   SELECT fecha_proceso  = fecha_proceso
        , tipo_operacion = tipo_operacion
        , diasvalor      = Fpag.diasvalor
        , codigo         = Fpag.codigo
        , Puntero        = Identity(INT)
     INTO #TMP_FERIADOS_A
     FROM BAC_CNT_CONTABILIZA 
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO Fpag ON Forma_Pago_Mx = Fpag.codigo
    WHERE tipo_operacion      IN('ACMX','AVMX','ACAR','AVAR')
 GROUP BY fecha_proceso, tipo_operacion, Fpag.diasvalor, Fpag.codigo

   CREATE INDEX #ixt_TMP_FERIADOS_A ON #TMP_FERIADOS_A (Puntero)

      SET @iMax        = (SELECT MAX(Puntero) FROM #TMP_FERIADOS_A)
      SET @iMin        = (SELECT MIN(Puntero) FROM #TMP_FERIADOS_A)

   WHILE @iMax >= @iMin
   BEGIN
      SELECT @fecha           = fecha_proceso
      ,      @tipo_operacion  = tipo_operacion
      ,      @dias_valuta     = diasvalor
      ,      @Forma_de_Pago   = codigo
      FROM   #TMP_FERIADOS_A
      WHERE  Puntero          = @iMin

      SET @lflag    = -1
      SET @Dias_Ext = @dias_valuta

      WHILE @lflag = -1 
      BEGIN
         EXECUTE SP_BUSCA_FECHA_PROXIMA_HABIL @Fecha, @dias_valuta, 6,   @fecha_chile OUTPUT
         EXECUTE SP_BUSCA_FECHA_PROXIMA_HABIL @fecha, @Dias_Ext,    225, @fecha_usa   OUTPUT

         IF @fecha_chile > @fecha_usa 
         BEGIN
            SET @Dias_Ext = @Dias_Ext + 1	
            SET @lflag    = -1
         END
         IF  @fecha_usa > @fecha_chile
         BEGIN
            SET @dias_valuta = @dias_valuta + 1	
            SET @lflag       = -1
         END
         IF @fecha_usa = @fecha_chile
            SET @lflag = 0
      END						

      UPDATE BAC_CNT_CONTABILIZA
         SET Fecha_Contable = @fecha_chile
       WHERE fecha_proceso  = @dfecha
         AND tipo_operacion = @tipo_operacion
         AND Forma_Pago_Mx  = @Forma_de_Pago

      SET @iMin = @iMin + 1 
   END

   SELECT fecha_proceso  = fecha_proceso
        , tipo_operacion = tipo_operacion
        , diasvalor      = Fpag.diasvalor
        , codigo         = Fpag.codigo
        , Puntero        = Identity(INT)
     INTO #TMP_FERIADOS_B
     FROM BAC_CNT_CONTABILIZA 
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO Fpag ON Forma_Pago_Mn = Fpag.codigo
    WHERE tipo_operacion IN('ACMN', 'AVMN')
 GROUP BY fecha_proceso, tipo_operacion, Fpag.diasvalor, Fpag.codigo

   CREATE INDEX #ixt_TMP_FERIADOS_B ON #TMP_FERIADOS_B (Puntero)

      SET @iMax        = (SELECT MAX(Puntero) FROM #TMP_FERIADOS_B)
      SET @iMin        = (SELECT MIN(Puntero) FROM #TMP_FERIADOS_B)

   WHILE @iMax >= @iMin
   BEGIN
      SELECT @fecha           = fecha_proceso
      ,      @tipo_operacion  = tipo_operacion
      ,      @dias_valuta     = diasvalor
      ,      @Forma_de_Pago   = codigo
      FROM   #TMP_FERIADOS_B
      WHERE  Puntero          = @iMin

      IF @fecha = @dFecha AND @tipo_operacion IN('ACMN', 'AVMN')
      BEGIN
         EXECUTE SP_BUSCA_FECHA_PROXIMA_HABIL @Fecha, @dias_valuta, 6 , @fecha_chile OUTPUT

         UPDATE BAC_CNT_CONTABILIZA
         SET	Fecha_Contable  = @fecha_chile
         WHERE	@dfecha		= fecha_proceso		
         AND    @tipo_operacion	= tipo_operacion	
         AND    @Forma_de_Pago  = Forma_Pago_Mn
      END
   
      SET @iMin = @iMin + 1
   END

END



GO
