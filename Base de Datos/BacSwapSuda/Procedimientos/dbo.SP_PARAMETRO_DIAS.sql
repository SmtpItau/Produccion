USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PARAMETRO_DIAS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_PARAMETRO_DIAS]
AS
BEGIN

   SET NOCOUNT ON
   DECLARE  @Dias  NUMERIC (10)

     SET @Dias = 99999999          

     SELECT  'Dias' = @Dias	 

   SET NOCOUNT OFF
   RETURN 0	 
END
GO
