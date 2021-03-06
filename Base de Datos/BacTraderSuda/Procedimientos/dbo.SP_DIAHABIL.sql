USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DIAHABIL]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DIAHABIL] (@dfecha DATETIME OUTPUT )
AS
BEGIN
 set nocount on
   DECLARE @cdiai          CHAR(15) ,
           @cdia           CHAR(15) ,
           @cdiae          CHAR(15) ,
           @csw            CHAR(01) ,
           @ccampo         CHAR(05) ,
           @cstrexec       VARCHAR(255) ,
           @cferiado       VARCHAR(255) ,
           @cplaza         INTEGER,
           @cdiahoy        CHAR(02)
   DECLARE @nmonth         INTEGER ,
           @ncontrol       INTEGER ,
           @nano           INTEGER,
           @nposi          INTEGER
   SELECT @ncontrol       =  1
   SELECT @csw            = '0'
   SELECT @cplaza         = Folio FROM GEN_FOLIOS WHERE Codigo = 'PLAZA_CHIL'
   WHILE @ncontrol = 1
   BEGIN
        SELECT  @cdiai   = DATENAME(WEEKDAY,@dfecha)
        SELECT  @cdia    = UPPER( @cdiai )
        IF  @cdia = 'MONDAY'    SELECT @cdiae = 'LUNES'
        IF  @cdia = 'TUESDAY'   SELECT @cdiae = 'MARTES'
        IF  @cdia = 'WEDNESDAY' SELECT @cdiae = 'MIERCOLES'
        IF  @cdia = 'THURSDAY'  SELECT @cdiae = 'JUEVES'
        IF  @cdia = 'FRIDAY'    SELECT @cdiae = 'VIERNES'
        IF  @cdia = 'SATURDAY'  SELECT @cdiae = 'SABADO'
        IF  @cdia = 'SUNDAY'    SELECT @cdiae = 'DOMINGO'
        IF  @cdiae = 'DOMINGO' OR  @cdiae = 'SABADO'   BEGIN
           SELECT @dfecha = DATEADD( DAY, 1, @dfecha )
           SELECT  @csw = '1'
        END
        IF  @csw = '0'  BEGIN
           SELECT @cdiahoy = CONVERT( CHAR(02), DATEPART( DAY, @dfecha ) )
           IF  CONVERT( INT, @cdiahoy ) < 10  SELECT @cdiahoy = '0' + LTRIM( @cdiahoy )
           SELECT @nMonth  = DATEPART(month, @dfecha )
           SELECT @nAno    = DATEPART(year , @dfecha)
           IF @nmonth = 01 SELECT @cferiado = feene FROM VIEW_FERIADO WHERE  feplaza = @cplaza AND feano = @nAno
           IF @nmonth = 02 SELECT @cferiado = fefeb FROM VIEW_FERIADO WHERE  feplaza = @cplaza AND feano = @nAno
           IF @nmonth = 03 SELECT @cferiado = femar FROM VIEW_FERIADO WHERE  feplaza = @cplaza AND feano = @nAno
           IF @nmonth = 04 SELECT @cferiado = feabr FROM VIEW_FERIADO WHERE  feplaza = @cplaza AND feano = @nAno
           IF @nmonth = 05 SELECT @cferiado = femay FROM VIEW_FERIADO WHERE  feplaza = @cplaza AND feano = @nAno
           IF @nmonth = 06 SELECT @cferiado = fejun FROM VIEW_FERIADO WHERE  feplaza = @cplaza AND feano = @nAno
           IF @nmonth = 07 SELECT @cferiado = fejul FROM VIEW_FERIADO WHERE  feplaza = @cplaza AND feano = @nAno
           IF @nmonth = 08 SELECT @cferiado = feago FROM VIEW_FERIADO WHERE  feplaza = @cplaza AND feano = @nAno
           IF @nmonth = 09 SELECT @cferiado = fesep FROM VIEW_FERIADO WHERE  feplaza = @cplaza AND feano = @nAno
           IF @nmonth = 10 SELECT @cferiado = feoct FROM VIEW_FERIADO WHERE  feplaza = @cplaza AND feano = @nAno
           IF @nmonth = 11 SELECT @cferiado = fenov FROM VIEW_FERIADO WHERE  feplaza = @cplaza AND feano = @nAno
           IF @nmonth = 12 SELECT @cferiado = fedic FROM VIEW_FERIADO WHERE  feplaza = @cplaza AND feano = @nAno
           IF  LTRIM(@cdiahoy) = SUBSTRING( @cferiado,CHARINDEX( @cdiahoy, RTRIM(@cferiado)),2) BEGIN
              SELECT @dfecha = DATEADD( DAY, 1, @dfecha )     END
           ELSE    BREAK
        END
        SELECT  @csw= '0'
   END
END

GO
