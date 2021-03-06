USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[dpsp_Actualiza_Certificado]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[dpsp_Actualiza_Certificado] (@omd VARCHAR(50), @nCorrela INTEGER, @vCertificado VARCHAR(15) )  
AS  
/***********************************************************************  
NOMBRE         : dbo.dpsp_Actualiza_Certificado.StoredProcedure.sql  
AUTOR          : SONDA (Unidad de Desarrollo)  
FECHA CREACION : 09/08/2011  
DESCRIPCION    : Migracion a SQL 2008  
HISTORICO DE CAMBIOS  
FECHA        AUTOR           DESCRIPCION     
----------------------------------------------------------------------  
  
  
**********************************************************************/  
  
begin  
   
 If Exists(Select 1 from GEN_CAPTACION Where numero_operacion = @omd and correla_operacion = @nCorrela)  
BEGIN  
  Select 'OK' as respuesta  
  
END  
 If Exists(Select 1 from GEN_CAPTACION Where numero_operacion = @omd and correla_operacion = @nCorrela)  
BEGIN  
BEGIN TRAN  
  UPDATE GEN_CAPTACION  
  SET numero_certificado_dcv = CONVERT(NUMERIC(10),@vCertificado)  
  WHERE numero_operacion = @omd AND correla_operacion = @nCorrela   
COMMIT TRAN  
  
END  
ELSE  
BEGIN  
  Select 'NO' as respuesta  
  
END  
  
end  

GO
