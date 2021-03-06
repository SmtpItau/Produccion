USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_PERILES_VARIABLES]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Buscar_Periles_Variables    fecha de la secuencia de comandos: 03/04/2001 15:17:59 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Buscar_Periles_Variables    fecha de la secuencia de comandos: 14/02/2001 09:58:24 ******/
CREATE PROCEDURE [dbo].[SP_BUSCAR_PERILES_VARIABLES]
                                            (@folio_perfil    NUMERIC(10),
                                             @correlativo     NUMERIC(10),
                                             @perfil          NUMERIC(10))
AS
BEGIN
SET NOCOUNT ON
    Select valor,cuenta,descripcion ,*
      From PASO_CNT
     WHERE perfil = @perfil
SET NOCOUNT OFF
END
GO
