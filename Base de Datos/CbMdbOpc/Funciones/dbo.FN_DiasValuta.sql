USE [CbMdbOpc]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_DiasValuta]    Script Date: 16-05-2022 10:14:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[FN_DiasValuta]
       (
         @Fecha    datetime,
         @Dias     int,
         @Plaza    int
       )
RETURNS DATETIME
AS
BEGIN

    DECLARE @Result              DATETIME

    SET @Result = @Fecha

    IF @Dias > 0
    BEGIN
        WHILE (@Dias > 0)
        BEGIN
            SET @Dias = @Dias - 1
            SET @Result = dbo.FN_Proximo_Dia_Habil(@Result, @Plaza)
        END

    END

    RETURN @Result

END

GO
