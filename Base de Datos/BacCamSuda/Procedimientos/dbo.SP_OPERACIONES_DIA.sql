USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPERACIONES_DIA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_OPERACIONES_DIA]    
                 (    
                  @ENTIDAD    NUMERIC(3)         ,    
                  @TIPMERC    CHAR(4)            ,    
                  @TIPOPER    VARCHAR(3)         ,    
                  @ORDEN      NUMERIC(1)         ,    
                  @NUMOPER    NUMERIC(7)    = 0  ,    
                  @CESTADO    CHAR(03)      = '*',    
                  @RUTCLI     numeric(9,0)  = 0  ,    
                  @ORIGEN     char(15)      = '' ,    
                  @OPERADOR   char(15)      = '' ,    
                  @MTOINI     numeric(19,4) = 1  ,    
                  @MTOFIN     numeric(19,4) = 0  ,    
                  @TCAMINI    numeric(19,4) = 1  ,    
                  @TCAMFIN    numeric(19,4) = 0    
                 )    
AS    
BEGIN    
    
SET NOCOUNT ON    
    
DECLARE  @UF_HOY      FLOAT    
DECLARE  @UF_MAN      FLOAT    
DECLARE  @IVP_HOY     FLOAT    
DECLARE  @IVP_MAN     FLOAT    
DECLARE  @DO_HOY      FLOAT    
DECLARE  @DO_MAN      FLOAT    
DECLARE  @DA_HOY      FLOAT    
DECLARE  @DA_MAN      FLOAT    
    
     
if @CESTADO= 'APR' SET @CESTADO=''    
if @CESTADO= 'PEN' SET @CESTADO='P'    
if @CESTADO= 'REC' SET @CESTADO='R'    
if @CESTADO= 'ANU' SET @CESTADO='A'    
if @CESTADO= 'MOD' SET @CESTADO='M'    
                                                                                                                                                                                                                                                               




  
--PRD21646  Se valida por los siguiente categoria de Tabla general detalle, que se encuantran grabadas 
--en campo clase de la tabla usuarios.
--SELECT tbcodigo1,tbglosa FROM bacParamSuda.dbo.tabla_general_detalle WHERE tbcateg = 8602

DECLARE @ClaseUsuario int  
SET @ClaseUsuario = 0   

