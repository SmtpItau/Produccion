USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_USUARIO_MESA_TICKET_RTAFIJA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_USUARIO_MESA_TICKET_RTAFIJA]
       (
         @_USUARIO VARCHAR(15)
       )
AS
BEGIN 
      SET NOCOUNT ON

      SELECT codigomesa FROM bacparamsuda.dbo.usuario
      WHERE usuario = @_USUARIO     
END



GO
