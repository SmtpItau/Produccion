USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_PERFILESVARIABLES]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCAR_PERFILESVARIABLES]  
   (   @folio_perfil    NUMERIC(10)  
   ,   @correlativo     NUMERIC(10)  
   ,   @perfil          NUMERIC(10)  
   )  
AS  
BEGIN  
   SET NOCOUNT ON  
  
   SELECT valor, cuenta, descripcion ,*  
     FROM PASO_CNT  
    WHERE perfil = @PERFIL  
  
END  
GO
