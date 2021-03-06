USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTRATOINTERBANCARIO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CONTRATOINTERBANCARIO]  
   (   @nnumope           NUMERIC(7)  
   ,   @nrutapo1          NUMERIC(9)  
   ,   @nrutapo2          NUMERIC(9)  
   ,   @Codigo_Usuario    CHAR(15) = ''  
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @cdigver1               CHAR(01)  
   DECLARE @cdigver2               CHAR(01)  
   DECLARE @nnomapo1               CHAR(30)  
   DECLARE @nnomapo2               CHAR(30)  
   DECLARE @xNomprop               CHAR(50)  
   DECLARE @fecha_proceso          DATETIME --jtp  
   DECLARE @estado            CHAR(25) --jtp  
   DECLARE @flag                   NUMERIC(1) --jtp  
   DECLARE @tipo_cliente           CHAR(1) --jtp  
   DECLARE @Nombre_Usuario         CHAR(30)  
   DECLARE @Glosa_Paridad          CHAR(25)  
   DECLARE @Glosa_Tabla_Global_1   CHAR(25)  
   DECLARE @Glosa_Tabla_Global_2   CHAR(25)  
   DECLARE @Glosa_Tabla_Global_3   CHAR(25)  
   DECLARE @Codigo_Operacion       INT  
   DECLARE @Glosa_Tabla_Global_4   CHAR(25)
  
   SET @Glosa_Paridad  =''  
   SET @Glosa_Tabla_Global_1 = ''  
   SET @Glosa_Tabla_Global_2 = ''  
   SET @Glosa_Tabla_Global_3 = ''  
   SET @Glosa_Tabla_Global_4 = ''
  
   -- Rescata el tipo de Operacion 1,2,3,10  
   SELECT @Codigo_Operacion = cacodpos1 FROM MFCA with (nolock) WHERE canumoper = @nnumope  
  
   -------------------<< Apoderado Nro.1  
   SELECT @cdigver1 = ISNULL(ap.apdvapo,  '')  
      ,   @nnomapo1 = ISNULL(ap.apnombre, '')  
   FROM   VIEW_CLIENTE_APODERADO ap with (nolock)  
          INNER JOIN MFAC           with (nolock) ON MFAC.acrutprop = ap.aprutcli AND ap.aprutapo = @nrutapo1  
  
   -------------------<< Apoderado Nro.2  
   SELECT @cdigver2 = ISNULL(ap.apdvapo , '')  
      ,   @nnomapo2 = ISNULL(ap.apnombre, '')  
   FROM   VIEW_CLIENTE_APODERADO ap with (nolock)  
          INNER JOIN MFAC           with (nolock) ON MFAC.acrutprop = ap.aprutcli AND ap.aprutapo = @nrutapo2  
  
   -------------------<< Nombre Entidad  
   SET @xNomprop       = (SELECT rcnombre  FROM VIEW_ENTIDAD with (nolock) )  
   SET @Nombre_Usuario = (SELECT nombre    FROM VIEW_USUARIO with (nolock) WHERE usuario = @Codigo_Usuario )  
   SET @fecha_proceso  = (SELECT acfecproc FROM MFAC         with (nolock) ) --jtp  
  
   -- Rescata glosa paridad  
   IF @Codigo_Operacion = 1 OR @Codigo_Operacion = 2  
   BEGIN  
      SET @Glosa_Paridad = (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE with (nolock) WHERE tbcateg = 3000 )  
   END  
  
   IF @Codigo_Operacion = 3  
   BEGIN  
      SET @Glosa_Paridad = (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE with (nolock) WHERE tbcateg = 3001 )  
      SET @Glosa_Tabla_Global_4 = (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE with (nolock) WHERE tbcateg = 3002 and tbcodigo1 = 4 )
   END  
  
   IF @Codigo_Operacion =10  
   BEGIN  
      SET @Glosa_Tabla_Global_1 = (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE with (nolock) WHERE tbcateg = 3002 and tbcodigo1 = 1 )  
      SET @Glosa_Tabla_Global_2 = (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE with (nolock) WHERE tbcateg = 3002 and tbcodigo1 = 2 )  
      SET @Glosa_Tabla_Global_3 = (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE with (nolock) WHERE tbcateg = 3002 and tbcodigo1 = 3 )  
   END  
  
   -------------------<< Desde Cartera Vigente (MFCA)  
   SELECT 'BANCO'             = acnomprop  
   ,      'NUMOPE'            = canumoper  
   ,      'FECINI'            = CONVERT(CHAR(10), MFCA.cafecha, 103)  
   ,      'RUTBANCO'          = CONVERT(CHAR(9),  MFAC.acrutprop ) + '-' + MFAC.acdigprop  
   ,      'DIRBANCO'          = MFAC.acdirprop  
   ,      'TELBANCO'          = MFAC.actelefono  
   ,      'FAXBANCO'          = MFAC.acfax  
   ,      'CONTRAPARTE'       = cl.clnombre  
   ,      'RUTCONTRAPARTE'    = CONVERT(CHAR(9), cl.clrut) + '-' + cl.cldv  
   ,      'DIRCONTRAPARTE'    = cldirecc  
   ,      'TELCONTRAPARTE'    = cl.clfono  
   ,      'FAXCONTRAPARTE'    = cl.clfax  
   ,      'TIPOPE'            = MFCA.catipoper  
   ,      'FECVEN'            = CONVERT(CHAR(10), MFCA.cafecvcto, 103)  
   ,      'MODALIDAD'         = CASE MFCA.catipmoda WHEN 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END  
   ,      'CODMON'            = mdmn1.mnnemo  
   ,      'MTOMEX'            = MFCA.camtomon1  
   ,      'MONESCMTOMEX'      = 0  
   ,      'TIPCAR'            = MFCA.cacodpos1  
   ,      'PREFUT'            = CASE WHEN cacodpos1 = 3  THEN MFCA.catipcam   
                                     WHEN cacodpos1 = 12 THEN MFCA.catipcam   
                                     ELSE                     MFCA.caparmon2  
                                END  
   ,      'CODCNV'            = CASE WHEN cacodmon1 = 998 AND cacodpos1 = 10 THEN mdmn1.mnnemo ELSE mdmn2.mnnemo END  
   ,      'MTOFIN'            = MFCA.camtomon2  
   ,      'MONESCMTOFIN'      = 0  
   ,      'TCREFERENCIA'      = ISNULL((SELECT mdmn.mnglosa FROM VIEW_MONEDA mdmn with (nolock) WHERE MFCA.camdausd = mdmn.mncodmon AND MFCA.canumoper = canumoper ), 0 )  
   ,      'NOMAPODERADO1'     = ISNULL(@nnomapo1, '' )  
   ,      'RUTAPODERADO1'     = ISNULL(CONVERT ( CHAR ( 9 ), @nrutapo1 ) + '-' + @cdigver1, '' )  
   ,      'NOMAPODERADO2'     = ISNULL(@nnomapo2, '' )  
   ,      'RUTAPODERADO2'     = ISNULL(CONVERT ( CHAR ( 9 ), @nrutapo2 ) + '-' + @cdigver2, '' )  
   ,      'GLOSACODMON'       = mdmn1.mnglosa  
   ,      'GLOSACODCNV'       = mdmn2.mnglosa  
   ,      'REFUSD'            = (CASE mdmn1.mnrrda WHEN 'M' THEN 3 ELSE 1 END)  
   ,      'NUMSINACOFI'       = ISNULL(a.clnumsinacofi,'0000')  
   ,      'NOMSINACOFI'       = ISNULL(a.clnomsinacofi,'')  
   ,      'NUMSINACNV'        = ISNULL(b.clnumsinacofi,'0000')  
   ,      'NOMSINACNV'        = ISNULL(b.clnomsinacofi,'')  
   ,      'GLOSAFORMAPAGO'    = CASE WHEN mfca.catipmoda = 'C' AND ( mfca.cacodpos1 = 1 OR mfca.cacodpos1 = 3 OR mfca.cacodpos1 = 7 OR mfca.cacodpos1 = 10) THEN  
                                         ISNULL ( ( SELECT glosa FROM VIEW_FORMA_DE_PAGO with (nolock) WHERE codigo = mfca.cafpagomn ), '' )  
                                     ELSE  
                                         ISNULL ( ( SELECT glosa FROM VIEW_FORMA_DE_PAGO with (nolock) WHERE codigo = mfca.cafpagomx ), '' )  
                                END  
   ,      'INSTRUMENTO'       = caserie  
   ,      'TIPO_INSTRU'       = substring(caserie,1,3)  
   ,      'TIPO_REA_INST'     = isnull((select semonemi from bacparamsuda..SERIE where caserie=seserie),0)  
   ,      'CODIGO_NEMO'       = ' '  
   ,      'FEC_VEN_INST'      = isnull((select sefecven from bacparamsuda..SERIE where caserie=seserie),'')  
   ,      'VALORIZADOR'       = ' '  
   ,      'FEC_PAGO_CON'      = cafecvcto  
   ,      'TASA_CONTRATO'     = catasacon  
   ,      'TASA_REFEREN'      = catipcam  
   ,      'ESTADO_SINACOFI'   = estado_sinacofi  
   ,      'FECHA_SINACOFI'    = fecha_estado_sina  
   ,      'TIPO_CLIENTE'      = cltipcli  
   ,      'Nombre_Usuario'    = @Nombre_Usuario  
   ,      'PARIDAD'           = ISNULL(@Glosa_Paridad,'')
   ,      'GLOSA_TAB_GLOBAL_1'= ISNULL(@Glosa_Tabla_Global_1,'')
   ,      'GLOSA_TAB_GLOBAL_2'= ISNULL(@Glosa_Tabla_Global_2,'')
   ,      'GLOSA_TAB_GLOBAL_3'= ISNULL(@Glosa_Tabla_Global_3,'')
   ,      'GLOSA_TAB_GLOBAL_4'= ISNULL(@Glosa_Tabla_Global_4,'')
   INTO    #TEMPORAL  
   -- RQ 7619  
   FROM   --MFAC  
            MFCA  
   --,      VIEW_CLIENTE cl  
   ,      VIEW_TBSINACOFI a RIGHT OUTER JOIN VIEW_CLIENTE cl ON (a.clrut = cl.clrut AND a.clcodigo =cl.clcodigo)  
   ,      VIEW_TBSINACOFI b RIGHT OUTER JOIN MFAC ON (b.clrut       = acrutprop)  
   ,      VIEW_MONEDA  mdmn1  
   ,      VIEW_MONEDA  mdmn2     
   WHERE MFCA.canumoper = @nnumope  
     AND (cl.clrut      = MFCA.cacodigo AND cl.clcodigo = MFCA.cacodcli)  
     --AND (a.clrut       =* cl.clrut AND a.clcodigo =* cl.clcodigo)  
     --AND (b.clrut       =* acrutprop)  
     AND MFCA.cacodmon1 = mdmn1.mncodmon   
     AND MFCA.cacodmon2 = mdmn2.mncodmon   
  
   --jtp Actualiza datos de envio de operación en MFCA  
   SET @flag   = 0  
   SET @estado = (SELECT ESTADO_SINACOFI FROM #temporal )  
  
   IF @estado = ''  
   BEGIN  
      UPDATE MFCA   
         SET estado_sinacofi   = 'CN-CONTRATO NUEVO'  
         ,   fecha_estado_sina = @fecha_proceso  
       WHERE canumoper         = @nnumope  
  
      UPDATE #Temporal   
         SET ESTADO_SINACOFI   = 'CN-CONTRATO NUEVO'  
         ,   FECHA_SINACOFI    = @fecha_proceso  
       WHERE NUMOPE            = @nnumope  
  
      UPDATE MFMO   
         SET estado_sinacofi   = 'CN-CONTRATO NUEVO'  
         ,   fecha_estado_sina = @fecha_proceso  
       WHERE monumoper         = @nnumope  
  
      SELECT @flag=@flag + 1  
   END ELSE  
   BEGIN   
      UPDATE MFCA   
         SET estado_sinacofi   = 'CM-CONTRATO MODIFICADO'  
         ,   fecha_estado_sina = @fecha_proceso  
       WHERE canumoper         = @nnumope  
  
      UPDATE #Temporal   
         SET ESTADO_SINACOFI   = 'CM-CONTRATO MODIFICADO'  
         ,   FECHA_SINACOFI    = @fecha_proceso  
       WHERE NUMOPE            = @nnumope  
  
      UPDATE MFMO   
         SET estado_sinacofi   = 'CM-CONTRATO MODIFICADO'  
         ,   fecha_estado_sina = @fecha_proceso  
       WHERE monumoper         = @nnumope  
   END  
  
  
   -------------------<< Desde Cartera Historica (MFCAH)  
   INSERT INTO #TEMPORAL ( BANCO         ,  -- 1  
                           NUMOPE        ,  -- 2  
                           FECINI        ,  -- 3  
                           RUTBANCO      ,  -- 4  
                           DIRBANCO      ,  -- 5  
                           TELBANCO      ,  -- 6  
                           FAXBANCO      ,  -- 7  
                           CONTRAPARTE   ,  -- 8  
                           RUTCONTRAPARTE,  -- 9  
                           DIRCONTRAPARTE,  -- 10  
                           TELCONTRAPARTE,  -- 11  
                           FAXCONTRAPARTE,  -- 12  
                           TIPOPE        ,  -- 13  
                           FECVEN        ,  -- 14  
                           MODALIDAD     ,  -- 15  
                           CODMON        ,  -- 16  
                           MTOMEX        ,  -- 17  
                           MONESCMTOMEX  ,  -- 18  
                           TIPCAR        ,  -- 19  
                           PREFUT        ,  -- 20  
                           CODCNV        ,  -- 21  
                           MTOFIN        ,  -- 22  
                           MONESCMTOFIN  ,  -- 23  
                           TCREFERENCIA  ,  -- 24  
                           NOMAPODERADO1 ,  -- 25  
                           RUTAPODERADO1 ,  -- 26  
              NOMAPODERADO2 ,  -- 27  
                           RUTAPODERADO2 ,  -- 28  
                           GLOSACODMON   ,  -- 29  
                           GLOSACODCNV   ,  -- 30  
                           REFUSD        ,  -- 31  
                           NUMSINACOFI   ,  -- 32  
                           NOMSINACOFI   ,  -- 33  
                           NUMSINACNV    ,  -- 34  
                           NOMSINACNV    ,  -- 35  
                           GLOSAFORMAPAGO  , -- 36  
--NUEVOS CAMPOS  
      INSTRUMENTO,  --37  
      TIPO_INSTRU,  --38  
      TIPO_REA_INST, --39  
      CODIGO_NEMO,  --40  
      FEC_VEN_INST, --41  
      VALORIZADOR,  --42  
      FEC_PAGO_CON, --43  
      TASA_CONTRATO, --44  
      TASA_REFEREN , --45  
         ESTADO_SINACOFI, --46  
      FECHA_SINACOFI, --47  
      TIPO_CLIENTE, --48  
                           Nombre_Usuario,  
                           PARIDAD,  
                           GLOSA_TAB_GLOBAL_1,   
                           GLOSA_TAB_GLOBAL_2,  
                           GLOSA_TAB_GLOBAL_3, 
                           GLOSA_TAB_GLOBAL_4 
                         )  
   SELECT @xNomprop                                                           ,  -- 1  
          @nnumope                                                                                      ,  -- 2  
          CONVERT ( CHAR ( 10 ), MFCAH.cafecha, 103 )                                                   ,  -- 3  
          CONVERT ( CHAR ( 9 ), MFAC.acrutprop ) + '-' + MFAC.acdigprop                                 ,  -- 4  
          MFAC.acdirprop                                                                                ,  -- 5  
          MFAC.actelefono                                                                               ,  -- 6  
          MFAC.acfax                                         ,  -- 7  
          cl.clnombre                                                                                 ,  -- 8  
          CONVERT ( CHAR ( 9 ), cl.clrut ) + '-' + cl.cldv                                          ,  -- 9  
          cl.cldirecc                                                                                 ,  -- 10  
          cl.clfono                                                                                   ,  -- 11  
          cl.clfax                                                                                    ,  -- 12  
          MFCAH.catipoper                                                                               ,  -- 13  
          CONVERT ( CHAR ( 10 ), MFCAH.cafecvcto, 103 )                                                 ,  -- 14  
          ISNULL (( CASE MFCAH.catipmoda WHEN 'C' THEN 'Compensacion' ELSE 'Entrega Fisica' END ), '' ) ,  -- 15  
          mdmn1.mnnemo                                                                                  ,  -- 16  
          MFCAH.camtomon1                                                                               ,  -- 17  
          ''                                                                                            ,  -- 18  
          MFCAH.cacodpos1                                                                               ,  -- 19  
          CASE WHEN cacodpos1 = 3  THEN MFCAH.catipcam   
               WHEN cacodpos1 = 12 THEN MFCAH.catipcam   
               ELSE                     MFCAH.caparmon2  
          END,                                                                                             -- 20  
          mdmn2.mnnemo                                                                                  ,  -- 21    
          MFCAH.camtomon2                                                                               ,  -- 22  
          ''                                                                                            ,  -- 23  
          (SELECT m.mnglosa FROM MFCAH,  VIEW_MONEDA m WHERE MFCAH.camdausd = m.mncodmon AND MFCAH.canumoper = @nnumope),  -- 24  
          ISNULL ( @nnomapo1, '' )                                                                      ,  -- 25  
          ISNULL ( CONVERT ( CHAR ( 9 ), @nrutapo1 ) + '-' + @cdigver1, '' )                            ,  -- 26  
          ISNULL ( @nnomapo2, '' )                                                ,  -- 27  
          ISNULL ( CONVERT ( CHAR ( 9 ), @nrutapo2 ) + '-' + @cdigver2, '' )                            ,  -- 28  
          mdmn1.mnglosa                                                                                 ,  -- 29  
          mdmn2.mnglosa                                                                                 ,  -- 30  
          (CASE mdmn1.mnrrda WHEN 'M' THEN 3 ELSE 1 END)                                                ,  -- 31   
          ISNULL(a.clnumsinacofi,'0000')                                                                ,  -- 32  
          ISNULL(a.clnomsinacofi,'')                                                                    ,  -- 33  
          ISNULL(b.clnumsinacofi,'0000')                                                                ,  -- 34  
          ISNULL(b.clnomsinacofi,'')                                                                    ,  -- 35  
          CASE                                                                                             -- 36  
          WHEN mfcah.catipmoda = 'C' AND ( mfcah.cacodpos1 = 1 OR mfcah.cacodpos1 = 3 OR mfcah.cacodpos1 = 7 OR mfcah.cacodpos1 = 10) THEN  
             ( SELECT glosa FROM view_forma_de_pago WHERE codigo = mfcah.cafpagomn )  
          ELSE  
             ( SELECT glosa FROM view_forma_de_pago WHERE codigo = mfcah.cafpagomx )  
          END,  
 --nuevos campos  
    caserie,                         --37  
    substring(caserie,1,3),  
    isnull((select semonemi from bacparamsuda..SERIE where caserie=seserie),0),  
    ' ',  
    isnull((select sefecven from bacparamsuda..SERIE where caserie=seserie),'  '),  
    ' ',  
    cafecvcto,       --43  
    catasacon,       -- 44  
    catipcam,         -- 45  
    estado_sinacofi, --46  
    fecha_estado_sina, --47  
   cltipcli, --48  
          @Nombre_Usuario,  --49  
          @Glosa_Paridad,   --50  
          @Glosa_Tabla_Global_1, --51  
          @Glosa_Tabla_Global_2, --52  
          @Glosa_Tabla_Global_3, --53
          @Glosa_Tabla_Global_4  --54
     
   -- RQ 7619  
   FROM   --MFAC     ,   
          --MFCAH    ,  
          VIEW_CLIENTE  cl ,  
          VIEW_TBSINACOFI a  RIGHT OUTER JOIN MFCAH ON ( a.clrut =MFCAH.cacodigo AND a.clcodigo =MFCAH.cacodcli ),  
          VIEW_TBSINACOFI b  RIGHT OUTER JOIN MFAC ON  ( b.clrut = acrutprop ),  
          VIEW_MONEDA mdmn1  ,            
          VIEW_MONEDA mdmn2            
   WHERE MFCAH.canumoper   =  @nnumope         
     AND ( cl.clrut        =  MFCAH.cacodigo   
     AND cl.clcodigo       =  MFCAH.cacodcli )  
    -- AND ( a.clrut         =* MFCAH.cacodigo   
     --AND   a.clcodigo      =* MFCAH.cacodcli )  
     --AND ( b.clrut         =* acrutprop )  
     AND MFCAH.cacodmon1   =  mdmn1.mncodmon   
     AND MFCAH.cacodmon2   =  mdmn2.mncodmon   
  
--Actualiza datos de envio de operación en MFCA  
  
select @estado=ESTADO_SINACOFI from #temporal  
  
--select @estado  
  
    IF @estado = ''  
        BEGIN  
  UPDATE MFCAH SET  
   estado_sinacofi='CN-CONTRATO NUEVO',  
   fecha_estado_sina=@fecha_proceso  
  WHERE canumoper=@nnumope  
    
  UPDATE #Temporal SET  
   ESTADO_SINACOFI='CN-CONTRATO NUEVO',  
   FECHA_SINACOFI=@fecha_proceso  
  WHERE NUMOPE=@nnumope  
 END  
    ELSE  
 IF @flag = 0  
 BEGIN  
  BEGIN   
   UPDATE MFCAH SET  
    estado_sinacofi='CM-CONTRATO MODIFICADO',  
    fecha_estado_sina=@fecha_proceso  
   WHERE canumoper=@nnumope  
   
   UPDATE #Temporal SET  
    ESTADO_SINACOFI='CM-CONTRATO MODIFICADO',  
    FECHA_SINACOFI=@fecha_proceso  
   WHERE NUMOPE=@nnumope  
  END  
 END  
--select @estado  
--select canumoper,estado_sinacofi,fecha_estado_sina ,* from MFca where canumoper=8512 --@nnumope  
  
     
  
  
   SELECT * FROM #Temporal  
  
  
  SET NOCOUNT OFF  
END  
  
GO
