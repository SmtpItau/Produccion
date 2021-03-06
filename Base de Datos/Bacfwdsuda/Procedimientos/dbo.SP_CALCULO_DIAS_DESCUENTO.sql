USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULO_DIAS_DESCUENTO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CALCULO_DIAS_DESCUENTO]( @fecha  DATETIME  ,
      @pais  INT   ,
      @suma  CHAR(1)   ,
      @dias_entrada INT   ,
      @dias_retorno INT  OUTPUT ,
      @fecha_retorno DATETIME OUTPUT
       )
AS
BEGIN
 SET NOCOUNT ON
 
 DECLARE @feriado INT
 DECLARE @dias  INT
 DECLARE @primerdiasql INT 
 SELECT  @primerdiasql  = CASE @@DATEFIRST WHEN 1 THEN 0 ELSE 1 END 
 SELECT  @feriado  = -1
 SELECT  @dias_retorno  = @dias_entrada
 SELECT  @fecha_retorno  = @fecha 
 WHILE @feriado = -1
  BEGIN
   -- Valida que no sea Feriado, en funcion de Z, 
   EXECUTE sp_feriado @fecha, @pais , @feriado OUTPUT
    -- Si Es Feriado Debe Buscar en Dias Z
         IF @feriado = -1
     BEGIN
      SELECT  @dias_retorno =  Z
      FROM dia_descuento
      WHERE ( DATEPART( WEEKDAY, @fecha ) - @primerdiasql ) = dia
      
      SELECT @dias = @dias_retorno * ( CASE @suma WHEN 'S' THEN 1 ELSE -1 END )
      SELECT @fecha = DATEADD( DAY , @dias , @fecha )
      SELECT @fecha_retorno = @fecha 
  
     END
  END 
 SET NOCOUNT OFF
END
-- SELECT * FROM DIA_DESCUENTO

GO
