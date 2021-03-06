USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBVA_DELETE_LINEA_PLAZO]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BBVA_DELETE_LINEA_PLAZO]
AS
BEGIN TRAN 
 DELETE Linea_por_plazo 
 FROM linea_sistema b
 where Linea_por_plazo.rut_cliente = b.rut_cliente
 and   Linea_por_plazo.codigo_cliente = b.codigo_cliente
 and   ControlaPlazo = 'n'
 and   Linea_por_plazo.codigo_grupo = b.codigo_grupo
 IF @@ERROR <> 0 
  BEGIN 
      SELECT 'ERROR AL ACTULIZAR MOVIMIENTO_FORWARD'
      ROLLBACK TRAN
      RETURN 0
  END
COMMIT TRAN 
GO
