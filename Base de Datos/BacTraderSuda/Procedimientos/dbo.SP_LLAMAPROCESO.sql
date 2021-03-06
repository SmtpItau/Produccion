USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLAMAPROCESO]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
  
CREATE PROCEDURE [dbo].[SP_LLAMAPROCESO]  
   (    @nnumoper              NUMERIC(10,0),  
        @ctipoper              CHAR(04),  
        @nrutcart              NUMERIC(09,0),  
        @ctipo                 CHAR(01)      = '',  
        @nnumdocu              NUMERIC(10,0) =  0,  
        @correlativo           NUMERIC(05,0) =  0,  
        @parcial               CHAR(01)      = ''  
   )  
AS  
BEGIN  
  
    SET NOCOUNT ON  
  
    DECLARE @cmen               CHAR(255)  
    DECLARE @Retorno            INTEGER  
  
    SET @cmen = ''  
      
    DECLARE @IdPaquete   NUMERIC(10)  
        SET @IdPaquete   = ISNULL((SELECT Id_Paquete FROM BacParamSuda..MDLBTR WHERE sistema = 'BTR' AND numero_operacion = @nnumoper AND Estado_Paquete = 'A'),0)  
  
    IF @IdPaquete > 0  
    BEGIN  
      SELECT -4, 'OPERACION NO SE PUEDE ANULAR... ES PARTE DE UN GRUPO DE PAGO.'  
      RETURN  
    END  
  
   /* ===================================================================================== */  
   /*  CONFIRMACION DE EXISTENCIA DE GARANTIAS ASOCIADAS A LA OPERACION   (PRD-5521)             */  
   /* ===================================================================================== */  
   IF EXISTS(SELECT 1 FROM Bacparamsuda..tbl_registro_garantias  
          WHERE Sistema = 'BTR'  
  AND OperacionSistema = @nnumoper)  
   BEGIN  
 SELECT -4, 'OPERACION NO SE PUEDE ANULAR, TIENE GARANTIAS CONSTITUIDAS'  
 RETURN  
   END  
  
  
    BEGIN TRANSACTION  
  
    /*========================================================================================================*/  
    /* Anulación de Compra Propia                                                                             */  
    /*========================================================================================================*/  
    IF @ctipoper = 'CP'  
    BEGIN  
		UPDATE TBL_TICKERS_BOLSA SET ESTADO = 2 WHERE codigo_bac = @nnumoper 
	END

	IF @ctipoper = 'CP'
    BEGIN
        EXECUTE @Retorno = dbo.Sp_EliminaCP @nnumoper, @nrutcart, @cmen OUTPUT  
        IF @@ERROR <> 0  
        BEGIN  
           GOTO ErrorSQL  
        END  
        IF @Retorno = 1  
        BEGIN  
           GOTO ErrorTransaccion  
        END  
    END  
  
    /*========================================================================================================*/  
    /* Anulación de Venta Propia                                                                              */  
    /*========================================================================================================*/  
    IF @ctipoper = 'VP'  
    BEGIN  
        EXECUTE @Retorno = dbo.Sp_EliminaVP @nnumoper, @nrutcart, @cmen OUTPUT  
        IF @@ERROR <> 0  
        BEGIN  
           GOTO ErrorSQL  
        END  
        IF @Retorno = 1  
        BEGIN  
           GOTO ErrorTransaccion  
        END  
    END  
  
    /*========================================================================================================*/  
    /* Anulación de Compra con Pacto                                                                          */  
    /*========================================================================================================*/  
    IF @ctipoper = 'CI'  
    BEGIN  
        EXECUTE @Retorno = dbo.Sp_EliminaCI @nnumoper, @nrutcart, @cmen OUTPUT  
        IF @@ERROR <> 0  
        BEGIN  
           GOTO ErrorSQL  
        END  
        IF @Retorno = 1  
        BEGIN  
           GOTO ErrorTransaccion  
        END  
    END  
  
    /*========================================================================================================*/  
    /* Anulación de Venta con Pacto                                                                           */  
    /*========================================================================================================*/  
    IF @ctipoper = 'VI'  
    BEGIN  
        EXECUTE @Retorno = dbo.Sp_EliminaVI @nnumoper, @nrutcart, @cmen OUTPUT  
        IF @@ERROR <> 0  
        BEGIN  
           GOTO ErrorSQL  
        END  
        IF @Retorno = 1  
        BEGIN  
           GOTO ErrorTransaccion  
        END  
    END  
  
    /*========================================================================================================*/  
    /* Anulación de Recompra Anticipada                                                                       */  
    /*========================================================================================================*/  
    IF @ctipoper = 'RCA'  
    BEGIN  
        EXECUTE @Retorno = dbo.Sp_EliminaRCA @nnumoper, @nrutcart, @cmen OUTPUT  
        IF @@ERROR <> 0  
        BEGIN  
           GOTO ErrorSQL  
        END  
        IF @Retorno = 1  
        BEGIN  
           GOTO ErrorTransaccion  
        END  
    END  
  
    /*========================================================================================================*/  
    /* Anulación de Reventa Anticipada                             */  
    /*========================================================================================================*/  
    IF @ctipoper = 'RVA'  
    BEGIN  
        EXECUTE @Retorno = dbo.Sp_EliminaRVA @nnumoper, @nrutcart, @cmen OUTPUT  
        IF @@ERROR <> 0  
        BEGIN  
           GOTO ErrorSQL  
        END  
        IF @Retorno = 1  
        BEGIN  
           GOTO ErrorTransaccion  
        END  
   END  
  
    /*========================================================================================================*/  
    /* Anulación de FLI                                                                                       */  
    /*========================================================================================================*/  
    IF @ctipoper = 'FLI'  
    BEGIN  
        EXECUTE @Retorno = dbo.Sp_EliminaFLI @nnumoper, @nrutcart, @ctipo, @cmen OUTPUT  
        IF @@ERROR <> 0  
        BEGIN  
           GOTO ErrorSQL  
        END  
        IF @Retorno = 1  
        BEGIN  
           GOTO ErrorTransaccion  
        END  
    END  
  
    /*========================================================================================================*/  
    /* Anulación de pago de FLI                                                                               */  
    /*========================================================================================================*/  
    IF @ctipoper = 'FLIP'  
    BEGIN  
        EXECUTE @Retorno = dbo.Sp_EliminaFLI_Pagos @nnumoper,  
                                                   @nrutcart,  
                                                   @ctipo,  
                                                   @nnumdocu,  
                                                   @correlativo,  
                                                   @parcial,  
                                                   @cmen OUTPUT  
  
        IF @@ERROR <> 0  
        BEGIN  
           GOTO ErrorSQL  
        END  
        IF @Retorno = 1  
        BEGIN  
           GOTO ErrorTransaccion  
        END  
    END  
  
    IF @Retorno = 0  
    BEGIN  
        UPDATE bacparamsuda..MDLBTR  
           SET estado_envio     = 'A'  
         WHERE sistema          = 'BTR'  
           AND numero_operacion = @nnumoper  
           AND estado_envio     = 'P'  
  
        IF @@ERROR <> 0  
        BEGIN  
           GOTO ErrorSQL  
        END  
    END  
  
    COMMIT TRANSACTION  
  
    GOTO FIN  
ErrorSQL:  
    SET @cmen     = 'NO SE PUEDE ANULAR LA OPERACION'  
    SET @Retorno  = 1  
ErrorTransaccion:  
    ROLLBACK TRANSACTION  
FIN:  
    SELECT 'Mensaje' = @cmen, 'Estado' = @Retorno  
    SET NOCOUNT OFF  
END  
GO
