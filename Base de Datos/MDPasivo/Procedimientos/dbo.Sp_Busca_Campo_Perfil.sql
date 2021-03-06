USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Busca_Campo_Perfil]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


/****** Objeto:  procedimiento  almacenado dbo.Sp_Busca_Campo_Perfil    fecha de la secuencia de comandos: 03/04/2001 15:17:59 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Busca_Campo_Perfil    fecha de la secuencia de comandos: 14/02/2001 09:58:23 ******/
CREATE PROCEDURE [dbo].[Sp_Busca_Campo_Perfil]( @codigo_campo     NUMERIC(3),
                                        @sistema          CHAR(3)   ,
                                        @tipo_movimiento  CHAR(3)   ,
                                        @tipo_operacion   CHAR(5)   )
AS 
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON

 SELECT descripcion_campo 
   FROM CAMPO_CNT
         WHERE codigo_campo   = @codigo_campo    
    AND id_sistema     = @sistema         
    AND tipo_movimiento = @tipo_movimiento 
    AND tipo_operacion  = @tipo_operacion
END
-- Sp_Busca_Campo_Perfil 1,'BTR','MOV','CP'


GO
