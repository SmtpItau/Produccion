USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_PLAZOS_INFORME_CARTERA]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_CON_PLAZOS_INFORME_CARTERA]
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

        SELECT Plazo_Desde, Plazo_Hasta ,Tipo_Plazo 
        FROM PLAZO_INFORME_CARTERA
END


GO
