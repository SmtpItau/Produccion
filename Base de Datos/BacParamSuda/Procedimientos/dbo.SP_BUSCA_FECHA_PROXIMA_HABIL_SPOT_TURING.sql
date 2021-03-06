USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_FECHA_PROXIMA_HABIL_SPOT_TURING]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_FECHA_PROXIMA_HABIL_SPOT_TURING]
	(	@fecha       DATETIME 
	,   @dias        INTEGER  
	,   @plaza       INTEGER
	,   @fecha_habil DATETIME OUTPUT 
	)
AS
BEGIN
	-- Modificado el día : 23/01/2006 --
	--> Modificado el 05-12-2014

	SET NOCOUNT ON

	DECLARE @mes         INTEGER
	DECLARE @campo       CHAR(50)
	DECLARE @ano         INTEGER
	DECLARE @feriado     CHAR(1)
	DECLARE @nrodia      INTEGER
	DECLARE @iContador   INTEGER

		SET @iContador = 0
		SET @nrodia    = (CASE WHEN @dias < 0 THEN -1 ELSE 1 END)
		SET @feriado   = 'S'

   IF @dias = 0
   BEGIN
      SET @fecha_habil = @fecha
      RETURN
   END

   SET @iContador   = 0
   SET @fecha_habil = @fecha

   WHILE @feriado = 'S'
   BEGIN
      SET @fecha_habil = DATEADD(DAY   , @nrodia, @fecha_habil)
      SET @mes         = DATEPART(MONTH, @fecha_habil)
      SET @ano         = DATEPART(YEAR , @fecha_habil)
      
      SET @campo = '0'
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
      FROM   BacParamSuda.dbo.FERIADO with(nolock)
      WHERE  feano   = @ano
      and    feplaza = @plaza

      IF CHARINDEX(SUBSTRING(CONVERT(CHAR(10),@fecha_habil,103),1,2),@campo) = 0
      BEGIN
		 SET @iContador = @iContador + 1
	  
         IF  @iContador >= ABS(@dias)
         BEGIN
            SET @feriado = 'N'
         END
      END
	END

	RETURN 0
END
GO
