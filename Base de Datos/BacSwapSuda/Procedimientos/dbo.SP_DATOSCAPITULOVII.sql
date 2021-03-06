USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOSCAPITULOVII]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_DATOSCAPITULOVII](
                                             @Fecha		CHAR(8),        -- @Fecha debe ser igual siempre a yyyymmdd   
					     @representante     NUMERIC(10),
					     @rut		NUMERIC(10),
					     @modo              CHAR(1)) 		
					
AS
BEGIN
-- Swap: Guardar Como
SET NOCOUNT ON
-- SELECT * FROM MdApoderado dbo.sp_HELP  MdApoderado TEXT dbo.sp_DatosCapituloVII
DECLARE @ApNombre    CHAR(40)
DECLARE @ApFono      CHAR(15)
DECLARE @ApCargo     CHAR(40)
DECLARE @Nombre      CHAR(50)
DECLARE @CodigoBanco CHAR(5)
DECLARE @Quince      NUMERIC(3)
DECLARE @Spot	     CHAR(5)

SELECT @ApNombre    = ApNombre,
       @ApFono      = ApFono,
       @ApCargo     = ApCargo FROM View_Cliente_Apoderado WHERE aprutapo = @representante
SELECT @Nombre      = Nombre,
       @CodigoBanco = CONVERT(CHAR(5),CodigoBanco) FROM SwapGeneral WHERE rut = @rut
