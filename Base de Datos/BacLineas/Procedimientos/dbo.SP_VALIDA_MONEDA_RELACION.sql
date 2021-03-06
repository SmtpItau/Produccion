USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_MONEDA_RELACION]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_VALIDA_MONEDA_RELACION]
   (   @nRut      NUMERIC(10)
   ,   @nCodigo   INTEGER
   ,   @nMoneda   INTEGER
   )
AS
BEGIN

   SET NOCOUNT ON


   DECLARE @nRutPadre   NUMERIC(10)
       SET @nRutPadre   = -1

   DECLARE @nCodPadre   INTEGER
       SET @nCodPadre   = -1

   DECLARE @nMonPadre   VARCHAR(5)
       SET @nMonPadre   = ''

   DECLARE @oPadre      INTEGER
       SET @oPadre      = 0


   IF NOT EXISTS( SELECT 1 FROM BacLineas.dbo.CLIENTE_RELACIONADO WHERE clrut_padre = @nRut OR clrut_hijo = @nRut) 
   BEGIN
      SELECT 0, 'Cliente no relacionado.'
      RETURN
   END

   IF EXISTS( SELECT 1 FROM BacLineas.dbo.CLIENTE_RELACIONADO WHERE clrut_padre = @nRut and clcodigo_padre = @nCodigo)
   BEGIN

      SET @nRutPadre = @nRut
      SET @nCodPadre = @nCodigo
      SET @oPadre    = 1

      --> SELECT 0, 'Cliente es el padre de la relacion'
   END ELSE 
   BEGIN

      SELECT @nRutPadre  = clrut_padre
      ,      @nCodPadre  = clcodigo_padre
      FROM   BacLineas.dbo.CLIENTE_RELACIONADO 
      WHERE  clrut_hijo  = @nRut and clcodigo_hijo = @nCodigo

   END 

   SET @nMonPadre = ( SELECT CONVERT(INTEGER, ltrim(rtrim(Moneda)) ) 
                        FROM BacLineas.dbo.LINEA_GENERAL 
                       WHERE rut_cliente = @nRutPadre AND codigo_cliente = @nCodPadre )

   --IF @nMonPadre = '' or @nMonPadre IS NULL
   --BEGIN
      --SELECT -1,'No se ha definido la línea general paera el Padre de la relación'
      --RETURN
   --END

   IF @nMoneda <> @nMonPadre
   BEGIN
      IF @oPadre = 1
         SELECT -1, 'Cliente Relacionado... La moneda no concuerda con la moneda de al menos un cliente relacionado ... rebisar.' 
      ELSE 
         SELECT -1, 'La moneda ingresado no concuerda con la moneda definida para el cliente padre de la relación.'
   END ELSE 
   BEGIN
      SELECT 0, 'No existe ningun problema'
   END

END
GO
