USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_EJECUCION_PROCESOS_LINEAS_OPCIONES_PTONET]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_EJECUCION_PROCESOS_LINEAS_OPCIONES_PTONET]        
        
   (   @cSistema      CHAR(3)        
    ,  @fechini       DATETIME                
    ,  @Posicion1     CHAR(03)        
    ,  @Numoper       NUMERIC(10)        
    ,  @rut1          NUMERIC(9)         
    ,  @CodCli1       NUMERIC(9)        
    ,  @MtoMda1       NUMERIC(21,04)        
    ,  @fecvcto       DATETIME         
    ,  @moneda        NUMERIC(05)        
    ,  @AvrCLP        FLOAT        
    ,  @PorcAddOn     FLOAT        
    ,  @MontoAddOn    FLOAT        
    ,  @producto      CHAR(3)        
    ,  @MercadoLc     CHAR(01)        
    ,  @nContraMoneda NUMERIC(03)        
    ,  @nMonedaOpera  NUMERIC(03)        
    ,  @Usuario       CHAR(15)= ''  -- 22 Sept. 2009        
    ,  @MetodoLCR     NUMERIC(5)= 0 -- PRD_10968        
    ,  @Garantia      FLOAT    = 0 -- PRD_10968         
    ,  @ResultadoDRV  FLOAT     = 0 -- Valor LCR met. DRV          
   )        
        
AS         
BEGIN        
        
   SET NOCOUNT ON        
        
   --10968        
   declare @Observ  varchar(255)       
        
   DECLARE @Valor   FLOAT        
   SELECT  @Valor   = CASE WHEN  @MetodoLCR IN ( 1,4) THEN @MontoAddOn ELSE @ResultadoDRV end        
   select  @Observ  = ''        
        
   -- Revisar si es cotización        
   declare @EsCotizacion varchar(1)        
   declare @Existe       numeric(1)        
   select  @EsCotizacion = 'C'        
   select  @Existe       =  0        
   select  @EsCotizacion = CaEstado, @Existe = 1 from lnkOpc.CbMdbOpc.dbo.CaEncContrato where CaNumContrato = @Numoper         
   if @EsCotizacion = 'C' and @Existe = 1 begin        
            SELECT  'OK', 'Cotización no imputa LCR'         
            return            
   end        
   --10968        
        
        
  CREATE TABLE  #MENSAJE        
   (   xMensaje   VARCHAR(255)              
   ,   xGlosa     VARCHAR(255)        
   )        
           
        
         EXECUTE SP_LINEAS_CHEQUEARGRABAR    @fechini        
                                                ,    @cSistema        
                                                ,    @Posicion1        
                                                ,    @Numoper        
                                                ,    @Numoper        
                                                ,    0        
                                                ,    @rut1        
                                                ,    @CodCli1        
                                                ,    @MtoMda1          
                                                ,    0        
                                                ,    @fecvcto        
                                                ,    @Usuario -- 22 Sept. 2009 -- ''  -- < Va el Operador que en recálculo no se pone        
                                                ,    0        
                                                ,    0        
                                                ,    @fechini        
                                                ,    0        
                                                ,    'N'        
                                                ,    @moneda   --<-- Moneda en que será expresado el cálculo, CLP        
                                                ,    'C'        
                                                ,    0        
                                                ,    'N'        
                                                ,    0        
                                                ,    @fechini        
                                                ,    0        
                                                ,    0        
                                                ,    0        
                                                ,    0        
                                                ,    ''        
                                                , @AvrCLP     -- 500000  -- AVR        
                         , @PorcAddOn  -- 50.12   -- % Calculado aquí en servidor de opciones        
                                                , @Valor      -- 400000  -- Resultado sin incluir el AVR 31        
                                                , @MetodoLCR  -- PRD_10968        
                                                , @Garantia   -- PRD_10968          
                    
