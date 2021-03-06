USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_PERFILES_VARIABLES]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BUSCAR_PERFILES_VARIABLES]
   (   @Idsistema   CHAR(03)
   ,   @Usuario     CHAR(20)
   ,   @Filas       NUMERIC(08)
   ,   @Perfil      NUMERIC(9)
   )
AS 
BEGIN

   SET NOCOUNT ON

   SELECT fila
   ,      valor
   ,      cuenta
   ,      descripcion
   ,      perfil
   FROM   PASO_CNT
   WHERE  fila       = @filas
   and    id_sistema = @idsistema   
   and    usuario    = @usuario
   and    Perfil     = @Perfil
   ORDER BY CONVERT(INTEGER,valor)

END

GO
