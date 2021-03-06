USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDAFECHA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALIDAFECHA]
               (@xFecha    CHAR(8))
AS
BEGIN
   DECLARE @xCadena  CHAR(50)
   DECLARE @dFecha  DATETIME
   DECLARE @Plaza               NUMERIC(5)
SET NOCOUNT ON   
   SELECT @Plaza = Folio FROM GEN_FOLIOS WHERE Codigo = 'PLAZA_CHIL'
   
 IF ISDATE (SUBSTRING(@xFecha,5,2) + SUBSTRING(@xFecha,3,2) + SUBSTRING(@xFecha,1,2)) = 1 BEGIN
  SELECT @dFecha = CASE WHEN CONVERT(NUMERIC(2),SUBSTRING(@xFecha,5,2)) < 50 THEN '20' + SUBSTRING(@xFecha,5,2) 
         ELSE '19' + SUBSTRING(@xFecha,5,2) END + SUBSTRING(@xFecha,3,2) + SUBSTRING(@xFecha,1,2)
 END ELSE BEGIN
                SELECT 'ERR'
                SET NOCOUNT OFF
    RETURN 11
 END
   IF DATEPART(weekday,@dFecha) = 1 OR DATEPART(weekday,@dFecha) = 7 BEGIN
        SELECT 'ERR'
        SET NOCOUNT OFF
 RETURN 12
   END 
   IF SUBSTRING(@xFecha,3,2) = '01'
 SELECT @xCadena = feene FROM VIEW_FERIADO WHERE feplaza = @Plaza AND feano = DATEPART(YEAR,@dFecha)
   IF SUBSTRING(@xFecha,3,2) = '02'
 SELECT @xCadena = fefeb FROM VIEW_FERIADO WHERE feplaza = @Plaza AND feano = DATEPART(YEAR,@dFecha)
   IF SUBSTRING(@xFecha,3,2) = '03'
 SELECT @xCadena = femar FROM VIEW_FERIADO WHERE feplaza = @Plaza AND feano = DATEPART(YEAR,@dFecha)
   IF SUBSTRING(@xFecha,3,2) = '04'
 SELECT @xCadena = feabr FROM VIEW_FERIADO WHERE feplaza = @Plaza AND feano = DATEPART(YEAR,@dFecha)
   IF SUBSTRING(@xFecha,3,2) = '05'
 SELECT @xCadena = femay FROM VIEW_FERIADO WHERE feplaza = @Plaza AND feano = DATEPART(YEAR,@dFecha)
   IF SUBSTRING(@xFecha,3,2) = '06'
 SELECT @xCadena = fejun FROM VIEW_FERIADO WHERE feplaza = @Plaza AND feano = DATEPART(YEAR,@dFecha)
   IF SUBSTRING(@xFecha,3,2) = '07'
 SELECT @xCadena = fejul FROM VIEW_FERIADO WHERE feplaza = @Plaza AND feano = DATEPART(YEAR,@dFecha)
   IF SUBSTRING(@xFecha,3,2) = '08'
 SELECT @xCadena = feago FROM VIEW_FERIADO WHERE feplaza = @Plaza AND feano = DATEPART(YEAR,@dFecha)
   IF SUBSTRING(@xFecha,3,2) = '09'
 SELECT @xCadena = fesep FROM VIEW_FERIADO WHERE feplaza = @PLaza AND feano = DATEPART(YEAR,@dFecha)
   IF SUBSTRING(@xFecha,3,2) = '10'
  SELECT @xCadena = feoct FROM VIEW_FERIADO WHERE feplaza = @PLaza AND feano = DATEPART(YEAR,@dFecha)
   IF SUBSTRING(@xFecha,3,2) = '11'
 SELECT @xCadena = fenov FROM VIEW_FERIADO WHERE feplaza = @Plaza AND feano = DATEPART(YEAR,@dFecha)
   IF SUBSTRING(@xFecha,3,2) = '12'
 SELECT @xCadena = fedic FROM VIEW_FERIADO WHERE feplaza = @Plaza AND feano = DATEPART(YEAR,@dFecha)
 
 IF CHARINDEX(SUBSTRING(@xFecha,1,2),@xCadena) <> 0 BEGIN
                SELECT 'ERR'
                SET NOCOUNT OFF
  RETURN 12
 END
        SELECT 'OK'
        SET NOCOUNT OFF   
 RETURN
END

GO
