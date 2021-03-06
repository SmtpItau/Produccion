USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_COMERCIO_EMPR]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CARGA_COMERCIO_EMPR](
                                    @Codigo NUMERIC(3)
                                  )
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
     WHERE codigo_oma = @Codigo
   
END
-- Sp_Carga_Oma 110



GO
