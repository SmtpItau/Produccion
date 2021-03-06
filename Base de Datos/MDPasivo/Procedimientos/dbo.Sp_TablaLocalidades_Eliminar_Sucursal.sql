USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Eliminar_Sucursal]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Sp_TablaLocalidades_Eliminar_Sucursal 77777

CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Eliminar_Sucursal]( @codigo_Sucursal INT)
AS 
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

	  IF NOT EXISTS(SELECT codigo_sucursal FROM vale_vista_emitido
			WHERE	codigo_sucursal = @codigo_Sucursal )
	  AND NOT EXISTS(SELECT sucursal,sucursal,Sucursal	FROM MDPASIVO..MOVIMIENTO_PASIVO
			WHERE sucursal = @codigo_sucursal)
	  AND NOT EXISTS(SELECT sucursal,sucursal,Sucursal	FROM MDPASIVO..MOVIMIENTO_PASIVO
			WHERE sucursal = @codigo_sucursal)
	  AND NOT EXISTS(SELECT sucursal,sucursal,Sucursal	FROM MDPASIVO..MOVIMIENTO_PASIVO
			WHERE Sucursal = @codigo_sucursal)

  	  BEGIN

			DELETE SUCURSAL WHERE	codigo_sucursal	= @codigo_sucursal

	  END ELSE
	  BEGIN
			SELECT 'RELACIONADA'
	  END
	

END



GO
