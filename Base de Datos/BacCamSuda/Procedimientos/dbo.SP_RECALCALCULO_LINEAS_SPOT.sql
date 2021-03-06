USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RECALCALCULO_LINEAS_SPOT]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_RECALCALCULO_LINEAS_SPOT]  
   (   @nRutCliente   NUMERIC(10)   )  
AS   
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @ncont      INTEGER  
   DECLARE @Posicion1  CHAR(5)  
   DECLARE @Numoper    NUMERIC(10)  
   DECLARE @rut        NUMERIC(9)  
   DECLARE @CodCli     NUMERIC(9)  
   DECLARE @MtoMda1    NUMERIC(21,04)  
   DECLARE @fecvcto    CHAR(8)  
   DECLARE @MercadoLc  CHAR(1)  
   DECLARE @moneda     NUMERIC(5)  
   DECLARE @nregs      INTEGER  
   DECLARE @producto   CHAR(5)  
   DECLARE @Operador   CHAR(10)  
  
   DECLARE @fechini    CHAR(8)  
       SET @fechini    = (SELECT CONVERT(CHAR(8), acfecpro ,112) FROM MEAC with(nolock) )  
  
   SELECT  m.MOENTIDAD  
   ,    m.MOTIPMER  
   ,    m.MONUMOPE  
   ,    m.MOTIPOPE  
   ,    m.MORUTCLI  
   ,    m.MOCODCLI  
   ,    m.MONOMCLI  
   ,    m.MOCODMON  
   ,    m.MOCODCNV  
   ,    m.MOMONMO  
   ,    m.MOTICAM  
   ,    m.MOTCTRA  
   ,    m.MOPRECIO  
   ,    m.MOPRETRA  
   ,    m.MOPREFI  
   ,    m.MOUSSME  
   ,    m.MOUSS30  
   ,    m.MOUSSTR  
   ,    m.MOUSSFI  
   ,    m.MOMONPE  
   ,    m.MOENTRE  
   ,    m.MORECIB  
   ,    m.MOVALUTA1  
   ,    m.MOVALUTA2  
   ,    m.MOOPER  
   ,    m.MOFECH  
   ,    m.MOESTATUS  
   ,    m.MOFECINI  
   ,    m.mofecvcto  
   INTO    #tmp_car   
   FROM    MEMO  m with(nolock)  
   ,       MEAC  a with(nolock)  
   WHERE   m.motipope    = 'C'  
   AND     m.moestatus  <> 'A'  
   AND     m.morutcli    = @nRutCliente  
  
  
   INSERT INTO #TMP_CAR   
   SELECT  m.MOENTIDAD  
   ,    m.MOTIPMER  
   ,    m.MONUMOPE  
   ,    m.MOTIPOPE  
   ,    m.MORUTCLI  
   ,    m.MOCODCLI  
   ,    m.MONOMCLI  
   ,    m.MOCODMON  
   ,    m.MOCODCNV  
   ,    m.MOMONMO  
   ,    m.MOTICAM  
   ,    m.MOTCTRA  
   ,    m.MOPRECIO  
   ,    m.MOPRETRA  
   ,    m.MOPREFI  
   ,    m.MOUSSME  
   ,    m.MOUSS30  
   ,    m.MOUSSTR  
   ,    m.MOUSSFI  
   ,    m.MOMONPE  
   ,    m.MOENTRE  
   ,    m.MORECIB  
   ,    m.MOVALUTA1  
   ,    m.MOVALUTA2  
   ,    m.MOOPER  
   ,    m.MOFECH  
   ,    m.MOESTATUS  
   ,    m.MOFECINI  
   ,    m.mofecvcto  
   FROM    MEMO  m with(nolock)  
        ,  MEAC  a with(nolock)  
   WHERE   m.motipope   = 'V'   
   and     m.movaluta2 <> movaluta1   
   and     m.movaluta2  > movaluta1  
   and     m.moestatus <> 'A'  
   and     m.morutcli   = @nRutCliente  
  
   INSERT INTO #TMP_CAR   
   SELECT  movi.moentidad  
   ,    movi.motipmer  
   ,    movi.monumope  
   ,    movi.motipope  
   ,    movi.morutcli  
   ,    movi.mocodcli  
   ,    movi.monomcli  
   ,    movi.mocodmon  
   ,    movi.mocodcnv  
   ,    movi.momonmo  
   ,    movi.moticam  
   ,    movi.motctra  
   ,    movi.moprecio  
   ,    movi.mopretra  
   ,    movi.moprefi  
   ,    movi.moussme  
   ,    movi.mouss30  
   ,    movi.mousstr  
   ,    movi.moussfi  
   ,    movi.momonpe  
   ,    movi.moentre  
   ,    movi.morecib  
   ,    movi.movaluta1  
   ,    movi.movaluta2  
   ,    movi.mooper  
   ,    movi.mofech  
   ,    movi.moestatus  
   ,    movi.mofecini  
   ,    movi.mofecvcto  
   FROM    BacLineas.dbo.LINEAS_RETENIDAS  lret with(nolock)  
           INNER JOIN BacCamSuda.dbo.MEMOH movi with(nolock) ON movi.monumope = lret.numero_operacion  
   WHERE   lret.id_sistema         = 'BCC'  
   AND     lret.estado_liberacion  = 'N'  
   AND     lret.rut_cliente        = @nRutCliente  
   AND     lret.fecha_pago        >= @fechini  
  
   UPDATE  BacLineas.dbo.LINEA_SISTEMA   
   SET    TotalOcupado    = 0  
   ,    TotalExceso     = 0  
   ,    TotalDisponible = TotalAsignado  
   WHERE   id_sistema      = 'BCC'  
   and     rut_cliente     = @nRutCliente  
  
   UPDATE  BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO  
   SET    TotalOcupado    = 0  
   ,    TotalExceso     = 0  
   ,    TotalDisponible = TotalAsignado  
   WHERE   id_sistema      = 'BCC'  
   and     rut_cliente     = @nRutCliente  
  
   SELECT @nregs = COUNT(*)
   FROM   #tmp_car

   SET    @ncont = 1

   WHILE  @ncont <= @nregs
   BEGIN

   DELETE FROM BacLineas.dbo.LINEA_TRANSACCION   
         WHERE Id_Sistema      = 'BCC'  
           and Rut_Cliente     = @nRutCliente  
  
   DELETE FROM BacLineas.dbo.LINEA_TRANSACCION_DETALLE  
         WHERE Id_Sistema      = 'BCC'  
           and Rut_Cliente     = @nRutCliente  
  
  
   --SELECT @nregs = COUNT(*)
   --FROM   #tmp_car
  
   --SET    @ncont = 1
  
   --WHILE  @ncont <= @nregs
   --BEGIN
	PRINT @nregs
      SET ROWCOUNT @ncont  
  
      SELECT @Posicion1 = CONVERT(CHAR(5), motipmer)  
         ,   @Numoper   = monumope  
         ,   @rut       = morutcli  
         ,   @CodCli    = mocodcli  
         ,   @MtoMda1   = moussme   --> momonmo  
         ,   @fecvcto   = CONVERT(CHAR(8), movaluta2, 112)  
         ,   @MercadoLc = CASE WHEN clpais = 6 THEN 'S' ELSE 'N' END  
         ,   @Moneda    = 0  
         ,   @producto  = CONVERT(CHAR(5),motipmer)  
         ,   @Operador  = mooper  
      FROM   #tmp_car  
             INNER JOIN VIEW_CLIENTE with(nolock) ON morutcli = clrut AND mocodcli = clcodigo  
      INNER JOIN VIEW_MONEDA  with(nolock) ON mnnemo   = mocodmon  
  
      SET ROWCOUNT 0  
      SET @ncont = @ncont + 1  
  
      IF EXISTS( SELECT 1 FROM BacLineas.dbo.LINEA_SISTEMA WHERE @rut = rut_cliente AND @codcli = codigo_cliente AND id_sistema = 'BCC')  
      --IF EXISTS( SELECT 1 FROM BacLineas.dbo.LINEA_SISTEMA WHERE @nRutCliente = rut_cliente AND id_sistema = 'BCC')
      BEGIN  
         DELETE FROM BacLineas.dbo.LINEA_TRANSACCION   
               WHERE Id_Sistema      = 'BCC'  
                 and Rut_Cliente     = @nRutCliente  
                 and NumeroOperacion = @Numoper  
  
         DELETE FROM BacLineas.dbo.LINEA_TRANSACCION_DETALLE  
               WHERE Id_Sistema      = 'BCC'  
                 and Rut_Cliente     = @nRutCliente  
                 and NumeroOperacion = @Numoper  
  
         EXECUTE BacLineas.dbo.SP_LINEAS_CHEQUEARGRABAR    
                                                    @fechini ,  
                                                    'BCC'  ,   
                                                    @Posicion1 ,   
                                                    @Numoper  ,  
                                                    @Numoper  ,  
                                                    0  ,  
                                                    @rut   ,  
                                                    @CodCli  ,  
                                                    @MtoMda1  ,  
                                                    0  ,  
                                                    @fecvcto  ,  
                                                    @Operador  ,  
                                                    0  ,  
                                                    0  ,  
                                                    @fechini ,  
                                                    0  ,  
                                                    'N'  ,  
                                                    @moneda  ,  
                                                    'C'  ,  
                                                    0  ,  
                                                    'N'  ,  
                                                    0  ,  
                                                    @fechini ,  
                                                    0 ,  
                                                    0 ,  
                                                    0 ,  
                                                    0 ,  
                                                    ''  
        EXECUTE BacLineas.dbo.Sp_Lineas_Chequear      'BCC', @producto, @Numoper, '', 'N', 'S'  
  
         EXECUTE BacLineas.dbo.sp_Lineas_GrbOperacion  'BCC'  
                                                   ,   @Posicion1  
                                                   ,   @Numoper  
                                                   ,   @Numoper  
                                                   ,   ' '  
                                                   ,   'N'  
                                                   ,   @MercadoLc  
  
      END  
   END  
  
   EXECUTE BacLineas.dbo.SP_RECALCULA_GENERAL  
  
END  
GO
