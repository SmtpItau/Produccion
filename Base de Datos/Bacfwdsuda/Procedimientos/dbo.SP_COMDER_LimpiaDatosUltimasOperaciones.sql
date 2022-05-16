USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COMDER_LimpiaDatosUltimasOperaciones]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_COMDER_LimpiaDatosUltimasOperaciones](@UsuarioLog VARCHAR(20))
AS
BEGIN
-- =============================================
-- Author:		Sandra Vásquez
-- Create date: 11-06-2015
-- Description: Elimina las operaciones del simulador
--              para resetear las operaciones marcadas como anuladas.
-- =============================================

	-- ELIMINA LAS OPERACIONES DEL SIMULADOR
	   DELETE COMDER_Simulador_Lineas WHERE UsuarioLog = @UsuarioLog

END

GO
