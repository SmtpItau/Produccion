USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAERRORESCONTA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LISTAERRORESCONTA]
AS
BEGIN

   SELECT MENSAJE,
	  NOMBRE,
	  'HORA' = convert (char(8),getdate(),114)
   FROM Errores ,
	SwapGeneral

END
GO
