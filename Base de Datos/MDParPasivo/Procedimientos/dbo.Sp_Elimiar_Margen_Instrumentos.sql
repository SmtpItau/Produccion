USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Elimiar_Margen_Instrumentos]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Elimiar_Margen_Instrumentos]
                 (
                  @cartera NUMERIC(9) 
                  )
AS
BEGIN
       SET DATEFORMAT dmy   
  
       DELETE FROM  MARGEN_INVERSION_INSTRUMENTO WHERE rut_cartera=@cartera
END  

--SELECT * FROM INSTRUMENTO










GO
