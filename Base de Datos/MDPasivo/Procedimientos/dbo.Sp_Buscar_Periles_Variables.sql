USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Buscar_Periles_Variables]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Buscar_Periles_Variables]
                                            (@folio_perfil    NUMERIC(10),
                                             @correlativo     NUMERIC(10),
                                             @perfil          NUMERIC(10))
AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON

    Select valor,cuenta,descripcion ,*
      From PASO_CNT
     WHERE perfil = @perfil and fila = @correlativo
SET NOCOUNT OFF
END
GO