--return        
                    
        if @@error <> 0         
        begin                    
            SELECT 'ERROR', 'CAE SP_LINEAS_CHEQUEARGRABAR'         
            return                    
        end        
        
        EXECUTE SP_LINEAS_CHEQUEAR @cSistema        
                                                ,   @producto        
                                                ,   @Numoper        
                                                ,   ''        
                                                ,   'N'        
                                                ,   'S'        
        
        if @@error <> 0         
        begin                    
            SELECT  'ERROR', 'CAE SP_LINEAS_CHEQUEAR'         
            return                    
        end        
        
         -- select 'Ejecuta', 'SP_LINEAS_GRBOPERACION' -- select * from MENSAJE_LINEAS        
         -- INSERT INTO #TMP_MENSAJE        
         -- No se le hará retornar mensaje        
         -- POr ahorahasta plantear nueo         
         -- Proyecto        
        
         -- MAP 02 Septiembre Borrar por recáulculos        
        
         -- COMENTADO POR MIENTRAS        
        delete dbo.MENSAJE_LINEAS where Sistema =  @cSistema and NumOper = @Numoper        
        IF @cSistema = 'OPT'      
            delete dbo.MENSAJE_LINEAS_TURING where Sistema =  @cSistema and NumOper = @Numoper        
        
        
        INSERT INTO #MENSAJE                   
        EXECUTE SP_LINEAS_GRBOPERACION  @cSistema        
                                                ,   @Posicion1        
                                                ,   @Numoper        
                                                ,   @Numoper        
                                                ,   ' '        
                                                ,   'N'        
                                                ,   @MercadoLc        
                                                ,   @nContraMoneda        
                                                ,   @nMonedaOpera        
                
        if @@error <> 0         
        begin                    
            SELECT  'ERROR', 'CAE SP_LINEAS_GRBOPERACION'         
            return                    
        end        
        
        if ( select count(1) from #MENSAJE ) = 0         
        Begin        
            Insert into #Mensaje select 'OK', 'Limite'        
        
        End        
        
        -- 6066        
    DECLARE @motivoBloqueo VARCHAR(70),        
            @resultProceso VARCHAR(100)        
            
    SELECT  @motivoBloqueo = '',        
            @resultProceso = ''        
          
    if @MtoMda1 >= 0         
    Begin        
        EXECUTE BacParamsuda.dbo.SP_DET_BLOQUEOS_CLIENTES_OPT @rut1, @CodCli1, @motivoBloqueo OUTPUT        
        IF @motivoBloqueo <> ''        
        BEGIN        
            /* El cliente está bloqueado por Opciones */        
            EXECUTE BacParamsuda.dbo.SP_GRABA_BLOQUEOCLIENTE_OPT 'OPT', 'OPT', @Numoper, 'C', @motivoBloqueo, @rut1, @CodCli1, @fechini, @fecvcto, @Usuario, @MtoMda1, @resultProceso OUTPUT        
            /* IF @resultProceso = 'OK' ---> Se grabó bien el bloqueo en LINEA_TRANSACCION_DETALLE  */        
        END        
        -- 6066        
    end        
        
    IF @cSistema = 'OPT'      
    BEGIN      
     --EXECUTE Sp_Trae_Msj_Errores @cSistema, @Numoper, @Linea OUTPUT, @Bloqueo OUTPUT      
     INSERT INTO dbo.MENSAJE_LINEAS_TURING EXECUTE Sp_Trae_Msj_Errores @cSistema, @Numoper, @Observ OUTPUT, 1       
    
        if @@error <> 0         
        begin                    
            SELECT  'ERROR', 'CAE Sp_Trae_Msj_Errores'         
            return                    
        end      
      
        select  Column1 = TipoMensaje, Column2 = Glosa      
        from dbo.MENSAJE_LINEAS_TURING where Sistema = @cSistema and NumOper = @Numoper  order by TipoMensaje desc    
    END       
    ELSE      
    BEGIN                 
        Execute Sp_Trae_Msj_Errores @cSistema, @Numoper , @Observ OUTPUT         
        if @@error <> 0         
        begin                    
            SELECT  'ERROR', 'CAE Sp_Trae_Msj_Errores'         
            return                    
        end        
        
        
        INSERT dbo.MENSAJE_LINEAS        
        SELECT @cSistema, @Numoper, @rut1, @CodCli1, xMensaje, @Observ         
        FROM  #MENSAJE        
        
         
        select Column1 = Mensaje, Column2 = Glosa         
        from dbo.MENSAJE_LINEAS where Sistema =  @cSistema and NumOper = @Numoper      
    END         
END 
GO
