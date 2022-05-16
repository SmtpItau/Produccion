USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRUNCATE_DECIMALS]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_TRUNCATE_DECIMALS]
			(@VALUE AS NUMERIC(21,9)
                        ,@DECIMALS AS INTEGER)
AS BEGIN

DECLARE @SCALE NUMERIC(10)
SET @SCALE = POWER(10,@DECIMALS)

SELECT CAST(CAST(@VALUE* @SCALE AS INT) AS NUMERIC (18,9)) / @SCALE 

END

GO
