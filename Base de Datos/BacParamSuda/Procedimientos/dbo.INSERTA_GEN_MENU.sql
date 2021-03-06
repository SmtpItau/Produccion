USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[INSERTA_GEN_MENU]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Inserta_Gen_Menu    fecha de la secuencia de comandos: 03/04/2001 15:17:56 ******/
CREATE PROCEDURE [dbo].[INSERTA_GEN_MENU] 
 (
  @Entidad CHAR(3),
  @Indice  NUMERIC(3),
  @Nombre_Opcion CHAR(50),
  @Nombre_Objeto CHAR(30),
  @Posicion NUMERIC(3),
  @EntidadFox CHAR(3)
 )
AS 
BEGIN
IF EXISTS (SELECT 1 FROM GEN_MENU WHERE 
  Entidad  = @Entidad AND
  Indice  = @Indice  AND
  Nombre_Opcion  = @Nombre_Opcion AND
  Nombre_Objeto  = @Nombre_Objeto AND
  Posicion  = @Posicion AND
  EntidadFox  = @EntidadFox
 ) 
BEGIN
 DELETE FROM GEN_MENU WHERE
  Entidad  = @Entidad AND
  Indice  = @Indice  AND
  Nombre_Opcion  = @Nombre_Opcion AND
  Nombre_Objeto  = @Nombre_Objeto AND
  Posicion  = @Posicion AND
  EntidadFox  = @EntidadFox
 
END
  
INSERT INTO GEN_MENU
 
 (
  Entidad,
  Indice,
  Nombre_Opcion,
  Nombre_Objeto,
  Posicion,
  EntidadFox
 
 )
 VALUES( 
  @Entidad ,
  @Indice  ,
  @Nombre_Opcion ,
  @Nombre_Objeto ,
  @Posicion ,
  @EntidadFox 
  )
  
  
END
--SP_HELP GEN_MENU
GO
