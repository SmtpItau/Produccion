USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PROCNAME]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PROCNAME]
 ( @szPar VARCHAR(30))
AS
BEGIN
 DECLARE @Cnt SMALLINT
 SELECT @Cnt = ( SELECT COUNT(*)
    FROM  SysObjects
  WHERE Type = 'P'
AND Name LIKE RTRIM( @szPar ) + '________' )
 SELECT @Cnt
 SELECT RIGHT( Name, 8 )
  FROM  SysObjects
  WHERE Type = 'P'
AND Name LIKE RTRIM( @szPar ) + '________'
END


GO
