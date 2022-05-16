USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GUARDAOBSLINEASLIMITES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GUARDAOBSLINEASLIMITES]( @numoper   NUMERIC(10) ,
         @Mensaje_lin  CHAR(255) ,
         @Mensaje_lim  CHAR(255) 
       )
AS
BEGIN
 SET NOCOUNT ON
 UPDATE memo
 SET moobservlin = LTRIM(@Mensaje_lin) ,
  moobservlim = LTRIM(@Mensaje_lim) 
 WHERE @numoper = monumope
 SET NOCOUNT OFF
END

GO
