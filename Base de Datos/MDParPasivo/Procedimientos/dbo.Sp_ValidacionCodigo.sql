USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ValidacionCodigo]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ValidacionCodigo]
		(	@clrut		numeric(9)=0)
			
			
AS			
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

	SELECT  CLIENTE.clcodigo
               
	FROM   	CLIENTE

	WHERE  	(CLIENTE.clrut= @clrut)
	
END 









GO
