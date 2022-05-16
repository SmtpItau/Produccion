USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_GrabarNuevoReporteRelacion]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <Javier Sanhueza>      
-- Create date: <28-08-2013>      
-- Description: <GRABA UN NUEVO REGISTRO DE RELACION PARAMETRO-REPORTE>      
-- =============================================     
CREATE PROCEDURE [dbo].[Reportes_GrabarNuevoReporteRelacion]

(@id_reporte int,
@id_parametro int)

AS
Insert	into Reportes_Relacion
				(id_reporte,
				id_parametro) 
		values	( @id_reporte, @id_parametro)
GO
