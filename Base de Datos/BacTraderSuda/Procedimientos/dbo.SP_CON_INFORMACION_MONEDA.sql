USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_INFORMACION_MONEDA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_INFORMACION_MONEDA]
                                        (
                                            @iMoneda    CHAR(3) ---
                                        )
AS
BEGIN

    /* AQUI CONVIERTO LA MONEDA SI SE ENVIA NUMERO
    ---------------------------------------------- */
    if ISNUMERIC(@iMoneda) = 0 BEGIN
        SELECT @iMoneda = RTRIM(CONVERT( CHAR(3) , MNCODMON )) FROM VIEW_MONEDA WHERE MNNEMO = @iMoneda
    END

    SELECT
         'CODIGO'    = mncodmon
        ,'NEMO'      = mnnemo
        ,'DECIMALES' = mndecimal
        ,'NACIONAL'  = mnextranj
    FROM VIEW_MONEDA
    WHERE MNCODMON = @iMoneda

END





GO
