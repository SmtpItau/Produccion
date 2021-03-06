USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_Plazos]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Graba_Plazos]
                        (
                             @Cartera            NUMERIC(01,00),
                             @Instrumento        CHAR(10),
                             @Plazo_minimo       NUMERIC(06), 
                             @Plazo_maximo       NUMERIC(06)
                         )
AS

BEGIN

SET NOCOUNT ON

IF @Cartera <> 0 AND @Instrumento <> ''''
BEGIN
    IF EXISTS (SELECT * FROM TBLimper WHERE cartera = @Cartera AND instrumento = @Instrumento)
        BEGIN
        UPDATE TBLimper
        SET Plazo_minimo = @Plazo_minimo,
            Plazo_maximo = @Plazo_maximo
        WHERE cartera = @cartera AND instrumento = @Instrumento
    END
    ELSE
    BEGIN
        INSERT TBLimper (Cartera, Instrumento, Plazo_minimo,Plazo_maximo)
        VALUES          (@Cartera,@Instrumento,@Plazo_minimo,@Plazo_maximo)
    END
END

/*Actualiza plazo Residual MDAC*/

--IF @Plazo_Residual > 0 --and @Cartera = 1 
--BEGIN
--    UPDATE VIEW_MDAC
--    SET acplazoafs = @Plazo_Residual

--END

SET NOCOUNT OFF

END
GO
