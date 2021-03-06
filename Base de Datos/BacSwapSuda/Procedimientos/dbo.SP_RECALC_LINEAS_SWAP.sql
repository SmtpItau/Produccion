USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RECALC_LINEAS_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_RECALC_LINEAS_SWAP]
AS 
BEGIN

	--+++CONTROL IDD, jcamposd ya realiza el return se registra para seguimiento.
	RETURN

-- Swap: Guardar Como
 SET NOCOUNT ON
 DECLARE @ncont  INTEGER   	,
  @Posicion1  CHAR(3)   	,
  @Numoper NUMERIC(10)  	,
  @rut      NUMERIC(9)  	,
  @CodCli     NUMERIC(9)  	,
  @MtoMda1    NUMERIC(21,04)  	,
  @fecvcto    CHAR(8)   	,
  @fechini    CHAR(8)   	,
  @MercadoLc  CHAR(1)   	,
  @moneda  NUMERIC(5)  		,
  @nregs  INTEGER		,
  @producto char(5)             ,
  @rut1      NUMERIC(9)  	,
  @CodCli1     NUMERIC(9)  	

   CREATE TABLE #TMP_MENSAJE
   (   xMensaje   VARCHAR(255)
   ,   xGlosa     VARCHAR(255)
   )

 
--  Se comenta ya que se realiza un Truncate Table en  SP_NUEVO_RECALCULO_LINEAS de Forward
--  delete   BacLineas..debug_valores    where variable01 like '%PCS%'

  Insert BacLineas..DEBUG_VALORES select   '000Inicio sp_recalc_lineas', 0.0, 'sp_recalc_lineas_swap', 0.0

 SELECT  DISTINCT
        c.compra_capital
,	c.compra_moneda
,	c.numero_operacion
,	c.rut_cliente
,	c.codigo_cliente
,	c.fecha_termino
,	c.tipo_swap
 INTO  #tmp_car 
 FROM   cartera c 
,  	swapgeneral  s
 WHERE c.compra_capital > 0
AND	c.compra_moneda > 0
AND     c.Estado       <> 'C'

UPDATE 	BACLINEAS..LINEA_SISTEMA 
SET	TotalOcupado = 0
,	TotalExceso = 0
,	TotalDisponible = TotalAsignado
WHERE 	ID_SISTEMA = 'PCS'

UPDATE 	BACLINEAS..LINEA_PRODUCTO_POR_PLAZO
SET	TotalOcupado = 0
,	TotalExceso = 0
,	TotalDisponible = TotalAsignado
WHERE 	ID_SISTEMA = 'PCS'


 SELECT  @fechini = CONVERT(CHAR(8), fechaproc ,112)    
 FROM swapgeneral


 SELECT @nregs = COUNT(*)
 FROM #tmp_car
 SELECT @ncont = 1

 WHILE @ncont <= @nregs
  BEGIN  
   SET ROWCOUNT @ncont
   SELECT @Posicion1 = CONVERT(CHAR(3),tipo_swap)     ,
    @Numoper   = numero_operacion        ,
    @rut       = rut_cliente       ,
    @CodCli    = codigo_cliente       ,
    @MtoMda1   = compra_capital   ,
    @fecvcto   = CONVERT(CHAR(8),fecha_termino,112)    ,
    @MercadoLc = CASE clpais WHEN 6 THEN 'S' ELSE 'N' END   ,
    @Moneda    = compra_moneda ,
    @producto  = CONVERT(CHAR(5),tipo_swap)
   FROM   #tmp_car 
   ,      view_cliente
   WHERE  rut_cliente = clrut 
   AND    codigo_cliente = clcodigo

      IF EXISTS( SELECT 1 FROM baclineas..CLIENTE_RELACIONADO WHERE clrut_hijo = @rut AND clcodigo_hijo = @CodCli )
      BEGIN
         SELECT	@rut1           = clrut_padre		
         ,      @CodCli1        = clcodigo_padre
         FROM	baclineas..CLIENTE_RELACIONADO 
         WHERE 	clrut_hijo 	= @rut1	
         AND    clcodigo_hijo 	= @CodCli1
      END ELSE
      BEGIN
         SELECT	@rut1           = @rut
         SELECT	@CodCli1        = @CodCli
      END

      SET ROWCOUNT 0
      SELECT @ncont = @ncont + 1

   IF EXISTS( SELECT * FROM baclineas..linea_sistema WHERE @rut1 = rut_cliente AND @codcli1 = codigo_cliente AND id_sistema = 'PCS' )
   BEGIN
      --------------------------------------<< Estado de Flujos
      -- MAP 20071213 Se reformula el reconocimiento del flujo vigente  
      -- para que no se modifique la tasa y flujo de interes de flujos
      -- que aún no parten, lo que se da comunmente cuando la fecha
      -- efectiva es posterior a la fecha de proceso y al hacer unwind
      -- el Swap queda con fecha de inicio de proximo cupón posterior
      -- a la fecha de proceso, pese a esto tal flujo debe ser 
      -- considerado como flujo vigente.
      --------------------------------------<< Estado de Flujos
      EXECUTE SP_FLUJO_VIGENTE @Numoper

      EXECUTE BacLineas..SP_LINEAS_CHEQUEARGRABAR  @fechini   
                                                ,  'PCS'
                                                ,  @Posicion1
                                                ,  @Numoper
                                                ,  @Numoper
                                                ,  0
                                                ,  @rut
                                                ,  @CodCli
                                                ,  @MtoMda1
						,  0
                                               ,  @fecvcto
                                               	,  ''
                                                ,  0
                                                ,  0
                                                ,  @fechini
                                                ,  0
                                                ,  'N'
                                                ,  @moneda
                                                ,  'C'
                                                ,  0
                                                ,  'N'
                                                ,  0
                                                ,  @fechini
					        ,  0
                                                ,  0
                                                ,  0
                                                ,  0
                                                ,  ''

         EXECUTE baclineas..SP_LINEAS_CHEQUEAR       'PCS' , @producto  , @Numoper , '', 'N', 'S'  

	 INSERT INTO #TMP_MENSAJE         
         EXECUTE baclineas..SP_LINEAS_GRBOPERACION   'PCS' , @Posicion1 , @Numoper , @Numoper , ' ' , 'N' , @MercadoLc , 0 , 0 , 1  

         Insert  BacLineas..DEBUG_VALORES select   ltrim( @Numoper ) + '00'  , @Numoper , 'Sp_Lineas_GrbOpera', 0.0
      END
   END

--   EXECUTE BACLINEAS..SP_RECALCULA_GENERAL

   UPDATE  BACLINEAS..matriz_atribucion_instrumento 
   SET	   Acumulado_Diario = 0
   WHERE   Id_Sistema       = 'PCS'


   Insert  BacLineas..DEBUG_VALORES select   '000Fin sp_recalc_lineas', 0.0, 'sp_recalc_lineasSwap', 0.0

   DROP TABLE #TMP_MENSAJE

   SET NOCOUNT OFF

END
GO
