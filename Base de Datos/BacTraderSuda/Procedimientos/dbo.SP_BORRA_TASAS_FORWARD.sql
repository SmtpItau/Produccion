USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRA_TASAS_FORWARD]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BORRA_TASAS_FORWARD]
AS
BEGIN
DELETE VIEW_TASA_FWD
 IF @@ERROR <> 0 
     SELECT -1, 'Problemas al borrar información'
END


GO
