USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNTPAISPLAZA_BUSCARPLAZA]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_MntPaisPlaza_BuscarPlaza    fecha de la secuencia de comandos: 03/04/2001 15:18:10 ******/
CREATE PROCEDURE [dbo].[SP_MNTPAISPLAZA_BUSCARPLAZA]( @CODIGOPLAZA NUMERIC(5))
                    
AS 
BEGIN
 SET NOCOUNT ON
 SELECT codigo_plaza, glosa, nombre, codigo_pais,
        'descripais'=(select PAIS.nombre from PAIS where PAIS.codigo_pais = PLAZA.codigo_pais )  
 FROM PLAZA
 WHERE codigo_plaza = @CODIGOPLAZA
 SET NOCOUNT OFF
END 

GO
