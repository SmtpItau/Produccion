USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BLOQGRABARUSUARIO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BLOQGRABARUSUARIO]
       (
        @cusuario   CHAR(12),
        @cidconect  CHAR(01),
        @cidbloqueo CHAR(01)
       )
AS
BEGIN
   UPDATE BACUSER SET idconect = @cidconect, idbloqueo = @cidbloqueo WHERE usuario = @cusuario
END

GO
