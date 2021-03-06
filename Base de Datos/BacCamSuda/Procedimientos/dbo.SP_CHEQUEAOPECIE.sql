USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHEQUEAOPECIE]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CHEQUEAOPECIE]
            ( @ENTIDAD  CHAR(2),
              @POS      NUMERIC(2) )
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @DIG CHAR(9)
    SELECT  @DIG = aclogdig  FROM MEAC  WHERE acentida = @ENTIDAD
    IF @POS = 7
    BEGIN
        IF SUBSTRING(@DIG,8,2) <>  '00'
           SELECT @DIG = 'N'
        ELSE
           BEGIN
               UPDATE MEAC SET
                      aclogdig = SUBSTRING(aclogdig,1,6) + '1' + SUBSTRING(aclogdig,8,2)
               SELECT @DIG = 'S'
           END
    END
    SELECT @DIG
    SET NOCOUNT OFF
END 




GO
