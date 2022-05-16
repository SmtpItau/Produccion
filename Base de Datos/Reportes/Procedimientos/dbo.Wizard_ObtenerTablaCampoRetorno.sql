USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Wizard_ObtenerTablaCampoRetorno]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Wizard_ObtenerTablaCampoRetorno]    Script Date: 27-11-2013 18:15:02 ******/

CREATE PROCEDURE [dbo].[Wizard_ObtenerTablaCampoRetorno]
(
   @IDCAMPO INT    	
	
)

AS
BEGIN

SET NOCOUNT ON

SELECT C.BD,
       C.TABLA,
       C.CAMPORETORNO,
       C.TIPODATO 
FROM CAMPORETORNO c
WHERE C.IDCAMPO = @IDCAMPO
 

END
GO
