USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEER_ROLES]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEER_ROLES]  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   SELECT codigo  = id_rol
      ,   glosa   = Descripcion
   FROM   BacparamSuda.dbo.SADP_ROLES  
  
END
GO
