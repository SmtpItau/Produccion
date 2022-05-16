USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPMDRC]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_OPMDRC]
               (@nRutcart NUMERIC (09,0) )
 AS 
 BEGIN
 DECLARE @cnumoper NUMERIC (10,0)
 SELECT  @cnumoper= rcnumoper FROM view_entidad mdrc
 WHERE  rcrut = @nrutcart
 UPDATE MDRC
 SET rcnumoper = rcnumoper + 1
 WHERE  rcrut = @nrutcart 
 SELECT @cnumoper
 RETURN        
 END

GO
