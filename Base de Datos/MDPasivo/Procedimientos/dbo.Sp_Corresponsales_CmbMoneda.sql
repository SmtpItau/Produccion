USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Corresponsales_CmbMoneda]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[Sp_Corresponsales_CmbMoneda]
AS
BEGIN
    SET NOCOUNT ON
    SET DATEFORMAT dmy

	SELECT  mnnemo
	   ,   	mncodmon
--           ,    mnmx
        FROM  MONEDA
	WHERE (mnmx ='C')
               AND ESTADO<>'A'
        ORDER BY mnnemo

   SET NOCOUNT OFF
END




GO
