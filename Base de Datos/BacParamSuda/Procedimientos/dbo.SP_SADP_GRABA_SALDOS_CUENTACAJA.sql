USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_GRABA_SALDOS_CUENTACAJA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_GRABA_SALDOS_CUENTACAJA]  
 ( @dFechaProceso   DATETIME  
 , @iRutCliente   INT  
	,   @iCodCliente			TINYINT
 , @fMontoSaldo   NUMERIC(21,0)   
 )  
AS  
BEGIN  
   
 INSERT INTO SADP_CUENTA_CAJA  
 ( iRutCliente  
 , iCodCliente  
 , dFechaSaldo  
 , fMontoSaldo  
 )  
 VALUES  
 ( @iRutCliente  
	,	@iCodCliente
 , @dFechaProceso  
 , @fMontoSaldo   
 )  
  
END   
GO
