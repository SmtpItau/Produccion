USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_PRODUCTO]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_PRODUCTO](
                                @id_sistema         CHAR(3)
                               )
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

    SELECT 
         Id_Sistema
        ,Codigo_Producto
        ,Descripcion
        ,Contabiliza
        ,Gestion
    FROM PRODUCTO
    WHERE Id_Sistema = @id_sistema

END



GO
