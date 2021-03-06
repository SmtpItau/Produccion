USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMITES_RECHEQUEAROVERNIGHT]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LIMITES_RECHEQUEAROVERNIGHT](
      @sistema  CHAR(3)  ,
      @usuario_operacion CHAR(15) ,
      @usuario_autoriza CHAR(15) 
         )
AS 
BEGIN
 DECLARE @HedgeTotal  NUMERIC(21,04) ,
  @over_min  NUMERIC(21,04) ,
  @over_max  NUMERIC(21,04) ,
  @num_error  INTEGER  ,
  @monto_controlar NUMERIC(21,04) ,
  @supervisor  CHAR(1)  ,
  @tipo_operacion  CHAR(1)
 SET NOCOUNT ON
 SELECT  @num_error = 0
 IF NOT EXISTS(  SELECT  *
   FROM aprobacion_hedge
   WHERE @sistema = sistema  AND
    @usuario_operacion = Usuario  
       )
  SELECT  @num_error = 4
 SELECT  @monto_controlar = Monto_Operacion
 FROM aprobacion_hedge
 WHERE @sistema = sistema  AND
  @usuario_operacion = Usuario
 SELECT  @supervisor  = Supervisor   ,
  @over_min = Overnigth_Minimo ,
  @over_max = Overnigth_Maximo            
 FROM  view_parametros_operadores_spt
 WHERE   Usuario = @usuario_autoriza
 IF @supervisor = 'S'
  BEGIN
   IF @tipo_operacion = 'C'
    BEGIN
     IF @monto_controlar > @over_max 
      SELECT @num_error = 1
    END
   ELSE
    BEGIN
     IF @monto_controlar < @over_min 
      SELECT @num_error = 2
    END
   END
 ELSE
  BEGIN
   SELECT @num_error = 3
  END
 IF @num_error <> 3
  BEGIN
   UPDATE aprobacion_hedge 
   SET  Aprobado = 1   ,
    Autoriza = @usuario_autoriza
   WHERE @sistema = sistema  AND
    @usuario_operacion = Usuario  
  END
 SELECT @num_error
  
 SET NOCOUNT OFF
END
-- select * from aprobacion_hedge
-- select * from view_parametros_operadores_spt

GO
