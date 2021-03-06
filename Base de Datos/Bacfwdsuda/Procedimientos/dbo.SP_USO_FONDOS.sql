USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_USO_FONDOS]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_USO_FONDOS] ( @modalidad  CHAR(1)  ,
     @dfecvto  DATETIME ,
     @fecha_proceso  DATETIME 
    )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @fecha_tasa  DATETIME ,
  @fecha_paso  DATETIME ,
  @fecha_paso1  DATETIME ,
  @dias_P   INT  , -- Dias USD
  @dias_i   INT  , -- Dias USD
  @dias_F   INT  , -- Dias USD
  @dias_i2  INT  , -- Dias Conversión
  @dias_F2  INT  , -- Dias Conversión
  @pais   INT  , -- Para los Feriados
  @dias_pasar  INT  ,
  @fdias_i  DATETIME , -- Dias USD
  @fdias_F  DATETIME , -- Dias USD
  @fdias_i2  DATETIME , -- Dias Conversión
  @fdias_F2  DATETIME , -- Dias Conversión
  @primerdiasql  INT  , 
  @tasaefectiva1  FLOAT  , -- Tasa de La Operación Moneda1
  @tasaefectiva2  FLOAT  , -- Tasa de La Operación Moneda2
  @dias_descto_USD INT  ,
  @dias_descto_CLP INT
 SELECT @primerdiasql = CASE @@DATEFIRST WHEN 1 THEN 0 ELSE 1 END 
 SELECT  @pais = ISNULL( acpais , 0 )
 FROM mfac
 ----------------------------------------------------------------------------------------
 -- Cálculo de los Dias de Descuento para Obtener la Tasa MTM
 ----------------------------------------------------------------------------------------
 -- CALCULO DE COMPENSACION
 IF @modalidad = 'C'
  BEGIN
   -- Cálculo de los Dias_p, Feriado CHILE
   SELECT  @dias_pasar =  Y
   FROM dia_descuento
   WHERE ( DATEPART( WEEKDAY, @dfecvto ) - @primerdiasql ) = dia
   SELECT @fecha_paso = DATEADD( DAY , -@dias_pasar, @dfecvto )
   EXECUTE sp_calculo_dias_descuento  @fecha_paso  ,
        @pais   ,
        'N'   ,
        @dias_pasar  ,
        @dias_p  OUTPUT ,  
        @fecha_paso1 OUTPUT 
   SELECT @fecha_paso = @fecha_paso1
   -- Cálculo de los Dias_F, Feriado USA
   SELECT  @dias_pasar =  X
   FROM dia_descuento
   WHERE ( DATEPART( WEEKDAY, @fecha_paso ) - @primerdiasql ) = dia
   SELECT @fecha_paso = DATEADD( DAY , @dias_pasar , @fecha_paso )
   EXECUTE sp_calculo_dias_descuento  @fecha_paso  ,
        225   ,
        'S'   ,
        @dias_pasar  ,
        @dias_F  OUTPUT ,  
        @fecha_paso1 OUTPUT 
   SELECT @fdias_F = @fecha_paso1
 
   -- Cálculo de los Dias_I, Feriado USA
   SELECT  @dias_pasar =  X
   FROM dia_descuento
   WHERE ( DATEPART( WEEKDAY, @fecha_proceso ) - @primerdiasql ) = dia
   SELECT @fecha_paso = DATEADD( DAY , @dias_pasar , @fecha_proceso )
   EXECUTE sp_calculo_dias_descuento  @fecha_paso  ,
        225   ,
        'S'   ,
        @dias_pasar  ,
        @dias_I  OUTPUT ,  
        @fecha_paso1 OUTPUT 
   SELECT @fdias_I = @fecha_paso1
 
   -- Cálculo de los Dias_I2, Feriado CHILE
   SELECT  @dias_pasar =  Z
   FROM dia_descuento
   WHERE ( DATEPART( WEEKDAY, @fecha_proceso ) - @primerdiasql ) = dia
   SELECT @fecha_paso = DATEADD( DAY , @dias_pasar , @fecha_proceso )
   EXECUTE sp_calculo_dias_descuento  @fecha_paso  ,
        @pais   ,
        'S'   ,
        @dias_pasar  ,
        @dias_I2 OUTPUT ,  
        @fecha_paso1 OUTPUT 
   SELECT @fdias_I2 = @fecha_paso1 
   SELECT @fdias_F2 = @dfecvto
  END
 ELSE 
  BEGIN
   -- Cálculo de los Dias_I, Feriado USA
   SELECT  @dias_pasar =  X
   FROM dia_descuento
   WHERE ( DATEPART( WEEKDAY, @fecha_proceso ) - @primerdiasql ) = dia
   SELECT @fecha_paso = DATEADD( DAY , @dias_pasar, @fecha_proceso )
   EXECUTE sp_calculo_dias_descuento  @fecha_paso  ,
        225   ,
        'S'   ,
        @dias_pasar  ,
        @dias_I  OUTPUT ,  
        @fecha_paso1 OUTPUT 
   SELECT @fdias_I = @fecha_paso1
   -- Cálculo de los Dias_F, Feriado USA
   SELECT  @dias_pasar =  X
   FROM dia_descuento
   WHERE ( DATEPART( WEEKDAY, @dfecvto ) - @primerdiasql ) = dia
   SELECT @fecha_paso = DATEADD( DAY , @dias_pasar, @dfecvto )
   EXECUTE sp_calculo_dias_descuento  @fecha_paso  ,
        225   ,
        'S'   ,
        @dias_pasar  ,
        @dias_F  OUTPUT ,  
        @fecha_paso1 OUTPUT 
   SELECT @fdias_F = @fecha_paso1
  -- Cálculo de los Dias_I2, Feriado CHILE
   SELECT  @dias_pasar =  Z
   FROM dia_descuento
   WHERE ( DATEPART( WEEKDAY, @fecha_proceso ) - @primerdiasql ) = dia
   SELECT @fecha_paso = DATEADD( DAY , @dias_pasar , @fecha_proceso )
   EXECUTE sp_calculo_dias_descuento  @fecha_paso  ,
        @pais   ,
        'S'   ,
        @dias_pasar  ,
        @dias_I2 OUTPUT ,  
        @fecha_paso1 OUTPUT 
   SELECT @fdias_I2 = @fecha_paso1
   SELECT  @dias_pasar =  Z
   FROM dia_descuento
   WHERE ( DATEPART( WEEKDAY, @dfecvto ) - @primerdiasql ) = dia
   SELECT @fecha_paso = DATEADD( DAY , @dias_pasar , @dfecvto )
   EXECUTE sp_calculo_dias_descuento  @fecha_paso  ,
        @pais   ,
        'S'   ,
        @dias_pasar  ,
        @dias_F2 OUTPUT ,  
        @fecha_paso1 OUTPUT 
   SELECT @fdias_F2 = @fecha_paso1
  END 
 SELECT @dias_descto_USD = DATEDIFF( DAY , @fdias_I , @fdias_F )
 SELECT @dias_descto_CLP = DATEDIFF( DAY , @fdias_I2 , @fdias_F2 ) 
 SELECT ISNULL(@dias_descto_USD,0) , ISNULL(@dias_descto_CLP,0)
 SET NOCOUNT OFF
END
-- sp_uso_fondos 'C', '20020103', '20020222'

GO
