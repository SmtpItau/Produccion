USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_AUTORIZA_HEDGE]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_AUTORIZA_HEDGE](  @usuario  CHAR(15) ,
     @sistema CHAR(3)
      )
AS 
BEGIN
 SET NOCOUNT ON
 SELECT  ISNULL( Autoriza , '' ) ,
  ISNULL( Aprobado , 0  )   
 FROM view_aprobacion_hedge
 WHERE  @usuario = usuario AND
  @sistema = sistema
 SET NOCOUNT OFF
END

GO
