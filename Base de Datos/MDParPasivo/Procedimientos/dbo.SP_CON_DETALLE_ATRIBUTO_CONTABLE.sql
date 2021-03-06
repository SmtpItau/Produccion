USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_DETALLE_ATRIBUTO_CONTABLE]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_CON_DETALLE_ATRIBUTO_CONTABLE]
          ( @icampo_atributo      CHAR(20)
          , @nTipo                NUMERIC(01)
          )
AS
BEGIN


   SET DATEFORMAT dmy

   DECLARE @cCadena   VARCHAR(255)

   SET NOCOUNT ON

   IF @nTipo = 1 BEGIN

      SELECT campo_atributo
           , codigo_utilizacion
           , descripcion
           , codigo_relacion
        FROM ATRIBUTO_CONTABLE_DETALLE
       WHERE campo_atributo = @icampo_atributo

   END ELSE
   BEGIN

      SELECT @cCadena = campo_consulta
        FROM ATRIBUTO_CONTABLE
       WHERE campo_atributo = @icampo_atributo

        EXEC (@cCadena)

   END

   SET NOCOUNT OFF

END



GO
