USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_OPERACIONES1446]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_OPERACIONES1446]
                 (
                  @Entidad      NUMERIC(03),
                  @CODMON       CHAR(03),
                  @CODCNV       CHAR(03),
                  @FECHA        CHAR(08),
                  @TERM         CHAR(12),
                  @OPER         CHAR(10),
                  @TIPMER       CHAR(04),
                  @MONMO        NUMERIC(19,2),
                  @TIPOPE       CHAR(01),
                  @TICAM        NUMERIC(19,2),
                  @NOMCLI       CHAR(35),
                  @RUTCLI       NUMERIC(09),
                  @CODCL        NUMERIC(11),
                  @NumOper      NUMERIC(19)
                 )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @xNumOper  numeric(9)
   IF @NumOper = 0 BEGIN
      UPDATE meac SET accorope = accorope + 1
      SELECT      @NumOper = accorope
             FROM meac
   END
   IF EXISTS( SELECT monumope FROM memo WHERE monumope = @NumOper ) BEGIN 
      UPDATE memo 
             SET   moentidad  = 1,
                   mocodmon   = @codmon,
                   mocodcnv   = @codcnv,
                   mofech     = @fecha,
                   mohora     = CONVERT(CHAR(08),GETDATE(),108),
                   moterm     = @term,
                   mooper     = @oper,
                   motipmer   = @tipmer,
                   momonmo    = @monmo,
                   motipope   = @tipope,
                   moticam    = @ticam,
                   monomcli   = @nomcli,
                   morutcli   = @rutcli,
                   mocodcli   = @codcl,
                   monumope   = @NumOper
             WHERE monumope   = @NumOper 
   END ELSE BEGIN
      INSERT INTO    memo
                    (
                     moentidad,
                     mocodmon,
                     mocodcnv,
                     mofech,
                     mohora,
                     moterm,
                     mooper,
                     motipmer,
                     momonmo,
                     motipope,
                     moticam,
                     monomcli,
                     morutcli,
                     mocodcli,
                     monumope
                    )
             VALUES (
                     @entidad,
                     @codmon,
                     @codcnv,
                     CONVERT(CHAR(8),@fecha ,112), -- Fecha
                     CONVERT(CHAR(08),GETDATE(),108),  -- HORA 
                     @term,
                     @oper,
                     @tipmer,
                     @monmo,
                     @tipope, 
                     @ticam,
                     @nomcli,
                     @rutcli,
                     @codcl,
                     @numoper + 1
                    )
   END
   SELECT @NumOper
   SET NOCOUNT OFF
END

GO
