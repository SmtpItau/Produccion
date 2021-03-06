USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_UPDATE_VALEVISTAS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[SP_SADP_UPDATE_VALEVISTAS]  
 ( @SISTEMA VARCHAR(4), @NUMOPER NUMERIC(10), @NUMVALEVISTA NUMERIC(10),@MENSAJE VARCHAR(30))  
AS  
BEGIN  
 UPDATE SADP_DETALLE_PAGOS   
  SET   
  vNumTransferencia = @NUMVALEVISTA  
  ,cObservaciones = @MENSAJE  
	WHERE Id_Detalle_Pago= @NUMOPER
   AND cModulo    = @SISTEMA  
  
       
	IF @@ERROR<>0 	
  SELECT 1 ;  
 ELSE   
  SELECT 0 ;    
   
END  
GO
