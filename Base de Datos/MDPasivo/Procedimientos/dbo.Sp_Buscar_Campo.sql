USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Buscar_Campo]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Buscar_Campo]( @id_sistema          CHAR(3) = '',
                                  @tipo_movimiento     CHAR(3) = '',  
                                  @tipo_operacion      CHAR(5) = '',  
                                  @codigo_campo     NUMERIC(3) = 0  
                                 )
AS BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


     SELECT id_sistema, tipo_movimiento, tipo_operacion, 
            codigo_campo, descripcion_campo, nombre_campo_tabla, tipo_administracion_campo,
            tabla_campo, campo_tabla, campos_tablas --- para perfiles variables
       FROM CAMPO_CNT 
      WHERE (@id_sistema      = '' OR id_sistema      = @id_sistema     )
        AND (@tipo_movimiento = '' OR tipo_movimiento = @tipo_movimiento)
        AND (@tipo_operacion  = '' OR tipo_operacion  = @tipo_operacion )
        AND (@codigo_campo    =  0 OR codigo_campo    = @codigo_campo   )
      ORDER BY id_sistema, tipo_movimiento, tipo_operacion, codigo_campo
END 

GO
