USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GMENSAJES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GMENSAJES](
                                  @Mensaje_Linea  CHAR(255)
                                 ,@Mensaje_Limite CHAR(255)
                                 ,@Operacion      NUMERIC(7)
                                 )
AS
BEGIN

   UPDATE memo
   SET    moobservlin = @Mensaje_Linea
         ,moobservlim = @Mensaje_Limite
   WHERE  monumope = @Operacion

END
GO
