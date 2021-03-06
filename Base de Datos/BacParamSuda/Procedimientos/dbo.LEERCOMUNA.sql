USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[LEERCOMUNA]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.LeerComuna    fecha de la secuencia de comandos: 03/04/2001 15:17:56 ******/
/****** Objeto:  procedimiento  almacenado dbo.LeerComuna    fecha de la secuencia de comandos: 14/02/2001 09:58:22 ******/
CREATE PROCEDURE [dbo].[LEERCOMUNA] 
    (
     @cod_pai      NUMERIC(6),
                              @cod_ciu      NUMERIC(6),
                               @cod_com      NUMERIC(6) 
    )
AS
BEGIN   
SET NOCOUNT ON
 SELECT DISTINCT cod_com,nom_ciu
                
        FROM
         CIUDAD_COMUNA, TABLA_GENERAL_DETALLE
      WHERE
--  tbcodigo1 = (tbcodigo1 + 1) 
--        and 
   cod_pai = @cod_pai
        AND      cod_ciu = @cod_ciu
        AND      cod_com = @cod_com
      
 ORDER BY NOM_CIU
 RETURN
SET NOCOUNT OFF
END  
GO
