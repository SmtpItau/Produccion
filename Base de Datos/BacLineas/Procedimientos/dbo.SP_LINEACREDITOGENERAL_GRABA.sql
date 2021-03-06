USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_GRABA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_GRABA]  
  ( @rut_cliente    NUMERIC(9) ,  
   @codigo_cliente   NUMERIC(9) ,  
   @fechaasignacion  DATETIME ,  
   @fechavencimiento  DATETIME ,  
   @fechafincontrato  DATETIME ,  
   @bloqueado    CHAR(1)  ,  
   @totalasignado  NUMERIC(19,4) ,  
   @totalocupado    NUMERIC(19,4) ,  
   @totaldisponible  NUMERIC(19,4) ,  
   @totalexceso    NUMERIC(19,4) ,  
   @moneda   VARCHAR(3) ,  
   @totLineaThresHold	NUMERIC(19,4),
   @iMonedaThreshold	SMALLINT
  )  
AS  
BEGIN  
  
 SET NOCOUNT ON  
  
        SELECT  @moneda = Ltrim(Rtrim(@moneda))  
  
 IF EXISTS(SELECT 1 FROM LINEA_GENERAL   
                          WHERE rut_cliente    = @rut_cliente  
                            AND codigo_cliente = @codigo_cliente)  
  BEGIN  
   SELECT 'EXISTS'  
  
   UPDATE LINEA_GENERAL   
   SET fechaasignacion   = @fechaasignacion ,  
    fechavencimiento  = @fechavencimiento ,  
    fechafincontrato  = @fechafincontrato ,  
    bloqueado    = @bloqueado  ,  
    totalasignado    = @totalasignado ,  
    totalocupado    = @totalocupado  ,  
    totaldisponible   = @totaldisponible ,  
    totalexceso    = @totalexceso  ,  
    moneda   = @moneda  ,  
    Monto_Linea_Threshold           = @totLineaThresHold    ,
    iMonedaThreshold		= @iMonedaThreshold
   WHERE  rut_cliente    = @rut_cliente  
   AND     codigo_cliente = @codigo_cliente  
  
   IF @@ERROR<>0   
    BEGIN  
     SELECT 'NO ACTUALIZADO'  
    END  
   ELSE  
    BEGIN  
     SELECT 'ACTUALIZADO'  
     DELETE LINEA_SISTEMA   
     WHERE  rut_cliente    = @rut_cliente  
     AND     codigo_cliente = @codigo_cliente  
    END  
  
  END  
 ELSE  
  BEGIN  
   SELECT 'NO EXISTS'  
   INSERT INTO LINEA_GENERAL  
    ( rut_cliente  ,  
     codigo_cliente  ,  
     fechaasignacion  ,  
     fechavencimiento ,  
     fechafincontrato ,  
     bloqueado  ,  
     totalasignado  ,  
     totalocupado  ,  
     totaldisponible  ,  
     totalexceso  ,  
     moneda   ,  
     Monto_Linea_Threshold,
     iMonedaThreshold
    )  
VALUES	
 (   @rut_cliente		,
     @codigo_cliente  ,  
     @fechaasignacion ,  
     @fechavencimiento ,  
     @fechafincontrato ,  
     @bloqueado  ,  
     @totalasignado  ,  
     @totalocupado  ,  
     @totaldisponible ,  
     @totalexceso  ,  
     @moneda   ,  
     @totLineaThresHold	,
     @iMonedaThreshold
)  
   IF @@ERROR<>0   
    BEGIN  
     SELECT 'NO INSERTADO'  
    END  
   ELSE  
    BEGIN  
     SELECT 'INSERTADO'  
    END  
  
  END  
  
END
GO
