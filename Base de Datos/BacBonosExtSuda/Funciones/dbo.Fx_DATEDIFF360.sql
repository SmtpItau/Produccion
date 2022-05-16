USE [BacBonosExtSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_DATEDIFF360]    Script Date: 11-05-2022 16:40:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[Fx_DATEDIFF360] (
    @fromDate   date,   --- Start date
    @toDate     date,   --- End date
    @european   bit=0   --- 0=US NASD, 1=European
)
RETURNS int             --- The number of 30/360 days
WITH SCHEMABINDING
AS

BEGIN
    --- Split year, month and day into separate variables:
    DECLARE @y1 smallint=DATEPART(yy, @fromDate), @y2 smallint=DATEPART(yy, @toDate),
            @m1 smallint=DATEPART(mm, @fromDate), @m2 smallint=DATEPART(mm, @toDate),
            @d1 smallint=DATEPART(dd, @fromDate), @d2 smallint=DATEPART(dd, @toDate);

    --- US: If both from and to dates are last day of february, set @d2 to 30.
    IF (@european=0 AND
        @m1=2 AND DATEPART(dd, DATEADD(dd, 1, @fromDate))=1 AND
        @m2=2 AND DATEPART(dd, DATEADD(dd, 1, @toDate))=1)
        SET @d2=30;

    --- US: If from date is last of february, set @d1=30.
    IF (@european=0 AND @m1=2 AND DATEPART(dd, DATEADD(dd, 1, @fromDate))=1)
        SET @d1=30;

    --- US: If @d1 is 30 or 31 and @d2 is 31, set @d2 to 30
    ---     If @d1 is 31, set @d1 to 30.
    IF (@european=0 AND @d2>30 AND @d1>=30) SET @d2=30;
    IF (@european=0 AND @d1>30)             SET @d1=30;

    --- European: Starting and ending dates on the 31st become the 30th.
    IF (@european=1 AND @d1=31) SET @d1=30;
    IF (@european=1 AND @d2=31) SET @d2=30;

    --- Add it all together and return:
    RETURN 360*(@y2-@y1) + 30*(@m2-@m1) + (@d2-@d1);
END
GO
