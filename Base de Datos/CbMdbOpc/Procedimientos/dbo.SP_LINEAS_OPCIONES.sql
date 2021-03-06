USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_OPCIONES]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_OPCIONES]  
   (   @cSistema    CHAR(3)  
   ,   @nCliente    NUMERIC(09)  
   ,   @nCodigo     INTEGER  
   ,   @iRecGrl     INTEGER = 0  
   ,   @Usuario     CHAR(15)= ''  
   ,   @NumContrato NUMERIC(10) = 0   
   )  
AS   
BEGIN  
  
   SET NOCOUNT ON  
  
   -- MAP 05 Octubre, al parecer leia de movimientos antes en vez de Cartera  
  
   -- POR HACER: Evaluar crear el proceso en BacLineas y que lean desde alla la cartera y por tanto se conecten una sola vez  
   -- Conclusiones: habria que calcular el monto en Opciones  
   -- simplemente imputar en BAC.  
   -- por el tema se que no se puede estar en opciones y llamar un proceso de BAC y luego   -- un proceso de BAC no puede ver a Opciones y se esta ejecutando de opciones.  
  
   -- DELETE LnkBac.BacLineas.dbo.LINEA_CHEQUEAR -- MAP 20090603 solo para trace  
  
--   MAP 20090603 solo para trace  
--   INSERT INTO lnkBac.BacFwdSuda.dbo.LOG_AUDITORIA_FWD  
--   SELECT 2, fechaproc, GETDATE(), CONVERT(CHAR(10),GETDATE(),108), 'RECALCULO', @Usuario, @cSistema, '--', '00', 'RECALCULO DE LINEAS OPCIONES', 'LINEAS', '',''  
--   FROM   OpcionesGeneral WITH (NOLOCK)  
  
-- MAP 05 Nov. 2009 Desvio a vista por alter a tabla cliente  
  
  
   DECLARE @ncont      INTEGER  
   DECLARE @Posicion1      CHAR(03)  
   DECLARE @Numoper     NUMERIC(10)  
   DECLARE @rut          NUMERIC(9)  
   DECLARE @CodCli         NUMERIC(09)  
   DECLARE @rut1          NUMERIC(9)   DECLARE @CodCli1        NUMERIC(09)  
   DECLARE @MtoMda1        NUMERIC(21,04)  
   DECLARE @fecvcto        CHAR(08)  
   DECLARE @fechini        CHAR(08)  
   DECLARE @MercadoLc      CHAR(01)  
   DECLARE @moneda      NUMERIC(05)  
   DECLARE @nregs      INTEGER  
   DECLARE @producto     CHAR(05)  
   DECLARE @fecpro    DATETIME  
   DECLARE @nContraMoneda  NUMERIC(03)  
   DECLARE @nMonedaOpera   NUMERIC(03)  
   DECLARE @nPerdidaDev    NUMERIC(21,04)  
   DECLARE @nTipoOperacion NUMERIC(05)  
   DECLARE @nPlazoResidual NUMERIC(05)  
   DECLARE @nTipoCam    FLOAT  
   DECLARE @nDolarHoy    FLOAT  
   DECLARE @Moneda_Sis    NUMERIC(10)  
   DECLARE @PERDIDALIM    FLOAT  
   DECLARE @AvrCLP         FLOAT  
   DECLARE @fecant    DATETIME  
   DECLARE @MontoAddOn     FLOAT  
   DECLARE @PorcAddOn      FLOAT  
  
  
   DELETE  lnkBac.BacLineas.dbo.debug_valores  
  
   SET @fecpro     = (SELECT fechaproc FROM OpcionesGeneral)  
   SET @fecant     = (SELECT fechaant  FROM OpcionesGeneral)  
   SET @fechini    = (SELECT CONVERT(CHAR(8), fechaproc,112) FROM OpcionesGeneral)  
   SET @MontoAddOn = 0.0  
   SET @PorcAddOn  = 0.0   
  
  
   SELECT  Enc.*  
   ,       'Vencimiento' = ( select max( CaFechaPagoEjer) from CaDetContrato Det where Det.CaNumContrato = Enc.CaNumContrato )  
   ,       'Id_Puntero' = Identity(INT)  
   INTO    #TMP_CAR  
   FROM    CaEncContrato Enc  
           INNER JOIN lnkBac.BacParamSuda.dbo.VIEW_CLIENTEParaOpc    ON CaRutCliente     = clrut     AND CaCodigo        = clcodigo  
