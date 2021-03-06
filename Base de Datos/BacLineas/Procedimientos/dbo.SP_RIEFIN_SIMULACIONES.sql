USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_SIMULACIONES]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_SIMULACIONES]  
     ( @Metodologia NUMERIC(3) = 0  
     , @NroMaximoSimulaciones NUMERIC(5) = 40 )  
  
As   
-- SP_RIEFIN_SIMULACIONES 3 , 299
-- SP_RIEFIN_SIMULACIONES 3 , 50  
BEGIN   
  SET NOCOUNT ON      
  IF @Metodologia = 3   
  BEGIN  
      
    SELECT 'Numero_Simulaciones'  = CASE WHEN @NroMaximoSimulaciones > NumeroSimulaciones - 1  
                                         THEN @NroMaximoSimulaciones - 1  
                                         ELSE NumeroSimulaciones - 1  
                                    END   
                    FROM BacTraderSuda..MDAC    
  END  
  ELSE   
  BEGIN  
     SELECT 'Numero_Simulaciones'  = 2  
  
  END            
  
END
GO
