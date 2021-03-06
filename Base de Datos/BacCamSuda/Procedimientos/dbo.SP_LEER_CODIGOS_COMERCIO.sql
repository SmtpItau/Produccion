USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CODIGOS_COMERCIO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEER_CODIGOS_COMERCIO] (
                                               @Comercio CHAR(6),
                                               @Concepto CHAR(3)
                                              )
AS
BEGIN
     SET NOCOUNT ON
     SELECT 'fecha' = CONVERT(CHAR(8),fecha,112)
           ,codigo_relacion  
           ,concepto         
           ,glosa         
           ,tipo_documento 
           ,codigo_OMA    
           ,estadistica   
           ,ventanas      
           ,pais_remesa   
           ,rut_bcch      
       FROM Codigo_Comercio
      WHERE (@Comercio = '' OR @Comercio = codigo_relacion) 
      --  AND (@Concepto = '' OR @Concepto = concepto)
      ORDER BY codigo_relacion
END

GO
