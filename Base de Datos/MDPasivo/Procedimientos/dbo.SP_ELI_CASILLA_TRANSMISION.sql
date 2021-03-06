USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELI_CASILLA_TRANSMISION]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_ELI_CASILLA_TRANSMISION](
                                            @iNombre_Host    Char(30)
                                          )
AS
BEGIN --INICIO SP

    SET DATEFORMAT dmy

    IF EXISTS( SELECT * FROM INTERFAZ WHERE @iNombre_Host=CASILLA ) BEGIN
        SELECT 'NO'        
    END ELSE BEGIN
        DELETE CASILLA_TRANSMISION WHERE Nombre_Host = @iNombre_Host
        SELECT 'SI'
    END

END   --FIN SP








GO
