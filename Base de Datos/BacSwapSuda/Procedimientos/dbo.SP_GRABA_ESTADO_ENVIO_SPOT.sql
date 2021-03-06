USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_ESTADO_ENVIO_SPOT]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GRABA_ESTADO_ENVIO_SPOT]
  (   @NumOpe      NUMERIC(8)   
    , @EstadoEnvio INTEGER
   )  
AS   
BEGIN  
  
  SET NOCOUNT ON  
  DECLARE    
           @dFechaAnterior DATETIME ,   
           @dFechaProceso  DATETIME ,
           @dFechaProxima DATETIME 
  
   --------------------------<< Valida existencia de Swap


  SELECT     @dFechaAnterior   = fechaant  
       ,     @dFechaProceso    = fechaproc  
       ,     @dFechaProxima    = fechaprox  
  FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock)  


   


        UPDATE FLUJOS_VCTOS_SPOT 
	    SET   EstadoEnvio = @EstadoEnvio
		WHERE NumeroOperacion  = @NumOpe   
        AND   FechaProceso     = @dFechaProceso  

     
        IF  @@ROWCOUNT <> 0
        BEGIN
            SELECT 'SI',@NumOpe
            RETURN 0
        END
        ELSE 
        BEGIN 
            SELECT 'NO',@NumOpe
            RETURN -3
        END


END  
GO
