USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_TRAE_MENU_INTERFAZ]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_TRAE_MENU_INTERFAZ](@iSistema CHAR(3))
AS
BEGIN

        SET NOCOUNT ON
        SET DATEFORMAT dmy
                
        SELECT nombre_opcion,
               nombre_objeto
        FROM MENU
        WHERE @isistema  = entidad
        AND   entidadfox IN(1,2)

END




GO
