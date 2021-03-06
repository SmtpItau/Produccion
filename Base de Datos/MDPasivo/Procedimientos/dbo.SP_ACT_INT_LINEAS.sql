USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_INT_LINEAS]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ACT_INT_LINEAS]
     (
     @numero_operacion_star NUMERIC(10)
   , @Monto_operacion  NUMERIC(19,2)
     )
AS
BEGIN
 SET NOCOUNT ON
 SET DATEFORMAT dmy
 BEGIN TRANSACTION

 DECLARE 
  @moneda_primaria   NUMERIC(3)
  ,@moneda_secundaria   NUMERIC(3)
  ,@fecha_proceso   DATETIME

  ,@sistema   VARCHAR(3)
  ,@Producto   VARCHAR(3)
  ,@numero_operacion_bt  NUMERIC(10)
  ,@numero_operacion_SWAP  NUMERIC(10)
  ,@rut_cliente   NUMERIC(10)
  ,@codigo_cliente  NUMERIC(5)
  ,@fecha_inicio   DATETIME
  ,@fecha_termino   DATETIME
  ,@modalidad_compensacion VARCHAR(1)
  ,@flag    NUMERIC(1)  

 SELECT  @fecha_proceso = fecha_proceso 
 FROM  datos_generales


 SET  @sistema  = ''
 SET  @Producto  = ''
 SET  @numero_operacion_bt = 0
 SET  @rut_cliente  = 0
 SET  @codigo_cliente  = 0
 SET  @fecha_inicio  = ''
 SET  @fecha_termino  = ''
 SET  @modalidad_compensacion = ''

 SET @moneda_primaria  = 999
 SET @moneda_secundaria  = 999
 
 SET  @flag    = 0


-- IF ( ( SELECT COUNT(*) FROM view_cartera_forward WHERE operacion_star = @numero_operacion_star ) > 0  )
-- BEGIN
  

  SELECT 
   @sistema  = 'BFW'
   ,@Producto  = cacodpos1
   ,@numero_operacion_bt = canumoper 
   ,@rut_cliente  = cacodigo 
   ,@codigo_cliente = cacodcli 
   ,@fecha_inicio  = cafecha 
   ,@fecha_termino  = cafecvcto 
   ,@modalidad_compensacion= catipmoda 
   ,@flag = 1
  FROM  view_cartera_forward   
  WHERE  operacion_star  = @numero_operacion_star

   
-- END
/*
 IF ( ( SELECT COUNT(*) FROM view_cartera_forward_historica WHERE operacion_star = @numero_operacion_star) > 0 )
 BEGIN

  SET @flag = 1

  SELECT 
   @sistema  = 'BFW'
   ,@Producto  = cacodpos1
   ,@numero_operacion_bt = canumoper 
   ,@rut_cliente  = cacodigo 
   ,@codigo_cliente = cacodcli 
   ,@fecha_inicio  = cafecha 
   ,@fecha_termino  = cafecvcto 
   ,@modalidad_compensacion= catipmoda 
  FROM  view_cartera_forward_historica  
  WHERE  operacion_star   = @numero_operacion_star
   and fecha_proceso = @fecha_proceso

 END
*/

  SELECT @numero_operacion_SWAP = 0

  SELECT @numero_operacion_SWAP = NUMERO_OPERACION_SWAP
  FROM RELACION_SWAP_STAR
  WHERE NUMERO_OPERACION_STAR = @numero_operacion_star
  AND @flag = 0

  IF @numero_operacion_SWAP <> 0
   SELECT  
    @sistema  = 'SWP'
    ,@Producto  = tipo_swap
    ,@numero_operacion_bt = numero_operacion 
    ,@rut_cliente  = rut_cliente 
    ,@codigo_cliente = codigo_cliente 
    ,@fecha_inicio  = fecha_inicio 
    ,@fecha_termino  = fecha_cierre 
    ,@modalidad_compensacion= ''
    ,@flag    = 1
   FROM  view_contrato 
   WHERE  numero_operacion = @numero_operacion_SWAP



-- END


/*
 IF ( ( SELECT COUNT(*) FROM view_contrato WHERE operacion_star = @numero_operacion_star ) > 0 )
 BEGIN

  SET @flag = 1

  SELECT  
   @sistema  = 'SWP'
   ,@Producto  = tipo_swap
   ,@numero_operacion_bt = numero_operacion 
   ,@rut_cliente  = rut_cliente 
   ,@codigo_cliente = codigo_cliente 
   ,@fecha_inicio  = fecha_inicio 
   ,@fecha_termino  = fecha_cierre 
   ,@modalidad_compensacion= ''
  FROM  view_contrato 
  WHERE  operacion_star = @numero_operacion_star

 END

 IF ( ( SELECT COUNT(*) FROM view_contrato_historico WHERE operacion_star = @numero_operacion_star ) > 0 )
 BEGIN
  SET @flag = 1

  SELECT  
   @sistema  = 'SWP'
   ,@Producto  = tipo_swap
   ,@numero_operacion_bt = numero_operacion 
   ,@rut_cliente  = rut_cliente 
   ,@codigo_cliente = codigo_cliente 
   ,@fecha_inicio  = fecha_inicio 
   ,@fecha_termino  = fecha_cierre 
   ,@modalidad_compensacion= ''
  FROM  view_contrato_historico 
  WHERE  operacion_star = @numero_operacion_star

 END
*/

 IF @flag = 1 
 BEGIN
  INSERT INTO CARTERA_LINEAS_STAR
   (
    fecha_proceso               
    ,id_sistema 
    ,producto 
    ,numero_operacion 
    ,numero_operacion_STAR 
    ,rut_cliente 
    ,codigo_cliente 
    ,fecha_inicio                
    ,fecha_vence                 
    ,monto_operacion         
    ,moneda_primaria 
    ,moneda_secundaria 
    ,modalidad_pago 
   )
  VALUES (
--select
    @fecha_proceso
    ,@sistema  
    ,@Producto  
    ,@numero_operacion_bt 
    ,@numero_operacion_star
    ,@rut_cliente  
    ,@codigo_cliente 
    ,@fecha_inicio  
    ,@fecha_termino  
    ,@Monto_operacion
    ,@moneda_primaria  
    ,@moneda_secundaria  
    ,@modalidad_compensacion
   )
  
  
  IF @@ERROR <> 0
  BEGIN
   ROLLBACK TRANSACTION
   RETURN
  END
 END 

 COMMIT TRANSACTION
 SET NOCOUNT OFF

END
 


GO
