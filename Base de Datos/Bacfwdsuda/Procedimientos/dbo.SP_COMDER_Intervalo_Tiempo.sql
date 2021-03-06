USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COMDER_Intervalo_Tiempo]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_COMDER_Intervalo_Tiempo]
AS
-- =============================================
-- Author:		Sandra Vásquez
-- Create date: 27-05-2015
-- Description: Obtiene los valores de intervalo de tiempo, 
--              para la carga automática del simulador.
-- =============================================

 SELECT tbcodigo1 as id,  tbcodigo1 as nombre
 FROM BacParamSuda..TABLA_GENERAL_GLOBAL c WITH (NOLOCK) 
	 INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE d WITH (NOLOCK) ON c.ctcateg = d.tbcateg
 WHERE c.ctcateg = 9922

GO
