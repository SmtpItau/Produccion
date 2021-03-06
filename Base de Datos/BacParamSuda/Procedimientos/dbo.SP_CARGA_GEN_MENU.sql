USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_GEN_MENU]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CARGA_GEN_MENU]
   (   @Primera_Vez    CHAR(1)
   ,   @Entidad        CHAR(3)
   ,   @Indice         NUMERIC(3)
   ,   @Nombre_Opcion  CHAR(150)
   ,   @Nombre_Objeto  CHAR(30)
   ,   @Posicion       NUMERIC(3)  
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @Primera_Vez = 'S'
   BEGIN
      DELETE FROM GEN_MENU WHERE Entidad = @Entidad
   END

   IF @@ERROR = 0
   BEGIN  
      INSERT INTO GEN_MENU
      (   Entidad
      ,   Indice
      ,   Nombre_Opcion
      ,   Nombre_Objeto
      ,   Posicion
      ,   EntidadFox 
      )
      VALUES
      (   @Entidad
      ,   @Indice
      ,   @Nombre_Opcion
      ,   @Nombre_Objeto
      ,   @Posicion
      ,   '' 
      )
   END

   IF @@ERROR <> 0
      SELECT 'ERROR'
   ELSE
      SELECT 'OK'

END
GO
