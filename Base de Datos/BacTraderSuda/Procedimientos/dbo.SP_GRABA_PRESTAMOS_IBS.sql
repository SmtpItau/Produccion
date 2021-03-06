USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PRESTAMOS_IBS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GRABA_PRESTAMOS_IBS]
   (    @IBS_FecProc      DATETIME
       ,@IBS_NumPrestamo  NUMERIC(12,0)
       ,@IBS_CodProd      VARCHAR(4)
       ,@IBS_CodFam       VARCHAR(4)
       ,@IBS_NumDerivado  NUMERIC(12,0)
       ,@IBS_cTipo        VARCHAR(1)
       ,@IBS_Fecini       DATETIME
       ,@IBS_FecVenc      DATETIME
       ,@IBS_Monto        FLOAT   = 0.0
       ,@IBS_CodTasa      VARCHAR(2)
       ,@IBS_TipoTasa     VARCHAR(35)
       ,@IBS_TasaCli      FLOAT   = 0.0 
       ,@IBS_Spread       FLOAT   = 0.0
       ,@IBS_Moneda       VARCHAR(3)
       ,@IBS_RuCli        VARCHAR(9)
       ,@IBS_TipoPlazo    VARCHAR(1)
       ,@IBS_Plazo        NUMERIC(4,0)
       ,@IBS_cEstadoOper  VARCHAR(7)

  )
  
AS
BEGIN

   SET NOCOUNT ON     
      

      INSERT INTO BacTraderSuda.dbo.TBL_PRESTAMOS_IBS
      (  FechaProceso
		,NumPrestamo
		,CodigoProducto
		,CodigoFamilia
		,NumDerivado
		,Tipo
		,FechaInicio
		,FechaVencimiento
		,Monto
		,CodigoTasa
		,TipoTasa
		,TasaCliente
		,Spread
		,MonedaPrestamo
		,RutCliente
		,TipoPlazo
		,Plazo
		,EstadoOperacion

      )      
      VALUES
      ( @IBS_FecProc      
	   ,@IBS_NumPrestamo  
       ,@IBS_CodProd      
       ,@IBS_CodFam       
       ,@IBS_NumDerivado  
       ,@IBS_cTipo  
       ,@IBS_Fecini       
       ,@IBS_FecVenc      
       ,@IBS_Monto        
       ,@IBS_CodTasa      
       ,@IBS_TipoTasa     
       ,@IBS_TasaCli      
       ,@IBS_Spread       
       ,@IBS_Moneda       
       ,@IBS_RuCli        
       ,@IBS_TipoPlazo    
       ,@IBS_Plazo        
       ,@IBS_cEstadoOper



      )


END
GO
