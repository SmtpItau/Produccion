USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_GRABA_MOVIMIENTOS_MANUALES]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_GRABA_MOVIMIENTOS_MANUALES]  
    ( @id_Transaccion  NUMERIC(15)  
    , @dFechaMovto  DATETIME    
    , @sOrigen   VARCHAR(05)    
    , @Movimiento   VARCHAR(01)   
    , @Tipo_Operacion  VARCHAR(50)   
    , @RutCliente   INT      
				,	@iCodSec			TINYINT
    , @sNombreCliente  VARCHAR(60)    
    , @iFormadPago  SMALLINT    
    , @Monto    NUMERIC(21,4)  
    , @sMoneda   SMALLINT    
    , @iBanco    NUMERIC(10)  
    , @sCuenta   VARCHAR(40)    
    ,   @iRutB    INT  
    ,   @sDvB    VARCHAR(1)  
    , @sBeneficiario  VARCHAR(40)    
    , @sUserNT   VARCHAR(20)   
    )  
AS  
BEGIN  
   
  
  INSERT INTO   
  dbo.SADP_MOVIMIENTOS_MANUALES  
    ( idTX_Carga    
    , dFechaCarga  
    , dFechaMovto    
    , sOrigen  
    , Movimiento    
    , Tipo_Operacion   
    , RutCliente     
				,	CodCliente   
    , sNombreCliente    
    , iFormadPago     
    , Monto     
    , sMoneda      
    , iBanco      
    , sCuenta      
    , sBeneficiario   
    ,   iRutBeneficiario  
    ,   sDvBeneficiario  
    , idNumeroSistema  
    , sUserNT     
    , sUserAutoriza    
    )  
   VALUES  
    ( @id_Transaccion  
    , CONVERt(DATETIME,(CONVERT(CHAR(10),GETDATE(),112)))   
    , @dFechaMovto   
    , @sOrigen    
    , @Movimiento   
    , substring(@Tipo_Operacion,1,5)   
    , @RutCliente      
				,	@iCodSec	
    , @sNombreCliente    
    , @iFormadPago    
    , @Monto  
    , @sMoneda    
    , @iBanco    
    , @sCuenta   
    , @sBeneficiario  
    ,   @iRutB  
    ,   @sDvB  
    , 0    
    , @sUserNT   
    , ''    
    )  
  
END  
GO
