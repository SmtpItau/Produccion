USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FRMLETRASHIPOTECARIAS_TRAE_CORTES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FRMLETRASHIPOTECARIAS_TRAE_CORTES]
AS
BEGIN
      SET NOCOUNT ON
      SELECT 
       codigo_planilla
      ,correlativo
      ,corte_numero
      ,corte_monto
      ,corte_nominal
      FROM LETRA_HIPOTECARIA_CORTE
      SET NOCOUNT OFF
END

GO
