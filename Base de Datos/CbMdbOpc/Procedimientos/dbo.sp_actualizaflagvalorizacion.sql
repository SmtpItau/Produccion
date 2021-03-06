USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[sp_actualizaflagvalorizacion]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_actualizaflagvalorizacion]
AS
BEGIN

    SET NOCOUNT ON

    UPDATE dbo.OpcionesGeneral
       SET devengo = 1

    IF @@ROWCOUNT = 1
    BEGIN
        SELECT 'STATUS'  = 0
             , 'MESSAGE' = 'OK'

    END ELSE
    BEGIN
        SELECT 'STATUS'  = 1
             , 'MESSAGE' = 'ERROR'

    END

    SET NOCOUNT OFF

END

GO
