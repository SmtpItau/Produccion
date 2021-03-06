USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CORRESPONSALES_GRABAR]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CORRESPONSALES_GRABAR](   @rutcliente       NUMERIC(9)  
      ,@codigocliente    NUMERIC(5)  
      ,@codigomoneda     NUMERIC(5)  
      ,@codigopais       NUMERIC(5)  
      ,@codigoplaza      NUMERIC(5)   
      ,@codigoswift      VARCHAR(11)  
      ,@nombre           VARCHAR(50)   
      ,@cuentacorriente  VARCHAR(30)  
      ,@swiftsantiago    VARCHAR(10) = ' ' 
      ,@bancocentral     CHAR(1)     = ' ' 
      ,@fechavencimiento DATETIME    = ' ' 
      ,@Codigo_contable  CHAR(4)   
      ,@correlativo      NUMERIC(5)  
      ,@codigo_corres    NUMERIC(8)  
      ,@Rut_Corresponsal NUMERIC(9)
          )
AS
BEGIN
 IF  @Correlativo = 0 BEGIN 
  SET @Correlativo = ((SELECT MAX(cod_corresponsal) FROM CORRESPONSAL) + 1 )
 END 
 SET NOCOUNT ON
 
 INSERT INTO CORRESPONSAL( rut_cliente  
     ,codigo_cliente  
     ,codigo_moneda  
     ,codigo_pais  
     ,codigo_plaza  
     ,codigo_swift  
     ,nombre   
     ,cuenta_corriente 
     ,swift_santiago  
     ,banco_central  
     ,fecha_vencimiento 
     ,codigo_contable  
     ,cod_corresponsal  
     ,codigo_corres  
     ,Rut_Corresponsal
                                )    
   VALUES (  @rutcliente  
      ,@codigocliente  
      ,@codigomoneda  
      ,@codigopais  
      ,@codigoplaza    
      ,@codigoswift  
      ,@nombre   
      ,@cuentacorriente 
      ,@swiftsantiago  
      ,'N'    --@bancocentral  
      ,@fechavencimiento 
      ,@Codigo_contable 
      ,@Correlativo   
      ,@codigo_corres  
      ,@Rut_Corresponsal 
    )
 
 IF @@ERROR <> 0 
  SELECT 'error'
 ELSE 
  SELECT 'ok'   
END
-- SP_AUTORIZA_EJECUTAR 'bacuser'
GO
