USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_ENTIDAD]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_ENTIDAD] 
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

        SELECT rccodcar,
               rcnombre,
               rcrut 
        FROM ENTIDAD

END

GO
