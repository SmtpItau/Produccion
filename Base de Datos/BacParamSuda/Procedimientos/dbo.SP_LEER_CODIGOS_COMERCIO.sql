USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CODIGOS_COMERCIO]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEER_CODIGOS_COMERCIO] (
                                               @Comercio CHAR(6)
                                              ,@Concepto CHAR(3)
                                              )
AS
BEGIN
     SET NOCOUNT ON
     SELECT  'fecha' = CONVERT(CHAR(8),fecha,112) 
            ,codigo_relacion
            ,concepto       
            ,glosa          
            ,tipo_documento 
            ,codigo_OMA    
            ,estadistica   
            ,ventanas      
            ,pais_remesa   
            ,rut_bcch      
       FROM  Codigo_Comercio
      WHERE (@Comercio = '' OR LTRIM(@Comercio) = codigo_relacion ) AND
            (@concepto = '' OR concepto = @concepto)
END
GO
