USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CTELIMINAR]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_CTELIMINAR    fecha de la secuencia de comandos: 03/04/2001 15:18:02 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_CTELIMINAR    fecha de la secuencia de comandos: 14/02/2001 09:58:25 ******/
CREATE PROCEDURE [dbo].[SP_CTELIMINAR] 
               (@ctcateg NUMERIC(4) )
AS
BEGIN
SET NOCOUNT ON
       DELETE  FROM TABLA_GENERAL_GLOBAL WHERE ctcateg = @ctcateg
SET NOCOUNT OFF
SELECT 'OK'
END
--execute Sp_ClEliminar1 14185532,1

GO
