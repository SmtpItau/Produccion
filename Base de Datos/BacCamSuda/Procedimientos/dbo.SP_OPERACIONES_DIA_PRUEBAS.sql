USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPERACIONES_DIA_PRUEBAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_OPERACIONES_DIA_PRUEBAS]
   (   @ENTIDAD    NUMERIC(3)
   ,   @TIPMERC    CHAR(4)
   ,   @TIPOPER    VARCHAR(3)
   ,   @ORDEN      NUMERIC(1)
   ,   @NUMOPER    NUMERIC(7)    = 0
   ,   @CESTADO    CHAR(03)      = '*'
   ,   @RUTCLI     NUMERIC(9,0)  = 0
   ,   @ORIGEN     CHAR(15)      = ''
   ,   @OPERADOR   CHAR(15)      = ''
   ,   @MTOINI     NUMERIC(19,4) = 1
   ,   @MTOFIN     NUMERIC(19,4) = 0
   ,   @TCAMINI    NUMERIC(19,4) = 1
   ,   @TCAMFIN    NUMERIC(19,4) = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFecProc     DATETIME
   DECLARE @dFecProx     DATETIME

    SELECT @dFecProc     = acfecproc
        ,  @dFecProx     = acfecprox
      FROM bacTraderSuda..MDAC with(nolock)

   DECLARE  @UF_HOY      FLOAT
   DECLARE  @UF_MAN      FLOAT
   DECLARE  @IVP_HOY     FLOAT
   DECLARE  @IVP_MAN     FLOAT
   DECLARE  @DO_HOY      FLOAT
   DECLARE  @DO_MAN      FLOAT
   DECLARE  @DA_HOY      FLOAT
   DECLARE  @DA_MAN      FLOAT

   SET @UF_HOY  = (SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA with(nolock) WHERE vmcodigo = 998 AND vmfecha = @dFecProc)
   SET @UF_MAN  = (SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA with(nolock) WHERE vmcodigo = 998 AND vmfecha = @dFecProx)
   SET @IVP_HOY = (SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA with(nolock) WHERE vmcodigo = 997 AND vmfecha = @dFecProc)
   SET @IVP_MAN = (SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA with(nolock) WHERE vmcodigo = 997 AND vmfecha = @dFecProx)
   SET @DO_HOY  = (SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA with(nolock) WHERE vmcodigo = 994 AND vmfecha = @dFecProc)
   SET @DO_MAN  = (SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA with(nolock) WHERE vmcodigo = 994 AND vmfecha = @dFecProx)
   SET @DA_HOY  = (SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA with(nolock) WHERE vmcodigo = 995 AND vmfecha = @dFecProc)
   SET @DA_MAN  = (SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA with(nolock) WHERE vmcodigo = 995 AND vmfecha = @dFecProx)

 
if @CESTADO= 'APR' SET @CESTADO=''
if @CESTADO= 'PEN' SET @CESTADO='P'
if @CESTADO= 'REC' SET @CESTADO='R'
if @CESTADO= 'ANU' SET @CESTADO='A'
if @CESTADO= 'MOD' SET @CESTADO='M'
                                                                                                                                                                                                                                                               

   SELECT 'ENTID'     = moentidad
      ,   'TIPOMERC'  = motipmer
      ,   'NUMOPE'    = monumope
      ,   'RUT'       = a.clrut
      ,   'DV'        = a.cldv
      ,   'CODCLIEN'  = a.clcodigo
      ,   'NOMCLIEN'  = a.clnombre
      ,   'TIPOPER'   = motipope
      ,   'CODMDA'    = mocodmon
      ,   'MDACONV'   = mocodcnv
      ,   'MONTO'     = momonmo
      ,   'TIPCAMB'   = moticam
      ,   'TCTRA'     = motctra
      ,   'PARME'     = moparme
      ,   'PARTR'     = mopartr
      ,   'PRECIO'    = moprecio
      ,   'PRETRA'    = mopretra
      ,   'USSME'     = moussme
      ,   'MONPE'     = momonpe
      ,   'ENTREG'    = moentre
      ,   'GLOENTR'   = ISNULL(pe.glosa, ' ')
      ,   'FECVALUE'  = CONVERT(CHAR(10), movaluta1, 103)
      ,   'RECIB'     = morecib
      ,   'GLORECIB'  = ISNULL(pr.glosa, ' ')
      ,   'FECVALUR'  = CONVERT(CHAR(10), movaluta2, 103)
      ,   'OPER'      = mooper
      ,   'FECHA'     = CONVERT(CHAR(10), mofech, 103)
      ,   'HORA'      = mohora
      ,   'GLOMDA'    = mon.mnglosa
      ,   'GLOMDACN'  = cnv.mnglosa
      ,   'VAMOS'     = movamos
      ,   'TERM'      = moterm
      ,   'CODOMA'    = mocodoma
      ,   'ESTATUS'   = moestatus
      ,   'RENTAB'    = morentab
      ,   'ALINEA'    = moalinea
      ,   'TIPCAR'    = motipcar
      ,   'NUMFUT'    = monumfut
      ,   'FECHAINI'  = CONVERT(CHAR(10), mofecini, 103)
      ,   'APROBA'    = moaprob
      ,   'CBCOMDA'   = mon.mncodbanco
      ,   'CBCOMDAC'  = cnv.mncodbanco
      ,   'ENTIDAD'   = ent.rcnombre
      ,   'NOMPROP'   = MEAC.acnombre
      ,   'FECHAP'    = MEAC.acfecpro
      ,   'HORASERV'  = CONVERT(CHAR(08), GETDATE(), 108)
      ,   'ESTADO'    = moestatus
      ,   'FECHASER'  = CONVERT(CHAR(10), GETDATE(), 101)
      ,   'TIPMERC'   = motipmer
      ,   'OBSERV'    = observacion
      ,   'CODCOMER'  = codigo_comercio
      ,   'RUTGIRAD'  = morutgir
      ,   'NOMGIRAD'  = CASE WHEN morutgir = 0 THEN ' ' ELSE girador.clnombre END
      ,   'DESCRIP'   = pro.descripcion
      ,   'USSTR'     = mousstr
      ,   'SWIFT_C'   = swift_corresponsal
      ,   'SWIFT_R'   = swift_recibimos
      ,   'SWIFT_E'   = swift_entregamos
      ,   'COSTFOND'  = mocostofo
      ,   'ENTMX'     = forma_pago_cli_ext
      ,   'GLOENTMX'  = CASE WHEN forma_pago_cli_ext = 0 THEN ' ' ELSE isnull(px.glosa, ' ') END
      ,   'FECVALMX'  = CONVERT(CHAR(10), valuta_cli_ext, 103)
      ,   'RECMN'     = forma_pago_cli_nac
      ,   'GLORECMN'  = CASE WHEN forma_pago_cli_nac = 0 THEN ' ' ELSE isnull(pn.glosa, ' ') END
      ,   'FECVALMN'  = CONVERT(CHAR(10), valuta_cli_nac, 103)
      ,   'FECVCTO'   = ISNULL(CONVERT(CHAR(10), mofecvcto, 103),'')
      ,   'DIAS'      = modias
      ,   'USUARIO'   = mooper
      ,   'UF_HOY'    = @UF_HOY
      ,   'UF_MAN'    = @UF_MAN
      ,   'IVP_HOY'   = @IVP_HOY
      ,   'IVP_MAN'   = @IVP_MAN
      ,   'DO_HOY'    = @DO_HOY
      ,   'DO_MAN'    = @DO_MAN
      ,   'DA_HOY'    = @DA_HOY
      ,   'DA_MAN'    = @DA_MAN
      ,   'CodigoGir' = mocodigogirador
      ,   'MORECIB_C' = morecib
      ,   'MOTLXP1'   = motlxp1
   INTO   #TEMP
   FROM   MEMO
          INNER JOIN BacParamSuda..CLIENTE        a with(nolock) ON a.clrut        = morutcli and a.clcodigo       = mocodcli
          LEFT  JOIN BacParamSuda..CLIENTE  girador with(nolock) ON girador.clrut  = morutgir and girador.clcodigo = mocodigogirador
          LEFT  JOIN BacParamSuda..FORMA_DE_PAGO pe with(nolock) ON pe.codigo      = moentre
          LEFT  JOIN BacParamSuda..FORMA_DE_PAGO pr with(nolock) ON pr.codigo      = morecib
          LEFT  JOIN BacParamSuda..FORMA_DE_PAGO px with(nolock) ON px.codigo      = forma_pago_cli_ext
          LEFT  JOIN BacParamSuda..FORMA_DE_PAGO pn with(nolock) ON pn.codigo      = forma_pago_cli_nac
          LEFT  JOIN BacParamSuda..MONEDA       mon with(nolock) ON mon.mnnemo     = mocodmon
          LEFT  JOIN BacParamSuda..MONEDA       cnv with(nolock) ON cnv.mnnemo     = mocodcnv
          LEFT  JOIN BacParamSuda..ENTIDAD      ent with(nolock) ON ent.rccodcar   = moentidad
          LEFT  JOIN BacParamSuda..PRODUCTO     pro with(nolock) ON pro.id_sistema = 'BCC'   and pro.codigo_producto = motipmer
      ,   MEAC                                      with(nolock) 
    WHERE @RUTCLI   in( morutcli,  0)
      AND @TIPMERC  in( motipmer,  '')
      AND @ENTIDAD  in( moentidad, 0)
      AND @NUMOPER  IN( monumope,  0)
      AND @CESTADO  in( moestatus, '*')
      AND @ORIGEN   in( moterm,    '')
      AND @OPERADOR in( mooper,    '')
      AND @TIPOPER  in( motipope,  '')

      AND (@MTOINI  > @MTOFIN  OR MOMONMO BETWEEN @MTOINI  AND @MTOFIN)
      AND (@TCAMINI > @TCAMFIN OR MOTICAM BETWEEN @TCAMINI AND @TCAMFIN)
   ORDER BY MONUMOPE

   IF @ORDEN <= 0 OR @ORDEN > 4
      SELECT DISTINCT * FROM #TEMP ORDER BY ENTID, NUMOPE

   IF @ORDEN = 1
      SELECT  * FROM #TEMP ORDER BY ENTID, TIPOPER

   IF @ORDEN = 2
      SELECT  * FROM #TEMP ORDER BY ENTID, NOMCLIEN

   IF @ORDEN = 3
      SELECT  * FROM #TEMP ORDER BY ENTID, OPER

   IF @ORDEN = 4
      SELECT *  FROM #TEMP ORDER BY ENTID, TIPOMERC, NUMOPE

END

GO
