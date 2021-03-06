USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_POSICION_SPT]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_posicion_spt    fecha de la secuencia de comandos: 05/04/2001 9:20:54 ******/
/****** Objeto:  vista dbo.view_posicion_spt    fecha de la secuencia de comandos: 07/02/2001 11:43:19 ******/
CREATE VIEW [dbo].[VIEW_POSICION_SPT]
AS
SELECT
            vmcodigo,
            vmfecha,
            vmposini,
            vmpreini,
            vmposic,
            vmtotco,
            vmpmeco,
            vmtotcous,
            vmtotcope,
            vmtotve,
            vmpmeve,
            vmtotveus,
            vmtotvepe,
            vmutili,
            vmprecierre,
            vmparidad,
            vmparcom,
            vmparven,
            vmtotcopo,
            vmpmecopo,
            vmtotvepo,
            vmpmevepo,
            vmutilipo,
            vmutiltot,
            vmparmes,
            vmpositini,
            vmposition,
            vmnegocio
FROM BACPARAMSUDA..POSICION_SPT

GO
