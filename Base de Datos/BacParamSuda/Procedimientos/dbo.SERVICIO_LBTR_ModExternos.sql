USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SERVICIO_LBTR_ModExternos]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SERVICIO_LBTR_ModExternos]  
   ( @NumOper     NUMERIC(10) = 0  
   , @Sistema     VARCHAR(5)     = ''  
   , @BacUser     VARCHAR(10)    = 'ADMINISTRA'  
   , @ChangeState CHAR(1)     = 'N'  
   , @iSecuencia   int  
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @iIncodigo           NUMERIC(10)  
   DECLARE @Mensaje             CHAR(5)  
   DECLARE @iMonedaMx           INT  
   DECLARE @iTipCli             INT  
   DECLARE @BancoReceptor       VARCHAR(50)  
   DECLARE @SwiftReceptor       VARCHAR(50)  
   DECLARE @CtaContable         VARCHAR(50)  
   DECLARE @SwiftIntermediario  VARCHAR(50)  
   DECLARE @BcoIntermediario    VARCHAR(50)  
   DECLARE @CtaCte              VARCHAR(50)  
   DECLARE @SwiftBeneficiario   VARCHAR(50)  
   DECLARE @BcoBeneficiario     VARCHAR(50)  
   DECLARE @DirBeneficiario     VARCHAR(50)  
   DECLARE @CiuBeneficiario     VARCHAR(50)  
   
   DECLARE @ConClave   INT  
       SET @ConClave   = 0  
  
   DECLARE @iFoundError   INT  
       SET @iFoundError   = 0  
  
   DECLARE @iCheClave   INT  
       SET @iCheClave   = 0  
  
   DECLARE @dFechaProc   DATETIME  
       SET @dFechaProc   = (SELECT dFechaProceso FROM SADP_CONTROL with(nolock) )  
  
   DECLARE @nMontoGrupo   NUMERIC(21,4)  
       SET @nMontoGrupo   = 0.0  
  
   DECLARE @IdGrupo    NUMERIC(10)  
       SET @IdGrupo    = ISNULL((SELECT DISTINCT Id_Paquete FROM BacParamSuda..MDLBTR with (nolock)  
             WHERE sistema = @Sistema AND numero_operacion = @NumOper AND secuencia = @iSecuencia   and Tipo_Movimiento = 'C' AND Estado_Paquete = 'A'), 0)  
  
   -->     Realiza el cambio de estado de las operaciones enviadas  
   IF @ChangeState = 'S'  
   BEGIN  
      UPDATE MDLBTR  
      SET    estado_envio      = 'E'   
      WHERE  sistema           = @Sistema   
      AND    numero_operacion  = @NumOper  
      AND secuencia = @iSecuencia   
      AND    Tipo_Movimiento   = 'C'  
  
      UPDATE SADP_DETALLE_PAGOS  
         SET sEnviadoPor       = @BacUser  
         ,   cEstado           = 'E'  
         ,   vNumTransferencia = 0  
      WHERE  cModulo           = @Sistema  
        AND  nContrato         = @NumOper  
        AND isecuencia = @iSecuencia  
     and cEstado <>'APM'  
  
      RETURN  
   END  
   -->     Realiza el cambio de estado de las operaciones enviadas  
  
   -->     Identifica si es moneda extranjera  
   SELECT  @iMonedaMx          = CASE WHEN md.moneda = 13 THEN 1 ELSE 0 END  
   ,       @iTipCli            = 0  
   FROM    BacParamSuda.dbo.MDLBTR                        md with(nolock)  
           INNER JOIN BacParamSuda.dbo.SADP_DETALLE_PAGOS dp with(nolock) ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND dp.cestado IN('P')  
   WHERE   md.fecha            = @dFechaProc  
   AND     md.sistema          = @Sistema  
   AND     md.numero_operacion = @NumOper  
   AND    md.secuencia = @iSecuencia  
   AND     md.Tipo_Movimiento  = 'C'  
   AND     dp.iFormaPago       NOT IN(5, 103, 105)  
   -->     Identifica si es moneda extranjera  
  
   IF @ChangeState = 'V'  
   BEGIN  
  IF @Sistema = 'CDB' OR @Sistema = 'FFMM' OR @Sistema = 'GPI'  
     BEGIN  
   UPDATE MDLBTR  
   SET  estado_envio  = 'E'   
   WHERE sistema    = @Sistema   
   AND  numero_operacion = @NumOper  
   AND  secuencia = @iSecuencia   
   AND  Tipo_Movimiento  = 'C'  
   AND  forma_pago   IN(5, 103, 105)  
   AND  estado_envio  = 'P'  
  
   UPDATE SADP_DETALLE_PAGOS  
   SET  sEnviadoPor   = @BacUser  
   ,  cEstado    = 'E'  
   ,  vNumTransferencia = 0  
   WHERE cModulo    = @Sistema  
   AND  nContrato   = @NumOper  
   AND  isecuencia = @iSecuencia  
   AND  iFormaPago   IN(5, 103, 105)  
   AND  cEstado    = 'P'     
     END  
      
      -->     Validacion de Cambios de Estado  
      SELECT  @iFoundError   = -4  
      FROM    BacParamSuda.dbo.MDLBTR                        md with(nolock)  
              INNER JOIN BacParamSuda.dbo.SADP_DETALLE_PAGOS dp with(nolock) ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND isecuencia = Secuencia and dp.cestado IN('P')  
              INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO      fp with(nolock) ON fp.codigo  = dp.iFormaPago  
      WHERE   md.fecha            = @dFechaProc  
      AND     md.sistema          = @Sistema  
      AND     md.numero_operacion = @NumOper  
      AND   md.Secuencia        = @iSecuencia  
      AND     md.Tipo_Movimiento  = 'C'  
      AND     dp.iFormaPago       NOT IN(5, 103, 105)  
      AND (  
             (dp.iRutCliente      = 0  OR dp.iCodigo = 0  )  
         OR  (dp.sSwift           = '' OR dp.sCtaCte = '' )  
          )  
      -->     Validacion de Cambios de Estado  
  
      IF @iFoundError = -4  
      BEGIN  
         SELECT -4 , 'Err. - 1.- NO es posible enviar, Favor revise los datos del beneficiario y banco receptor.... '  
         RETURN  
      END  
  
      -->     Validacion del Canal por Medio de Pago  
      SELECT  @iFoundError        = CASE WHEN cfp.Codigo_Canal = 2 THEN -4 ELSE 0 END  
      FROM    BacParamSuda.dbo.MDLBTR                        md with(nolock)  
              INNER JOIN BacParamSuda.dbo.SADP_DETALLE_PAGOS dp with(nolock) ON dp.cModulo           = md.sistema AND dp.nContrato = md.numero_operacion AND isecuencia = Secuencia and  dp.cestado IN('P')  
              INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO      fp with(nolock) ON fp.codigo            = dp.iFormaPago  
              INNER JOIN BacParamSuda.dbo.FPAGO_CANAL       cfp with(nolock) ON cfp.Codigo_FormaPago = fp.codigo   
      WHERE   md.fecha            = @dFechaProc  
      AND     md.sistema          = @Sistema  
      AND     md.numero_operacion = @NumOper  
      AND   md.Secuencia        = @iSecuencia  
      AND     md.Tipo_Movimiento  = 'C'  
      AND     dp.iFormaPago       NOT IN(5, 103, 105)  
      AND (  
             (dp.iRutCliente      = 0  OR dp.iCodigo = 0  )  
         OR  (dp.sSwift           = '' OR dp.sCtaCte = '' )  
          )  
      -->     Validacion del Canal por Medio de Pago  
  
      IF @iFoundError = -4  
      BEGIN  
         SELECT -4 , 'Err. - 2.- No es posible enviar, Favor revise el canal de la forma de pago. (DVP Combanc).'  
         RETURN  
      END  
  
      SELECT 0, 'Ok. Operacion se puede enviar.'  
      RETURN  
   END  
  
   -->     Rehace la carga, en caso que se este eliminando por otro usuario  
   EXECUTE SP_BTR_CARGA_TABLA_MDLBTR  
   -->     Rehace la carga, en caso que se este eliminando por otro usuario  
  
   IF NOT EXISTS(SELECT 1 FROM BacParamSuda..MDLBTR with (nolock) WHERE sistema = @Sistema AND numero_operacion = @NumOper AND Secuencia        = @iSecuencia)  
   BEGIN  
      SELECT -3, 'Err. - Operación no genera mensaje swift.'  
      RETURN  
   END  
  
   DECLARE @cRutBanco     NUMERIC(9)  
   DECLARE @cCodBanco     NUMERIC(9)  
   DECLARE @cDvBanco      CHAR(1)  
   DECLARE @cNombreBanco  VARCHAR(70)   
   DECLARE @cDireccion    VARCHAR(70)   
   DECLARE @cSwiftBanco   VARCHAR(20)  
   DECLARE @dpCtaCte   VARCHAR(20)  
  
   SELECT  @cRutBanco    = cl.clrut  
   ,       @cCodBanco    = cl.clcodigo  
   ,       @cDvBanco     = cl.cldv  
   ,       @cNombreBanco = cl.clnombre  
   ,       @cDireccion   = cl.cldirecc   
   ,       @cSwiftBanco  = cl.clswift  
   FROM    BacParamSuda.dbo.CLIENTE          cl with(nolock), bacparamsuda.dbo.sadp_control sc  
   WHERE  cl.clcodigo = 1 AND cl.clrut= CASE WHEN @Sistema='FFMM' THEN  sc.iRut_FFMM WHEN @Sistema='GPI' THEN sc.iRut_Agencia WHEN @Sistema='CDB' THEN sc.iRut_CDB ELSE 0 END  
  
/*  
   SELECT  @cRutBanco    = clrut  
   ,       @cCodBanco    = clcodigo  
   ,       @cDvBanco     = cldv  
   ,       @cNombreBanco = clnombre  
   ,       @cDireccion   = cldirecc   
   ,       @cSwiftBanco  = clswift   
   FROM    VIEW_MDAC     with (nolock)   
   ,       CLIENTE       with (nolock)  
   WHERE   clrut         = acrutprop  
   AND     clcodigo      = 1  
*/   
  
 IF @Sistema='FFMM'  
  SET @dpCtaCte  = (SELECT  sCuentaCorriente   
                                FROM SADP_CUENTASCORRIENTES sc  
                     INNER  
                                JOIN SADP_CONTROL sc2  
                         ON sc.iRutCliente = sc2.iRut_FFMM  
                                 AND sc.iCodCliente = 0  
                                 AND sc.id_banco    = 27  
                                 AND sc.iCodMoneda =999) ;  
 IF @Sistema='GPI'                                  
  SET @dpCtaCte   = (SELECT  sCuentaCorriente   
                                FROM SADP_CUENTASCORRIENTES sc  
                               INNER  
                                JOIN SADP_CONTROL sc2  
                                  ON sc.iRutCliente = sc2.iRut_Agencia  
                                 AND sc.iCodCliente = 0  
                                 AND sc.id_banco    = 27) ;  
IF @Sistema='CDB'                                   
  SET @dpCtaCte   = (SELECT  sCuentaCorriente   
                                FROM SADP_CUENTASCORRIENTES sc  
                               INNER  
                                JOIN SADP_CONTROL sc2  
                                  ON sc.iRutCliente = sc2.iRut_CDB  
                                 AND sc.iCodCliente = 0  
                                 AND sc.id_banco    = 27) ;  
  
   
   DECLARE @cCodSinacofi  CHAR(4)  
       SET @cCodSinacofi  = ''  
       SET @cCodSinacofi  = isnull(( SELECT TOP 1 isnull(clnumsinacofi, '') FROM BacParamSuda.dbo.SINACOFI with(nolock) WHERE clrut = @cRutBanco AND clcodigo = @cCodBanco ), '')  
  
/*   IF @cCodSinacofi = '' or @cCodSinacofi is null  
   BEGIN  
      SELECT -4, 'Err. - Operación No se puede enviar, favor revisar el codigo sinacofi.'  
      RETURN  
   END   
*/  
   SET @Mensaje                = ''  
   SET @iMonedaMx              = 0  
  
   SELECT  @Mensaje            = 'MT103'  
   ,       @iMonedaMx          = 0  
   FROM    BacParamSuda.dbo.MDLBTR                        md with(nolock)  
           INNER JOIN BacParamSuda.dbo.SADP_DETALLE_PAGOS dp with(nolock) ON dp.cModulo   = md.sistema AND dp.nContrato = md.numero_operacion AND Secuencia        = @iSecuencia AND dp.cestado IN('P')  
           INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO      fp with(nolock) ON fp.codigo            = dp.iFormaPago  
           INNER JOIN BacParamSuda.dbo.FPAGO_CANAL       cfp with(nolock) ON cfp.Codigo_FormaPago = fp.codigo   
   WHERE   md.fecha            = @dFechaProc  
   AND     md.sistema          = @Sistema  
   AND     md.numero_operacion = @NumOper  
   AND  md.Secuencia        = @iSecuencia  
   AND     md.Tipo_Movimiento  = 'C'  
   AND     dp.iFormaPago       NOT IN(5, 103, 105)  
     
     
    
   SET @iIncodigo = 0  
  
 DECLARE @xUsuanrio VARCHAR(7)  
  SET @xUsuanrio = ( SELECT cUser FROM SADP_DATOS_ENVIO )   
  
   SELECT /*001*/          'H01USERID' = @xUsuanrio -->@xUsuanrio  
   ,      /*002*/          'H01PROGRM' = 'EPR3000'  
   ,      /*003*/          'H01TIMSYS' = CASE WHEN DATEPART(HOUR,GETDATE())   <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(HOUR,GETDATE()))  
                                              ELSE                                            CONVERT(CHAR(2),DATEPART(HOUR,GETDATE()))  
           END  
                                       + CASE WHEN DATEPART(MINUTE,GETDATE()) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(MINUTE,GETDATE()))  
                                              ELSE                                            CONVERT(CHAR(2),DATEPART(MINUTE,GETDATE()))  
                                         END  
                                       + CASE WHEN DATEPART(SECOND,GETDATE()) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(SECOND,GETDATE()))  
                                              ELSE                                            CONVERT(CHAR(2),DATEPART(SECOND,GETDATE()))  
                                         END  
                                       + CASE WHEN DATEPART(DAY,GETDATE())    <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,GETDATE()))  
                                              ELSE                                            CONVERT(CHAR(2),DATEPART(DAY,GETDATE()))  
                                         END  
                                       + CASE WHEN DATEPART(MONTH,GETDATE())  <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(MONTH,GETDATE()))  
                                              ELSE                                            CONVERT(CHAR(2),DATEPART(MONTH,GETDATE()))  
                                         END  
                                       + CONVERT(CHAR(2),SUBSTRING(CONVERT(CHAR(4),YEAR(GETDATE())),3,2))  
   ,      /*004*/      'H01SCRCOD' = '01'  
   ,      /*005*/          'H01OPECOD' = '001'  
   ,      /*006*/          'H01FLGMAS' = ' '  
   ,      /*007*/          'H01FLGWK1' = ' '  
   ,      /*008*/          'H01FLGWK2' = ' '  
   ,      /*009*/          'H01FLGWK3' = ' '  
   ,      /*010*/          'E01INWUSR' = @xUsuanrio  -->'MESADIN'-->'TSTLALB'    
   ,      /*011*/          'E01INWEXA' = 'MDIR'  
   ,      /*012*/          'E01INWIMT' = 'S'  
   ,      /*013*/          'E01INWSQN' = '1'  
   ,      /*014*/          'E01INWTYP' = 'O'  
   ,      /*015*/     'E01INWTCD' = CASE  WHEN LTRIM(RTRIM(@Sistema)) ='FFMM' THEN 'FFMM'   
           WHEN LTRIM(RTRIM(@Sistema))='CDB' THEN 'CCBB'   
           ELSE  CASE WHEN tipo_operacion = 'CP'  THEN CONVERT(CHAR(8),'CDEF')   
              ELSE  CONVERT(CHAR(8),tipo_operacion)  END END   
     
  
   ,      /*016*/          'E01INWTDM' = '0'  
   ,      /*017*/          'E01INWTDD' = '0'  
   ,      /*018*/          'E01INWTDY' = '0'  
   ,      /*019*/          'E01INWTTM' = '0'  
   ,      /*020*/          'E01INWVDM' = CASE WHEN DATEPART(MONTH,fecha) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(MONTH,fecha))  
                                              ELSE                                       CONVERT(CHAR(2),DATEPART(MONTH,fecha))  
                                         END  
   ,      /*021*/          'E01INWVDD' = CASE WHEN DATEPART(DAY,fecha)   <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,fecha))  
                 ELSE                            CONVERT(CHAR(2),DATEPART(DAY,fecha))  
                                         END  
   ,     /*022*/ 'E01INWVDY' = SUBSTRING(CONVERT(CHAR(4), DATEPART( YEAR , fecha ) ),3,2)  
   ,     /*023*/           'E01INFVTM' = '900'  
   ,     /*024*/           'E01INWOBN' = '01'  
   ,     /*025*/           'E01INWOBR' = '1'  
   ,     /*026*/           'E01INWOCU' = '0'  
   ,     /*027*/           'E01INWNUM' = '0'  
   ,     /*028*/           'E01INWCDE' = ' '  
   ,     /*029*/           'E01INWAMT' = dp.nMonto  
   ,     /*030*/           'E01INWTCY' = UPPER(mnnemo)   
