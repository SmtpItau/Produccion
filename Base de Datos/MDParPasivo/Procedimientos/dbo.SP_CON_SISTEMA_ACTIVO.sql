USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_SISTEMA_ACTIVO]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_CON_SISTEMA_ACTIVO](@id_sistema CHAR(3))	
AS
BEGIN
	
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
        SET DATEFORMAT dmy
        
        SELECT nombre_sistema,activo=UPPER(activo)
        FROM SISTEMA  WITH (NOLOCK)
        WHERE  id_sistema = @id_sistema
	
END







GO
