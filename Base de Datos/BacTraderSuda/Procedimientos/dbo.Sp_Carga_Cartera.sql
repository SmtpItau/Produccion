USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Carga_Cartera]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Carga_Cartera]
AS
BEGIN

SET NOCOUNT ON

/*********************************************************/
/******CAMBIO REALIZADO PARA FUSIÓN LD1_COR_035***********/
/*********************************************************/
SELECT tbglosa,tbvalor FROM Tabla_General_detalle WHERE tbcateg = 1111 AND  tbvalor in (1,2)
--SELECT tbglosa,tbcodigo1 FROM Tabla_General_detalle WHERE tbcateg = 204 AND tbcodigo1 in (1,2)

SET NOCOUNT OFF

END
-- Base de Datos --
GO
