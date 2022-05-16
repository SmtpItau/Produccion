USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELI_CODIGOS_GESTION]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_ELI_CODIGOS_GESTION](
                                        @id_Sistema    char(3)
                                      )
AS
BEGIN

    SET DATEFORMAT dmy
    DELETE GESTION_TESORERIA WHERE @id_Sistema=id_Sistema
    
END




GO
