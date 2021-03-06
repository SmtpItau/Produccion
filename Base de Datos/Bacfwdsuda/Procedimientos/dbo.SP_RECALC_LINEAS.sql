USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RECALC_LINEAS]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_RECALC_LINEAS]
AS 
BEGIN

   SET NOCOUNT ON

   DECLARE @ncont  	   INT
   ,       @Posicion1  	   CHAR(03)
   ,       @Numoper 	   NUMERIC(10)
   ,       @rut      	   NUMERIC(9)
   ,       @CodCli     	   NUMERIC(09)
   ,       @rut1      	   NUMERIC(9)
   ,       @CodCli1        NUMERIC(09)
   ,       @MtoMda1    	   NUMERIC(21,04)
   ,       @fecvcto    	   CHAR(08)
   ,       @fechini    	   CHAR(08)
   ,       @MercadoLc  	   CHAR(01)
   ,       @moneda  	   NUMERIC(05)
   ,       @nregs  	       INT
   ,       @producto 	   CHAR(05)
   ,       @fecpro	   DATETIME
   ,       @nContraMoneda  NUMERIC(03)
   ,       @nMonedaOpera   NUMERIC(03)
   ,       @nPerdidaDev	   NUMERIC(21,04)
   ,       @nTipoOperacion NUMERIC(05)
   ,       @nPlazoResidual NUMERIC(05)
   ,       @nTipoCam	   FLOAT
   ,       @nDolarHoy	   FLOAT
   ,       @Moneda_Sis	   NUMERIC(10)
   ,       @PERDIDALIM	   FLOAT
   ,       @Monto_Ori	   FLOAT
   ,       @Monto_USD	   FLOAT
   ,       @Clase_Op 	   CHAR(1)

  delete   BacLineas..debug_valores    where variable01 like '%BFW%'
		
   SELECT  MFCA.*
   INTO    #tmp_car 
   FROM    MFAC
   ,       MFCA
           LEFT JOIN BacParamSuda..CLIENTE ON cacodigo     = clrut AND cacodcli        = clcodigo
           INNER JOIN VIEW_PRODUCTO      P ON P.id_sistema = 'BFW' AND Codigo_producto = cacodpos1
   WHERE   cafecvcto > acfecproc 
   AND     cacodpos1 in(1,2,3,7,10)
   ORDER BY canumoper

   SELECT  @fechini = CONVERT(CHAR(8), acfecproc ,112)    
   FROM    MFAC

   SELECT  @fecpro = acfecproc 
   FROM    MFAC

   SELECT @nDolarHoy = vmvalor
   FROM   VIEW_VALOR_MONEDA
   WHERE  vmcodigo   = 994 
   AND    vmfecha    = @fecpro


   CREATE TABLE #Tmp_Moneda
   (   Codigo	NUMERIC(10)	
   ,   TCambio	FLOAT
   ,   Tipo	CHAR(01)
   )

   INSERT #TMP_MONEDA
   SELECT mncodmon,1.0, mnrrda
   FROM   VIEW_MONEDA

   UPDATE #TMP_MONEDA
   SET    TCambio = CASE WHEN vmvalor = 0.0 THEN 1.0 ELSE vmvalor END
   FROM   VIEW_VALOR_MONEDA
   WHERE  vmcodigo = Codigo
   AND    vmfecha = @fecpro

   UPDATE #TMP_MONEDA
   SET    TCambio = @nDolarHoy
   WHERE  Codigo  = 13

   SELECT 'Numero   '= canumoper        
   ,      'fecha    '= MIN(corfecvcto)  
   ,      'fechaven '= cafecvcto
   INTO    #cortes
   FROM    MFCA 	
   ,	   CORTES
   WHERE   canumoper = cornumoper
   AND	   corfecvcto > @fecpro
   GROUP BY canumoper, cafecvcto
	
   UPDATE #tmp_car
   SET    cafecvcto = CASE WHEN fechaven >= fecha THEN fechaven ELSE fecha END
   FROM   #cortes
   WHERE  canumoper = Numero


   UPDATE BACLINEAS..LINEA_SISTEMA 
   SET	  TotalOcupado 	  = 0
   ,	  TotalExceso 	  = 0
   ,	  TotalDisponible = TotalAsignado
   WHERE  id_sistema      = 'BFW'

   UPDATE BACLINEAS..LINEA_PRODUCTO_POR_PLAZO
   SET	  TotalOcupado 	  = 0
   ,	  TotalExceso 	  = 0
   ,	  TotalDisponible = TotalAsignado
   WHERE  id_sistema      = 'BFW'

   SELECT @nregs = COUNT(*)
   FROM   #tmp_car

   SELECT @ncont = 1

   WHILE @ncont <= @nregs
   BEGIN  
      SET ROWCOUNT @ncont

      SELECT @Posicion1      = CONVERT(CHAR(3),cacodpos1)
      ,      @Numoper        = canumoper
      ,      @rut            = cacodigo
      ,      @CodCli         = cacodcli
      ,      @rut1           = cacodigo
      ,      @CodCli1        = cacodcli
      ,      @MtoMda1        = CASE WHEN cacodpos1 = 2  THEN camtomon2
                                    WHEN cacodpos1 = 3  THEN caequusd1
                                    WHEN cacodpos1 = 10 THEN caequusd2
                                    ELSE camtomon1
          		       END
      ,      @fecvcto        = CONVERT(CHAR(8),cafecvcto,112)
      ,      @MercadoLc      = CASE WHEN clpais = 6 THEN 'S' ELSE 'N' END
      ,      @Moneda         = cacodmon1
      ,      @producto       = CONVERT(CHAR(5),cacodpos1)
      ,      @nMonedaOpera   = ISNULL(CASE WHEN cacodpos1     = 2   THEN cacodmon2 ELSE cacodmon1 END,0)
      ,      @nContraMoneda  = ISNULL(CASE WHEN Contra_Moneda = 'S' THEN ISNULL(CASE WHEN cacodpos1 = 2 THEN cacodmon1 ELSE cacodmon2 END,0)
				          ELSE                          0 
				     END,0)
      ,      @nPerdidaDev    = CASE WHEN ROUND(fRes_Obtenido,0) > 0.0 THEN ROUND(fRes_Obtenido,0) ELSE 0.0 END
                               /*
                               CASE WHEN cacodpos1 In(1,7) THEN carevtot
				    WHEN cacodpos1 In(2)   THEN cavalordia
				    WHEN cacodpos1 In(3)   THEN cautilacum
                               END
                               */
      ,      @nTipoOperacion = cacodpos1
      ,      @nPlazoResidual = caplazovto
      ,      @Monto_Ori	     = camtomon1
      ,      @Clase_Op	     = catipoper
      FROM   #tmp_car 	
             INNER JOIN VIEW_PRODUCTO P ON P.id_sistema = 'BFW' AND Codigo_producto = cacodpos1 
             INNER JOIN VIEW_CLIENTE	ON cacodigo     = clrut AND cacodcli        = clcodigo
      ORDER BY canumoper

      /******* Actualiza el Monto Origen a Dolar con la Paridad del día *******/
      SELECT @Monto_USD = @MtoMda1
      If @Posicion1 in(2,3)
      BEGIN
         SELECT @Monto_USD = CASE WHEN @Posicion1 In(2) THEN (@Monto_Ori * Tcambio) / @nDolarHoy
	  	                  WHEN @Posicion1 In(3) THEN (@Monto_Ori * Tcambio) / @nDolarHoy
   	        	     END
         FROM   #Tmp_Moneda
         WHERE  Codigo     = @Moneda
      END
      SELECT @MtoMda1 = @Monto_USD
      /******************************* FIN ***********************************/

      IF EXISTS(SELECT 1 FROM baclineas..CLIENTE_RELACIONADO WHERE clrut_hijo = @rut1 AND clcodigo_hijo = @CodCli1 )
      BEGIN
         SELECT	@rut1         = clrut_padre
         ,      @CodCli1      = clcodigo_padre
         FROM	baclineas..CLIENTE_RELACIONADO
         WHERE 	clrut_hijo    = @rut1
         AND    clcodigo_hijo = @CodCli1
      END	

      SET ROWCOUNT 0
      SELECT @ncont = @ncont + 1

      IF EXISTS( SELECT 1 FROM baclineas..LINEA_SISTEMA WHERE @rut1 = rut_cliente AND @codcli1 = codigo_cliente AND id_sistema = 'BFW')
      BEGIN
         EXECUTE baclineas..SP_LINEAS_CHEQUEARGRABAR @fechini 
                                                ,    'BFW'
                                                ,    @Posicion1
                                                ,    @Numoper
                                                ,    @Numoper
                                                ,    0
                                                ,    @rut
                                                ,    @CodCli
                                                ,    @MtoMda1
                                                ,    0
                                                ,    @fecvcto
                                                ,    ''
                                                ,    0
                                                ,    0
                                                ,    @fechini
                                                ,    0
                                                ,    'N'
                                                ,    @moneda
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

         --  Esto para crear linea por plazo si no existe                        
         EXECUTE baclineas..SP_LINEAS_CHEQUEAR      'BFW'
                                                ,   @producto
                          ,   @Numoper
                                                ,   ''
                                                ,   'N'
                                                ,   'S'

         EXECUTE baclineas..SP_LINEAS_GRBOPERACION  'BFW'
                                                ,   @Posicion1
                                                ,   @Numoper
                                                ,   @Numoper
                                                ,   ' '
                                                ,   'N'
                                                ,   @MercadoLc
                                                ,   @nContraMoneda
                                                ,   @nMonedaOpera



         /***************** Fin LINEA_PRODUCTO_POR_PLAZO **************************/
            EXECUTE SP_Graba_Registro_Utilidad_Banco  @Numoper
                                                ,     @nTipoOperacion
                                                ,     @rut
                                                ,     @CodCli
                                                ,     @nMonedaOpera
                                                ,     @nPerdidaDev
                                                ,     @nContraMoneda
                                                ,     @nPlazoResidual
                                                ,     @Monto_Ori
                                                ,     @MtoMda1
                                                ,     @Clase_Op

      END -- If
   END -- While

   EXECUTE BACLINEAS..SP_RECALCULA_GENERAL

   UPDATE BACLINEAS..matriz_atribucion_instrumento 
   SET	  Acumulado_Diario = 0
   WHERE  Id_Sistema       = 'BFW'

END




GO
