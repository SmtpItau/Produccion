USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MntPaisPlaza_FiltroPlazaPais]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_MntPaisPlaza_FiltroPlazaPais    fecha de la secuencia de comandos: 03/04/2001 15:18:10 ******/
CREATE PROCEDURE [dbo].[Sp_MntPaisPlaza_FiltroPlazaPais] (@CODIGOPais NUMERIC(5))
                    
AS 
BEGIN
 SET NOCOUNT ON
 SELECT codigo_plaza, glosa, nombre, codigo_pais,
        'descripais'=(select PAIS.nombre from PAIS where PAIS.codigo_pais = PLAZA.codigo_pais )  
 FROM PLAZA
 WHERE codigo_pais = @CODIGOPais
 SET NOCOUNT OFF
END 






GO
