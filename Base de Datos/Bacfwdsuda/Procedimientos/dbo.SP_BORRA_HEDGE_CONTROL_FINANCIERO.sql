USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRA_HEDGE_CONTROL_FINANCIERO]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BORRA_HEDGE_CONTROL_FINANCIERO](  @usuario  CHAR(15) ,
       @sistema CHAR(3)
        )
AS 
BEGIN
 SET NOCOUNT ON
 DELETE view_aprobacion_hedge 
 WHERE  @usuario = usuario AND
	@sistema = sistema
 SET NOCOUNT OFF
END

GO
