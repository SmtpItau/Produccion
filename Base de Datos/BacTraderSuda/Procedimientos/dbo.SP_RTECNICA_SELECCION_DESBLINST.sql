USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_SELECCION_DESBLINST]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RTECNICA_SELECCION_DESBLINST]
                                 ( --@rutcart NUMERIC(10,0),
                              @usuario CHAR(20) )
AS
BEGIN
 SET NOCOUNT ON
 --desbloqueo el papel
 DELETE FROM mdbl
 WHERE blusuario = @usuario
 
 SET NOCOUNT OFF
END


GO
