USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Mostrar_Pais]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_Mostrar_Pais]
 ( @codigo_pais CHAR(5)='')
AS
BEGIN
 IF @codigo_pais ='' BEGIN
    SELECT codigo_pais, nombre,cod_bcch FROM PAIS ORDER BY nombre
 END
 ELSE BEGIN
    SELECT codigo_pais, nombre,cod_bcch FROM PAIS
  WHERE codigo_pais = @codigo_pais
   ORDER BY nombre
 END
END






GO
