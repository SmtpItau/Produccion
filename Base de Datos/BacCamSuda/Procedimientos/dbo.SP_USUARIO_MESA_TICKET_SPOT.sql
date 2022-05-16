USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_USUARIO_MESA_TICKET_SPOT]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_USUARIO_MESA_TICKET_SPOT]
       (
         @_USUARIO VARCHAR(15)
       )
AS
BEGIN 
      SET NOCOUNT ON

      SELECT codigomesa FROM BACPARAMSUDA.DBO.USUARIO
      WHERE usuario = @_USUARIO     
END



GO
