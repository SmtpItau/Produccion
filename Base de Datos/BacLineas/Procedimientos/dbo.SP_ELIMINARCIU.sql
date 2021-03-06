USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINARCIU]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_ELIMINARCIU    fecha de la secuencia de comandos: 03/04/2001 15:18:02 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_ELIMINARCIU    fecha de la secuencia de comandos: 14/02/2001 09:58:25 ******/
CREATE PROCEDURE [dbo].[SP_ELIMINARCIU]
                  (@COD_PAI NUMERIC(6),
                  @COD_CIU NUMERIC(6))
                
AS
BEGIN
SET NOCOUNT ON
    DELETE CIUDAD_COMUNA WHERE cod_pai = @COD_PAI AND cod_ciu = @COD_CIU 
    SELECT 'OK'
    RETURN
SET NOCOUNT OFF
END
GO