SELECT @ClaseUsuario = rtrim(ltrim(clase))
FROM bacparamsuda.dbo.usuario 
WHERE rtrim(ltrim(usuario)) = (SELECT rtrim(ltrim(MOOPER)) FROM memo WHERE MONUMOPE = @NUMOPER)
  
    
    
    
SELECT          'ENTID'    = MOENTIDAD       ,--(1)    
                'TIPOMERC' = MOTIPMER        ,--(2)    
                'NUMOPE'   = MONUMOPE        ,--(3)    
                'RUT'      = isnull(A.CLRUT,0)         ,--(4)    
                'DV'       = isnull(A.CLDV,'')          ,--(5)    
                'CODCLIEN' = isnull(A.CLCODIGO,0)      ,--(6)    
                'NOMCLIEN' = SUBSTRING( isnull(A.CLNOMBRE,''), 1, 49), --> A.CLNOMBRE      ,--(7)    
                'TIPOPER'  = MOTIPOPE        ,--(8)    
                'CODMDA'   = MOCODMON        ,--(9)    
                'MDACONV'  = MOCODCNV        ,--(10)    
                'MONTO'    = MOMONMO         ,--(11)    
                'TIPCAMB'  = MOTICAM         ,--(12)    
                'TCTRA'    = CASE	WHEN @ClaseUsuario NOT IN(1,0) AND mocodmon  = 'USD' THEN CMX_TC_Costo_Trad
										WHEN @ClaseUsuario NOT IN(1,0) AND mocodmon <> 'USD' THEN motctra
										ELSE motctra
									END           ,--(13)  modificado en PRD21656 RESCATE DE OPERACIONES WEB SOLICITADO POR DANIEL SANTAMARIA  05-06-2015
                'PARME'    = MOPARME         ,--(14)    
                'PARTR'    = CASE	WHEN @ClaseUsuario NOT IN(1,0) AND mocodmon  = 'USD' THEN mopartr
										WHEN @ClaseUsuario NOT IN(1,0) AND mocodmon <> 'USD' THEN CMX_TC_Costo_Trad
										ELSE mopartr  
									END          ,--(15)   modificado en PRD21656 RESCATE DE OPERACIONES WEB SOLICITADO POR DANIEL SANTAMARIA  05-06-2015 
                'PRECIO'   = MOPRECIO        ,--(16)    
                'PRETRA'   = MOPRETRA        ,--(17)    
                'USSME'    = MOUSSME         ,--(18)    
                'MONPE'    = MOMONPE         ,--(19)    
                'ENTREG'   = MOENTRE         ,--(20)    
                'GLOENTR'  = ISNULL((SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO=MOENTRE),'')  ,--(21)    
                'FECVALUE' = CONVERT(CHAR(10),MOVALUTA1,103)       ,--(22)    
                'RECIB'    = MORECIB          ,--(23)    
                'GLORECIB' = ISNULL((SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO=MORECIB),'')  ,--(24)    
                'FECVALUR' = CONVERT(CHAR(10),MOVALUTA2,103)       ,--(25)    
                'OPER'     = MOOPER         ,--(26)    
                'FECHA'    = CONVERT(CHAR(10),MOFECH,103)      ,--(27)    
                'HORA'  = MOHORA         ,--(28)    
                'GLOMDA'   = D.MNGLOSA      ,--(29)    
                'GLOMDACN' = E.MNGLOSA      ,--(30)    
                'VAMOS'    = MOVAMOS        ,--(31)    
                'TERM'     = MOTERM         ,--(32)    
                'CODOMA'   = MOCODOMA       ,--(33)    
                'ESTATUS'  = MOESTATUS      ,--(34)    
                'RENTAB'   = MORENTAB       ,--(35)    
                'ALINEA'   = MOALINEA       ,--(36)    
                'TIPCAR'   = MOTIPCAR       ,--(37)    
                'NUMFUT'   = MONUMFUT       ,--(38)    
                'FECHAINI' = MOFECINI       ,--(39)    
                'APROBA'   = MOAPROB        ,--(40)    
                'CBCOMDA'  = D.MNCODBANCO   ,--(41)    
                'CBCOMDAC' = E.MNCODBANCO   ,--(42)    
                'ENTIDAD'  = ( SELECT DISTINCT F.RCNOMBRE FROM  VIEW_ENTIDAD WHERE  F.RCCODCAR = MOENTIDAD ),--(43) -- BACTRADER..MDRC    
                'NOMPROP'  = ( SELECT DISTINCT ACNOMBRE   FROM  MEAC )     ,--(44)     
                'FECHAP'   = ( SELECT  DISTINCT ACFECPRO  FROM  MEAC )     ,--(45)     
                'HORASERV' = CONVERT(CHAR(08),GETDATE(),108)      ,--(46)     
                'ESTADO'   = MOESTATUS         ,--(47)     
                'FECHASER' = CONVERT(CHAR(10),GETDATE(),101)      ,--(48)     
                'TIPMERC'  = MOTIPMER         ,--(49)     
                'OBSERV'   = OBSERVACION        ,--(50)     
                'CODCOMER' = CODIGO_COMERCIO        ,--(51)    
                'RUTGIRAD' = MORUTGIR         ,--(52)    
                'NOMGIRAD' = CASE WHEN MORUTGIR = 0 THEN ' ' ELSE ( SELECT CLNOMBRE FROM VIEW_CLIENTE WHERE CLRUT=MORUTGIR AND CLCODIGO=mocodigogirador ) END,--(53)    
                'DESCRIP'  = P.DESCRIPCION        ,--(54)    
                'USSTR'    = MOUSSTR         ,--(55)    
                'SWIFT_C'  = SWIFT_CORRESPONSAL        ,--(56)    
                'SWIFT_R'  = SWIFT_RECIBIMOS        ,--(57)    
                'SWIFT_E'  = SWIFT_ENTREGAMOS        ,--(58)    
                'COSTFOND' = MOCOSTOFO         ,--(59)    
                'ENTMX'    = FORMA_PAGO_CLI_EXT        ,--(60)    
                'GLOENTMX' = CASE WHEN FORMA_PAGO_CLI_EXT = 0 THEN ' ' ELSE ( SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO=FORMA_PAGO_CLI_EXT ) END,--(61)    
                'FECVALMX' = CONVERT(CHAR(10),VALUTA_CLI_EXT,103)     ,--(62)    
                'RECMN'    = FORMA_PAGO_CLI_NAC        ,--(63)    
                'GLORECMN' = CASE WHEN FORMA_PAGO_CLI_NAC = 0 THEN ' ' ELSE ( SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO=FORMA_PAGO_CLI_NAC ) END,--(64)    
                'FECVALMN' = CONVERT(CHAR(10),VALUTA_CLI_NAC,103)     ,--(65)    
                'FECVCTO'  = ISNULL(CONVERT(CHAR(10),MOFECVCTO,103),'')     ,--(66)    
                'DIAS'     = MODIAS         ,--(67)    
                'USUARIO'  = MOOPER         ,--(68)    
                'UF_HOY'   = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 998 AND VMFECHA = ACFECPROC) ,--(69)    
                'UF_MAN'   = ISNULL((SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 998 AND VMFECHA = ACFECPROX),0) ,--(70)    
                'IVP_HOY'  = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 997 AND VMFECHA = ACFECPROC) ,--(71)    
                'IVP_MAN'  = ISNULL((SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 997 AND VMFECHA = ACFECPROX),0) ,--(72)    
                'DO_HOY'   = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 994 AND VMFECHA = ACFECPROC) ,--(73)    
                'DO_MAN'   = ISNULL((SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 994 AND VMFECHA = ACFECPROX),0) ,--(74)    
                'DA_HOY'   = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 995 AND VMFECHA = ACFECPROC) ,--(75)    
                'DA_MAN'   = ISNULL((SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 995 AND VMFECHA = ACFECPROX),0) ,--(76)    
                'CodigoGir' = mocodigogirador ,--(77)    
                'MORECIB_C' = MORECIB         ,--(78)    
                'MOTLXP1'   = MOTLXP1, --(79)  
				'RES_CLP'   = MODIFTRAN_CLP, --(80)
				'RES_USD'   = MODIFTRAN_MO --(81)
          INTO  #TEMP    
          FROM  MEMO    
                LEFT  JOIN VIEW_FORMA_DE_PAGO r ON R.codigo = MORECIB    
    left  join VIEW_CLIENTE   A On MORUTCLI = A.CLRUT  AND  MOCODCLI = A.CLCODIGO  
              , MEAC  
     , VIEW_MONEDA D, VIEW_MONEDA E, VIEW_ENTIDAD F, VIEW_PRODUCTO P, VIEW_MEAC, VIEW_MDAC    
          WHERE @RUTCLI             in(MORUTCLI,0)                            and    
