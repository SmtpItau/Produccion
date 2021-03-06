USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_Valida_Feriado_Next_Year]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[sp_Valida_Feriado_Next_Year] 
       (
         @nYear		INTEGER
       )
AS
BEGIN
   SET NOCOUNT ON

   DECLARE @dFecini	DATETIME
   DECLARE @dfechaaux	DATETIME
   DECLARE @cdias1 	VARCHAR(255)
   DECLARE @nUltDiames  INTEGER
   DECLARE @nDiaMes	INTEGER
   DECLARE @dfechames	DATETIME
   DECLARE @mes		INTEGER
   DECLARE @nReg	INTEGER

   SELECT @dFecini = CONVERT(DATETIME, CONVERT(CHAR(04),@nYear) + '0101')

   CREATE TABLE #Paso_Feriado (FechaFeriado DATETIME)   

   IF not exists(SELECT 1 FROM view_feriado WHERE feano = @nYear And feplaza = 6) BEGIN
	SELECT 'NO',0,0
	RETURN
   END ELSE
	BEGIN
		SELECT @dfechaaux = @dFecini
		SELECT @mes = 1
		WHILE @mes <= 12
		BEGIN
  			SELECT @cdias1 =CASE DATEPART(MONTH, @dfechaaux)
    						WHEN  1 THEN feene
    						WHEN  2 THEN fefeb
						WHEN  3 THEN femar
    						WHEN  4 THEN feabr
    						WHEN  5 THEN femay
    						WHEN  6 THEN fejun
    						WHEN  7 THEN fejul
    						WHEN  8 THEN feago
    						WHEN  9 THEN fesep
    						WHEN 10 THEN feoct
    						WHEN 11 THEN fenov
    						WHEN 12 THEN fedic
   					END
  			FROM VIEW_FERIADO
  			WHERE feano  = @nYear
  			AND   feplaza = 6

			SELECT @nUltDiames = Day(dateadd(d,day(@dfechaaux)*-1,dateadd(m,1,@dfechaaux)))
			SELECT @nDiaMes = 1
			SELECT @dfechames = @dfechaaux

			WHILE @nDiaMes <= @nUltDiames
			BEGIN
			   IF (DATEPART(WEEKDAY,@dfechames)= 7 OR DATEPART(WEEKDAY,@dfechames)=1 ) /* Sabado y Domingo*/
				IF CHARINDEX( RTRIM(CONVERT(CHAR(02),DATEPART(DAY,@dfechames))),@cdias1) = 0
					INSERT INTO #Paso_Feriado
					SELECT @dfechames

			   SELECT @dfechames = DAteadd(d,1,@dfechames)
			   SELECT @nDiaMes = @nDiaMes + 1
			END

			SELECT @nDiaMes = 0
			SELECT @dfechaaux = DATEADD(mm,1,@dfechaaux)
			SELECT @mes = @mes + 1
		END
	END

   SELECT @nReg = COUNT(*) FROM #Paso_Feriado
   IF @nReg = 0
	SELECT 'SI',0,0
   ELSE
	SELECT DISTINCT 'NO',MONTH(FechaFeriado),YEAR(FechaFeriado) FROM #Paso_Feriado

   SET NOCOUNT OFF
END


GO
