USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACKHABIL]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BACKHABIL]
		(	@dfecha1 	DATETIME	,
			@cPlaza 	NUMERIC  (3)	,
			@dfechasal 	DATETIME OUTPUT ,
			@Tipo		Char     (1) 	)-- Salida 'S/V' Sql o Visual Basic
AS
BEGIN

   SET NOCOUNT ON

 DECLARE  @cdias1      VARCHAR(255) 	,
          @icontadia   INTEGER  	,
          @dfechaaux   DATETIME 		
 SELECT   @icontadia = -1
 SELECT   @dfechaaux = DATEADD(DAY,@icontadia,@dfecha1)

 WHILE 1=1
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
  WHERE feano   = DATEPART(YEAR,@dfecha1)
  AND   feplaza = @cplaza

  IF  CHARINDEX( RTRIM(substring(convert(char(08),@dfechaaux,112),7,2)),@cdias1) > 0 OR 
     (DATEPART(WEEKDAY,@dfechaaux)= 7 OR DATEPART(WEEKDAY,@dfechaaux)=1 ) BEGIN      

	     SELECT @dfechaaux = DATEADD(DAY,@icontadia,@dfecha1)

  END

  ELSE BREAK
  SELECT @icontadia = @icontadia - 1
 END

  If @Tipo = 'S' 
	  SELECT @dfechasal =  @dfechaaux
  Else 
	  SELECT @dfechaaux


   SET NOCOUNT OFF

END


GO
