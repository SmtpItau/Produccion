USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MNEliminar]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_MNEliminar] (@mncodmon1 NUMERIC(5,0))
AS
BEGIN
        SET DATEFORMAT dmy

        --DELETE FROM MONEDA WHERE  mncodmon = @mncodmon1   AND ESTADO<>'A'

        UPDATE MONEDA    SET   ESTADO='A' WHERE  mncodmon = @mncodmon1   

        RETURN
END



GO
