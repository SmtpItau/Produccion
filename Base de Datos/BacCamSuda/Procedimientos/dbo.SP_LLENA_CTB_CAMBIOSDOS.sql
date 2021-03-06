USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_CTB_CAMBIOSDOS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LLENA_CTB_CAMBIOSDOS]
   (   @dFecha DATETIME   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @nRutBCCH       	NUMERIC(09)
   ,       @ncont 	   	INTEGER
   ,       @fecha_chile	   	DATETIME
   ,       @fecha_usa	   	DATETIME
   ,       @lFlag  		INTEGER
   ,       @nregs	   	INTEGER
   ,       @fecha 	   	DATETIME
   ,       @Dias_ext 	   	INTEGER
   ,       @tipo_operacion 	CHAR(5)
   ,       @operacion	   	NUMERIC(10)
   ,       @dias_valuta	   	INTEGER
   ,       @Forma_de_Pago  	NUMERIC(3)
   ,       @Rut_Corre_Corp 	NUMERIC(10)
   ,       @Rut_bCo_Corp 	NUMERIC(10)
   ,       @Cod_Corre_Corp 	NUMERIC(10)
   ,       @Cod_bCo_Corp 	NUMERIC(10)

   SELECT @nRutBCCH           = 97029000   -- Banco Central
   ,      @Rut_Corre_Corp     = 96665450   -- Rut corredora CorpBanca
   ,	  @Rut_BCo_Corp       = 97023000
   ,      @Cod_Corre_Corp     = 1          -- Codigo corredora CorpBanca
   , 	  @Cod_bCo_Corp       = 1

   SELECT monumope  as Operacion
   INTO   #Arbi_Empresas
   FROM   MEMO
   WHERE  motipmer  = 'EMPR'
   AND    mocodcnv  = 'USD'
   AND    mocodmon <> 'USD'

   DELETE BAC_CNT_CONTABILIZA

   /*====================================================================================================================*/
   /* Operaciones de Punta (PERFIL 1, 2)                                                                                 */
   /*====================================================================================================================*/

SELECT '1'
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
   )
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = 'MOV'
   ,      'tipo_operacion'     = CASE WHEN motipope = 'C' THEN 'CMXN' ELSE 'VMXN' END
   ,      'operacion'          = monumope
   ,      'correlativo'        = isnull(tbcodigo1,0)
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,      'Codigo_Moneda'      = mocodmon
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
   FROM    MEMO                AS Me--(INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
                               LEFT JOIN bacparamsuda..TABLA_GENERAL_DETALLE ON tbcateg = 400 AND tbtasa  = (CASE WHEN motipope = 'V' THEN moentre ELSE morecib END) AND convert(numeric,tbvalor) = anula_motivo
                               LEFT JOIN bacparamsuda..CLIENTE               ON morutcli = clrut AND mocodcli = clcodigo
   WHERE   mocodcnv            = 'CLP'
   and     morutcli           <> @nRutBCCH
   and     motipmer          IN('PTAS','EMPR')
   and     morutcli      NOT IN(1,2,3,4,5,70)
   and     cltipcli          IN(1,2,3,4)
   and     moestatus     NOT IN('A')
   AND     monumope      NOT IN(SELECT Operacion FROM #Arbi_Empresas)

   /*====================================================================================================================*/
   /* Operaciones de Punta y Empresa Reversa M/X                                                                                      */
   /*====================================================================================================================*/
SELECT '2'

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
   )
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = 'MOV'
   ,      'tipo_operacion'     = CASE WHEN motipope = 'C' THEN 'ACMX' ELSE 'AVMX' END
   ,      'operacion'          = monumope
   ,      'correlativo'        = isnull(tbcodigo1,0)
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,      'Codigo_Moneda'      = mocodmon
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
   FROM   MEMO                 AS Me--(INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
                               LEFT JOIN bacparamsuda..TABLA_GENERAL_DETALLE ON tbcateg = 400 AND tbtasa  = (CASE WHEN motipope = 'V' THEN moentre ELSE morecib END) and convert(numeric,tbvalor) = anula_motivo
                               LEFT JOIN bacparamsuda..CLIENTE               ON morutcli = clrut AND mocodcli = clcodigo
                               LEFT JOIN bacparamsuda..MONEDA                ON mocodcnv = mnnemo
                               LEFT JOIN bacparamsuda..FORMA_DE_PAGO         ON Codigo   = (CASE WHEN motipope = 'C' THEN moentre ELSE morecib END) AND cc2756 = 'N'
   WHERE  mocodcnv             = 'CLP'
   and    morutcli       NOT IN(@nRutBCCH)
   and    motipmer           IN('PTAS','EMPR')
   and    morutcli       NOT IN(1,2,3,4,5,6,70)
   and    cltipcli           IN(1,2,3,4)
   and    moestatus      NOT IN('A')
   and   (diasvalor          >= 1 or Codigo IN(101,131))
   AND     monumope      NOT IN(SELECT Operacion FROM #Arbi_Empresas)

   /*====================================================================================================================*/
   /* Operaciones de Punta y Empresa Reversa M/N    */
   /*====================================================================================================================*/

SELECT '3'

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
   )
   --   este 
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = 'MOV'
   ,      'tipo_operacion'     = CASE WHEN motipope = 'C' THEN 'ACMN' ELSE 'AVMN' END
   ,      'operacion'          = monumope
   ,      'correlativo'        = isnull(tbcodigo1,0)
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,      'Codigo_Moneda'      = mocodcnv
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
   FROM   MEMO                 AS Me--(INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
                               LEFT JOIN bacparamsuda..TABLA_GENERAL_DETALLE ON tbcateg  = 400 and tbtasa  = (CASE WHEN motipope = 'V' THEN moentre ELSE morecib END) and convert(numeric,tbvalor) = anula_motivo
                               LEFT JOIN bacparamsuda..CLIENTE               ON morutcli = clrut AND mocodcli = clcodigo
                               LEFT JOIN bacparamsuda..MONEDA                ON mocodcnv = mnnemo
                               LEFT JOIN bacparamsuda..FORMA_DE_PAGO         ON Codigo   = (CASE WHEN motipope = 'C' THEN moentre ELSE morecib END) AND cc2756 = 'N'
   WHERE  mocodcnv             = 'CLP'
   and    morutcli       NOT IN(@nRutBCCH)
   and   (motipmer             = 'PTAS' OR (motipmer = 'EMPR' and (monumfut = 0 OR (cltipcli in(1,4) and clrut <> 96665450))))
   and    morutcli       NOT IN(1,2,3,4,5,70)
   and    cltipcli           IN(1,2,3,4)
   and    moestatus      NOT IN('A')
   and    codigo              <> 5
   and   (diasvalor           >= 1 or Codigo IN(104,106))
   AND    monumope        NOT IN(SELECT Operacion FROM #Arbi_Empresas)

   /*====================================================================================================================*/
   /* Operaciones de Punta Cupo - Canje                                                                                  */
   /*====================================================================================================================*/
SELECT '4'

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
   )
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = 'MOV'
   ,      'tipo_operacion'     = 'CMXN'
   ,      'operacion'          = monumope
   ,      'correlativo'        = isnull(tbcodigo1,0)
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,      'Codigo_Moneda'      = mocodmon
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
   FROM   MEMO                 AS me --(INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
                               LEFT JOIN bacparamsuda..TABLA_GENERAL_DETALLE ON tbcateg  = 400 and tbtasa  = (CASE WHEN motipope = 'V' THEN moentre ELSE morecib END) and convert(numeric,tbvalor) = anula_motivo
                               LEFT JOIN bacparamsuda..CLIENTE               ON morutcli = clrut AND mocodcli = clcodigo
   WHERE  motipmer            IN('CUPO','CANJ')
   and    moestatus       NOT IN('A')
   and    cltipcli            IN(1,2,3)
   AND    monumope        NOT IN(SELECT Operacion FROM #Arbi_Empresas)

   /*====================================================================================================================*/
   /* Operaciones de Cupo - Canje                                */
   /*====================================================================================================================*/
SELECT '5'

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
   )
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = 'MOV'
   ,      'tipo_operacion'     = 'VMXN'
   ,      'operacion'          = monumope
   ,      'correlativo'        = isnull(tbcodigo1,0)
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,      'Codigo_Moneda'      = mocodmon
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
   FROM   MEMO                 AS me --(INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
                               LEFT JOIN bacparamsuda..TABLA_GENERAL_DETALLE ON tbcateg  = 400 and tbtasa  = (CASE WHEN motipope = 'V' THEN moentre ELSE morecib END) and convert(numeric,tbvalor) = anula_motivo
                               LEFT JOIN bacparamsuda..CLIENTE               ON morutcli = clrut AND mocodcli = clcodigo
   WHERE  motipmer            IN('CUPO','CANJ')
   and    moestatus       NOT IN('A')
   and    Cltipcli            IN(1,2,3)
   AND    monumope        NOT IN(SELECT Operacion FROM #Arbi_Empresas)

   /*====================================================================================================================*/
   /* Operaciones de Punta Arriendo                                                                                      */
   /*====================================================================================================================*/
SELECT '6'

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
   )
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = 'MOV'
   ,      'tipo_operacion'     = CASE WHEN motipope = 'C' THEN 'CMXN' ELSE 'VMXN' END
   ,      'operacion'          = monumope
   ,      'correlativo'        = isnull(tbcodigo1,0)
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,    'Codigo_Moneda'      = mocodmon
   ,      'Monto_Origen'       = momonmo
   ,      'Monto_Dolar'        = moussme
   ,      'Monto_Pesos'        = momonpe
   ,      'Forma_Pago_Mn'      = CASE WHEN motipope = 'C' THEN moentre ELSE morecib END
   ,      'Forma_Pago_Mx'      = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END
   ,      'Forma_Pago_Us'      = 0
   ,      'Fecha_Proceso'      = mofech
   ,      'Fecha_Contable'     = mofech
   ,      'Tipo_Mercado'    = motipmer
   ,      'Rut_Cliente'     = morutcli
   ,      'codigo_cliente'     = mocodcli
   ,      'tipo_cambio'        = moticam
   FROM   MEMO                 AS me --(INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
                               LEFT JOIN bacparamsuda..TABLA_GENERAL_DETALLE ON tbcateg  = 400 and tbtasa  = (CASE WHEN motipope = 'V' THEN moentre ELSE morecib END) and convert(numeric,tbvalor) = anula_motivo
                               LEFT JOIN bacparamsuda..CLIENTE               ON morutcli = clrut AND mocodcli = clcodigo
   WHERE  motipmer            IN('ARRI')
   and    moestatus           IN('A')
   AND    monumope        NOT IN(SELECT Operacion FROM #Arbi_Empresas)

   /*====================================================================================================================*/
   /* Operaciones de Arbitraje (PERFIL 3, 4)                                                                             */
   /*====================================================================================================================*/
SELECT '7'
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
   )
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = 'MOV'
   ,      'tipo_operacion'     = CASE motipope WHEN 'C' THEN 'CMXA' ELSE 'VMXA' END
   ,      'operacion'          = monumope
   ,      'correlativo'        = isnull(C.tbcodigo1,0)
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,      'Codigo_Moneda'      = mocodmon
   ,      'Monto_Origen'       = momonmo
   ,      'Monto_Dolar'        = moussme
   ,      'Monto_Pesos'        = CASE WHEN monumfut = 0 THEN momonpe ELSE ROUND((moussme * moticam),0) END
   ,      'Forma_Pago_Mn'      = isnull(D.tbcodigo1,0)
   ,      'Forma_Pago_Mx'      = CASE WHEN motipope = 'C' THEN moentre ELSE morecib END
   ,      'Forma_Pago_Us'      = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END
   ,      'Fecha_Proceso'      = mofech
   ,      'Fecha_Contable'     = mofech
   ,      'Tipo_Mercado'       = motipmer
   ,      'Rut_Cliente'        = morutcli
   ,      'codigo_cliente'     = mocodcli
   ,      'tipo_cambio'        = moticam
   FROM   MEMO                 AS me --(INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
                               LEFT JOIN bacparamsuda..CORRESPONSAL          A ON CONVERT(CHAR(10),A.cod_corresponsal) = CASE WHEN motipope = 'C' THEN Swift_Corresponsal ELSE Swift_Entregamos   END
                               LEFT JOIN bacparamsuda..CORRESPONSAL          B ON CONVERT(CHAR(10),B.cod_corresponsal) = CASE WHEN motipope = 'C' THEN Swift_Entregamos   ELSE Swift_Corresponsal END
                               LEFT JOIN bacparamsuda..TABLA_GENERAL_DETALLE C ON C.tbcateg  = 400 and C.tbtasa  = (CASE WHEN motipope = 'V' THEN moentre ELSE morecib END) and convert(numeric,C.tbvalor) = A.codigo_contable --anula_motivo
                               LEFT JOIN bacparamsuda..TABLA_GENERAL_DETALLE D ON D.tbcateg  = 400 and D.tbtasa = (CASE WHEN motipope = 'V' THEN moentre ELSE morecib END) and convert(numeric,D.tbvalor) = B.codigo_contable --anula_motivo
                               LEFT JOIN bacparamsuda..CLIENTE                 ON morutcli = clrut AND mocodcli = clcodigo
   WHERE  motipmer            IN('ARBI')
   and    morutcli        NOT IN(1,2)
   and    cltipcli            IN(1,2,3)
   and    moestatus       NOT IN('A')
   AND    monumope        NOT IN(SELECT Operacion FROM #Arbi_Empresas)

   /*=============================================================================================================*/
   /*===== Operaciones de Arbitraje Reversa ======================================================================*/
   /*=============================================================================================================*/
SELECT '8'

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
   )
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = 'MOV'
   ,      'tipo_operacion'     = CASE motipope WHEN 'C' THEN 'ACAR' ELSE 'AVAR' END
   ,      'operacion'          = monumope
   ,      'correlativo'        = isnull(C.tbcodigo1,0)
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,      'Codigo_Moneda'      = mocodmon
   ,      'Monto_Origen'       = momonmo
   ,      'Monto_Dolar'        = moussme
   ,      'Monto_Pesos'        = CASE WHEN monumfut = 0 THEN momonpe ELSE ROUND((moussme * moticam),0) END
   ,      'Forma_Pago_Mn'      = isnull(D.tbcodigo1,0)
   ,      'Forma_Pago_Mx'      = CASE WHEN motipope = 'C' THEN moentre ELSE morecib END
   ,      'Forma_Pago_Us'      = CASE WHEN motipope = 'V' THEN moentre ELSE morecib END
   ,      'Fecha_Proceso'      = mofech
   ,      'Fecha_Contable'     = mofech
   ,      'Tipo_Mercado'       = motipmer
   ,      'Rut_Cliente'        = morutcli
   ,      'codigo_cliente'     = mocodcli
   ,      'tipo_cambio'        = moticam
   FROM   MEMO                 AS me --(INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
                               LEFT JOIN bacparamsuda..CORRESPONSAL          A ON CONVERT(CHAR(10),A.cod_corresponsal) = CASE WHEN motipope = 'C' THEN Swift_Corresponsal ELSE Swift_Entregamos   END
                               LEFT JOIN bacparamsuda..CORRESPONSAL          B ON CONVERT(CHAR(10),B.cod_corresponsal) = CASE WHEN motipope = 'C' THEN Swift_Entregamos   ELSE Swift_Corresponsal END
                               LEFT JOIN bacparamsuda..TABLA_GENERAL_DETALLE C ON C.tbcateg  = 400 and C.tbtasa  = (CASE WHEN motipope = 'V' THEN moentre ELSE morecib END) and convert(numeric,C.tbvalor) = A.codigo_contable --anula_motivo
                               LEFT JOIN bacparamsuda..TABLA_GENERAL_DETALLE D ON D.tbcateg  = 400 and D.tbtasa  = (CASE WHEN motipope = 'V' THEN moentre ELSE morecib END) and convert(numeric,D.tbvalor) = B.codigo_contable --anula_motivo
                               LEFT JOIN bacparamsuda..CLIENTE                 ON morutcli = clrut AND mocodcli = clcodigo
   WHERE  motipmer            IN('ARBI')
   and    morutcli        NOT IN(1,2)
   and    cltipcli            IN(1,2,3)
   and    moestatus       NOT IN('A')
   AND    monumope        NOT IN(SELECT Operacion FROM #Arbi_Empresas)

   /*====================================================================================================================*/
   /* Operaciones Overnight / Weekend 	Inicio								    	 	 */
   /*====================================================================================================================*/
SELECT '9'

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
   )
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = 'MOV'
   ,      'tipo_operacion'     = 'OVER'
   ,      'operacion'          = monumope
   ,      'correlativo'        = Swift_Corresponsal
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,      'Codigo_Moneda'      = mocodmon
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
   FROM   MEMO                 AS me --(INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
                               LEFT JOIN bacparamsuda..TABLA_GENERAL_DETALLE ON tbcateg  = 400 and tbtasa  = (CASE WHEN motipope = 'V' THEN moentre ELSE morecib END) and convert(numeric,tbvalor) = anula_motivo
                               LEFT JOIN bacparamsuda..CLIENTE               ON morutcli = clrut AND mocodcli = clcodigo
   WHERE  motipmer            IN('OVER','WEEK')
   and    moestatus       NOT IN('A')
   AND    monumope        NOT IN(SELECT Operacion FROM #Arbi_Empresas)

   /*====================================================================================================================*/
   /* Operaciones Overnight / Weekend 	Ajuste al Vencimiento							    	 */
   /*====================================================================================================================*/

SELECT '10'
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
   )
   SELECT 'id_sistema'         = 'BCC'
   ,      'tipo_movimiento'    = 'MOV'
   ,      'tipo_operacion'     = 'AOVE'
   ,      'operacion'          = monumope
   ,      'correlativo'        = Swift_Corresponsal
   ,      'Documento'          = CASE WHEN monumfut = 0 THEN 0 ELSE monumfut END
   ,      'codigo_instrumento' = ''
   ,      'moneda_instrumento' = ''
   ,      'Codigo_Moneda'      = mocodmon
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
   ,      'codigo_cliente'    = mocodcli
   ,      'tipo_cambio'        = moticam
   FROM   MEMO                 AS me --(INDEX=Tipo_Mcdo_Rut_Cliente_Cod_Mda_Conv)
                               LEFT JOIN bacparamsuda..TABLA_GENERAL_DETALLE ON tbcateg  = 400 and tbtasa  = (CASE WHEN motipope = 'V' THEN moentre ELSE morecib END) and convert(numeric,tbvalor) = anula_motivo
                               LEFT JOIN bacparamsuda..CLIENTE               ON morutcli = clrut AND mocodcli = clcodigo
   WHERE  motipmer           IN('OVER','WEEK')
   and    moestatus      NOT IN('A')
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
   WHERE  bac_cnt_contabiliza.tipo_operacion NOT IN('CMXA','VMXA')
   and    Tipo_Mercado                       NOT IN('CANJ')
 
   DELETE BAC_CNT_CONTABILIZA 
   WHERE  Forma_Pago_Mx = 15 
   AND    tipo_operacion IN ('ACMX','AVMX') -- OP con Cheque no genera Ajuste segun hugo

   /***********************************************************************/
   /***********************************************************************/

   DELETE BAC_CNT_CONTABILIZA 
   WHERE (rut_cliente = @Rut_Corre_Corp AND Codigo_cliente = @Cod_Corre_Corp)
   OR    (rut_cliente = @Rut_bCo_Corp   AND Codigo_cliente = @Cod_bCo_Corp)

   /****** no van las operaciones que son con la corredora del banco ******/
   /***********************************************************************/

   /***********************************************************************/
   /******************* Vencimientos de Valutas MX y MN *******************/
   /***********************************************************************/
   --ContabilizaciÃ³n Valutas $$ --Agrega la Fecha Contable

   /******************** Feriado Plaza EEUU ***********************************/
   SELECT  @ncont = 1
   SELECT  @nregs = COUNT(1)
   FROM	   BAC_CNT_CONTABILIZA
   WHERE   tipo_operacion IN('ACMX', 'AVMX', 'ACAR', 'AVAR')

   WHILE @nregs >= @ncont 
   BEGIN

      SET ROWCOUNT @ncont

      SELECT @fecha              = CONVERT(CHAR(8),fecha_proceso,112)
      ,      @tipo_operacion	 = tipo_operacion
      ,      @operacion		 = operacion
      ,      @dias_valuta	 = ISNULL(Fpag.diasvalor,0)
      ,      @Forma_de_Pago  	 = ISNULL(Fpag.codigo,0)
      FROM   BAC_CNT_CONTABILIZA 
             LEFT JOIN BacParamSuda..FORMA_DE_PAGO Fpag ON Forma_Pago_Mx = Fpag.codigo
      WHERE  tipo_operacion      IN('ACMX', 'AVMX', 'ACAR', 'AVAR')

      SET ROWCOUNT 1

      SELECT @lflag    = -1
      SELECT @Dias_Ext = @dias_valuta

      IF @tipo_operacion IN('ACMX', 'AVMX', 'ACAR', 'AVAR')
      BEGIN

         WHILE @lflag = -1 
         BEGIN
            EXECUTE SP_BUSCA_FECHA_PROXIMA_HABIL @Fecha , @dias_valuta , 6   , @fecha_chile OUTPUT
            EXECUTE SP_BUSCA_FECHA_PROXIMA_HABIL @fecha , @Dias_Ext    , 225 , @fecha_usa   OUTPUT

            IF @fecha_chile > @fecha_usa 
            BEGIN
               SELECT @Dias_Ext    = @Dias_Ext + 1	
               ,      @lflag       = -1
            END
            IF  @fecha_usa > @fecha_chile
            BEGIN
               SELECT @dias_valuta = @dias_valuta + 1	
               ,      @lflag       = -1
            END
            IF  @fecha_usa = @fecha_chile
               SELECT @lflag = 0
         END						

         UPDATE BAC_CNT_CONTABILIZA
         SET	Fecha_Contable  = @fecha_chile
         WHERE	@dfecha		= fecha_proceso		
         AND    @tipo_operacion	= tipo_operacion	
         AND    @operacion	= operacion		
      END			
      SELECT  @ncont = @ncont + 1
   END

   /***************** Fin Feriado Plaza EEUU **********************************/
   --ContabilizaciÃ³n Valutas $$ --Agrega la Fecha Contable

   SELECT  @ncont = @ncont + 1
   SELECT  @ncont = 1

   SELECT  @nregs = COUNT(1)
   FROM	   BAC_CNT_CONTABILIZA
   WHERE   tipo_operacion IN('ACMN', 'AVMN')

   WHILE @nregs >= @ncont 
   BEGIN

      SET ROWCOUNT @ncont

      SELECT @fecha	 	   = CONVERT(CHAR(8),fecha_proceso,112)
      ,      @tipo_operacion	   = tipo_operacion
      ,      @operacion		   = operacion
      ,      @dias_valuta	   = ISNULL(Fpago.diasvalor,0)
      ,      @Forma_de_Pago  	   = ISNULL(Fpago.codigo,0)
      FROM   BAC_CNT_CONTABILIZA   LEFT JOIN bacparamsuda..FORMA_DE_PAGO Fpago ON Forma_Pago_Mn = Fpago.codigo
      WHERE  tipo_operacion        IN('ACMN', 'AVMN')

      SET ROWCOUNT 1

      IF @fecha = @dFecha AND @tipo_operacion IN('ACMN', 'AVMN')
      BEGIN
         EXECUTE SP_BUSCA_FECHA_PROXIMA_HABIL @Fecha , @dias_valuta , 6 , @fecha_chile OUTPUT

         UPDATE BAC_CNT_CONTABILIZA
         SET	Fecha_Contable  = @fecha_chile
         WHERE	@dfecha		= fecha_proceso		
         AND    @tipo_operacion	= tipo_operacion	
         AND    @operacion	= operacion		
      END
      SELECT  @ncont = @ncont + 1
   END

END

GO