-->,     /*031*/           'E01INWSID' = ltrim(rtrim(dp.sSwift)) + 'AXXX'  
   ,     /*031*/     'E01INWSID' = 'CONBCLRMAXXX'-->   ltrim(rtrim(@cSwiftBanco)) + 'AXXX'   
   ,     /*032*/           'E01INWRID' = dp.sSwift  
   ,     /*033*/           'E01INWSRF' = md.tipo_operacion + CONVERT(CHAR(09),@NumOper)  
   ,     /*034*/           'E01INWTHF' = ' '  
   ,     /*035*/           'E01INWDBK' = '01'  
   ,     /*036*/           'E01INWDBR' = '1'  
   ,     /*037*/           'E01INWDCY' = mncodfox  
   ,     /*038*/           'E01INWDGL' = '0'-->'50014'-->'3005010040000000' -->0000000' --> '70094'  --> Cambiar... No debe ir en Duro [Cta Contable Debito]  
   ,     /*039*/           'E01INWDAC' = @dpCtaCte -->'0'  
   ,     /*040*/           'E01INWDCC' = '0'  
   ,     /*041*/           'E01INWDXR' = '0'  
   ,     /*042*/           'E01INWCBK' = '01'   
   ,     /*043*/           'E01INWCBR' = '001'  
   ,     /*044*/           'E01INWCCY' = mncodfox  
   ,     /*045*/           'E01INWCGL' = '33860'-->'211001145000000' -->0000000'    --> '70094'  --> Cambiar... No debe ir en Duro [Cta Contable Credito]  
   ,     /*046*/           'E01INWCAC' = '0'     --> Cambiar... No debe ir en Duro [Cta Detalle Credito]  
   ,     /*047*/    'E01INWCCC' = '0'  
   ,     /*048*/           'E01INWCXR' = '0.00'  
   ,     /*049*/           'E01INWCCU' = '0'  
   ,     /*050*/           'E01INWHDY' = '0'  
   ,     /*051*/           'E11INWORC' = ' '  
   ,     /*052*/           'E21INWORC' = ' '   
  ,     /*053*/           'E31INWORC' = ' ' --  
   ,     /*054*/     'E41INWORC' = ' '  
   ,     /*055*/           'E01INWORO' = 'K'  
   ,     /*056*/           'E11INWOBK' = ' '  
   ,     /*057*/           'E21INWOBK' = ' '  
   ,     /*058*/           'E31INWOBK' = ' '  
   ,     /*059*/           'E41INWOBK' = ' '  
   ,     /*060*/           'E01INWOBO' = ' '  
   ,     /*061*/           'E11INWINB' = ' '  
   ,     /*062*/           'E21INWINB' = ' '  
   ,     /*063*/           'E31INWINB' = ' '  
   ,     /*064*/           'E41INWINB' = ' '  
   ,     /*065*/           'E01INWINO' = ' '  
   ,     /*066*/           'E11INWBCU' = ltrim(rtrim( dp.sNomBeneficiario )) --> ltrim(rtrim( clnombre ))   --> Nombre Cliente o beneficiario  
   ,     /*067*/           'E21INWBCU' = ltrim(rtrim( RecDireccion )) --> Direccion de Banco beneficiario  
   ,     /*068*/           'E31INWBCU' = ''  
   ,     /*069*/           'E41INWBCU' = ''  
   ,     /*070*/           'E01INWBCO' = ' '  
   ,     /*071*/           'E11INWBBK' = isnull(( SELECT ltrim(rtrim(clnombre)) FROM CLIENTE WHERE clrut = RecRutBanco and clcodigo = RecCodBanco),'') -- Nombre Bco Beneficiario  
   ,     /*072*/           'E21INWBBK' = ' '  
   ,     /*073*/           'E31INWBBK' = ' '  
   ,     /*074*/           'E41INWBBK' = ' '  
   ,     /*075*/           'E01INWBBO' = 'D'  
   ,     /*076*/           'E11INWSCB' = ' '  
   ,     /*077*/           'E21INWSCB' = ' '  
   ,     /*078*/           'E31INWSCB' = ' '  
   ,     /*079*/           'E41INWSCB' = ' '  
   ,     /*080*/           'E01INWSCO' = ' '  
   ,     /*081*/           'E11INWRCB' = ' '  
   ,     /*082*/           'E21INWRCB' = ' '  
   ,     /*083*/           'E31INWRCB' = ' '  
   ,     /*084*/           'E41INWRCB' = ' '  
   ,     /*085*/           'E01INWRBO' = ' '  
   ,     /*086*/           'E11INWDTO' = 'TRANSFERENCIA ' + fp.glosa  
   ,     /*087*/           'E21INWDTO' = ' '  
   ,     /*088*/           'E31INWDTO' = ' '  
   ,     /*089*/           'E41INWDTO' = ' '  
   ,     /*090*/           'E11INWDTP' = ISNULL( pe.Producto, '')  
   ,     /*091*/           'E21INWDTP' = ' ' --> Detalle Pago  
   ,     /*092*/           'E31INWDTP' = ' ' --> Detalle Pago  
   ,    /*093*/            'E41INWDTP' = ' ' --> Detalle Pago  
   ,     /*094*/           'E01INWCHG' = 'N' --> Es O no Cero  
   ,     /*095*/           'E11INWBKB' = ISNULL( pe.Producto, '')  
   ,     /*096*/           'E21INWBKB' = ' '  
   ,     /*097*/           'E31INWBKB' = ' '  
   ,     /*098*/           'E41INWBKB' = ' '  
   ,     /*099*/           'E01INWCKN' = '0'  
   ,     /*100*/           'E01INWFMT' = 'MT103'  
   ,     /*101*/           'E01INWCOT' = '0'  
   ,     /*102*/     'E01INWCOM' = '0.00'  
   ,     /*103*/           'E01INWCOB' = ' '  
   ,     /*104*/           'E01INWCOR' = '0'  
   ,     /*105*/           'E01INWCOY' = ' '  
   ,     /*106*/           'E01INWCOG' = '0'  
   ,     /*107*/           'E01INWCOC' = '0'  
   ,     /*108*/           'E01INWBCA' = '0.00'  
   ,     /*109*/           'E01INWPVI' = '3'  
   ,     /*110*/           'E01INWDPT' = ' '  
   ,     /*111*/           'E01INWSOU' = '05'  
   ,     /*112*/           'E01INWDIB' = ' '  
   ,     /*113*/           'E01INWDSQ' = ' '  
   ,     /*114*/           'E01INWFL1' = ' '  
   ,     /*115*/           'E01INWFL2' = ' '  
   ,     /*116*/           'E01INWFL3' = ' '  
   ,     /*117*/           'E01INWIDM' = CASE WHEN DATEPART(MONTH, md.fecha_vencimiento) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(MONTH, md.fecha_vencimiento))  
                                              ELSE                                                 CONVERT(CHAR(2),DATEPART(MONTH, md.fecha_vencimiento))  
                                         END  
   ,     /*118*/           'E01INWIDD' = CASE WHEN DATEPART(DAY, md.fecha_vencimiento)   <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY, md.fecha_vencimiento))  
                                              ELSE                                               CONVERT(CHAR(2),DATEPART(DAY, md.fecha_vencimiento))  
                 END  
   ,     /*119*/           'E01INWIDY' = SUBSTRING(CONVERT(CHAR(4), DATEPART(YEAR , md.fecha_vencimiento ) ),3,2)  
   ,     /*120*/           'E11INWRTR' = ' '  
   ,     /*121*/           'E21INWRTR' = ' '  
   ,     /*122*/           'E31INWRTR' = ' '  
   ,     /*123*/           'E01INWBKO' = ' '  
   ,     /*124*/           'E01INWITC' = ' '  
   ,     /*125*/           'E01INWITA' = ' '  
   ,     /*126*/           'E01INWTTC' = ' '  
   ,     /*127*/         'E11INWTRD' = ' '  
   ,     /*128*/           'E21INWTRD' = ' '  
   ,     /*129*/           'E31INWTRD' = ' '  
   ,     /*130*/           'E41INWTRD' = ' '  
   ,     /*131*/           'E01INWTRI' = ' '  
   ,     /*132*/           'E01INWSCC' = ' '  
   ,     /*133*/           'E01INWSCA' = '0.00'  
   ,     /*134*/           'E01INWRCC' = ' '  
   ,     /*135*/           'E01INWRRA' = '0.00'  
   ,     /*136*/    'E01INWBID' = CASE WHEN @iMonedaMx = 1 THEN '' ELSE LTRIM(RTRIM(CONVERT(CHAR(10),DP.iRutBeneficiario))) + LTRIM(RTRIM(dp.sDigBeneficiario)) END  
   -->,     /*137*/           'E01INWOID' =  '970230009' --LTRIM(RTRIM(CONVERT(CHAR(10),@cRutBanco))) + @cDvBanco ' 15-03-2012 esta linea se debe agregar cuando el que paga es uno distinto de las filiales definidas   
   ,     /*137*/           'E01INWOID' =  LTRIM(RTRIM(CONVERT(CHAR(10),@cRutBanco))) + @cDvBanco  
   ,     /*138*/           'E01INWOCT' = 'TERCERO'  
   ,     /*139*/           'E01INWBIS' = 1  
   ,     /*140*/    'E01INWBAC' = dp.sCtaCte   
   ,     /*141*/           'E01INWRBI' = ISNULL((SELECT LTRIM(RTRIM(CONVERT(CHAR(10),clrut))) + LTRIM(RTRIM(cldv)) FROM CLIENTE WHERE clrut = dp.iRutCliente and clcodigo = dp.iCodigo ),'') -- Nombre Bco Beneficiario  
   ,     /*142*/           'E01INWACI' = 'P'  
   ,     /*143*/           'E01INWDAT' = '2'  
   ,     /*144*/           'E01INWCAT' = '2'  
   ,     /*145*/           'E01INWCNL' = ISNULL( cfp.codigo_canal, 0)  
   ,     /*146*/           'E01INWPTY' = '0'  
   ,     /*147 -- 101 n*/  'E01INWSST' = ' '  
   ,     /*148 -- 117 n*/  'E01INWFL4' = '1'  
   ,     /*149 -- 118 n*/  'E01INWFL5' = '1'-->se cambia  
   ,     /*150 -- 119 n*/  'E01INWFL6' = '1'  
   ,     /*151 -- 139 n*/  'E01INWOIS' = ' '  
         -- Claves --    
   ,     /*152 -- 147 n*/  'E01PRUCR1' = ' '  
   ,     /*153 -- 148 n*/  'E01PRUCR2' = ' '  
   ,     /*154 -- 149 n*/  'E01PRUCR3' = ' '  
   ,     /*155 -- 150 n*/  'E01PRUCR4' = ' '  
   ,     /*156 -- 151 n*/  'E01PRUCR5' = ' '  
   ,     /*157 -- 152 n*/  'E01PRUCR6' = ' '  
   ,     /*158 -- 153 n*/  'E01PRUCR7' = ' '  
   ,     /*159 -- 154 n*/  'E01PRUCR8' = ' '  
   ,     /*160 -- 155 n*/  'E01PRUCR9' = ' '  
   ,     /*161 -- 156 n*/  'E01PRUC10' = ' '  
   ,     /*162*/           'E01INWPYM' = CASE WHEN DATEPART(MONTH, md.fecha_vencimiento) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(MONTH, md.fecha_vencimiento))  
                                              ELSE                                                 CONVERT(CHAR(2),DATEPART(MONTH, md.fecha_vencimiento))  
                                         END  
   ,     /*163*/           'E01INWPYD' = CASE WHEN DATEPART(DAY, md.fecha_vencimiento)   <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY, md.fecha_vencimiento))  
                                              ELSE                                                 CONVERT(CHAR(2),DATEPART(DAY, md.fecha_vencimiento))  
                                         END  
   ,     /*164*/           'E01INWPYY' = SUBSTRING(CONVERT(CHAR(4), DATEPART(YEAR, md.fecha_vencimiento)),3,2)  
   ,     /*165*/           'E01PRIBID' = dp.iRutBeneficiario  
   ,  /*166*/           'E01PRIBAC' = dp.sCtaCte  
   INTO    #TEMP_LBTR  
   FROM    BacParamSuda.dbo.MDLBTR            md with(nolock)  
           INNER JOIN BacParamSuda.dbo.SADP_DETALLE_PAGOS dp with(nolock) ON dp.cModulo           = md.sistema AND dp.nContrato = md.numero_operacion AND md.secuencia=dp.isecuencia and dp.cestado IN('P')  
           INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO      fp with(nolock) ON fp.codigo            = dp.iFormaPago  
           INNER JOIN BacParamSuda.dbo.MONEDA             mn with(nolock) ON mn.mncodmon          = dp.iMoneda  
           INNER JOIN BacParamSuda.dbo.FPAGO_CANAL cfp with(nolock) ON cfp.Codigo_FormaPago = fp.codigo   
           LEFT  JOIN dbo.SADP_PRODUCTO_MODULOEXTERNO     pe with(nolock) ON pe.Modulo            = md.sistema  AND pe.Codigo = md.tipo_mercado AND pe.CodInterno = md.tipo_operacion   
   WHERE   md.fecha            = @dFechaProc  
   AND     md.sistema          = @Sistema  
   AND     md.Tipo_Movimiento  = 'C'  
   AND     dp.iFormaPago       NOT IN(5, 103, 105)  
   AND     md.numero_operacion = @NumOper  
 AND  md.secuencia=@iSecuencia  
   
   UPDATE #TEMP_LBTR   
   SET    E01INWTCD = 'DVPDCV' --> 'CCBDCV'  
   WHERE  E01INWCNL = 2  
  
   IF @iMonedaMx = 0   
   BEGIN  
      UPDATE #TEMP_LBTR  
      SET    E11INWORC  = ''  
      ,      E21INWORC  = ''  
      ,      E01INWORO  = ''  
      ,      E11INWBCU  = ''  
      ,      E21INWBCU  = ''  
      ,      E01INWBID  = ''  
      ,      E01INWOID  = ltrim(rtrim(convert(char(10),@cRutBanco))) + @cDvBanco  
      ,      E01INWBAC  = ''  
      WHERE  E01INWFMT <> 'MT103'  
   END ELSE  
   BEGIN  
      UPDATE #TEMP_LBTR  
      SET    E11INWORC  = ''  
      ,      E21INWORC  = ''  
      ,      E01INWORO  = ''  
      ,      E01INWBID  = ''  
      ,      E01INWOID  = ltrim(rtrim(convert(char(10),@cRutBanco))) + @cDvBanco  
      ,      E01INWBAC  = ''  
      WHERE  E01INWFMT <> 'MT103'  
   END  
  
   UPDATE #TEMP_LBTR  
   SET    E11INWBKB  = ''  
   WHERE  E01INWCNL  = 2  
  
   SELECT * FROM #TEMP_LBTR  
  
END  
  
  
GO
