USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SERVICIO_LBTR_PASO]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SERVICIO_LBTR_PASO]
   (	@NumOper     NUMERIC(10) = 0
   ,	@Sistema     CHAR(3)     = ''
   ,	@BacUser     CHAR(10)    = 'ADMINISTRA'
   ,	@ChangeState CHAR(1)     = 'N'
   )
AS
BEGIN

   SET NOCOUNT ON

   --> Define si se trata de un Grupo u/o una operacion individual
   DECLARE @nMontoGrupo  NUMERIC(21,4)
       SET @nMontoGrupo  = 0.0

   DECLARE @IdGrupo      NUMERIC(10)
       SET @IdGrupo      = ISNULL((SELECT DISTINCT Id_Paquete FROM BacParamSuda..MDLBTR with (nolock) WHERE sistema = @Sistema AND numero_operacion = @NumOper AND Tipo_Movimiento = 'C' AND Estado_Paquete = 'A'),0)

   IF @IdGrupo > 0
       SET @nMontoGrupo  = ISNULL((SELECT SUM(monto_operacion) FROM BacParamSuda..MDLBTR with (nolock) WHERE sistema = @Sistema AND Id_Paquete = @IdGrupo),0)
   --> 

   SELECT @IdGrupo, @nMontoGrupo

   DECLARE @dFechaProc   DATETIME
       SET @dFechaProc   = (SELECT acfecproc FROM BacTraderSuda..MDAC with (nolock) )

   IF @Sistema = 'PCS'
   BEGIN
      IF (SELECT COUNT(1) FROM MDLBTR with (nolock) WHERE sistema = @Sistema AND numero_operacion = @NumOper) > 1
      BEGIN
         DELETE FROM MDLBTR 
               WHERE sistema = @Sistema AND numero_operacion = @NumOper AND fecha < @dFechaProc
      END
   END

      
   DECLARE @cRutBanco             NUMERIC(9)
   DECLARE @cCodBanco             NUMERIC(9)
   DECLARE @cDvBanco              CHAR(1)
   DECLARE @cNombreBanco          VARCHAR(70) 
   DECLARE @cDireccion            VARCHAR(70) 
   DECLARE @cCodSinacofi          CHAR(4)
   DECLARE @cSwiftBanco           VARCHAR(20)
   DECLARE @iIncodigo             NUMERIC(10)
   DECLARE @Mensaje               CHAR(5)
   DECLARE @iMonedaMx             INTEGER
   DECLARE @iTipCli               INTEGER

   DECLARE @BancoReceptor         VARCHAR(50)
   DECLARE @SwiftReceptor         VARCHAR(50)
   DECLARE @CtaContable           VARCHAR(50)
   DECLARE @SwiftIntermediario    VARCHAR(50)
   DECLARE @BcoIntermediario      VARCHAR(50)
   DECLARE @CtaCte                VARCHAR(50)
   DECLARE @SwiftBeneficiario     VARCHAR(50)
   DECLARE @BcoBeneficiario       VARCHAR(50)
   DECLARE @DirBeneficiario       VARCHAR(50)
   DECLARE @CiuBeneficiario       VARCHAR(50)
 
   DECLARE @ConClave              INTEGER
       SET @ConClave              = 0

   IF @Sistema = 'BTR'
   BEGIN
      SELECT  @ConClave   = 1
      FROM    bactradersuda..MDMO with (nolock)
      WHERE   monumdocu   = @NumOper 
      AND     mocorrela   in(1,2,3,4,5,6,7,8,9,10) 
      AND     LTRIM(RTRIM(moclave_dcv)) <> ''
   END

   SELECT  @iMonedaMx       = CASE WHEN sistema = 'BCC' AND tipo_operacion = 'ITF/MX' THEN 1 
                                   WHEN sistema = 'BTR' AND tipo_operacion = 'ITF/MX' THEN 1 
                                   ELSE 0 
                              END
   ,       @iTipCli         = cltipcli
   FROM    MDLBTR with (nolock)
           INNER JOIN CLIENTE     ON rut_cliente      = clrut AND codigo_cliente = clcodigo
           INNER JOIN MONEDA      ON moneda           = mncodmon 
           INNER JOIN FPAGO_CANAL ON Codigo_FormaPago = forma_pago
   WHERE   sistema          = @Sistema  
   AND     numero_operacion = @NumOper
   AND     Tipo_Movimiento  = 'C'

   IF @ChangeState = 'S'
   BEGIN
      IF @IdGrupo > 0
         UPDATE MDLBTR SET estado_envio = 'E' WHERE sistema = @Sistema AND Id_Paquete = @IdGrupo
      ELSE
         UPDATE MDLBTR SET estado_envio = 'E' WHERE sistema = @Sistema AND Tipo_Movimiento = 'C' AND numero_operacion = @NumOper 
      RETURN
   END

   IF @ChangeState = 'V'
   BEGIN
      DECLARE @iFoud      INTEGER
          SET @iFoud      = 0

      DECLARE @iCheclave  INTEGER
          SET @iCheclave  = 0

      -- valida los datos del receptor para los clientes no Bancos
      IF @iMonedaMx = 0
      BEGIN
         SELECT  @iFoud   = -4
         FROM    MDLBTR   with (nolock)
                 LEFT JOIN CLIENTE ON rut_cliente = clrut AND codigo_cliente = clcodigo
         WHERE   numero_operacion  = @NumOper 
         AND     sistema           = @Sistema
         AND     Tipo_Movimiento   = 'C'
         AND     cltipcli         <> 1 -- No banco
         AND    (RecRutBanco       = 0 OR ltrim(rtrim(RecCodBanco)) = '' OR ltrim(rtrim(RecCodSwift)) = '' OR ltrim(rtrim(RecCtaCte)) = '' OR ltrim(rtrim(RecCtaCte)) = '0' )
      END ELSE
      BEGIN
         IF @iTipCli = 1
         BEGIN
            SELECT  @iFoud                             = -4
            FROM    MDLBTR_MX a 
            WHERE   a.operacion                        = @NumOper 
            AND     a.sistema                          = @Sistema
            AND    (ltrim(rtrim(a.BancoReceptor))      = '' 
                OR  ltrim(rtrim(a.SwiftReceptor))      = ''
                OR  ltrim(rtrim(a.CtaContable))        = ''
                OR  ltrim(rtrim(a.SwiftIntermediario)) = ''
                OR  ltrim(rtrim(a.BancoIntermediario)) = ''
                OR  ltrim(rtrim(a.CtaCte))             = ''
                OR  ltrim(rtrim(a.SwiftBeneficiario))  = ''
                OR  ltrim(rtrim(a.BancoBeneficiario))  = ''
                    )
         END

         IF @iTipCli <> 1
         BEGIN
            SELECT  @iFoud                             = -4
            FROM    MDLBTR_MX a
            WHERE   a.operacion                        = @NumOper 
            AND     a.sistema                          = @Sistema
            AND    (ltrim(rtrim(a.BancoReceptor))      = '' 
                OR  ltrim(rtrim(a.SwiftReceptor))      = ''
                OR  ltrim(rtrim(a.CtaContable))        = ''
                OR  ltrim(rtrim(a.SwiftIntermediario)) = ''
                OR  ltrim(rtrim(a.BancoIntermediario)) = ''
                OR  ltrim(rtrim(a.CtaCte))             = ''
                OR  ltrim(rtrim(a.BancoBeneficiario))  = ''
                OR  ltrim(rtrim(a.DirBeneficiario))    = ''
                OR  ltrim(rtrim(a.CiuBeneficiario))    = ''
                   )
         END
      END

      IF @iFoud = -4
      BEGIN
         SELECT -4 , 'Mensaje no enviado... REVISAR DATOS DEL BENEFICIARIO Y BANCO RECEPTOR.'
         RETURN
      END

      IF @iMonedaMx = 0
      BEGIN
         -- Valida Codigo Swift para Bancos
         SELECT @iFoud            = -4
         FROM   MDLBTR  with (nolock)
                LEFT JOIN CLIENTE ON rut_cliente = clrut AND codigo_cliente = clcodigo
         WHERE  numero_operacion  = @NumOper 
         AND    sistema           = @Sistema
         AND    Tipo_Movimiento   = 'C'
         AND    cltipcli          = 1 -- Banco
         AND   (LTRIM(RTRIM(RecCodSwift)) = '') -- OR ltrim(rtrim(RecCtaCte)) = '')
      END

      IF @iFoud = -4
      BEGIN
         SELECT -4 , 'Mensaje no enviado... REVISAR DATOS DEL BANCO RECEPTOR.'
         RETURN
      END

      SELECT @iCheclave = -4 FROM BacTraderSuda..MDMO with (nolock) WHERE monumoper = @NumOper AND moclave_dcv = ''

      IF @iCheclave <> 0
      BEGIN
         SELECT  @iCheclave
         ,       CASE WHEN @iCheclave = -4 THEN '¡ E - Operación tiene claves en blanco... !' ELSE '' END
         FROM    MDLBTR with (nolock)
                 INNER JOIN FPAGO_CANAL ON Codigo_FormaPago = forma_pago AND Codigo_Canal     = 2
         WHERE   sistema          = @Sistema  
         AND     numero_operacion = @NumOper
         AND     Tipo_Movimiento  = 'C'
         RETURN
      END

      -- Validación por Forma de Pago DVP COMBANC
      IF @Sistema <> 'BTR'
      BEGIN
         SELECT  @iFoud           = CASE WHEN Codigo_Canal = 2 THEN -4 ELSE 0 END
         FROM    MDLBTR with (nolock)
                 INNER JOIN FPAGO_CANAL ON Codigo_FormaPago = forma_pago
         WHERE   numero_operacion = @NumOper 
         AND     sistema          = @Sistema
         AND     Tipo_Movimiento  = 'C'
      
         IF @iFoud = -4
         BEGIN
            SELECT -4 , '¡ E - Operación no debe ser enviada por canal 2 (DVP Combanc) !'
            RETURN
         END
      END

      SELECT CASE WHEN estado_envio = 'P' THEN 0
                  WHEN estado_envio = 'I' THEN 0
                  WHEN estado_envio = 'E' THEN '-1' 
                  WHEN estado_envio = 'A' THEN '-2'
                  ELSE                         '-3'
             END AS Estado 
     ,       CASE WHEN estado_envio = 'P' THEN 'Operacion se puede enviar'
                  WHEN estado_envio = 'I' THEN 'Operacion impresa se puede enviar'
                  WHEN estado_envio = 'E' THEN 'Operacion ya enviada' 
                  WHEN estado_envio = 'A' THEN 'Operacion anulada'
                  ELSE                         'Operacion con problemas'
             END AS Mensaje
      FROM   MDLBTR with (nolock)
      WHERE  numero_operacion = @NumOper 
      AND    sistema          = @Sistema
      AND    Tipo_Movimiento  = 'C'

      RETURN
   END

   EXECUTE SP_BTR_CARGA_TABLA_MDLBTR

   IF NOT EXISTS(SELECT 1 FROM BacParamSuda..MDLBTR with (nolock) WHERE sistema = @Sistema AND numero_operacion = @NumOper)
   BEGIN
      SELECT -3, 'Operacion no Genera Mensaje Swift.'
   END

   SELECT  @cRutBanco    = clrut
   ,       @cCodBanco    = clcodigo
   ,       @cDvBanco     = cldv
   ,       @cNombreBanco = clnombre
   ,       @cDireccion   = cldirecc 
   ,       @cSwiftBanco  = clswift 
   FROM    VIEW_MDAC
   ,       CLIENTE
   WHERE   clrut         = acrutprop
   AND     clcodigo      = 1

   SELECT  @cCodSinacofi = clnumsinacofi 
   FROM    SINACOFI
   WHERE   clrut         = @cRutBanco
   AND     clcodigo      = @cCodBanco

   SET @iMonedaMx = 0

   SELECT @Mensaje       = CASE WHEN sistema  = 'BCC' AND tipo_operacion = 'CSPOT'  AND cltipcli =  1 THEN 'MT202'
                                WHEN sistema  = 'BCC' AND tipo_operacion = 'CSPOT'  AND cltipcli <> 1 THEN 'MT103'
                                WHEN sistema  = 'BCC' AND tipo_operacion = 'ITF/MX' AND cltipcli =  1 THEN 'MT202'
                                WHEN sistema  = 'BCC' AND tipo_operacion = 'ITF/MX' AND cltipcli <> 1 THEN 'MT103'
                                WHEN sistema  = 'BTR' AND tipo_operacion = 'ITF/MX' AND cltipcli =  1 THEN 'MT202'
                                WHEN sistema  = 'BTR' AND tipo_operacion = 'ITF/MX' AND cltipcli <> 1 THEN 'MT103'
                                WHEN sistema  = 'BTR' AND tipo_operacion = 'ICOL'   AND cltipcli =  1 THEN 'MT202'
                                WHEN sistema  = 'BTR' AND tipo_operacion = 'ICOL'   AND cltipcli <> 1 THEN 'MT103'
                                WHEN sistema  = 'BTR' AND tipo_operacion = 'VICAP'  AND cltipcli =  1 THEN 'MT202'
                                WHEN sistema  = 'BTR' AND tipo_operacion = 'VICAP'  AND cltipcli <> 1 THEN 'MT103'
                                WHEN sistema  = 'BTR' AND tipo_operacion = 'CDEF'   AND cltipcli =  1 THEN 'MT202'
                                WHEN sistema  = 'BTR' AND tipo_operacion = 'CDEF'   AND cltipcli <> 1 THEN 'MT103'
                                WHEN sistema  = 'BTR' AND tipo_operacion = 'CPAC'   AND cltipcli =  1 THEN 'MT202'
                                WHEN sistema  = 'BTR' AND tipo_operacion = 'CPAC'   AND cltipcli <> 1 THEN 'MT103'
                                WHEN sistema  = 'BTR' AND tipo_operacion = 'RECOMP' AND cltipcli =  1 THEN 'MT202'
                                WHEN sistema  = 'BTR' AND tipo_operacion = 'RECOMP' AND cltipcli <> 1 THEN 'MT103'
                                WHEN sistema  = 'BFW' AND tipo_operacion = 'VFUT'   AND cltipcli =  1 THEN 'MT202'
                                WHEN sistema  = 'BFW' AND tipo_operacion = 'VFUT'   AND cltipcli <> 1 THEN 'MT103'
			        WHEN sistema  = 'PCS' 					    	      THEN 'MT202'
                           END
   ,       @iMonedaMx    = CASE WHEN sistema  = 'BCC' AND tipo_operacion = 'ITF/MX'        THEN 1
                                WHEN sistema  = 'BTR' AND tipo_operacion = 'ITF/MX'                   THEN 1
			        WHEN sistema  = 'PCS' AND mnmx 		= 'C' 			     THEN 1 
			        WHEN sistema  = 'PCS' AND mnmx 	       <> 'C' 			     THEN 0
                                ELSE 0 
                           END 
   FROM    MDLBTR
           INNER JOIN CLIENTE     ON rut_cliente      = clrut AND codigo_cliente   = clcodigo
           INNER JOIN MONEDA      ON moneda           = mncodmon 
           INNER JOIN FPAGO_CANAL ON Codigo_FormaPago = forma_pago
   WHERE   sistema          = @Sistema  
   AND     numero_operacion = @NumOper
   AND     Tipo_Movimiento  = 'C'
  
   SET @iIncodigo = 0

   IF @Sistema = 'BTR'
      SELECT @iIncodigo = mocodigo FROM bactradersuda..MDMO WHERE monumoper = @NumOper

      SELECT Monumoper
      ,      Mocorrela = identity(Int)
      ,      moclave_dcv 
      INTO   #Claves_DCV
      FROM   bactradersuda..MDMO
      WHERE  monumoper = @NumOper

   IF (@Sistema = 'BCC' AND @iMonedaMx = 1) or (@Sistema = 'BTR' AND @iMonedaMx = 1)
   BEGIN
      SELECT @BancoReceptor      = BancoReceptor
      ,      @SwiftReceptor      = SwiftReceptor
      ,      @CtaContable        = CtaContable
      ,      @SwiftIntermediario = SwiftIntermediario
      ,      @BcoIntermediario   = BancoIntermediario
      ,      @CtaCte             = CtaCte
      ,      @SwiftBeneficiario  = CASE WHEN @Mensaje = 'MT202' THEN '//' + SwiftBeneficiario
                                        ELSE                                SwiftBeneficiario
                                   END
      ,      @BcoBeneficiario    = BancoBeneficiario
      ,      @DirBeneficiario    = DirBeneficiario
      ,      @CiuBeneficiario    = CiuBeneficiario
      FROM   MDLBTR_MX
      WHERE  Sistema             = @Sistema
      AND    Operacion           = @NumOper
   END

  SELECT /*001*/    'H01USERID' = 'SQ3CER1'
   ,     /*002*/    'H01PROGRM' = 'EPR3000'
   ,     /*003*/    'H01TIMSYS' = CASE WHEN DATEPART(HOUR,GETDATE())   <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(HOUR,GETDATE()))
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
   ,     /*004*/    'H01SCRCOD' = '01'
   ,     /*005*/    'H01OPECOD' = '001'
   ,     /*006*/    'H01FLGMAS' = ' '
   ,     /*007*/    'H01FLGWK1' = ' '
   ,     /*008*/    'H01FLGWK2' = ' '
   ,     /*009*/    'H01FLGWK3' = ' '
   ,     /*010*/    'E01INWUSR' = 'CBCLRGD'
   ,     /*011*/    'E01INWEXA' = 'MDIR'
   ,     /*012*/    'E01INWIMT' = 'S'
   ,     /*013*/    'E01INWSQN' = '1'
   ,     /*014*/    'E01INWTYP' = 'O'
   ,     /*015*/    'E01INWTCD' = CASE WHEN tipo_operacion = 'CP' THEN CONVERT(CHAR(8),'CDEF') ELSE CONVERT(CHAR(8),tipo_operacion) END
   ,     /*016*/    'E01INWTDM' = '0'
   ,     /*017*/    'E01INWTDD' = '0'
   ,     /*018*/    'E01INWTDY' = '0'
   ,     /*019*/    'E01INWTTM' = '0'
   ,     /*020*/    'E01INWVDM' = CASE WHEN DATEPART(MONTH,fecha) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(MONTH,fecha))
                                       ELSE                                       CONVERT(CHAR(2),DATEPART(MONTH,fecha))
                                  END
   ,     /*021*/    'E01INWVDD' = CASE WHEN DATEPART(DAY,fecha)   <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,fecha))
                                       ELSE                                       CONVERT(CHAR(2),DATEPART(DAY,fecha))
                                  END
   ,     /*022*/    'E01INWVDY' = SUBSTRING(CONVERT(CHAR(4), DATEPART( YEAR , fecha ) ),3,2)
   ,     /*023*/    'E01INFVTM' = '900'
   ,     /*024*/    'E01INWOBN' = '01'
   ,     /*025*/    'E01INWOBR' = '1'
   ,     /*026*/    'E01INWOCU' = '0'
   ,     /*027*/    'E01INWNUM' = '0'
   ,     /*028*/    'E01INWCDE' = ' '

   ,     /*029*/    'E01INWAMT' = CASE WHEN @IdGrupo > 0 THEN @nMontoGrupo ELSE monto_operacion END --> monto_operacion

   ,     /*030*/    'E01INWTCY' = CASE WHEN mncodmon = 998 THEN 'CLP' 
                                       WHEN mncodmon = 997 THEN 'CLP' 
                                       WHEN mncodmon = 994 THEN 'CLP' 
                                       ELSE UPPER(mnnemo) 
                                  END
   ,     /*031*/    'E01INWSID' = ltrim(rtrim(@cSwiftBanco)) + 'AXXX' 
   ,     /*032*/    'E01INWRID' = CASE WHEN @iMonedaMx = 1 THEN ltrim(rtrim(@SwiftReceptor))
                                       ELSE                     RecCodSwift
                                  END
   ,     /*033*/    'E01INWSRF' = CASE WHEN tipo_operacion = 'CP'                          THEN 'CDEF'
                                       WHEN tipo_operacion = 'ITF/MX' AND @Sistema = 'BCC' THEN 'VSPOT'
                                       WHEN tipo_operacion = 'ITF/MX' AND @Sistema = 'BTR' THEN CASE WHEN tipo_mercado = 'ICOL' THEN 'ICOL' ELSE 'VICAP' END
				       WHEN @Sistema 	   = 'PCS'    AND @iMonedaMx = 1   THEN 'VFUT'  --> 'ITF/MX'
				       WHEN @Sistema 	   = 'PCS'    AND @iMonedaMx = 0   THEN 'VFUT'  --> 'ITF/ML'
                                       ELSE                                                     tipo_operacion
                                  END
                                + CONVERT(CHAR(09),@NumOper)
   ,     /*034*/    'E01INWTHF' = ' '
   ,     /*035*/    'E01INWDBK' = '01'
   ,     /*036*/    'E01INWDBR' = '1'
   ,     /*037*/    'E01INWDCY' = CASE WHEN mncodmon = 994 THEN '00' -- UPPER(mnnemo)
                                       WHEN mncodmon = 997 THEN '00'
                                       WHEN mncodmon = 998 THEN '00'
                                       ELSE mncodfox
                                  END  
   ,     /*038*/    'E01INWDGL' = CASE WHEN @Sistema = 'BCC' AND @iMonedaMx = 1 THEN @CtaContable
                                       WHEN @Sistema = 'BTR' AND @iMonedaMx = 1 THEN @CtaContable
                                       ELSE                                          '33951' --> '70094'  --> Cambiar... No debe ir en Duro [Cta Contable Debito]
                                  END
   ,     /*039*/    'E01INWDAC' = '0'
   ,     /*040*/    'E01INWDCC' = '0'
   ,     /*041*/    'E01INWDXR' = '0'
   ,     /*042*/    'E01INWCBK' = '01'
   ,     /*043*/    'E01INWCBR' = '001'
   ,     /*044*/    'E01INWCCY' = CASE WHEN mncodmon = 994 THEN '00' -- UPPER(mnnemo)
                                       WHEN mncodmon = 997 THEN '00'
                                       WHEN mncodmon = 998 THEN '00'
                                       ELSE mncodfox
                                  END
   ,     /*045*/    'E01INWCGL' = CASE WHEN @Sistema = 'BCC' AND @iMonedaMx = 1 THEN @CtaContable
                                       WHEN @Sistema = 'BTR' AND @iMonedaMx = 1 THEN @CtaContable
                                       ELSE                                          '33951' --> '70094'  --> Cambiar... No debe ir en Duro [Cta Contable Credito]
                                  END
   ,     /*046*/    'E01INWCAC' = '0'                  --> Cambiar... No debe ir en Duro [Cta Detalle Credito]
   ,     /*047*/    'E01INWCCC' = '0'
   ,     /*048*/    'E01INWCXR' = '0.00'
   ,     /*049*/    'E01INWCCU' = '0'
   ,     /*050*/    'E01INWHDY' = '0'
   ,     /*051*/    'E11INWORC' = CASE WHEN @iMonedaMx = 1 THEN '//' + @cSwiftBanco ELSE ' ' END 
   ,     /*052*/    'E21INWORC' = ' ' 
   ,     /*053*/    'E31INWORC' = ' ' --
   ,     /*054*/    'E41INWORC' = ' '
   ,     /*055*/    'E01INWORO' = 'K'
   ,     /*056*/    'E11INWOBK' = ' '
   ,     /*057*/    'E21INWOBK' = ' '
   ,     /*058*/    'E31INWOBK' = ' '
   ,     /*059*/    'E41INWOBK' = ' '
   ,     /*060*/    'E01INWOBO' = ' '
   ,     /*061*/    'E11INWINB' = ' '
   ,     /*062*/    'E21INWINB' = ' '
   ,     /*063*/    'E31INWINB' = ' '
   ,     /*064*/    'E41INWINB' = ' '
   ,     /*065*/    'E01INWINO' = ' '

   ,     /*066*/    'E11INWBCU' = CASE WHEN @iMonedaMx = 1 THEN ltrim(rtrim(@CtaCte))   
                                       ELSE                     ltrim(rtrim(clnombre))  
                                  END
   ,     /*067*/    'E21INWBCU' = CASE WHEN @iMonedaMx = 1 AND cltipcli =  1 THEN ltrim(rtrim(@SwiftBeneficiario))
                                       WHEN @iMonedaMx = 1 AND cltipcli <> 1 THEN ltrim(rtrim(@BcoBeneficiario))
                                       ELSE                                       ltrim(rtrim(RecDireccion)) --LTRIM(RTRIM(cldirecc)) -- select * from mdlbtr
                                  END
   ,     /*068*/    'E31INWBCU' = CASE WHEN @iMonedaMx = 1 AND cltipcli =  1 THEN ltrim(rtrim(@BcoBeneficiario))
                                       WHEN @iMonedaMx = 1 AND cltipcli <> 1 THEN ltrim(rtrim(@DirBeneficiario))
                                       ELSE   ''
                                  END
   ,     /*069*/    'E41INWBCU' = CASE WHEN @iMonedaMx = 1 AND cltipcli <> 1 THEN ltrim(rtrim(@CiuBeneficiario))
                                       ELSE                                       ''
                                  END
   ,     /*070*/    'E01INWBCO' = ' '
   ,     /*071*/    'E11INWBBK' = CASE WHEN @iMonedaMx = 1 THEN '//' + ltrim(rtrim(@SwiftIntermediario))
                                       ELSE                            isnull(( SELECT ltrim(rtrim(clnombre)) FROM CLIENTE WHERE clrut = RecRutBanco and clcodigo = RecCodBanco),'') -- Nombre Bco Beneficiario
                                  END
   ,     /*072*/    'E21INWBBK' = CASE WHEN @iMonedaMx = 1 THEN ' '--ltrim(rtrim(@BcoIntermediario))
                                       ELSE ' '
                                  END
   ,     /*073*/    'E31INWBBK' = ' '
   ,     /*074*/    'E41INWBBK' = ' '
   ,     /*075*/    'E01INWBBO' = 'D'
   ,     /*076*/    'E11INWSCB' = ' '
   ,     /*077*/    'E21INWSCB' = ' '
   ,     /*078*/    'E31INWSCB' = ' '
   ,     /*079*/    'E41INWSCB' = ' '
   ,     /*080*/    'E01INWSCO' = ' '
   ,     /*081*/    'E11INWRCB' = ' '
   ,     /*082*/    'E21INWRCB' = ' '
   ,     /*083*/    'E31INWRCB' = ' '
   ,     /*084*/    'E41INWRCB' = ' '
   ,     /*085*/    'E01INWRBO' = ' '
   ,     /*086*/    'E11INWDTO' = 'TRANSFERENCIA ' + fpag.glosa
   ,     /*087*/    'E21INWDTO' = ' '
   ,     /*088*/    'E31INWDTO' = ' '
   ,     /*089*/    'E41INWDTO' = ' '
   ,     /*090*/    'E11INWDTP' = CASE WHEN sistema  = 'BCC' AND tipo_operacion = 'CSPOT'  THEN 'COMPRA SPOT'
                                       WHEN sistema  = 'BCC' AND tipo_operacion = 'VSPOT'  THEN 'VENTA SPOT'
                                       WHEN sistema  = 'BCC' AND tipo_operacion = 'ITF/MX' THEN '/RFB/ VTAS DOLARES'           -- 'TRANSACCION MONEDA MX'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'ITF/MX' THEN CASE WHEN tipo_mercado = 'ICOL' THEN 'INTERBANCARIO DE COLOCACION' ELSE 'VENCIMIENTO DE CAPTACIONES' END
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'ICOL'   THEN 'INTERBANCARIO DE COLOCACION'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'ICAP'   THEN 'INTERBANCARIO DE CAPTACION'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'VICAP'  THEN 'VENCIMIENTO DE CAPTACIONES'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'VICOL'  THEN 'VENCIMIENTO DE COLOCACIONES'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'CDEF'   THEN 'COMPRA DEFINITIVA'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'VDEF'   THEN 'VENTA DEFINITIVA'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'CPAC'   THEN 'COMPRA CON PACTO'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'VPAC'   THEN 'VENTA CON PACTO'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'RECOMP' THEN 'RECOMPRA '
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'REVTA'  THEN 'REVENTA '
                                       WHEN sistema  = 'BFW' AND tipo_operacion = 'VFUT'   THEN 'VENTA FORWARD'
				       WHEN Sistema  = 'PCS' AND @iMonedaMx 	= 1   	   THEN 'VENCIMIENTO FLUJO ICP MX' -- 'ITF/MX'
				       WHEN Sistema  = 'PCS' AND @iMonedaMx 	= 0   	   THEN 'VENCIMIENTO FLUJO ICP MN' -- '??????'
                                  END --> Detalle Pago
   ,     /*091*/    'E21INWDTP' = ' ' --> Detalle Pago
   ,     /*092*/    'E31INWDTP' = ' ' --> Detalle Pago
   ,     /*093*/    'E41INWDTP' = ' ' --> Detalle Pago
   ,     /*094*/    'E01INWCHG' = 'N' --> Es O no Cero
   ,     /*095*/    'E11INWBKB' = CASE WHEN sistema  = 'BCC' AND tipo_operacion = 'CSPOT'  THEN 'COMPRA SPOT'
                                       WHEN sistema  = 'BCC' AND tipo_operacion = 'VSPOT'  THEN 'VENTA SPOT'
                                       WHEN sistema  = 'BCC' AND tipo_operacion = 'ITF/MX' THEN 'TRANSACCION MONEDA MX'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'ITF/MX' THEN 'TRANSACCION MONEDA MX'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'ICOL'   THEN 'INTERBANCARIO DE COLOCACION'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'ICAP'   THEN 'INTERBANCARIO DE CAPTACION'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'VICAP'  THEN 'VENCIMIENTO DE CAPTACIONES'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'VICOL'  THEN 'VENCIMIENTO DE COLOCACIONES'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'CDEF'   THEN 'COMPRA DEFINITIVA'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'VDEF'   THEN 'VENTA DEFINITIVA'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'CPAC'   THEN 'COMPRA CON PACTO'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'VPAC'   THEN 'VENTA CON PACTO'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'RECOMP' THEN 'RECOMPRA '
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'REVTA'  THEN 'REVENTA '
                                       WHEN sistema  = 'BFW' AND tipo_operacion = 'VFUT'   THEN 'VENTA FORWARD'
				       WHEN Sistema  = 'PCS' AND @iMonedaMx 	= 1   	   THEN 'VENCIMIENTO FLUJO ICP MX' -- 'ITF/MX'
				       WHEN Sistema  = 'PCS' AND @iMonedaMx 	= 0   	   THEN 'VENCIMIENTO FLUJO ICP MN' -- '??????'

                                  END --> Detalle Pago
   ,     /*096*/    'E21INWBKB' = ' '
   ,     /*097*/    'E31INWBKB' = ' '
   ,     /*098*/    'E41INWBKB' = ' '
   ,     /*099*/    'E01INWCKN' = '0'
   ,     /*100*/    'E01INWFMT' = CASE WHEN sistema  = 'BCC' AND tipo_operacion = 'CSPOT'  AND cltipcli =  1 THEN 'MT202'
                                       WHEN sistema  = 'BCC' AND tipo_operacion = 'CSPOT'  AND cltipcli <> 1 THEN 'MT103'
                                       WHEN sistema  = 'BCC' AND tipo_operacion = 'ITF/MX' AND cltipcli =  1 THEN 'MT202'
                                       WHEN sistema  = 'BCC' AND tipo_operacion = 'ITF/MX' AND cltipcli <> 1 THEN 'MT103'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'ITF/MX' AND cltipcli =  1 THEN 'MT202'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'ITF/MX' AND cltipcli <> 1 THEN 'MT103'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'ICOL'   AND cltipcli =  1 THEN 'MT202'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'ICOL'   AND cltipcli <> 1 THEN 'MT103'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'VICAP'  AND cltipcli =  1 THEN 'MT202'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'VICAP'  AND cltipcli <> 1 THEN 'MT103'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'CDEF'   AND cltipcli =  1 THEN 'MT202'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'CDEF'   AND cltipcli <> 1 THEN 'MT103'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'CPAC'   AND cltipcli =  1 THEN 'MT202'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'CPAC'   AND cltipcli <> 1 THEN 'MT103'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'RECOMP' AND cltipcli =  1 THEN 'MT202'
                                       WHEN sistema  = 'BTR' AND tipo_operacion = 'RECOMP' AND cltipcli <> 1 THEN 'MT103'
                                       WHEN sistema  = 'BFW' AND tipo_operacion = 'VFUT'   AND cltipcli =  1 THEN 'MT202'
                                       WHEN sistema  = 'BFW' AND tipo_operacion = 'VFUT'   AND cltipcli <> 1 THEN 'MT103'
				       WHEN Sistema  = 'PCS' AND @iMonedaMx 	= 1   	   		     THEN 'MT202'
				       WHEN Sistema  = 'PCS' AND @iMonedaMx 	= 0   	   		     THEN 'MT202'
                                   END
   ,     /*101*/    'E01INWCOT' = '0'
   ,     /*102*/    'E01INWCOM' = '0.00'
   ,     /*103*/    'E01INWCOB' = ' '
   ,     /*104*/    'E01INWCOR' = '0'
   ,     /*105*/    'E01INWCOY' = ' '
   ,     /*106*/    'E01INWCOG' = '0'
   ,     /*107*/    'E01INWCOC' = '0'
   ,     /*108*/    'E01INWBCA' = '0.00'
   ,     /*109*/    'E01INWPVI' = CASE WHEN cltipcli   = 1 THEN '5' ELSE '3'  END
   ,     /*110*/    'E01INWDPT' = ' '
   ,     /*111*/    'E01INWSOU' = '01'
   ,     /*112*/    'E01INWDIB' = CASE WHEN @iMonedaMx = 1 THEN ''  ELSE '40' END--'10'
   ,     /*113*/    'E01INWDSQ' = ' '
   ,     /*114*/    'E01INWFL1' = ' '
   ,     /*115*/    'E01INWFL2' = ' '
   ,     /*116*/    'E01INWFL3' = ' '
   ,     /*117*/    'E01INWIDM' = CASE WHEN DATEPART(MONTH,fecha_vencimiento) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(MONTH,fecha_vencimiento))
                                       ELSE                                                   CONVERT(CHAR(2),DATEPART(MONTH,fecha_vencimiento))
                                  END
   ,     /*118*/    'E01INWIDD' = CASE WHEN DATEPART(DAY,fecha_vencimiento)   <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,fecha_vencimiento))
                                       ELSE                                                   CONVERT(CHAR(2),DATEPART(DAY,fecha_vencimiento))
                                  END
   ,     /*119*/    'E01INWIDY' = SUBSTRING(CONVERT(CHAR(4), DATEPART( YEAR , fecha_vencimiento ) ),3,2)
   ,     /*120*/    'E11INWRTR' = ' '
   ,     /*121*/    'E21INWRTR' = ' '
   ,     /*122*/    'E31INWRTR' = ' '
   ,     /*123*/    'E01INWBKO' = ' '
   ,     /*124*/    'E01INWITC' = ' '
   ,     /*125*/    'E01INWITA' = ' '
   ,     /*126*/    'E01INWTTC' = ' '
   ,     /*127*/    'E11INWTRD' = ' '
   ,     /*128*/    'E21INWTRD' = ' '
   ,     /*129*/    'E31INWTRD' = ' '
   ,     /*130*/    'E41INWTRD' = ' '
   ,     /*131*/    'E01INWTRI' = ' '
   ,     /*132*/    'E01INWSCC' = ' '
   ,     /*133*/    'E01INWSCA' = '0.00'
   ,     /*134*/    'E01INWRCC' = ' '
   ,     /*135*/    'E01INWRRA' = '0.00'
   ,     /*136*/    'E01INWBID' = CASE WHEN @iMonedaMx = 1 THEN '' ELSE LTRIM(RTRIM(CONVERT(CHAR(10),clrut))) + LTRIM(RTRIM(cldv)) END

   ,     /*137*/    'E01INWOID' = LTRIM(RTRIM(CONVERT(CHAR(10),@cRutBanco))) + @cDvBanco

   ,     /*138*/    'E01INWOCT' = CASE WHEN cltipcli = 1 THEN 'FINANCIERO' ELSE 'TERCERO' END
   ,     /*139*/    'E01INWBIS' = CONVERT(CHAR(2),clcodigo) -- CASE WHEN cltipcli = 6 THEN CONVERT(CHAR(2),clcodigo) ELSE ' ' END
   ,     /*140*/    'E01INWBAC' = CASE WHEN @iMonedaMx = 1 and cltipcli <> 1 THEN '' ELSE RecCtaCte END
   ,     /*141*/    'E01INWRBI' = ISNULL((SELECT LTRIM(RTRIM(CONVERT(CHAR(10),clrut))) + LTRIM(RTRIM(cldv)) FROM CLIENTE WHERE clrut = RecRutBanco and clcodigo = RecCodBanco),'') -- Nombre Bco Beneficiario
   ,     /*142*/    'E01INWACI' = 'P'
   ,     /*143*/    'E01INWDAT' = '2'
   ,     /*144*/    'E01INWCAT' = '2'
   ,     /*145*/    'E01INWCNL' = ISNULL(Codigo_Canal,0)
   ,     /*146*/    'E01INWPTY' = '0'
   ,     /*147 -- 101 n*/  'E01INWSST' = ' '
   ,     /*148 -- 117 n*/  'E01INWFL4' = '1'
   ,     /*149 -- 118 n*/  'E01INWFL5' = '0'
   ,     /*150 -- 119 n*/  'E01INWFL6' = '1'
   ,     /*151 -- 139 n*/  'E01INWOIS' = ' '

         -- Claves --  
   ,     /*152 -- 147 n*/  'E01PRUCR1' = isnull(CASE WHEN sistema = 'BTR' THEN (SELECT moclave_dcv FROM #Claves_DCV         WHERE monumoper = @NumOper AND mocorrela = 1)  ELSE ' ' END,' ')
   ,     /*153 -- 148 n*/  'E01PRUCR2' = isnull(CASE WHEN sistema = 'BTR' THEN (SELECT moclave_dcv FROM #Claves_DCV         WHERE monumoper = @NumOper and mocorrela = 2)  ELSE ' ' END,' ')
   ,     /*154 -- 149 n*/  'E01PRUCR3' = isnull(CASE WHEN sistema = 'BTR' THEN (SELECT moclave_dcv FROM #Claves_DCV         WHERE monumoper = @NumOper and mocorrela = 3)  ELSE ' ' END,' ')
   ,     /*155 -- 150 n*/  'E01PRUCR4' = isnull(CASE WHEN sistema = 'BTR' THEN (SELECT moclave_dcv FROM #Claves_DCV         WHERE monumoper = @NumOper and mocorrela = 4)  ELSE ' ' END,' ')
   ,     /*156 -- 151 n*/  'E01PRUCR5' = isnull(CASE WHEN sistema = 'BTR' THEN (SELECT moclave_dcv FROM #Claves_DCV         WHERE monumoper = @NumOper and mocorrela = 5)  ELSE ' ' END,' ')
   ,     /*157 -- 152 n*/  'E01PRUCR6' = isnull(CASE WHEN sistema = 'BTR' THEN (SELECT moclave_dcv FROM #Claves_DCV         WHERE monumoper = @NumOper and mocorrela = 6)  ELSE ' ' END,' ')
   ,     /*158 -- 153 n*/  'E01PRUCR7' = isnull(CASE WHEN sistema = 'BTR' THEN (SELECT moclave_dcv FROM #Claves_DCV         WHERE monumoper = @NumOper and mocorrela = 7)  ELSE ' ' END,' ')
   ,     /*159 -- 154 n*/  'E01PRUCR8' = isnull(CASE WHEN sistema = 'BTR' THEN (SELECT moclave_dcv FROM #Claves_DCV         WHERE monumoper = @NumOper and mocorrela = 8)  ELSE ' ' END,' ')
   ,     /*160 -- 155 n*/  'E01PRUCR9' = isnull(CASE WHEN sistema = 'BTR' THEN (SELECT moclave_dcv FROM #Claves_DCV         WHERE monumoper = @NumOper and mocorrela = 9)  ELSE ' ' END,' ')
   ,     /*161 -- 156 n*/  'E01PRUC10' = isnull(CASE WHEN sistema = 'BTR' THEN (SELECT moclave_dcv FROM #Claves_DCV         WHERE monumoper = @NumOper and mocorrela = 10) ELSE ' ' END,' ')
   ,     /*162*/    'E01INWPYM' = CASE WHEN DATEPART(MONTH,fecha_vencimiento) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(MONTH,fecha_vencimiento))
                                       ELSE                                                   CONVERT(CHAR(2),DATEPART(MONTH,fecha_vencimiento))
                                  END
   ,     /*163*/    'E01INWPYD' = CASE WHEN DATEPART(DAY,fecha_vencimiento)   <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,fecha_vencimiento))
                                       ELSE                                                   CONVERT(CHAR(2),DATEPART(DAY,fecha_vencimiento))
           END
   ,     /*164*/    'E01INWPYY' = SUBSTRING(CONVERT(CHAR(4), DATEPART(YEAR,fecha_vencimiento)),3,2)
   INTO    #TEMP_LBTR
   FROM    MDLBTR               
           INNER JOIN FORMA_DE_PAGO fpag ON MDLBTR.forma_pago = fpag.codigo
           INNER JOIN CLIENTE            ON rut_cliente       = clrut AND codigo_cliente = clcodigo
           INNER JOIN MONEDA             ON moneda            = mncodmon 
           INNER JOIN FPAGO_CANAL        ON Codigo_FormaPago  = forma_pago
   WHERE   sistema          = @Sistema  
   AND     numero_operacion = @NumOper
   AND     Tipo_Movimiento  = 'C'

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
