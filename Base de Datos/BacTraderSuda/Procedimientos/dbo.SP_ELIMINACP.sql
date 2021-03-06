USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINACP]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[SP_ELIMINACP]  
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
    DECLARE @NumeroOperacion    NUMERIC(10,0)    ,  
            @fecant             DATETIME         ,  
            @fecproc            DATETIME           
  
    SELECT  @fecant  = acfecante     ,  
            @fecproc = acfecproc  
    FROM    mdac  
  
    SELECT @NumeroOperacion = monumdocu  
      FROM dbo.MDMO  
     WHERE monumdocu  = @noperacion  
       AND mostatreg  <> 'A'  
       AND motipoper in ( 'VP', 'VI', 'FLI' )    -- <== Hay que agregar los FLI !!!  
  
    IF @@ROWCOUNT <> 0  
    BEGIN  
        SET @mensaje = 'la operación de compras registra tener ventas o FLI asociadas a los instrumentos que ' +  
                       'componen la operación que esta anulando'  
        RETURN 1  
  
    END  
  
    /*========================================================================================================*/  
    /* Elimino operación en la tabla de cartera propia (MDCP)                                                 */  
    /*========================================================================================================*/  
    DELETE dbo.MDCP  
     WHERE cpnumdocu = @noperacion  
  
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
    /* Elimino la operación de la tabla de pago mañana si la operacion es anulada en el dia (MDMOPM			  */  
	/* +++ VBF  por contingencia 05102018*/
    /*========================================================================================================*/  
	 IF EXISTS (SELECT 1 FROM MDMOPM, MDAC WHERE monumoper = @noperacion  AND mofecpro=acfecproc )     
	 BEGIN 
		DELETE FROM dbo.mdmopm WHERE monumoper = @noperacion  
		IF @@ERROR <> 0  
		BEGIN  
			SET @mensaje = 'No se Pudo Anular Operacion'  
			RETURN 1  
		END  
	END  
	/* --- VBF  por contingencia 05102018*/
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
       SET mostatreg= 'A'  
     WHERE monumoper = @noperacion  
     
    IF @@ERROR <> 0  
    BEGIN  
        SET @mensaje = 'No se Pudo Anular Operacion'  
        RETURN 1  
  
    END  
  
    /*========================================================================================================*/  
    /* Anulo en tabla MDMOPM                                                                                  */  
    /*========================================================================================================*/  
    UPDATE MDMOPM  
       SET mostatreg= 'A'    ,  
           --> VB 10/07/2018  mocondpacto= CASE WHEN mofecpro = @fecant THEN 'X' ELSE 'H' END  
           mocondpacto= CASE WHEN mofecpro <= @fecant THEN 'X' ELSE 'H' END  
     WHERE monumoper = @noperacion  
  
    IF @@ERROR <> 0  
    BEGIN  
        SET @mensaje = 'No se Pudo Anular Operacion'  
        RETURN 1  
  
    END   

    IF EXISTS (SELECT 1 FROM MDMOPM WHERE monumoper = @noperacion  AND mostatreg ='A')     
    BEGIN  
        DELETE dbo.MDRS   
        WHERE rsnumdocu = @noperacion  
          AND rsfecha   = @fecproc  
  
        IF @@ERROR <> 0  
        BEGIN  
            SET @mensaje = 'No se Pudo Anular Operacion'  
            RETURN 1  
        END  
  
    END  
  
    /*========================================================================================================*/  
    /* Elimino tabla de cartera MDNS                                                                          */  
    /*========================================================================================================*/  
    DELETE VIEW_NOSERIE  
     WHERE nsnumdocu = @noperacion  
     
    IF @@ERROR <> 0  
    BEGIN  
        SET @mensaje = 'No se Pudo Anular Operacion'  
        RETURN 1  
  
    END  
  
    SET @mensaje = 'Operacion Fue Anulada Correctamente'  
    RETURN 0  
  
END  
GO
