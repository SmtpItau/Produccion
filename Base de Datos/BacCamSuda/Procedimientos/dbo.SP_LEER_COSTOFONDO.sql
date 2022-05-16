USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_COSTOFONDO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_LEER_COSTOFONDO]
                ( @entidad char(2) )
AS
BEGIN
     SET NOCOUNT ON
     select accoscomp, accosvent  from MEAC  where acentida = @entidad
END



GO
