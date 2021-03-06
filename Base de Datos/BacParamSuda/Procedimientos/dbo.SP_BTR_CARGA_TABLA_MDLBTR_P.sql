USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BTR_CARGA_TABLA_MDLBTR_P]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- sp_helptext SP_BTR_CARGA_TABLA_MDLBTRText                                                                                                                                                                                                                                                            
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
CREATE PROCEDURE [dbo].[SP_BTR_CARGA_TABLA_MDLBTR_P]
AS 
BEGIN
	
   SET NOCOUNT ON

   DECLARE @fc_proceso  DATETIME
       SET @fc_proceso  = (SELECT acfecproc FROM BacTraderSuda.dbo.MDAC with (nolock))

   /* ** Crea tablas Temporales para los Movimientos ** */
   CREATE TABLE #TEMP_MDLBTR
   (   fecha                DATETIME       NOT NULL
   ,   sistema              CHAR(03)       NOT NULL
   ,   tipo_mercado         CHAR(12)       NOT NULL
   ,   tipo_operacion       CHAR(06)       NOT NULL
   ,   estado_envio         CHAR(01)       NOT NULL
   ,   numero_operacion     NUMERIC(9,0)   NOT NULL
   ,   rut_cliente          NUMERIC(9,0)   NOT NULL
   ,   codigo_cliente       NUMERIC(9,0)   NOT NULL
   ,   moneda               NUMERIC(5,0)   NOT NULL
   ,   monto_operacion      NUMERIC(21,4)  NOT NULL
   ,   forma_pago           NUMERIC(5,0)   NOT NULL
   ,   fecha_operacion	    DATETIME	   NOT NULL
   ,   fecha_vencimiento    DATETIME	   NOT NULL
   ,   liquidada            CHAR(01) 	   NOT NULL
   ,   Tipo_Movimiento      CHAr(01)	   NOT NULL
   ,   Anticipo             Char(150)      NOT NULL DEFAULT('')
   )

   CREATE INDEX #ixt_TEMP_MDLBTR ON #TEMP_MDLBTR (fecha, sistema, tipo_operacion, numero_operacion, tipo_Movimiento, tipo_mercado)
   CREATE INDEX #ixw_TEMP_MDLBTR ON #TEMP_MDLBTR (forma_pago)

   CREATE TABLE #TMPBTR
   (   fecha                DATETIME       NOT NULL
   ,   tipo_mercado         CHAR(12)       NOT NULL
   ,   tipo_operacion       CHAR(06)       NOT NULL
   ,   numero_operacion     NUMERIC(9,0)   NOT NULL
   ,   rut_cliente          NUMERIC(9,0)   NOT NULL
   ,   codigo_cliente       NUMERIC(9,0)   NOT NULL
   ,   forma_pago           NUMERIC(5,0)   NOT NULL
   ,   moneda2              NUMERIC(5,0)   NOT NULL
   ,   moneda3              NUMERIC(5,0)   NOT NULL
   ,   monto_operacion      NUMERIC(21,4)  NOT NULL
   ,   fecha_operacion	    DATETIME	   NOT NULL
   ,   fecha_vencimiento    DATETIME	   NOT NULL
   ,   liquidada            CHAR(01) 	   NOT NULL
   ,   Tipo_Movimiento      CHAr(01)	   NOT NULL
   ,   Anticipo             Char(150)      NOT NULL DEFAULT('')
   )

   CREATE INDEX #ixt_TMPBTR_NumOpe ON #TMPBTR (numero_operacion)

   -- **** Spot **** --
   -- Genera los Cargos en Moneda Extranjera Para el Motor de Pago --
   INSERT INTO #TEMP_MDLBTR
   SELECT mofech
   ,      'BCC'
   ,      motipmer
   ,      'motipope' = CASE WHEN motipope = 'V' THEN 'ITF/MX' END
   ,      'P'
   ,      monumope
   ,      morutcli
   ,      mocodcli
   ,      mncodmon
   ,      momonmo
   ,      moentre
   ,      mofech
   ,      mofech
   ,      ' '
   ,      'C'
   ,      ' '
   FROM	  BacCamSuda.dbo.MEMO  --(Index = ix_MEMO_Operacion) 
          LEFT JOIN BacParamSuda.dbo.MONEDA with (nolock)  ON mocodmon = mnnemo
   WHERE  mofech      = @fc_proceso
   AND    motipmer    IN('PTAS','EMPR')
   AND    motipope    = 'V'
   AND    mocodmon    = 'USD'
   AND    mocodcnv    = 'CLP'
   AND    moestatus  <> 'P'
   AND    moentre    IN( SELECT DISTINCT Codigo_FormaPago FROM BacParamSuda.dbo.FPAGO_CANAL with (nolock) )
   -->    ORDER BY mofech, motipmer, motipope, mocodmon, mocodcnv, moentre, moestatus
   -- Genera los Cargos en Moneda Extranjera Para el Motor de Pago --
   -- **** Spot **** --

   /* ** Traspasa operaciones para generar operaciones LBTR ** */
   --  se ingresan a tablas temporal para pasar luego a MDLBTR
   INSERT INTO #TEMP_MDLBTR
   SELECT fecha
   ,      'BTR'
   ,      tipo_mercado
   ,      tipo_operacion
   ,      'P'
   ,      numero_operacion
   ,      rut_cliente
   ,      codigo_cliente  
   ,      CASE WHEN tipo_operacion IN('CI','VI') THEN moneda2
	       ELSE                                   moneda3
          END
   ,      monto_operacion
   ,      forma_pago
   ,      fecha_operacion
   ,      fecha_vencimiento
   ,      liquidada --' '
   ,      tipo_Movimiento
   ,      Anticipo
   FROM	  #TMPBTR

   --   Calcula fecha de Vencimiento   --
   SELECT 'fecha'            = fecha
   ,      'sistema'          = sistema
   ,      'tipo_mercado'     = tipo_mercado
   ,      'tipo_operacion'   = tipo_operacion
   ,      'estado_envio'     = estado_envio
   ,      'numero_operacion' = numero_operacion
   ,      'rut_cliente'      = rut_cliente
   ,      'codigo_cliente'   = codigo_cliente
   ,      'moneda'           = moneda
   ,      'monto_operacion'  = monto_operacion
   ,      'forma_pago'       = forma_pago
   ,      'fecha_operacion'  = fecha_operacion
   ,      'fecha_vencimiento'= fecha_vencimiento
   ,      'liquidada'        = liquidada
   ,      'Tipo_Movimiento'  = Tipo_Movimiento
   ,      'Anticipo'         = Anticipo
   ,      'iDiasValor_i'     = diasvalor
   ,      'iMoneda_i'        = Moneda
   ,      'Correlativo'      = identity(INT)
   INTO   #TEMPORAL_LBTR
   FROM   #TEMP_MDLBTR
          LEFT JOIN BacParamSuda.dbo.FORMA_DE_PAGO with (nolock) ON forma_pago = codigo

   CREATE INDEX #ixt_TEMPORAL_LBTR ON #TEMPORAL_LBTR (Correlativo)

   DECLARE @iRegistros  NUMERIC(9)
   ,       @iRegistro   NUMERIC(9)
   ,       @iMoneda     NUMERIC(5)
   ,       @dFechaVcto  DATETIME
   ,       @iDiasVal    INTEGER
   
   SELECT  @iRegistros  = MAX(Correlativo)
   ,       @iRegistro   = MIN(Correlativo)
   FROM    #TEMPORAL_LBTR

   WHILE @iRegistros >= @iRegistro
   BEGIN

      SELECT @iDiasVal   = iDiasValor_i --> diasvalor
      ,      @iMoneda    = iMoneda_i    --> Moneda 
      FROM   #TEMPORAL_LBTR 
         --> LEFT JOIN bacparamsuda.dbo.FORMA_DE_PAGO ON forma_pago = codigo
      WHERE  Correlativo = @iRegistro
      
      IF @iMoneda = 13 
      BEGIN
         EXECUTE BacCamSuda.dbo.SP_BUSCA_FECHA_HABIL @fc_proceso, @iDiasVal, 225, @dFechaVcto OUTPUT      
      END ELSE 
      BEGIN
         EXECUTE BacTraderSuda.dbo.SP_BUSCA_FECHA_HABIL @fc_proceso , @iDiasVal , @dFechaVcto OUTPUT
      END

      UPDATE #TEMPORAL_LBTR
      SET    fecha_vencimiento = @dFechaVcto
      WHERE  Correlativo       = @iRegistro

      SET @iRegistro = @iRegistro + 1
   END

   DELETE #TEMP_MDLBTR

   INSERT INTO #TEMP_MDLBTR
   SELECT fecha
   ,      sistema
   ,      tipo_mercado
   ,      tipo_operacion
   ,      estado_envio
   ,      numero_operacion
   ,      rut_cliente
   ,      codigo_cliente
   ,      moneda
   ,      monto_operacion
   ,      forma_pago
   ,      fecha_operacion
   ,      fecha_vencimiento
   ,      liquidada
   ,      tipo_Movimiento 
   ,      Anticipo
   FROM   #TEMPORAL_LBTR
   --   Calcula fecha de Vencimiento   --

   DELETE #TEMP_MDLBTR
   FROM	  #TEMP_MDLBTR       a
   ,      MDLBTR             b 
   WHERE  a.fecha	     = b.fecha 
   AND    a.sistema          = b.sistema 
   AND    a.tipo_operacion   = b.tipo_operacion
   AND    a.numero_operacion = b.numero_operacion
   AND    a.tipo_Movimiento  = b.tipo_Movimiento
   AND    b.tipo_mercado    <> 10  

   --> forward bond trades
   DELETE MDLBTR
   FROM	  #TEMP_MDLBTR       a
   ,      MDLBTR             b
   WHERE  a.fecha	     = a.fecha
   AND    a.sistema	     = b.sistema
   AND    a.tipo_operacion   = b.tipo_operacion
   AND    a.numero_operacion = b.numero_operacion
   AND    b.tipo_mercado     = 10
   AND    b.estado_envio     = 'P'

   DELETE #TEMP_MDLBTR
   FROM	  #TEMP_MDLBTR       a
   ,      MDLBTR             b
   WHERE  a.fecha	     = a.fecha
   AND    a.sistema	     = b.sistema
   AND    a.tipo_operacion   = b.tipo_operacion
   AND    a.numero_operacion = b.numero_operacion
   AND    b.tipo_mercado     = 10
   AND    b.estado_envio     IN('E','A')
   --> forward bond trades

   UPDATE MDLBTR 
   SET    estado_envio      = 'A'
   FROM	  MDLBTR              as a
   ,      BacTraderSuda.dbo.MDMO as b
   WHERE  b.monumoper       = a.numero_operacion 
   AND    b.mostatreg       = 'A' 

   UPDATE MDLBTR 
   SET    estado_envio      = 'A'
   FROM	  MDLBTR              as a
   ,      BacCamSuda.dbo.MEMO    as b
   WHERE  b.monumope        = a.numero_operacion 
   AND    b.moestatus       = 'A' 

   UPDATE MDLBTR 
   SET    estado_envio      = 'A'
   FROM	  MDLBTR              as a
   ,      BacFwdSuda.dbo.MFMO    as b
   WHERE  b.monumoper       = a.numero_operacion 
   AND    b.moestado        = 'A' 

   /* ** Traspasa operaciones para generar operaciones LBTR ** */   
   INSERT INTO MDLBTR
   SELECT 'fecha'             = fecha
   ,      'sistema'           = sistema
   ,      'tipo_mercado'    = tipo_mercado
   ,      'tipo_operacion'    = tipo_operacion
   ,      'estado_envio'      = estado_envio
   ,      'numero_operacion'  = numero_operacion
   ,      'rut_cliente'       = rut_cliente
   ,      'codigo_cliente'    = codigo_cliente
   ,      'moneda'            = moneda
   ,      'monto_operacion'   = monto_operacion
   ,      'forma_pago'        = forma_pago
   ,      'fecha_operacion'   = fecha_operacion
   ,      'fecha_vencimiento' = fecha_vencimiento
   ,      'liquidada'         = liquidada
   ,      'RecRutBanco'       = CASE WHEN cltipcli = 1 THEN clrut           ELSE ISNULL(RutBancoReceptor,0) END
   ,      'RecCodBanco'       = CASE WHEN cltipcli = 1 THEN clcodigo        ELSE ISNULL(CodBancoReceptor,0) END
   ,      'RecCodSwift'       = CASE WHEN cltipcli = 1 THEN UPPER(clswift)  ELSE ' '                        END
   ,      'BenDireccion'      = UPPER(cldirecc)
   ,      'BenCtaCte'	      = CASE WHEN clctacte      = 0 THEN ' ' 
                                     WHEN LEN(clctacte) = 0 THEN ' '
                                     ELSE                        UPPER(clctacte)
                                END 
   ,      'tipo_Movimiento'   = tipo_Movimiento
   ,      'Anticipo'          = Anticipo
   ,      'Id_Paquete'        = 0
   ,      'Estado_Paquete'    = 'D'
   ,      'Reservado'         = ''
   FROM   #TEMP_MDLBTR
          INNER JOIN BacParamSuda.dbo.CLIENTE with (nolock) ON clrut = rut_cliente AND clcodigo = codigo_cliente
   ORDER BY sistema, numero_operacion


    UPDATE A
       SET RecCodSwift  = SUBSTRING(clswift, 1, 50)
      FROM MDLBTR A 
           INNER JOIN CLIENTE ON clrut = RecRutBanco and clcodigo = RecCodBanco
     WHERE Fecha = @fc_proceso


   --   Completa Swift de Moneda Mx   --
   DECLARE @iContadorMx           INTEGER
   ,       @iRegistrosMx          INTEGER
   ,       @iOperacion            NUMERIC(9)
   ,       @cSistema              CHAR(3)
   ,       @CtaContale            VARCHAR(60)

   DECLARE @BancoReceptor         VARCHAR(50)
   ,       @SwiftReceptor         VARCHAR(50)
   ,       @CtaContable           VARCHAR(50)
   ,       @SwiftIntermediario    VARCHAR(50)
   ,       @BcoIntermediario      VARCHAR(50)
   ,       @CtaCte                VARCHAR(50)
   ,       @SwiftBeneficiario     VARCHAR(50)
   ,       @BcoBeneficiario       VARCHAR(50)
   ,       @DirBeneficiario       VARCHAR(50)
   ,       @CiuBeneficiario       VARCHAR(50)


   DELETE
   FROM    MDLBTR
   WHERE   fecha    = @fc_proceso
   AND    (sistema <> 'BCC' AND moneda <> 999)

   CREATE TABLE #Temporal_MtMx
   (   Columna1   VARCHAR(50)
   ,   Columna2   VARCHAR(50)
   ,   Columna3   VARCHAR(50)
   ,   Columna4   VARCHAR(50)
   )

   DELETE 
   FROM   MDLBTR_MX
   WHERE  BancoReceptor      = ''
   AND    SwiftReceptor      = ''
   AND    CtaContable        = ''
   AND    SwiftIntermediario = ''
   AND    BancoIntermediario = ''
   AND    CtaCte             = ''
   AND    BancoBeneficiario  = ''

   SELECT Sistema
   ,      numero_operacion
   ,      CtaContable      = CASE WHEN morutcli = 96665450 THEN 745 ELSE anula_motivo END
   ,      identity(int)    as Identificador
   INTO   #TmpSwiftMx
   FROM   MDLBTR                     with (nolock)
          LEFT JOIN BacCamSuda.dbo.MEMO with (nolock) ON monumope = numero_operacion
   WHERE  moneda           <> 999
   and    fecha             = @fc_proceso
   and    Sistema           = 'BCC'

   INSERT INTO #TmpSwiftMx
   SELECT Sistema
   ,      numero_operacion
   ,      CtaContable       = 745   --> Defecto Wachovia
   FROM   MDLBTR                        with (nolock)
          LEFT JOIN BacTraderSuda.dbo.MDMO with (nolock) ON monumopeR = numero_operacion
   WHERE  moneda           <> 999
   and    fecha    = @fc_proceso
   and   Sistema           = 'BTR'

      SET @iContadorMx  = 0
      SET @iRegistrosMx = 0

   SELECT @iRegistrosMx = MAX(Identificador)
   ,      @iContadorMx  = 1
  FROM   #TmpSwiftMx

   WHILE @iRegistrosMx >= @iContadorMx
   BEGIN

      SELECT @iOperacion   = numero_operacion
      ,      @cSistema     = Sistema
      ,      @CtaContale   = CtaContable
      FROM   #TMPSWIFTMX
      WHERE  Identificador = @iContadorMx

      IF NOT EXISTS( SELECT 1 FROM MDLBTR_MX with (nolock) WHERE Sistema = @cSistema AND Operacion = @iOperacion )
      BEGIN
         IF @cSistema = 'BCC'
         BEGIN
            
            EXECUTE BacCamSuda.dbo.SP_CARGA_MOVIMIENTO_SWIFT_MOTORPAGOS 
                                        @iOperacion
                              ,         @BancoReceptor          OUTPUT
                              ,         @SwiftReceptor          OUTPUT
                              ,         @CtaContable            OUTPUT
                              ,         @SwiftIntermediario     OUTPUT
                              ,         @BcoIntermediario       OUTPUT
                              ,         @CtaCte                 OUTPUT
                              ,         @SwiftBeneficiario      OUTPUT
                              ,         @BcoBeneficiario        OUTPUT
                              ,         @DirBeneficiario        OUTPUT
                              ,         @CiuBeneficiario        OUTPUT

            IF ( LTRIM(RTRIM(@BancoReceptor))      <> ''
             OR  LTRIM(RTRIM(@SwiftReceptor))      <> ''
             OR  LTRIM(RTRIM(@CtaContable))        <> ''
             OR  LTRIM(RTRIM(@SwiftIntermediario)) <> ''
             OR  LTRIM(RTRIM(@BcoIntermediario))   <> ''
             OR  LTRIM(RTRIM(@BcoBeneficiario))    <> ''
               )
            BEGIN
               IF EXISTS(SELECT 1 FROM BacParamSuda.dbo.CORRESPONSAL with (nolock) WHERE codigo_swift = @SwiftReceptor)
               BEGIN
                  SET @BancoReceptor = ( SELECT TOP 1 nombre FROM BacParamSuda.dbo.CORRESPONSAL with (nolock) WHERE codigo_swift = @SwiftReceptor ) --> 'CITIUS33'
               END

               INSERT INTO MDLBTR_MX
               SELECT @cSistema
               ,      @iOperacion
               ,      @BancoReceptor
               ,      @SwiftReceptor
               ,      @CtaContable
               ,      ISNULL(@SwiftIntermediario,'')
               ,      ISNULL(@BcoIntermediario,'')
               ,      ISNULL(@CtaCte,'')
               ,      ISNULL(@SwiftBeneficiario,'')
               ,      ISNULL(@BcoBeneficiario,'')
               ,      ISNULL(@DirBeneficiario,'')
               ,      ISNULL(@CiuBeneficiario,'')

            END
         END

         IF NOT EXISTS( SELECT 1 FROM MDLBTR_MX with (nolock) WHERE Sistema = @cSistema AND Operacion = @iOperacion )
         BEGIN
            SET ROWCOUNT 1

            INSERT INTO #Temporal_MtMx ( Columna1 , Columna2 , Columna3 )
            EXECUTE SP_MNT_MDLBTR_MX @iOperacion , @cSistema , 1 , @CtaContale

            SELECT @BancoReceptor = Columna1
            ,      @SwiftReceptor = Columna2
            ,      @CtaContable   = Columna3
            FROM   #Temporal_MtMx
            
            DELETE #Temporal_MtMx
   
            INSERT INTO #Temporal_MtMx ( Columna1 , Columna2 , Columna3 )
            EXECUTE SP_MNT_MDLBTR_MX @iOperacion , @cSistema , 2 , @CtaContale

            SELECT @SwiftIntermediario = Columna1
            ,      @BcoIntermediario   = Columna2
            ,      @CtaCte             = Columna3
            FROM   #Temporal_MtMx            

            DELETE #Temporal_MtMx

            INSERT INTO #Temporal_MtMx ( Columna1 , Columna2 , Columna3 , Columna4 ) 
            EXECUTE SP_MNT_MDLBTR_MX @iOperacion , @cSistema , 3 , @CtaContale

            SELECT @SwiftBeneficiario = Columna1
            ,      @BcoBeneficiario   = Columna2
            ,      @DirBeneficiario   = Columna3
            ,      @CiuBeneficiario   = Columna4
            FROM   #Temporal_MtMx

            DELETE FROM #Temporal_MtMx

            SET ROWCOUNT 0

            INSERT INTO MDLBTR_MX
            SELECT @cSistema
            ,      @iOperacion
            ,      @BancoReceptor
            ,      @SwiftReceptor
            ,      @CtaContable
            ,      @SwiftIntermediario
            ,      @BcoIntermediario
            ,      ISNULL(@CtaCte,'')
            ,      ISNULL(@SwiftBeneficiario,'')
            ,      ISNULL(@BcoBeneficiario,'')
            ,      ISNULL(@DirBeneficiario,'')
            ,      ISNULL(@CiuBeneficiario,'')
         END

      END

      SET @iContadorMx = @iContadorMx + 1
   END
   --   Completa Swift de Moneda Mx   --

   DROP TABLE #Temporal_MtMx

   DELETE FROM MDLBTR_MX
         WHERE BancoReceptor      = ''
           AND SwiftReceptor      = ''
           AND CtaContable        = ''
           AND SwiftIntermediario = ''
           AND BancoIntermediario = ''
           AND CtaCte             = ''
           AND BancoBeneficiario  = ''

END
GO
