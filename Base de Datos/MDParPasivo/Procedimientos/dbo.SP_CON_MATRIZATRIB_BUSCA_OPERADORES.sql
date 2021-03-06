USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_MATRIZATRIB_BUSCA_OPERADORES]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CON_MATRIZATRIB_BUSCA_OPERADORES] (@Grupo 	CHAR(10))
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

         SELECT codigo = usuario
                    ,   nombre,
                marca  =CONVERT(CHAR(2),'')
         INTO #USUARIO
         FROM USUARIO
         WHERE activo = 'S'

   	 UPDATE #USUARIO SET MARCA = 'X'
 	 FROM MATRIZ_ATRIBUCION
	 WHERE  codigo_control = @Grupo
         AND    codigo = usuario
        
         SELECT codigo,nombre,marca
         FROM #USUARIO

END

GO
