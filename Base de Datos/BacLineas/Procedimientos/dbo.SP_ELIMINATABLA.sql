USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINATABLA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_ELIMINATABLA    fecha de la secuencia de comandos: 03/04/2001 15:18:02 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_ELIMINATABLA    fecha de la secuencia de comandos: 14/02/2001 09:58:25 ******/
CREATE PROCEDURE [dbo].[SP_ELIMINATABLA](@tbcateg   NUMERIC(5),
                              @tbcodigo1 CHAR   (6))
        /* @tbtasa    NUMERIC(3),
         @tbfecha   DATETIME)*/
                  
AS
BEGIN
      SET NOCOUNT ON
 DELETE TABLA_GENERAL_DETALLE 
 WHERE tbcateg = @tbcateg 
 AND tbcodigo1 = @tbcodigo1 /*AND tbtasa = @tbTasa AND tbfecha = @tbfecha*/
    SET NOCOUNT OFF
    SELECT 'OK'
    RETURN
END
GO
