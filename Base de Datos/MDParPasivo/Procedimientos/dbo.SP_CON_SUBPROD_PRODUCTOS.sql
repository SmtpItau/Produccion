USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_SUBPROD_PRODUCTOS]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CON_SUBPROD_PRODUCTOS]
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

       SELECT P.id_sistema
            , S.nombre_sistema
            , P.codigo_producto
            , P.descripcion
        FROM PRODUCTO P
            ,SISTEMA  S
        WHERE P.id_sistema = S.id_sistema
        ORDER BY P.id_sistema
                ,P.codigo_producto

       SET NOCOUNT OFF
END
GO
