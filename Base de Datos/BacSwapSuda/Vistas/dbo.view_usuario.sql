USE [BacSwapSuda]
GO
/****** Object:  View [dbo].[view_usuario]    Script Date: 13-05-2022 11:17:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[view_usuario]
AS 

   SELECT	Usuario    	,
		Clave           ,
		Nombre          ,                         
		Tipo_Usuario    ,
		Fecha_Expira    ,           
		Cambio_Clave	,
		Bloqueado	,
		Reset_Psw

	FROM bacparamsuda..Usuario

GO
