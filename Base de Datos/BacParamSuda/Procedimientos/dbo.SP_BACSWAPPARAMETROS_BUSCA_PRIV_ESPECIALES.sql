USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACSWAPPARAMETROS_BUSCA_PRIV_ESPECIALES]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_BacSwapParametros_Busca_Priv_Especiales    fecha de la secuencia de comandos: 03/04/2001 15:17:57 ******/
CREATE PROCEDURE [dbo].[SP_BACSWAPPARAMETROS_BUSCA_PRIV_ESPECIALES] (
        @usuario CHAR(15),
        @entidad CHAR(3) )
AS
BEGIN
 SET NOCOUNT ON
 
 IF EXISTS (SELECT 1 FROM GEN_PRIVILEGIOS WHERE usuario = @usuario AND tipo_privilegio = 'U' AND entidad=@entidad AND habilitado='S') BEGIN
  SELECT opcion,habilitado
   FROM  GEN_PRIVILEGIOS
   WHERE  usuario = @usuario 
    AND tipo_privilegio = 'U' 
    AND entidad=@entidad AND 
    habilitado='S'
 END
 ELSE BEGIN
  
  SELECT ('NO EXISTE') 
 END
 SET NOCOUNT OFF
END
GO
