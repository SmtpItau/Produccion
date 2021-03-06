USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RECALC_LINEAS_CAM]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RECALC_LINEAS_CAM]  
AS   
BEGIN  
  
  --+++CONTROL IDD, jcamposd no debe ejecutar el proceso
  RETURN
  -----CONTROL IDD, jcamposd no debe ejecutar el proceso
  
 SET NOCOUNT ON  
   -- PROD-13828 Impresion Masiva Contratos SAO y Problema en la retención de lineas
   /* Se elimina codigo del recálculo
   DECLARE @ncont      INTEGER,  
           @Posicion1  CHAR(5),  
           @Numoper    NUMERIC(10),  
           @rut        NUMERIC(9),  
           @CodCli     NUMERIC(9),  
           @MtoMda1    NUMERIC(21,04),  
           @fecvcto    CHAR(8),  
           @fechini    CHAR(8),  
           @MercadoLc  CHAR(1),  
           @moneda     NUMERIC(5),  
           @nregs      INTEGER,  
           @producto   CHAR(5),  
           @Operador   CHAR(10)  
  
   SELECT  @fechini = CONVERT(CHAR(8), acfecpro ,112)      
   FROM    MEAC  
  
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
   INTO   #tmp_car   
   FROM   MEMO  m  
   ,      MEAC  a  
   WHERE  m.motipope   = 'C'  
   AND   m.movaluta2  > a.acfecpro  
   AND   m.moestatus <> 'A'  
  
   INSERT INTO #tmp_car   
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
   FROM    MEMO  m  
        ,  MEAC  a  
   WHERE   m.motipope   = 'V'   
   and     m.movaluta2 <> movaluta1   
   and     m.movaluta2  > movaluta1  
   and     m.mofech     = a.acfecpro --> @fechini  
  
   */

   UPDATE  BACLINEAS..LINEA_SISTEMA   
   SET    TotalOcupado    = 0  
   ,    TotalExceso     = 0  
   ,    TotalDisponible = TotalAsignado  
   WHERE   id_sistema      = 'BCC'  
  
   UPDATE  BACLINEAS..LINEA_PRODUCTO_POR_PLAZO  
   SET    TotalOcupado    = 0  
   ,    TotalExceso     = 0  
   ,    TotalDisponible = TotalAsignado  
   WHERE   id_sistema      = 'BCC'  
  

   DELETE FROM BacLineas.dbo.LINEA_TRANSACCION   
         WHERE Id_Sistema      = 'BCC'

   DELETE FROM BacLineas.dbo.LINEA_TRANSACCION_DETALLE
         WHERE Id_Sistema  = 'BCC'

   /*

   SELECT @nregs = COUNT(*)  
   FROM   #tmp_car  
  
   SET    @ncont = 1  
  
   WHILE @ncont <= @nregs  
   BEGIN    
      SET ROWCOUNT @ncont  
      SELECT @Posicion1 = CONVERT(CHAR(5),motipmer),  
             @Numoper   = monumope,  
             @rut       = morutcli,  
             @CodCli    = mocodcli,  
             @MtoMda1   = moussme, --> momonmo,  
             @fecvcto   = CONVERT(CHAR(8),movaluta2,112),  
             @MercadoLc = CASE clpais WHEN 6 THEN 'S' ELSE 'N' END,  
             @Moneda    = 0, --> mncodmon,  
             @producto  = CONVERT(CHAR(5),motipmer),  
             @Operador  = mooper  
      FROM   #tmp_car,  
          view_cliente,  
      view_moneda  
      WHERE  morutcli   = clrut  
       AND   mocodcli   = clcodigo  
       AND   mnnemo     = mocodmon  
  
      SET ROWCOUNT 0  
  
      SET @ncont = @ncont + 1  
  
      IF EXISTS( SELECT * FROM baclineas..linea_sistema WHERE @rut = rut_cliente AND @codcli = codigo_cliente AND id_sistema = 'BCC' )  
      BEGIN  
  
       EXECUTE baclineas..sp_Lineas_ChequearGrabar  @fechini ,  
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
      EXECUTE baclineas..Sp_Lineas_Chequear 'BCC', @producto, @Numoper, '', 'N', 'S'  
  
      EXECUTE baclineas..sp_Lineas_GrbOperacion     'BCC'  ,  
                                                    @Posicion1 ,  
                                                    @Numoper ,  
                                                    @Numoper ,  
                                                    ' '  ,  
                                                    'N'  ,  
                                                    @MercadoLc  
  
      END  
   END  
  
   EXECUTE BACLINEAS..SP_RECALCULA_GENERAL  
   */
END  
--> +++ cvegasan 2017.08.08 Control Lineas IDD
GO
