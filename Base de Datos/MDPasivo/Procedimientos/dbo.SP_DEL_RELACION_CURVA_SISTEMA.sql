USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_RELACION_CURVA_SISTEMA]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_DEL_RELACION_CURVA_SISTEMA](@iSistema            CHAR(3))  
AS
BEGIN

        SET NOCOUNT ON
        SET DATEFORMAT dmy
        
        DELETE RELACION_CURVA
        WHERE  Id_Sistema         = @iSistema
END




GO
