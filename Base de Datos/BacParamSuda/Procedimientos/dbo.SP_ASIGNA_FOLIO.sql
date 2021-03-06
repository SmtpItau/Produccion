USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ASIGNA_FOLIO]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ASIGNA_FOLIO]
            ( @codigo char(10) )
AS
BEGIN
   SET NOCOUNT ON 
      DECLARE @folio NUMERIC(10)

      SELECT @folio = folio FROM  GENERA_FOLIOS WHERE codigo = @codigo
      UPDATE GENERA_FOLIOS SET folio = @folio + 1 WHERE codigo = @codigo

      SELECT  @folio
   SET NOCOUNT OFF 
END   
GO