--           INNER JOIN BacParamSuda..PRODUCTO P ON P.id_sistema = @cSistema AND Codigo_producto = cacodpos1 ¿?  
   WHERE   -- cafecvcto > @fecpro   POR HACER: deleter después lo vencido segun Vencimiento  
           caRutCliente  = @nCliente  
      AND  cacodigo  = @nCodigo  
      and ( CaNumContrato = @NumContrato or @NumContrato = 0 )  
   ORDER BY CaRutCliente  
  
  
   SET @nregs = (SELECT MAX(Id_Puntero) FROM #TMP_CAR)  
   SET @ncont = (SELECT MIN(Id_Puntero) FROM #TMP_CAR)  
  
  
   WHILE @nregs >= @ncont  
   BEGIN    
      SELECT @Posicion1      = Codigo_producto   
      ,      @Numoper        = caNumContrato  
      ,      @rut            = caRutCliente  
      ,      @CodCli         = caCodigo  
      ,      @rut1           = caRutCliente  
      ,      @CodCli1        = caCodigo  
      ,      @fecvcto        = CONVERT(CHAR(8), Vencimiento ,112)  
      ,      @MercadoLc      = CASE WHEN clpais = 6 THEN 'S' ELSE 'N' END  
      ,      @Moneda         = 999                    -- POR HACER  
      ,      @producto       = Codigo_producto        --CONVERT(CHAR(5),1)     -- POR HACER: Parametrizar  
      ,      @nMonedaOpera   = 999       -- POR HACER: Ver que vamos hacer en esto  
      ,      @nContraMoneda  = 999    
      ,      @nTipoOperacion = 1                      -- POR HACER: Parametrizar, número para el producto, deberia ser uno  
                                                      -- Para todos los tipos de opciones a menos que se haga la estructura  
                                                      -- completa nuevamente.  
      ,      @nPlazoResidual = DATEDIFF(DAY, @fecpro, Vencimiento ) --> caplazovto  
      FROM   #TMP_CAR    
             INNER JOIN LnkBac.BacparamSuda.dbo.PRODUCTO P ON P.id_sistema = @cSistema AND Codigo_producto = 'OPT' --1  -- POR HACER: Parametrizar   
             INNER JOIN lnkBac.BacParamSuda.dbo.VIEW_CLIENTEParaOpc  ON caRutCliente     = clrut     AND caCodigo        = clcodigo  
      WHERE  Id_Puntero      = @ncont  
  
  
      SET @ncont   = @ncont + 1  
  
      SET @rut1    = @nCliente  
      SET @CodCli1 = @nCodigo  
  
      /*IF EXISTS(SELECT 1 FROM lnkBac.BacLineas.dbo.CLIENTE_RELACIONADO WHERE clrut_hijo = @nCliente AND clcodigo_hijo = @nCodigo)
      BEGIN  
         SELECT @rut1         = clrut_padre  
         ,      @CodCli1      = clcodigo_padre  
         FROM lnkBac.BacLineas.dbo.CLIENTE_RELACIONADO  
         WHERE  clrut_hijo    = @nCliente  
         AND    clcodigo_hijo = @nCodigo  
      END	*/
  
      IF (1 = 1) --> EXISTS( SELECT 1 FROM BacLineas..LINEA_SISTEMA WHERE @rut1 = rut_cliente AND @codcli1 = codigo_cliente AND id_sistema = @cSistema)  
      BEGIN               
  
        
         EXEC SP_Calculo_LCR_Interno_Opciones @Numoper, 'N', @MtoMda1 OUTPUT, @AvrCLP OUTPUT, @MontoAddOn OUTPUT, @PorcAddOn OUTPUT  
  
         EXEC LNKBAC.BacLineas.dbo.SP_EJECUCION_PROCESOS_LINEAS_OPCIONES    
                                                  @cSistema   
                                                , @fechini  
                                                , @Posicion1  
                                                , @Numoper  
                                                , @rut1  
                                                , @CodCli1  
                                                , @MtoMda1   
                                                , @fecvcto   
                                                , @moneda   
                                                , @AvrCLP  
                                                , @PorcAddOn  
                                                , @MontoAddOn  
                                                , @producto  
                                                , @MercadoLc  
                                                , @nContraMoneda  
                                                , @nMonedaOpera   
                                                , @Usuario -- 22 Sept. 2009 -- MAP 02 Septiembre 2009 Pendiente verificar impacto en las otras llamadas  
  
  
  
      END -- If  
   END -- While  
  
   IF @iRecGrl = 1  
   BEGIN  
      EXECUTE lnkBac.BacLineas.dbo.SP_RECALCULA_GENERAL  
  
       UPDATE lnkBac.BacLineas.dbo.MATRIZ_ATRIBUCION_INSTRUMENTO   
          SET Acumulado_Diario = 0  
        WHERE Id_Sistema       = @cSistema  
   END  
  
  
END  
GO
