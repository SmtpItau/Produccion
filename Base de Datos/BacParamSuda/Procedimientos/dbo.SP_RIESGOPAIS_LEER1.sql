USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIESGOPAIS_LEER1]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_RIESGOPAIS_LEER1    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_RIESGOPAIS_LEER1    fecha de la secuencia de comandos: 14/02/2001 09:58:31 ******/
CREATE PROCEDURE [dbo].[SP_RIESGOPAIS_LEER1]
as
begin
SELECT * FROM  RIESGO_PAIS 
end 

GO
