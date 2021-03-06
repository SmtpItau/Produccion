USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_FOLIO_BCCH]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_BUSCA_FOLIO_BCCH]
             (  @Folio   Numeric(9)
             )
AS
BEGIN

   SET NOCOUNT ON

 IF EXISTS (SELECT FolioBCCH FROM CARGASOMA WHERE FolioBCCH = @Folio)
 BEGIN
       SELECT @Folio
 END
 ELSE 
 BEGIN 
       SELECT 0 
 END
   SET NOCOUNT ON
END   /* fin procedimiento */

GO
