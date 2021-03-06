USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_EMISOR_BY_GENERIC]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_EMISOR_BY_GENERIC](@xGeneric  CHAR(10))
AS
BEGIN
set nocount on
 SELECT emcodigo,
	 emrut,
	 emdv,
	 emnombre,
	 emgeneric,
	 emdirecc,
	 emcomuna,
	 emtipo,
	 emglosa,
	 embonos
 FROM  VIEW_EMISOR 
	WHERE emgeneric = @xGeneric	
SET nocount OFF
END
GO
