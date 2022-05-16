USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PARIDADES_CENTRAL]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_PARIDADES_CENTRAL]
AS
BEGIN
  DECLARE @Fecha_Proceso CHAR(8)
  SELECT @Fecha_Proceso=CONVERT(char(8),acfecpro,112) FROM meac
  SELECT vmcodigo,mnglosa FROM view_posicion_spt,view_moneda WHERE mnnemo = vmcodigo AND vmfecha = @Fecha_Proceso AND mnmx = 'C' AND vmparmes=0.0
END


GO
