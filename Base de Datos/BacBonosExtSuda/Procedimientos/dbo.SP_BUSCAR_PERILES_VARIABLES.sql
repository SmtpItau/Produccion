USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_PERILES_VARIABLES]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCAR_PERILES_VARIABLES]
   (   @folio_perfil    NUMERIC(10)
   ,   @correlativo     NUMERIC(10)
   ,   @perfil          NUMERIC(10)
   )
AS
BEGIN
   SET NOCOUNT ON

   SELECT valor
   ,      cuenta
   ,      descripcion 
   ,      *
   FROM   PASO_CNT
   WHERE  perfil = @perfil
   AND    FILA   = @correlativo

   SET NOCOUNT OFF
END

GO
