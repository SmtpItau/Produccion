USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_CAMPO_PERFIL]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Busca_Campo_Perfil    fecha de la secuencia de comandos: 03/04/2001 15:17:59 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Busca_Campo_Perfil    fecha de la secuencia de comandos: 14/02/2001 09:58:23 ******/
CREATE PROCEDURE [dbo].[SP_BUSCA_CAMPO_PERFIL]( @codigo_campo     NUMERIC(3),
                                        @sistema          CHAR(3)   ,
                                        @tipo_movimiento  CHAR(3)   ,
                                        @tipo_operacion   CHAR(5)   )
AS 
BEGIN
 SELECT descripcion_campo 
   FROM CAMPO_CNT
         WHERE codigo_campo   = @codigo_campo    
    AND id_sistema     = @sistema         
    AND tipo_movimiento = @tipo_movimiento 
    AND tipo_operacion  = @tipo_operacion
END
-- Sp_Busca_Campo_Perfil 1,'BTR','MOV','CP'
GO
