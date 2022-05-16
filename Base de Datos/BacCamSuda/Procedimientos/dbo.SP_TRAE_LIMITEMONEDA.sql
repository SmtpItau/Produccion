USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_LIMITEMONEDA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_TRAE_LIMITEMONEDA]
 (
 @mnNemo  CHAR(8),
 @vmCodigo  CHAR(3)
 )
AS
BEGIN
SET NOCOUNT ON
 SELECT mnglosa,mnnemo, vmcodigo,vmlimite 
 FROM moneda, posicion_spt 
 WHERE vmcodigo = mnnemo
SET NOCOUNT OFF
END



GO
