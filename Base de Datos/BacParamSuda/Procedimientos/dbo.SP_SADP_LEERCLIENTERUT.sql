USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEERCLIENTERUT]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEERCLIENTERUT]
   (   @nRut      NUMERIC(10)
   ,   @nCodigo   INT
   )
AS
BEGIN

   SET NOCOUNT ON

   IF NOT EXISTS( SELECT 1 FROM BacParamSuda.dbo.CLIENTE with(nolock) WHERE clrut = @nRut and clcodigo = @nCodigo)
   BEGIN
      SELECT @nRut, @nCodigo, '', 'Cliente no valido.'
   END ELSE
   BEGIN
      SELECT clrut, clcodigo, cldv, clnombre
      FROM   BacParamSuda.dbo.CLIENTE with(nolock) WHERE clrut = @nRut and clcodigo = @nCodigo
   END

END
GO
