USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_OPERADORES]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LEER_OPERADORES]
AS
BEGIN

	select	nombre,
			usuario
	from 	VIEW_USUARIO 
	where 	tipo_usuario like '%TRADER%'

END
GO
