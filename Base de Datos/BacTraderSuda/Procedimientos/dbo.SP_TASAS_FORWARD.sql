USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TASAS_FORWARD]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TASAS_FORWARD]
AS
BEGIN
 SELECT  plazo_ini    ,
   plazo_fin    ,
   uf     ,
    clp     ,
   libor     ,
   spread                                                 
 FROM VIEW_TASA_FWD
 ORDER BY plazo_ini
END

GO
