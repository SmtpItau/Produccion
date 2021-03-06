USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_LINEA_SISTEMA]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SELECT_LINEA_SISTEMA]
AS
SELECT Rut_Cliente,Codigo_Cliente,codigo_grupo,FechaAsignacion,FechaVencimiento,FechaFinContrato,RealizaTraspaso,
       Bloqueado,Compartido,ControlaPlazo,TotalAsignado,TotalOcupado,TotalDisponible,TotalExceso,TotalTraspaso,
       TotalRecibido,SinRiesgoAsignado,SinRiesgoOcupado,SinRiesgoDisponible,SinRiesgoExceso,ConRiesgoAsignado,
       ConRiesgoOcupado,ConRiesgoDisponible,ConRiesgoExceso
FROM LINEA_SISTEMA
GO
