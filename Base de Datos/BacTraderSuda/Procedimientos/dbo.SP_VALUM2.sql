USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALUM2]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALUM2]
                          ( @cCodmon  VARCHAR(04),
                            @dFecha   DATETIME   )
AS
BEGIN
  IF @cCodmon = '$$' or @cCodmon='CLP'--o CLP
    SELECT 1.0
  ELSE
    SELECT vmvalor FROM VIEW_VALOR_MONEDA
           WHERE view_valor_moneda.vmfecha=@dFecha
           AND vmcodigo=(SELECT mncodmon FROM VIEW_MONEDA WHERE mnsimbol=@cCodmon)
END

GO
