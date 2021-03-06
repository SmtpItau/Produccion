USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_Campos]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Leer_Campos]
                               (@SISTEMA          CHAR(6),
                                @TIPO_MOVIMIENTO  CHAR(6),
                                @TIPO_OPERACION   CHAR(6))
                              
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON
  SELECT 
         id_sistema ,
         tipo_movimiento,
         tipo_operacion,
         codigo_campo,
         descripcion_campo,
         nombre_campo_tabla,
         tipo_administracion_campo,
         isnull(tabla_campo,''),
         isnull(campo_tabla,''),
         isnull(campos_tablas,'')          
   FROM CAMPO_CNT 
   WHERE id_sistema = @SISTEMA
        AND tipo_movimiento = @TIPO_MOVIMIENTO
        AND tipo_operacion  = @TIPO_OPERACION
 AND tipo_administracion_campo = "V" 
END 


GO
