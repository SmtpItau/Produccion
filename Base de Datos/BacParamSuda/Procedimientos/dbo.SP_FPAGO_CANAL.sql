USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FPAGO_CANAL]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FPAGO_CANAL]
(   @Tag                INTEGER
,   @Codigo_FormaPago   NUMERIC(9)   = 0
,   @Codigo_Canal       NUMERIC(9)   = 0
,   @Descripcion        VARCHAR(50)  = ''
)
AS
BEGIN

   SET NOCOUNT ON

   IF @Tag = 1
   BEGIN
      SELECT Codigo_FormaPago
      ,      Codigo_Canal
      ,      Descripcion
      FROM   FPAGO_CANAL 
      WHERE  Codigo_FormaPago = @Codigo_FormaPago
      RETURN
   END

   IF @Tag = 2
   BEGIN
      DELETE FPAGO_CANAL 
      RETURN
   END

   IF @Tag = 3
   BEGIN
      INSERT INTO FPAGO_CANAL 
      SELECT @Codigo_FormaPago
      ,      @Codigo_Canal
      ,      @Descripcion

      RETURN
   END

   IF @Tag = 4
   BEGIN
      SELECT Codigo , Glosa 
      FROM   FPAGO_CANAL a LEFT JOIN FORMA_DE_PAGO ON Codigo_FormaPago = codigo
      ORDER BY Codigo
      RETURN
   END

   IF @Tag = 5
   BEGIN
      SELECT   DISTINCT mfcodfor , glosa
      FROM     MONEDA_FORMA_DE_PAGO inner join FORMA_DE_PAGO ON mfcodfor = codigo
--    WHERE    mfcodmon = 999 
      ORDER BY glosa
      RETURN
   END

END

GO
