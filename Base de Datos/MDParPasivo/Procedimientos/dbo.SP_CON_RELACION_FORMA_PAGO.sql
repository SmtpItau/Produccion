USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_RELACION_FORMA_PAGO]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CON_RELACION_FORMA_PAGO](@id_sistema CHAR(03)='BTR')
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

        SELECT	Codigo, Descripción  
        FROM	RELACION_FORMA_PAGO
	WHERE	id_sistema = @id_sistema
END


GO
