USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPRIME_SWIFT_LBTR]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_IMPRIME_SWIFT_LBTR]
   (   @sistema   CHAR(3)
   ,   @numero    NUMERIC(10)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iMoneda       INTEGER
   ,       @iMensaje      CHAR(6)

   DECLARE @Campo_20      VARCHAR(40)
   ,       @Campo_21      VARCHAR(40)
   ,       @Campo_23B     VARCHAR(40)
   ,       @Campo_32A_1   VARCHAR(40)
   ,       @Campo_32A_2   VARCHAR(40)
   ,       @Campo_32A_3   VARCHAR(40)
   ,       @Campo_50K_1   VARCHAR(40)
   ,       @Campo_50K_2   VARCHAR(40)
   ,       @Campo_50K_3   VARCHAR(40)
   ,       @Campo_57A_1   VARCHAR(40)
   ,       @Campo_57A_2   VARCHAR(40)
   ,       @Campo_58D_1   VARCHAR(40)
   ,       @Campo_58D_2   VARCHAR(40)
   ,       @Campo_58D_3   VARCHAR(40)
   ,       @Campo_59_1    VARCHAR(40)
   ,       @Campo_59_2    VARCHAR(40)
   ,       @Campo_59_3    VARCHAR(40)
   ,       @Campo_59_4    VARCHAR(40)
   ,       @Campo_70_1    VARCHAR(40)
   ,       @Campo_71A_1   VARCHAR(40)
   ,       @Campo_72_1    VARCHAR(40)

   ,       @Bco           VARCHAR(40)
   ,       @Emisor        VARCHAR(40)
   ,       @Destinatario  VARCHAR(40)
   ,       @Swift         VARCHAR(40)
   ,       @Fecha         VARCHAR(40)

   SELECT @iMoneda           = moneda
   ,      @iMensaje          = CASE WHEN cltipcli = 1 THEN 'MT 202' ELSE 'MT 103' END
   FROM   MDLBTR b
          LEFT JOIN CLIENTE ON b.rut_cliente = clrut AND b.codigo_cliente = clcodigo
   WHERE  b.numero_operacion = @numero
   AND    b.sistema          = @sistema
   AND    b.Tipo_Movimiento  = 'C'

   IF @iMoneda = 999
   BEGIN
      SELECT 'Banco_emisor'    = 'CORPBANCA'
      ,      'codswift_emi'    = ISNULL((select DISTINCT codigo_swift from corresponsal where rut_cliente=rcrut and codigo_moneda=999),'')
      ,      'Banco_receptor'  = (select DISTINCT clnombre from cliente where clrut=b.rut_cliente and clcodigo=codigo_cliente)
      ,      'codswift_recep'  = ISNULL((select DISTINCT codigo_swift from corresponsal where rut_cliente=b.rut_cliente and codigo_moneda=999),'')
      ,      'ref_transaccion' = tipo_operacion+ ' ' +CONVERT(CHAR(10),b.numero_operacion)
      ,      'fecha_vcto'      = SUBSTRING(CONVERT(CHAR(10),b.fecha_vencimiento,112),3,2)+ '/'+SUBSTRING(CONVERT(CHAR(10),b.fecha_vencimiento,112),5,2)+'/'+SUBSTRING(CONVERT(CHAR(10),b.fecha_vencimiento,112),7,2)
      ,      'moneda'          = (select DISTINCT mnnemo from moneda where mncodmon=999)
      ,      b.monto_operacion
      ,      'referencia'      = 'NONREF'
      ,      'Seccion'         = 'OP.FINANCIERAS'
      ,      b.fecha      
      ,      'fono'            = rctelefono
      ,      'fax'             = rcfax
      FROM  MDLBTR b
      ,     entidad
      WHERE b.numero_operacion = @numero
      AND   b.sistema          = @sistema
      AND   b.Tipo_Movimiento  = 'C'
   END ELSE
   BEGIN

      SELECT  @Campo_20      = CASE WHEN @sistema = 'BCC' THEN 'VSPOT '                      + CONVERT(CHAR(10),numero_operacion)
                                    WHEN @sistema = 'BTR' THEN CONVERT(CHAR(6),tipo_mercado) + CONVERT(CHAR(10),numero_operacion)
                               END
      ,       @Campo_21      = 'NONREF'--CONVERT(CHAR(10),numero_operacion)
      ,       @Campo_23B     = 'CRED'
--    ,       @Campo_32A_1   = CONVERT(CHAR(10),fecha_vencimiento,112)

      ,       @Campo_32A_1   = convert(char(4),year(fecha_vencimiento))
                             + '/' + case when len(month(fecha_vencimiento)) = 1 then '0' + convert(char(1),month(fecha_vencimiento))
                                          else                                              convert(char(2),month(fecha_vencimiento))
                                     end
                             + '/' + case when len(day(fecha_vencimiento))   = 1 then '0' + convert(char(1),day(fecha_vencimiento))
                                          else                                              convert(char(2),day(fecha_vencimiento))
                                     end
      ,       @Campo_32A_2   = mnnemo
      ,       @Campo_32A_3   = monto_operacion
      ,       @Campo_50K_1   = mi.Clswift   --'CONBCLRM'--CONVERT(VARCHAR(10),rcrut) + '-' + rcdv
      ,       @Campo_50K_2   = rcnombre
      ,       @Campo_50K_3   = mi.cldirecc
      ,       @Campo_57A_1   = SwiftIntermediario
      ,       @Campo_57A_2   = BancoIntermediario
      ,       @Campo_58D_1   = CtaCte
      ,       @Campo_58D_2   = SwiftBeneficiario
      ,       @Campo_58D_3   = BancoBeneficiario
      ,       @Campo_59_1    = CONVERT(VARCHAR(10),cl.clrut) + '-' + cl.cldv
      ,       @Campo_59_2    = CtaCte
      ,       @Campo_59_3    = BancoBeneficiario
      ,       @Campo_59_4    = LTRIM(RTRIM(DirBeneficiario)) + ',' + CiuBeneficiario
      ,       @Campo_70_1    = CASE WHEN @sistema = 'BCC' THEN '/RFB/ VTAS DOLARES' -- 'TRANSACCION MONEDA Mx'
                                    WHEN @sistema = 'BTR' THEN 'INTERBANCARIO     '
                               END
      ,       @Campo_71A_1   = 'OUR'
      ,       @Campo_72_1    = ''
      ,       @Bco           = mi.clnombre
      ,       @Emisor        = mi.clswift
      ,       @Destinatario  = BancoReceptor
      ,       @Swift         = SwiftReceptor
      FROM   MDLBTR b
             LEFT JOIN CLIENTE   cl     ON b.rut_cliente  = cl.clrut  AND b.codigo_cliente = cl.clcodigo
             LEFT JOIN MDLBTR_MX mx     ON mx.sistema     = b.sistema AND mx.Operacion     = b.numero_operacion
             LEFT JOIN MONEDA    mo     ON mo.mncodmon    = moneda
      ,      ENTIDAD
             LEFT JOIN CLIENTE   mi     ON rcrut          = mi.clrut  AND rccodcar         = mi.clcodigo
      WHERE  b.numero_operacion = @numero
      AND    b.sistema          = @sistema
      AND    b.Tipo_Movimiento  = 'C'

      CREATE TABLE #Mensaje
      (   Mensaje    VARCHAR(10)
      ,   Orden      INTEGER
      ,   Campo      CHAR(5)
      ,   Contenido  VARCHAR(40)
      )
      
         INSERT INTO #Mensaje SELECT @iMensaje , 1  , '20'   , @Campo_20
         INSERT INTO #Mensaje SELECT @iMensaje , 2  , '21'   , @Campo_21
         INSERT INTO #Mensaje SELECT @iMensaje , 3  , '23 B' , @Campo_23B
         INSERT INTO #Mensaje SELECT @iMensaje , 4  , '32 A' , @Campo_32A_1
         INSERT INTO #Mensaje SELECT @iMensaje , 5  , ' '    , @Campo_32A_2
         INSERT INTO #Mensaje SELECT @iMensaje , 6  , ' '    , @Campo_32A_3
         INSERT INTO #Mensaje SELECT @iMensaje , 7  , '50 A' , @Campo_50K_1
         INSERT INTO #Mensaje SELECT @iMensaje , 8  , ' '    , @Campo_50K_2
         INSERT INTO #Mensaje SELECT @iMensaje , 9  , ' '    , @Campo_50K_3
         INSERT INTO #Mensaje SELECT @iMensaje , 10 , '57 A' , @Campo_57A_1
         INSERT INTO #Mensaje SELECT @iMensaje , 11 , ' '    , @Campo_57A_2

         INSERT INTO #Mensaje SELECT @iMensaje , 12 , '58 A' , @Campo_58D_1
         INSERT INTO #Mensaje SELECT @iMensaje , 13 , ' '    , @Campo_58D_2
         INSERT INTO #Mensaje SELECT @iMensaje , 14 , ' '    , @Campo_58D_3

         INSERT INTO #Mensaje SELECT @iMensaje , 15 , '59'   , @Campo_59_1
         INSERT INTO #Mensaje SELECT @iMensaje , 16 , '59'   , @Campo_59_2
         INSERT INTO #Mensaje SELECT @iMensaje , 17 , ' '    , @Campo_59_3
         INSERT INTO #Mensaje SELECT @iMensaje , 18 , ' '    , @Campo_59_4
         INSERT INTO #Mensaje SELECT @iMensaje , 19 , '70'   , @Campo_70_1
         INSERT INTO #Mensaje SELECT @iMensaje , 20 , '71A'   , @Campo_71A_1
         INSERT INTO #Mensaje SELECT @iMensaje , 21 , '72'   , @Campo_72_1

         IF @iMensaje = 'MT 202'
            DELETE #Mensaje WHERE Orden IN(3,7,8,9,15,16,17,18,19,20,21)
         ELSE
            DELETE #Mensaje WHERE Orden IN(2,12,13,14,15,21)

         SELECT *
         ,      @Bco                            as BcoEmisor
         ,      @Emisor                         as SwiftEmisor
         ,      @Destinatario                   as BcoDestinatario
         ,      @Swift                          as SwiftDestinatario
         ,      convert(char(10),Getdate(),103) as FechaEmision
         ,      convert(char(10),Getdate(),108) as HoraEmision
         FROM   #Mensaje

   END

END
GO
