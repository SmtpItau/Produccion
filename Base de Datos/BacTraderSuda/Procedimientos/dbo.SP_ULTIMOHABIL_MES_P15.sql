USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ULTIMOHABIL_MES_P15]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ULTIMOHABIL_MES_P15]
		(
		@dfecha1   DATETIME ,
		@dfechasal DATETIME OUTPUT
		)
AS BEGIN
 DECLARE @dfecha2 DATETIME ,
	 @Mes     INTEGER ,
	 @cdias1  CHAR(250) 
	DECLARE @I INTEGER

	SELECT @dfecha2 = DATEADD(MONTH,1,@dfecha1)
	SELECT @dfecha2 = DATEADD(DAY,(CONVERT(INTEGER,DATEPART(DAY,@dfecha1))*-1) ,@dfecha2)

	SELECT @dfecha2 = DATEADD(DAY,-1,@dfecha2)  -- ultimo dia del fin de mes

	SELECT @I = 0
	WHILE  @I = 0 BEGIN 
		SELECT @Mes =  DATEPART(MONTH, @dfecha2)  
		SELECT @cdias1 = CASE @Mes WHEN  1 THEN feene
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
		WHERE feano   = DATEPART(YEAR,@dfecha1)	AND
		      feplaza = 6

		IF  CHARINDEX( RTRIM(CONVERT(CHAR(02),DATEPART(DAY,@dfecha2))),@cdias1) > 0 OR 
		   (DATEPART(WEEKDAY,@dfecha2)= 7 OR DATEPART(WEEKDAY,@dfecha2)=1 ) BEGIN 
			SELECT @dfecha2 = DATEADD(DAY,-1,@dfecha2)
		END ELSE BEGIN
			SELECT @I = 1
			BREAK
		END
	END
 SELECT @dfechasal =@dfecha2  
END

GO
