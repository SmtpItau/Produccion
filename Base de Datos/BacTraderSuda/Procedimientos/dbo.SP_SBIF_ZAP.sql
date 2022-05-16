USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SBIF_ZAP]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SBIF_ZAP]
               (@dFecpro DATETIME )
AS
BEGIN
   set nocount on
  DELETE FROM MD_SBIF
  DELETE FROM MDTM1
  UPDATE MDAC SET acfecSbif1 = @dFecpro, acfecSbif2 = @dFecpro
select 'OK'
set nocount off
END

GO
