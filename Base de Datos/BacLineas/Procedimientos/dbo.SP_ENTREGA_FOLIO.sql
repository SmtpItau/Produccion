USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ENTREGA_FOLIO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Entrega_Folio    fecha de la secuencia de comandos: 03/04/2001 15:18:02 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Entrega_Folio    fecha de la secuencia de comandos: 14/02/2001 09:58:25 ******/
CREATE PROCEDURE [dbo].[SP_ENTREGA_FOLIO]
            ( @Codigo CHAR(10) )
AS
BEGIN
   SET NOCOUNT ON
      DECLARE @Folio NUMERIC(10)
      SELECT @Folio = folio FROM GEN_FOLIOS WHERE codigo = @Codigo
      UPDATE GEN_FOLIOS SET folio = @Folio + 1 WHERE codigo = @Codigo
   SELECT @Folio
   SET NOCOUNT OFF
END   /* FIN PROCEDIMIENTO */
--SELECT * FROM GEN_FOLIOS
--INSERT GEN_FOLIOS VALUES( 'DCV', 1 )
--  Sp_Entrega_Folio 'DCV'
GO
