USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_REPRESENTANTES]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_REPRESENTANTES]
   (   @RutCliente   NUMERIC(9) = 0
   ,   @CodCliente   NUMERIC(1) = 0
   ,   @Entidad      CHAR(1)    = 'N'
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @Entidad = 'S'
   BEGIN
      SELECT RutEntidad    = rut
         ,   Entidad       = nombre
         ,   Direccion     = direccion
         ,   NomApoderado  = ISNULL( apnombre, '')
         ,   RutApoderado  = ISNULL( REPLICATE(' ', 12 - LEN(LTRIM(RTRIM( aprutapo ))) ) + LTRIM(RTRIM( aprutapo )) + '-' + LTRIM(RTRIM( apdvapo )), '0-0')
         ,   RutApoEntidad = ISNULL( aprutapo, 0)
         ,   DigApoEntidad = ISNULL( apdvapo, 0)
        FROM BacSwapSuda..SWAPGENERAL                  with(nolock)
             LEFT JOIN BacParamSuda..CLIENTE_APODERADO with(nolock) ON aprutcli = rut and apcodcli = 1
   END

   IF @Entidad = 'N'
   BEGIN
      SELECT RutEntidad    = clrut
         ,   Entidad       = clnombre
         ,   Direccion     = cldirecc
         ,   NomApoderado  = ISNULL( apnombre, '')
         ,   RutApoderado  = ISNULL( REPLICATE(' ', 12 - LEN(LTRIM(RTRIM( aprutapo ))) ) + LTRIM(RTRIM( aprutapo )) + '-' + LTRIM(RTRIM( apdvapo )), '0-0')
         ,   RutApoEntidad = ISNULL( aprutapo, 0)
         ,   DigApoEntidad = ISNULL( apdvapo, 0)
        FROM BacParamSuda..CLIENTE                     with(nolock)
             LEFT JOIN BacParamSuda..CLIENTE_APODERADO with(nolock) ON aprutcli = clrut and apcodcli = clcodigo
       WHERE clrut         = @RutCliente
         AND clcodigo      = @CodCliente
   END

END
GO
