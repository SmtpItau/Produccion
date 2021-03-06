USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_MDLBTR_MX]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MNT_MDLBTR_MX]
   (   @iOperacion            NUMERIC(9)
   ,   @cSistema              CHAR(3)
   ,   @iSelCorresp           INTEGER     = 0
   ,   @CtaContale            VARCHAR(60) = ''
   ,   @BancoReceptor         VARCHAR(50) = ''
   ,   @SwiftReceptor         VARCHAR(50) = ''
   ,   @CtaContable           VARCHAR(50) = ''
   ,   @SwiftIntermediario    VARCHAR(50) = ''
   ,   @BcoIntermediario      VARCHAR(50) = ''
   ,   @CtaCte                VARCHAR(50) = ''
   ,   @SwiftBeneficiario     VARCHAR(50) = ''
   ,   @BcoBeneficiario       VARCHAR(50) = ''
   ,   @DirBeneficiario       VARCHAR(50) = ''
   ,   @CiuBeneficiario       VARCHAR(50) = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iSelCorresp = 4
   BEGIN

      IF EXISTS( SELECT 1 FROM MDLBTR_MX WHERE sistema = @cSistema AND operacion = @iOperacion )
      BEGIN
         DELETE MDLBTR_MX WHERE sistema = @cSistema AND operacion = @iOperacion
      END

      INSERT INTO MDLBTR_MX
      SELECT @cSistema
      ,      @iOperacion
      ,      SUBSTRING(@BancoReceptor, 1,50)
      ,      SUBSTRING(@SwiftReceptor, 1,50)
      ,      SUBSTRING(@CtaContable, 1,50)
      ,      SUBSTRING(@SwiftIntermediario, 1,50)
      ,      SUBSTRING(@BcoIntermediario, 1,50)
      ,      SUBSTRING(@CtaCte, 1,50)
      ,      SUBSTRING(@SwiftBeneficiario, 1,50)
      ,      SUBSTRING(@BcoBeneficiario, 1,50)
      ,      SUBSTRING(@DirBeneficiario, 1,50)
      ,      SUBSTRING(@CiuBeneficiario, 1,50)

      RETURN
   END

   DECLARE @iRutBanco     NUMERIC(9)
   ,       @iCodBanco     NUMERIC(9)

   DECLARE @iRutCliente   NUMERIC(9)
   ,       @iCodCliente   NUMERIC(9)
   ,       @iClTipCli     INTEGER

   SELECT  @iRutBanco     = 97023000
   ,       @iCodBanco     = 1

   SELECT DISTINCT 
           @iRutCliente     = rut_cliente
   ,       @iCodCliente     = codigo_cliente
   ,       @iClTipCli       = cltipcli
   FROM    MDLBTR
           LEFT JOIN CLIENTE ON clrut = rut_cliente AND clcodigo = codigo_cliente
   WHERE   sistema          = @cSistema
   AND     numero_operacion = @iOperacion
-- AND     moneda          <> 999

   IF @iSelCorresp = 0
   BEGIN

      SELECT BancoReceptor 
      ,      SwiftReceptor
      ,      CtaContable
      ,      SwiftIntermediario
      ,      BancoIntermediario
      ,      CtaCte
      ,      SwiftBeneficiario
      ,      BancoBeneficiario
      ,      DirBeneficiario
      ,      CiuBeneficiario
      ,      @iClTipCli   as Tipocliente
      FROM   MDLBTR_MX
      WHERE  sistema   = @cSistema 
      AND    operacion = @iOperacion

      RETURN
   END

   IF @iSelCorresp = 1
   BEGIN
      SELECT nombre           as BancoReceptor
      ,      codigo_swift     as SwiftReceptor
      ,      codigo_contable  as CtaContable
      FROM   CORRESPONSAL 
      WHERE  rut_cliente      = @iRutBanco
      and    codigo_cliente   = @iCodBanco
      and    cod_corresponsal > 0 
      and    codigo_contable  > 0
      AND   (codigo_contable  = @CtaContale OR @CtaContale = '')
      ORDER BY nombre

      RETURN 
   END

   IF @iSelCorresp = 2
   BEGIN
      SELECT Codigo_SWIFT         as SwiftIntermediario
      ,      Nombre_Corresponsal  as BancoIntermediario
      ,      Cuenta_Corresponsal  as CtaCorriente
      FROM   CLIENTE_CORRESPONSAL 
      WHERE  rut_cliente          = @iRutCliente
      and    codigo_cliente       = @iCodCliente
      ORDER BY BancoIntermediario

      RETURN 
   END

   IF @iSelCorresp = 3
   BEGIN
      SELECT SUBSTRING(Clswift,  1, 50) as SwiftBeneficiario
      ,      SUBSTRING(Clnombre, 1, 50) as BancoBeneficiario
      ,      SUBSTRING(Cldirecc, 1, 50) as DirreccionBeneficiario
      ,      SUBSTRING(nombre,   1, 50) as CiudadBeneficiario
      FROM   CLIENTE   
             LEFT JOIN CIUDAD on codigo_ciudad = Clciudad
      WHERE  clrut      = @iRutCliente
      and    clcodigo   = @iCodCliente

      RETURN 
   END

END
GO