--                MORUTCLI            = A.CLRUT AND MOCODCLI = A.CLCODIGO       AND    
         @TIPMERC            in (MOTIPMER, '')                         and    
                @ENTIDAD            in (MOENTIDAD,0)                          and    
                MOCODMON            = SUBSTRING( D.MNNEMO, 1, 3 )             AND    
                MOCODCNV            = SUBSTRING( E.MNNEMO, 1, 3 )             AND    
                @NUMOPER            IN(MONUMOPE, 0)                      AND    
                P.ID_SISTEMA        = 'BCC' AND P.CODIGO_PRODUCTO = MOTIPMER  AND    
                @CESTADO            in(MOESTATUS, '*')                        AND    
                @ORIGEN             in(MOTERM, '')                            and    
--              @OPERADOR           in(MOOPER, '')                            and    
                @TIPOPER            in(MOTIPOPE, '')                          AND    
               (@MTOINI  > @MTOFIN  or MOMONMO between @MTOINI  and @MTOFIN)  and    
               (@TCAMINI > @TCAMFIN or MOTICAM between @TCAMINI and @TCAMFIN) and    
    
               (   ( mooper like '%' + ltrim(rtrim( @operador )) + '%' )    
                or ( @operador = '' )    
               )     
    
ORDER BY MONUMOPE    
   IF @ORDEN <= 0 OR @ORDEN > 4      -- NRO OPERACION    
      SELECT DISTINCT * FROM #TEMP ORDER BY ENTID, NUMOPE    
   IF @ORDEN = 1        -- TIPO OPERACION    
      SELECT  * FROM #TEMP ORDER BY ENTID, TIPOPER    
   IF @ORDEN = 2               -- CLIENTE    
      SELECT  * FROM #TEMP ORDER BY ENTID, NOMCLIEN    
   IF @ORDEN = 3             -- OPERADOR    
      SELECT  * FROM #TEMP ORDER BY ENTID, OPER    
   IF @ORDEN = 4                     -- TIPO DE MERCADO    
      SELECT *  FROM #TEMP ORDER BY ENTID, TIPOMERC, NUMOPE    
END  
GO
