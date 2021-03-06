USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINACI]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ELIMINACI]
       ( 
         @noperacion            NUMERIC(10,0),
         @rutcart               NUMERIC(09,0),
         @mensaje               CHAR(255)       OUTPUT
       )
AS
BEGIN

    /*========================================================================================================*/
    /* chequear si la compra registra ventas                                                                  */
    /*========================================================================================================*/
    DECLARE @NumeroOperacion    NUMERIC(10,0)

     SELECT @NumeroOperacion = monumdocu
      FROM dbo.MDMO
     WHERE monumdocu         = @noperacion
       AND mostatreg         <> 'A'
       AND motipoper        in ( 'VP', 'VI' )

    IF @@ROWCOUNT <> 0
    BEGIN
        SET @mensaje = 'la operacion de compra registra tener ventas asocidas'
        RETURN 1

    END

    /*========================================================================================================*/
    /* Elimino operación en la tabla de cartera de compra con pacto (MDCI)                                    */
    /*========================================================================================================*/
    DELETE dbo.MDCI
     WHERE cinumdocu = @noperacion

    IF @@ERROR <> 0
    BEGIN
        SET @mensaje = 'No se Pudo Anular Operacion'
        RETURN 1

    END

    /*========================================================================================================*/
    /* Elimino la operación en la tabla de disponibilidad (MDDI)                                              */
    /*========================================================================================================*/
    DELETE dbo.MDDI
     WHERE dinumdocu = @noperacion

    IF @@ERROR <> 0
    BEGIN
        SET @mensaje = 'No se Pudo Anular Operacion'
        RETURN 1

    END

    /*========================================================================================================*/
    /* Elimino la operación de la tabla de cortes (MDCO)                                                      */
    /*========================================================================================================*/
    DELETE dbo.MDCO
     WHERE conumdocu = @noperacion

    IF @@ERROR <> 0
    BEGIN
        SET @mensaje = 'No se Pudo Anular Operacion'
        RETURN 1

    END

    /*========================================================================================================*/
    /* Cambia el estado de la operación a anulado en la tabla de movimiento (MDMO)                            */
    /*========================================================================================================*/
    UPDATE MDMO
       SET mostatreg = 'A'
     WHERE monumoper = @noperacion

    IF @@ERROR <> 0
    BEGIN
        SET @mensaje = 'No se Pudo Anular Operacion'
        RETURN 1

    END

    SET @mensaje = 'Operacion Fue Anulada Correctamente'
    RETURN 0

END



GO
