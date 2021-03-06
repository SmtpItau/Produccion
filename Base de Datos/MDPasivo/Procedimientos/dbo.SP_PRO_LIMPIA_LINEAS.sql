USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_PRO_LIMPIA_LINEAS]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PRO_LIMPIA_LINEAS]
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON
    DELETE LINEA_TRANSACCION_DETALLE
    
    DELETE LINEA_TRANSACCION
    
    DELETE LIMITE_TRANSACCION_ERROR

    DELETE LIMITE_TRANSACCION
    
    DELETE LINEA_AUTORIZACION
    
    DELETE LINEA_CHEQUEAR

    EXEC Sp_Lineas_Inicia_Lineas 

    EXEC SP_LINEAS_ACTUALIZA

END

GO
