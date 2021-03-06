USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_POSICION_GRUPO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_POSICION_GRUPO]
   (   @iFlag          CHAR(1)
   ,   @iCodigoGrupo   CHAR(2)   = ''
   ,   @iTotalPos      FLOAT     = 0
   ,   @iTotalOcu      FLOAT     = 0
   ,   @iTotalDis      FLOAT     = 0
   ,   @iTotalPorc     FLOAT     = 0
   ,   @iTotalExc      FLOAT     = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iFlag = 'I'
   BEGIN
      IF EXISTS(SELECT 1 FROM POSICION_GRUPO WHERE codigo_grupo = @iCodigoGrupo)
      BEGIN
         UPDATE POSICION_GRUPO
         SET    totalposicion   = @iTotalPos
         ,      totalocupado    = @iTotalOcu
         ,      totaldisponible = @iTotalDis
         ,      porcentaje      = @iTotalporc
         ,      totalexcedido   = @iTotalExc
         WHERE  codigo_grupo    = @iCodigoGrupo

         SELECT 0,'Modificación Correcta'
         RETURN

      END ELSE
      BEGIN
         INSERT INTO POSICION_GRUPO
         (   codigo_grupo
         ,   totalposicion
         ,   totalocupado
         ,   totaldisponible
         ,   porcentaje
         ,   totalexcedido
         )
         VALUES
         (   @iCodigoGrupo
         ,   @iTotalPos
         ,   @iTotalOcu
         ,   @iTotalDis
         ,   @iTotalPorc
         ,   @iTotalExc
         )

         SELECT 0,'Grabación Correcta'
         RETURN
      END
   END

   IF @iFlag = 'B'
   BEGIN

      SELECT SUBSTRING(GP.descripcion,1,50)      as Grup_Descripcion
      ,      GP.codigo_grupo                     as Grup_Codigo
      ,      ISNULL(totalposicion,0)             as Grup_TotPosicion
      ,      ISNULL(totalocupado,0)              as Grup_TotOcupado
      ,      ISNULL(totaldisponible,0)           as Grup_TotDisponible
      ,      ISNULL(porcentaje,0)                as Grup_Totporcentaje
      ,      ISNULL(totalexcedido,0)             as Grup_TotExcedido
      FROM   GRUPO_POSICION GP LEFT OUTER JOIN POSICION_GRUPO PG
      ON GP.codigo_grupo = PG.codigo_grupo

      RETURN
   END

   IF @iFlag = 'E'
   BEGIN
      DELETE POSICION_GRUPO 

      SELECT 0,'Eliminación Correcta'
      RETURN
   END

   SET NOCOUNT OFF

END
GO
