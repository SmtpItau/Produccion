USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProdxCampos_LeeCampos]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ProdxCampos_LeeCampos](
                  @codigo_campo      	NUMERIC(3) = 0
		 ,@evento		VARCHAR(10)
		 ,@administracion	VARCHAR(1)
            )
AS
-- Sp_ProdxCampos_LeeCampos '101', 'DEV'
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

	SELECT 	
		b.codigo_producto
		,b.descripcion
      		,b.id_sistema
	      	,b.contabiliza
		,CASE WHEN ISNULL(codigo_campo,0) <> 0 THEN 'S' ELSE 'N' END marca

	FROM 	campo_cnt	a
		,producto	b
	WHERE 	tipo_operacion 			=* codigo_producto
		AND tipo_movimiento 		= @evento
		AND ISNULL(codigo_campo,0) 	= @codigo_campo
		AND tipo_administracion_campo	= @administracion
        ORDER BY descripcion,ISNULL(codigo_campo,0)
            

      SET NOCOUNT OFF

END

GO