SELECT @spot        = mnsimbol FROM View_Moneda WHERE mncodmon = 994

   /*=============================================================== dbo.sp_help mdApoderado ========*/
   /*=======================================================================*/  

   SELECT       
                'a'  = clrut,
	        'b'  = cldv  ,		
	        'c'  = clnombre,
		'd'  = tipo_operacion,
 		'e'  = numero_operacion,
		'f'  = numero_flujo,
                'g'  = CONVERT(CHAR(10),fecha_cierre,103),
		'h'  = CONVERT(CHAR(10),fecha_vence_flujo,103),
		'i'  = modalidad_pago,
		'j'  = compra_moneda,		
        	'k'  = (SELECT MNNEMO FROM View_Moneda WHERE compra_moneda=mncodmon),
		'l'  = compra_amortiza,
		'm'  = compra_interes,
		'n'  = venta_moneda	,
          	'ñ'  = (SELECT MNNEMO FROM View_Moneda WHERE venta_moneda=mncodmon) ,
		'o'  = venta_amortiza,
		'p'  = venta_interes,
		'q'  = ISNULL(( SELECT vmvalor FROM View_Valor_Moneda WHERE vmfecha = fecha_cierre and vmcodigo=994),0) ,
		'r'  = venta_valor_tasa,
		's'  = venta_spread,
		't'  = compra_valor_tasa,
		'u'  = compra_spread,
		'v'  = @apnombre, 
		'w'  = @apfono  , 
		'x'  = @apcargo , 
		'y'  = @nombre  , 
		'z'  = @codigobanco,
   		'a1' = @rut , 
                'b1' = 'I',
		'd1' = @spot,
		'e1' = DATEDIFF (dd,fecha_cierre,fecha_vence_flujo),
		'CONTADOR'=0
         INTO #PASO_LOG

 FROM   Cartera ,View_Cliente
 WHERE  CONVERT(CHAR(8),fecha_cierre,112) = @Fecha      
 	AND tipo_swap = 2 
        AND Estado <> 'C'
	AND codigo_cliente =clcodigo
 ORDER BY numero_operacion,numero_flujo

     SELECT     
		'a'  = clrut,  
	        'b'  = cldv  ,		
	        'c'  = clnombre,
		'd'  = CarteraLog.tipo_operacion,
 		'e'  = CarteraLog.numero_operacion,
		'f'  = CarteraLog.numero_flujo,
		'g'  = CONVERT(CHAR(10),CarteraLog.fecha_cierre,103),
		'h'  = CONVERT(CHAR(10),CarteraLog.fecha_vence_flujo,103),
		'i'  = CarteraLog.modalidad_pago,
		'j'  = CarteraLog.compra_moneda,		
        	'k'  = (SELECT MNNEMO FROM View_Moneda WHERE CarteraLog.compra_moneda=mncodmon),
		'l'  = CarteraLog.compra_amortiza,
		'm'  = CarteraLog.compra_interes,
		'n'  = CarteraLog.venta_moneda	,
          	'ñ'  = (SELECT MNNEMO FROM View_Moneda WHERE CarteraLog.venta_moneda=mncodmon) ,
		'o'  = CarteraLog.venta_amortiza,
		'p'  = CarteraLog.venta_interes,
		'q'  = ISNULL(( SELECT vmvalor FROM View_Valor_Moneda WHERE vmfecha = CarteraLog.Fecha_cierre and vmcodigo=994),0) ,
		'r'  = CarteraLog.venta_valor_tasa,
		's'  = CarteraLog.venta_spread,
		't'  = CarteraLog.compra_valor_tasa,
		'u'  = CarteraLog.compra_spread,
		'v'  = @ApNombre, 
		'w'  = @ApFono  , 
		'x'  = @ApCargo , 
		'y'  = @Nombre  , 
		'z'  = @CodigoBanco,
   		'a1' = @Rut , 
                'b1' = 'M' ,
		'C1' = CarteraLog.FECHA_MODIFICA,
		'd1' = @spot,
		'e1' = DATEDIFF (dd,CarteraLog.fecha_cierre,CarteraLog.fecha_vence_flujo)
	   INTO #PASO1_LOG
       FROM  CarteraLog ,Cartera ,View_Cliente  
       WHERE CONVERT(CHAR(8),Cartera.fecha_cierre,112) = @fecha 
         AND CONVERT(CHAR(8),CarteraLog.fecha_cierre,112) = @Fecha
         AND CONVERT(CHAR(8),Cartera.fecha_cierre,112) = CONVERT(CHAR(8),CarteraLog.fecha_cierre,112)
         AND Cartera.numero_operacion = CarteraLog.numero_operacion
         AND Cartera.numero_flujo = CarteraLog.numero_flujo
         AND CarteraLog.Estado = 'M' 
         AND CONVERT(CHAR(8),Cartera.fecha_modifica,112) <> CONVERT(CHAR(8),Cartera.fecha_cierre,112)
         AND Cartera.codigo_cliente =clcodigo
         AND CarteraLog.codigo_cliente =clcodigo
       ORDER BY CarteraLog.numero_operacion,CarteraLog.numero_flujo

  INSERT INTO  #PASO_LOG(a,b,c,d,e,f,g,h,i,j,k,l,m,n,ñ,o,p,q,r,s,t,u,v,w,x,y,z,a1,b1,d1,e1,Contador)
 
  SELECT  #PASO1_LOG.a,
	  #PASO1_LOG.b,
          #PASO1_LOG.c,
	  #PASO1_LOG.d,
	  #PASO1_LOG.e,
       	  #PASO1_LOG.f,
	  #PASO1_LOG.g,	 
          (CASE WHEN CONVERT(CHAR(10),#PASO_LOG.h,103) = CONVERT(CHAR(10),#PASO1_LOG.h,103) THEN '' ELSE CONVERT(CHAR(10),#PASO_LOG.h,103) END) ,
	  (CASE WHEN #PASO_LOG.i = #PASO1_LOG.i THEN '' ELSE #PASO_LOG.i END),
          (CASE WHEN #PASO_LOG.j = #PASO1_LOG.j THEN 0  ELSE (SELECT mncodmon FROM View_Moneda WHERE mnnemo=#PASO_LOG.k) END),
          (CASE WHEN #PASO_LOG.k = #PASO1_LOG.k THEN '' ELSE #PASO_LOG.k END),
	  (CASE WHEN #PASO_LOG.l = #PASO1_LOG.l THEN 0  ELSE #PASO_LOG.l END),
	  (CASE WHEN #PASO_LOG.m = #PASO1_LOG.m THEN 0  ELSE #PASO_LOG.m END),
	  (CASE WHEN #PASO_LOG.n = #PASO1_LOG.n THEN 0  ELSE (SELECT mncodmon FROM View_Moneda WHERE mnnemo=#PASO_LOG.ñ) END),
          (CASE WHEN #PASO_LOG.ñ = #PASO1_LOG.ñ THEN '' ELSE #PASO_LOG.ñ END),
	  (CASE WHEN #PASO_LOG.o = #PASO1_LOG.o THEN 0  ELSE #PASO_LOG.o END),
	  (CASE WHEN #PASO_LOG.p = #PASO1_LOG.p THEN 0  ELSE #PASO_LOG.p END),
	  (CASE WHEN #PASO_LOG.q = #PASO1_LOG.q THEN 0  ELSE #PASO_LOG.q END),
	  (CASE WHEN #PASO_LOG.r = #PASO1_LOG.r THEN 0  ELSE #PASO_LOG.r END),
	  (CASE WHEN #PASO_LOG.s = #PASO1_LOG.s THEN 0  ELSE #PASO_LOG.s END),
	  (CASE WHEN #PASO_LOG.t = #PASO1_LOG.t THEN 0  ELSE #PASO_LOG.t END),
	  (CASE WHEN #PASO_LOG.u = #PASO1_LOG.u THEN 0  ELSE #PASO_LOG.u END),
	  #PASO1_LOG.v,
	  #PASO1_LOG.w,
	  #PASO1_LOG.x,
	  #PASO1_LOG.y,
	  #PASO1_LOG.z,
	  #PASO1_LOG.a1,
	  #PASO1_LOG.b1,
	  #PASO1_LOG.d1,
	  (CASE WHEN #PASO_LOG.g = #PASO_LOG.h THEN 0 ELSE DATEDIFF (dd,#PASO_LOG.g ,#PASO_LOG.h) END),
	  0
 FROM     #PASO1_LOG, #PASO_LOG 
 WHERE    #PASO1_LOG.e  = #PASO_LOG.e 
 AND      #PASO1_LOG.f  = #PASO_LOG.f 
 AND      #PASO1_LOG.c1 =(SELECT MAX(#PASO1_LOG.c1) FROM #PASO1_LOG, #PASO_LOG WHERE #PASO1_LOG.e = #PASO_LOG.e AND #PASO1_LOG.f = #PASO_LOG.F) 
 ORDER BY #PASO_LOG.e, #PASO_LOG.f

 SET ROWCOUNT 15
 
 DECLARE @Contador FLOAT
 DECLARE @Conta    FLOAT 
 DECLARE @Reg	   FLOAT
 DECLARE @Mod	   CHAR(1)	
 SELECT  @Contador = 1  
 SELECT  @Conta    = 1 
 select  @Reg      = 0
 select  @Mod      = @Modo

 WHILE 1 = 1
 BEGIN
  
    IF EXISTS(SELECT * FROM  #PASO_LOG WHERE Contador = 0 AND b1 = 'I')
       BEGIN
          SELECT @Reg = 1 
          SELECT @Mod = 'M'
          UPDATE #PASO_LOG SET Contador=@Contador WHERE Contador = 0 AND b1='I'
       END
    ELSE
       BEGIN
          IF EXISTS(SELECT * FROM  #PASO_LOG WHERE CONTADOR = 0 AND b1 = 'M')
             BEGIN
                SELECT @Reg = 2
                SELECT @Mod = 'I'
                UPDATE #PASO_LOG SET Contador=@Conta WHERE Contador = 0 AND b1='M'
                SELECT @CONTA = @CONTA + 1
             END
          ELSE
             BEGIN
                BREAK     
             END
       END
    SELECT @CONTADOR = @CONTADOR + 1
 
 END

 /* llena cuando no hay registros*/
 -- IF @Reg <> 1 or @Reg <> 2
 IF @Reg = 0
    BEGIN
      INSERT INTO #PASO_LOG(a,b,c,d,e,f,g,h,i,j,k,l,m,n,ñ,o,p,q,r,s,t,u,v,w,x,y,z,a1,b1,d1,e1,Contador) VALUES (0,'','','',0,0,'','','',0,'',0,0,0,'',0,0,0,0,0,0,0,ISNULL(@ApNombre,''),ISNULL(CONVERT(NUMERIC,@ApFono),0),ISNULL(@ApCargo,''),ISNULL(@Nombre,''),ISNULL(@CodigoBanco,0),CONVERT(NUMERIC,@Rut),@Mod,'',0,'')
    END
 /*fin*/
	
 SET ROWCOUNT 0

 SELECT * FROM #PASO_LOG WHERE #PASO_LOG.b1 = @Modo ORDER BY #PASO_LOG.b1, #PASO_LOG.Contador, #PASO_LOG.e, #PASO_LOG.f

END

GO
