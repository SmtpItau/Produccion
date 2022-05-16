USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAEAPODERADO]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAEAPODERADO]
AS
BEGIN
set nocount on
DECLARE @xRUT1 NUMERIC(10)
DECLARE @xDV1  CHAR(1)
DECLARE @xNOM1  CHAR(50)
DECLARE @xRUT2 NUMERIC(10)
DECLARE @xDV2  CHAR(1)
DECLARE @xNOM2  CHAR(50)
 SELECT @xRUT1=aprutapo,@xDV1=apdvapo,@xNOM1=apnombre FROM VIEW_MDAP WHERE aprutcli = 1
 SELECT @xRUT2=aprutapo,@xDV2=apdvapo,@xNOM2=apnombre FROM VIEW_MDAP WHERE aprutcli = 2
 SELECT @xRUT1,@xDV1,@xNOM1,
 @xRUT2,@xDV2,@xNOM2
set nocount off
END

GO
