USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_PERFILES_VARIABLES]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCAR_PERFILES_VARIABLES](
      @Idsistema   CHAR   (03),
      @Usuario     CHAR   (20),  
      @Filas       NUMERIC(08)
)
AS 
BEGIN
  SET NOCOUNT ON
 SELECT  FILA,
  VALOR,
                CUENTA,
                DESCRIPCION,
                perfil
 FROM PASO_CNT
 WHERE FILA       = @FILAS
   AND ID_SISTEMA = @Idsistema   
   AND USUARIO    = @Usuario
  SET NOCOUNT OFF 
END
GO
