USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALUM]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALUM]
                         ( @nCodmon  INTEGER        ,
                           @dFecha   DATETIME       ,
                           @fValmon  FLOAT   OUTPUT )
AS
BEGIN
       IF @nCodmon = 999                   -- Nota1.-
            SELECT @fValmon = 1.0
       ELSE
            SELECT @fValmon = view_valor_moneda.vmvalor
                   FROM VIEW_VALOR_MONEDA
                   WHERE view_valor_moneda.vmcodigo = @nCodmon AND
                         view_valor_moneda.vmfecha  = @dFecha
END

GO
