USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABACION_CONFIRMACIONES]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABACION_CONFIRMACIONES]
   (   @iSistema   CHAR(3)      = ''
   ,   @iNumOper   NUMERIC(9)   = 0
   ,   @iNumDocu   NUMERIC(9)   = 0
   ,   @iCorrela   NUMERIC(9)   = 0
   ,   @iConfirma  CHAR(1)      = ''
   ,   @iCodigo    NUMERIC(9)   = 0
   ,   @iGlosa     VARCHAR(100) = ''
   ,   @iHora      CHAR(8)      = ''
   ,   @iOper      VARCHAR(15)  = ''
   ,   @iCnv       VARCHAR(30)  = ''
   ,   @BRC        CHAR(1)
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @BRC = 'B'
   BEGIN 
      BEGIN TRANSACTION
      RETURN
   END
   IF @BRC = 'R'
   BEGIN 
      ROLLBACK TRANSACTION
      RETURN
   END
   IF @BRC = 'C'
   BEGIN 
      COMMIT TRANSACTION
      RETURN
   END

   IF @iSistema = 'BCC'
   BEGIN
      UPDATE baccamsuda..MEMO
      SET    Dcrp_Confirmador     = @iConfirma
      ,      Dcrp_Codigo          = @iCodigo
      ,      Dcrp_Glosa           = @iGlosa
      ,      Dcrp_HoraConfirm     = @iHora
      ,      Dcrp_OperConfirm     = @iOper
      ,      Dcrp_OpeCnvConfirm   = @iCnv
      WHERE  monumope             = @iNumOper
   END
   IF @iSistema = 'BTR'
   BEGIN
      UPDATE bactradersuda..MDMO
      SET    Dcrp_Confirmador     = @iConfirma
      ,      Dcrp_Codigo          = @iCodigo
      ,      Dcrp_Glosa           = @iGlosa
      ,      Dcrp_HoraConfirm     = @iHora
      ,      Dcrp_OperConfirm     = @iOper
      ,      Dcrp_OpeCnvConfirm   = @iCnv
      WHERE  monumoper            = @iNumOper
      AND   (monumdocu            = @iNumDocu OR @iNumDocu = 0)
      AND   (mocorrela            = @iCorrela OR @iCorrela = 0)
   END

END



GO
