USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_EJECUCION_PROCESOS_LINEAS_OPCIONES]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_EJECUCION_PROCESOS_LINEAS_OPCIONES]

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
   )

AS 
BEGIN

   SET NOCOUNT ON

  CREATE TABLE  #MENSAJE
   (   xMensaje   VARCHAR(255)      
   ,   xGlosa     VARCHAR(255)
   )


         EXECUTE SP_LINEAS_CHEQUEARGRABAR @fechini
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
                                                , @MontoAddOn -- 400000  -- Resultado sin incluir el AVR


         EXECUTE SP_LINEAS_CHEQUEAR @cSistema
                                                ,   @producto
                                                ,   @Numoper
                                                ,   ''
                                                ,   'N'
                                                ,   'S'


         -- select 'Ejecuta', 'SP_LINEAS_GRBOPERACION'
         -- INSERT INTO #TMP_MENSAJE
         -- No se le hará retornar mensaje
         -- POr ahorahasta plantear nueo 
         -- Proyecto

         -- MAP 02 Septiembre Borrar por recáulculos

         delete dbo.MENSAJE_LINEAS where Sistema =  @cSistema and NumOper = @Numoper


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
        


         INSERT dbo.MENSAJE_LINEAS
        SELECT @cSistema, @Numoper, @rut1, @CodCli1, xMensaje, xGlosa 
         FROM  #MENSAJE

	/* Solo para Bloqueos de Clientes */		
	DECLARE @motivoBloqueo VARCHAR(70),
			@resultProceso VARCHAR(100)
			
	SELECT 	@motivoBloqueo = '',
			@resultProceso = ''
	
	EXECUTE BacParamsuda.dbo.SP_DET_BLOQUEOS_CLIENTES_OPT @rut1, @CodCli1, @motivoBloqueo OUTPUT
	IF @motivoBloqueo <> ''
	BEGIN
		/*	El cliente está bloqueado por Opciones */
		EXECUTE BacParamsuda.dbo.SP_GRABA_BLOQUEOCLIENTE_OPT 'OPT', 'OPT', @Numoper, 'C', @motivoBloqueo, @rut1, @CodCli1, @fechini, @fecvcto, @Usuario, @MtoMda1, @resultProceso OUTPUT
		/* IF @resultProceso = 'OK' ---> Se grabó bien el bloqueo en LINEA_TRANSACCION_DETALLE  */
	END

END
GO
