USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_PRIVILEGIOS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_PRIVILEGIOS]
   (   @tipo_privilegio CHAR(1)
   ,   @entidad         CHAR(3)
   ,   @usuario         CHAR(15)
   )
AS
BEGIN
   SET NOCOUNT ON 

   SELECT opcion
   ,      habilitado
   FROM   BacParamSuda..GEN_PRIVILEGIOS with (Nolock)
   WHERE  tipo_privilegio = @tipo_privilegio 
   AND    usuario         = case when @usuario = '' then 'ECERDAC' ELSE @usuario END
   AND    entidad         = @entidad

END


GO
