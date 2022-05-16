USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMPIA_PASO_FLI]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

	    CREATE PROCEDURE [dbo].[SP_LIMPIA_PASO_FLI]
AS 

SET NOCOUNT ON

BEGIN
   IF EXISTS(SELECT name FROM sysobjects WHERE name = 'FLJ_LQZ_IMD' AND type = 'U')
      BEGIN
          DELETE FLJ_LQZ_IMD 
      END

   IF EXISTS(SELECT name FROM sysobjects WHERE name = 'FLJ_LQZ_MOD' AND type = 'U')
      BEGIN
         DELETE FLJ_LQZ_MOD 
      END

   RETURN
END







GO
