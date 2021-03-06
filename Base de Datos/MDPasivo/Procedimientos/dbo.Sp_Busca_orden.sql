USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Busca_orden]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[Sp_Busca_orden]
		( @tipo CHAR(1))
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   IF @Tipo = '1'

      SELECT Codigo_control, Orden, Descripcion
      FROM SWITCH_OPERATIVO
      GROUP BY Codigo_control, Orden, Descripcion
      ORDER BY Orden

   IF @Tipo = '2'

      SELECT Codigo_control, Orden_Especial, Descripcion
      FROM SWITCH_OPERATIVO
      GROUP BY Codigo_control, Orden_Especial ,Descripcion
      ORDER BY Orden_Especial

END


GO
