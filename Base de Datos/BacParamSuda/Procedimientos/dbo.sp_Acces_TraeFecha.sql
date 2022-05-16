USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_Acces_TraeFecha]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_Acces_TraeFecha]  
  
AS  
/***********************************************************************  
NOMBRE         : dbo.[sp_Acces_TraeFecha].StoredProcedure.sql  
AUTOR          : SONDA (Unidad de Desarrollo)  
FECHA CREACION : 09/08/2011  
DESCRIPCION    : Migracion a SQL 2008  
HISTORICO DE CAMBIOS  
FECHA        AUTOR           DESCRIPCION     
----------------------------------------------------------------------  
  
  
**********************************************************************/  
  
BEGIN  
   
 SET NOCOUNT ON  
  
 SELECT  acfecante,  
  acfecproc,  
  acfecprox   
 FROM VIEW_MDAC  
  
  
 SET NOCOUNT OFF  
  
END  
GO
