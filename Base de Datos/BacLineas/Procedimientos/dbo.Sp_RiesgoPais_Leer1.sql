USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_RiesgoPais_Leer1]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_RiesgoPais_Leer1    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_RiesgoPais_Leer1    fecha de la secuencia de comandos: 14/02/2001 09:58:31 ******/
crEAte procedure [dbo].[Sp_RiesgoPais_Leer1]
as
begin
SELECT * FROM  RIESGO_PAIS 
end 






GO
