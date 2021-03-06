USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SADP_SP_FPAGO_CANAL]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SADP_SP_FPAGO_CANAL]
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
		IF EXISTS( SELECT 1 FROM FPAGO_CANAL WHERE Codigo_FormaPago = @Codigo_FormaPago 
											   AND Codigo_Canal		= @Codigo_Canal )
		BEGIN
			DELETE FROM FPAGO_CANAL WHERE Codigo_FormaPago = @Codigo_FormaPago AND Codigo_Canal = @Codigo_Canal
		END
   	
      INSERT INTO FPAGO_CANAL 
      SELECT @Codigo_FormaPago
      ,      @Codigo_Canal
      ,      @Descripcion

      RETURN
   END

   IF @Tag = 4
   BEGIN
      SELECT	a.Codigo_FormaPago
		,		f.glosa
		,		a.Codigo_Canal
		,		a.Descripcion
      FROM		FPAGO_CANAL a 
				LEFT JOIN FORMA_DE_PAGO f ON a.Codigo_FormaPago = f.codigo
      ORDER BY	f.Codigo
      RETURN
   END

   IF @Tag = 5
   BEGIN
      SELECT   DISTINCT mfcodfor , glosa
      FROM     MONEDA_FORMA_DE_PAGO inner join FORMA_DE_PAGO ON mfcodfor = codigo
      ORDER BY glosa
      RETURN
   END

END
GO
