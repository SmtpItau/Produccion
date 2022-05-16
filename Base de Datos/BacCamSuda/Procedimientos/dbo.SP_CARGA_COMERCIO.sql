USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_COMERCIO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CARGA_COMERCIO]
AS 
BEGIN
   SELECT 
          fecha                       
         ,comercio 
         ,concepto 
         ,glosa                                                        
         ,tipo_documento 
         ,codigo_oma 
         ,codigo_planilla 
         ,pais_remesa 
      FROM VIEW_CODIGO_COMERCIO
   
END
-- Sp_Carga_Oma 110



GO
