USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_ANTICIPOS_IBS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GRABA_ANTICIPOS_IBS]
   (    @IBS_FecProc      DATETIME
       ,@IBS_NumPrestamo  NUMERIC(12,0)
       ,@IBS_CodProd      VARCHAR(4)
       ,@IBS_CodFam       VARCHAR(4)
       ,@IBS_NumDerivado  NUMERIC(12,0)
       ,@IBS_cTipo        VARCHAR(1)
       ,@IBS_cTipoAnti    VARCHAR(30)
       ,@IBS_Monto        FLOAT   = 0.0
       ,@IBS_FecAnti      DATETIME          
       ,@IBS_RuCli        NUMERIC(9)
  )
  
AS
BEGIN

   SET NOCOUNT ON     
      
      INSERT INTO BacTraderSuda.dbo.TBL_ANTICIPOS_IBS
      (  FechaProceso
		,NumPrestamo
		,CodigoProducto
		,CodigoFamilia
		,NumDerivado
		,TipoDRV
        ,TipoAnticipo
		,Monto
		,FechaAnticipo
		,RutCliente
      )      
      VALUES
      ( @IBS_FecProc      
	   ,@IBS_NumPrestamo  
       ,@IBS_CodProd      
       ,@IBS_CodFam       
       ,@IBS_NumDerivado  
       ,@IBS_cTipo  
       ,@IBS_cTipoAnti       
       ,@IBS_Monto        
       ,@IBS_FecAnti 
       ,@IBS_RuCli 

      )


END
GO
