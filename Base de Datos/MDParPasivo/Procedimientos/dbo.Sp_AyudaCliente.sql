USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_AyudaCliente]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_AyudaCliente]

AS BEGIN

	SET NOCOUNT ON
        SET DATEFORMAT dmy

	SELECT 'RUT'=STR(clrut) + '-' + cldv, clcodigo,clnombre , STR(clrut),cldv  FROM CLIENTE
         ORDER BY clnombre

        
	SET NOCOUNT OFF

END





GO
