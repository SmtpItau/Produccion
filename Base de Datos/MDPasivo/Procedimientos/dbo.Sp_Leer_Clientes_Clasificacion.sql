USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_Clientes_Clasificacion]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[Sp_Leer_Clientes_Clasificacion]
AS 
BEGIN
   


   	SET DATEFORMAT DMY
	SET NOCOUNT ON

   SELECT codigo_clasificacion
      ,   descripcion
      FROM   CLIENTE_CLASIFICACION
      ORDER BY codigo_clasificacion

   SET NOCOUNT OFF
END









GO
