USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAIS_MONEDA_BCCH]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PAIS_MONEDA_BCCH]
AS
BEGIN
        SELECT glosa , codigo_numerico 
 FROM VIEW_AYUDA_PLANILLA 
 WHERE codigo_tabla = 11   ORDER BY glosa
END

GO
