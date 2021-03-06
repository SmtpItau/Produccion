USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_UFProyectada]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_UFProyectada]
         ( 
           @dfecven    DATETIME     , -- Fecha de Vencimiento
    @valuffecvcto   FLOAT OUTPUT 
         )
AS 
BEGIN
   SET NOCOUNT ON
   DECLARE @retorna CHAR(1)
   IF @valuffecvcto = -1
   BEGIN
      SELECT @retorna = "N"
 
   END ELSE BEGIN
      SELECT @retorna = "S"
   END
   SELECT @valuffecvcto = 0
 
   SELECT   @valuffecvcto = vmvalor 
      FROM  VIEW_VALOR_MONEDA
      WHERE vmfecha = @dfecven 
        AND vmcodigo = 998
 
   IF @valuffecvcto = 0 BEGIN
  -- Calcula U.F. Proyectada
  DECLARE @dia   NUMERIC(2,0)
  DECLARE @mes  NUMERIC(2,0)
  DECLARE @ano   NUMERIC(4,0)
  DECLARE @feccal  DATETIME 
  DECLARE @fechacal     DATETIME
  DECLARE @valoruf    NUMERIC(12,2)
  DECLARE @valoripc   NUMERIC(6,2)
  DECLARE @nmaxdia    NUMERIC(2,0)
  DECLARE @ncandias   NUMERIC(2,0)
  DECLARE @ndiascal   FLOAT
  DECLARE @nipc       FLOAT
  DECLARE @nvalipc    FLOAT
  SELECT @dia=DATEPART(DAY,@dfecven)
  SELECT @mes=DATEPART(MM,@dfecven)
  SELECT @ano=DATEPART(YY,@dfecven) 
  IF @dia <= 9 BEGIN
   IF @mes = 1 BEGIN
    SELECT @mes = 12
    SELECT @ano = @ano - 1 
   END ELSE BEGIN
    SELECT @mes= @mes- 1
     
   END
  END 
   
  SELECT @feccal = CONVERT(DATETIME, "09/" + CONVERT(CHAR(2), @mes) + "/" + CONVERT(CHAR(4),@ano) ,103)
  SELECT @fechacal = ipcfeccal  ,
         @valoruf  = ipcvaloruf ,
         @valoripc = ipcvaloripc 
                FROM view_ipc_uf_proyectada WHERE CONVERT(CHAR(8),ipcfeccal,102) = CONVERT(CHAR(8),@feccal,102)
  SELECT @ncandias = DATEDIFF(DD,@feccal,@dfecven)
  SELECT @nmaxdia = 0
  /*=======================================================================*/
  IF  @mes =  1 BEGIN SELECT @nmaxdia = 31 END --Enero
  IF  @mes =  2 BEGIN SELECT @nmaxdia = 28 END --Febrero
  IF  @mes =  3 BEGIN SELECT @nmaxdia = 31 END --Marzo
  IF  @mes =  4 BEGIN SELECT @nmaxdia = 30 END --Abril
  IF  @mes =  5 BEGIN SELECT @nmaxdia = 31 END --Mayo
  IF  @mes =  6 BEGIN SELECT @nmaxdia = 30 END --Junio
  IF  @mes =  7 BEGIN SELECT @nmaxdia = 31 END --Julio
  IF  @mes =  8 BEGIN SELECT @nmaxdia = 31 END --Agosto
  IF  @mes =  9 BEGIN SELECT @nmaxdia = 30 END --Septiembre
  IF  @mes = 10 BEGIN SELECT @nmaxdia = 31 END --Octubre
  IF  @mes = 11 BEGIN SELECT @nmaxdia = 30 END --Noviembre
  IF  @mes = 12 BEGIN SELECT @nmaxdia = 31 END --Diciembre
  /*=======================================================================*/
  SELECT @nipc = (CONVERT(FLOAT, @valoripc) / 100) + 1
   
  SELECT @ndiascal = CONVERT(FLOAT, @ncandias / @nmaxdia)
  SELECT @nvalipc = POWER( @nipc , @ndiascal )
  SELECT @valuffecvcto =  @valoruf * @nvalipc
 END
 IF @retorna = 'S'
        BEGIN
          SELECT ISNULL(ROUND( @valuffecvcto , 4 ),0)
 END
   SET NOCOUNT OFF
END
GO
