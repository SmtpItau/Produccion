USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_FECHA_PROXIMA_HABIL]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_BUSCA_FECHA_PROXIMA_HABIL]
   (   @fecha       DATETIME 
   ,   @dias        INTEGER  
   ,   @plaza       INTEGER
   ,   @fecha_habil DATETIME OUTPUT 
   )
AS
BEGIN

   -- Modificado el dÃ­a : 23/01/2006 --

   SET NOCOUNT ON

   DECLARE @mes         INTEGER
   ,       @campo       CHAR(50)
   ,       @ano         INTEGER
   ,       @feriado     CHAR(1)
   ,       @nrodia      INTEGER
   DECLARE @iContador   INTEGER

   SELECT  @iContador = 0
   SELECT  @nrodia    = (CASE WHEN @dias < 0 THEN -1 ELSE 1 END)
   SELECT  @feriado   = 'S'

   IF @dias = 0
   BEGIN
      SELECT @fecha_habil = @fecha
      RETURN
   END

   SELECT @iContador   = 0
   SELECT @fecha_habil = @fecha

   WHILE @feriado = 'S'
   BEGIN

      SELECT @fecha_habil = DATEADD(DAY   , @nrodia, @fecha_habil)
      SELECT @mes         = DATEPART(MONTH, @fecha_habil)
      SELECT @ano         = DATEPART(YEAR , @fecha_habil)
      
      SELECT @campo = '0'
      SELECT @campo = CASE WHEN @mes = 01 THEN isnull(feene,' ')
                           WHEN @mes = 02 THEN isnull(fefeb,' ') 
                           WHEN @mes = 03 THEN isnull(femar,' ')
                           WHEN @mes = 04 THEN isnull(feabr,' ')
                           WHEN @mes = 05 THEN isnull(femay,' ')
                           WHEN @mes = 06 THEN isnull(fejun,' ')
                           WHEN @mes = 07 THEN isnull(fejul,' ')
                           WHEN @mes = 08 THEN isnull(feago,' ')
                           WHEN @mes = 09 THEN isnull(fesep,' ')
                           WHEN @mes = 10 THEN isnull(feoct,' ')
                           WHEN @mes = 11 THEN isnull(fenov,' ')
                           WHEN @mes = 12 THEN isnull(fedic,' ')
                      END
      FROM   BacParamSuda..FERIADO 
      WHERE  feano   = @ano
      and    feplaza = @plaza

      IF CHARINDEX(SUBSTRING(CONVERT(CHAR(10),@fecha_habil,103),1,2),@campo) = 0
    AND (DATEPART(WEEKDAY,@fecha_habil) <> 7 AND  DATEPART(WEEKDAY,@fecha_habil) <> 1) 
      BEGIN
         SELECT @iContador = @iContador + 1
         IF  @iContador = ABS(@dias)
         BEGIN
            SELECT @feriado = 'N'
         END
      END
   END

   RETURN 0
END




GO
