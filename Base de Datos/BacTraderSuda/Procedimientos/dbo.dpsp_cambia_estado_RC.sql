USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[dpsp_cambia_estado_RC]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[dpsp_cambia_estado_RC] (@noper VARCHAR(50), @ncertificado varchar(13))  
AS  
/***********************************************************************  
NOMBRE         : dbo.dpsp_cambia_estado_RC.StoredProcedure.sql  
AUTOR          : SONDA (Unidad de Desarrollo)  
FECHA CREACION : 09/08/2011  
DESCRIPCION    : Migracion a SQL 2008  
HISTORICO DE CAMBIOS  
FECHA        AUTOR           DESCRIPCION     
----------------------------------------------------------------------  
  
  
**********************************************************************/  
  
begin   
  
BEGIN TRAN  
UPDATE GEN_CAPTACION  
 SET Id_Compra = 'T'  
 WHERE numero_operacion = @noper and numero_certificado_dcv = convert(numeric(13),@ncertificado)
COMMIT TRAN  
  
end  

GO
