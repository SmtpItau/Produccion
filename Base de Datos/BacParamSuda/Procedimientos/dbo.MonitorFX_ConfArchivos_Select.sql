USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[MonitorFX_ConfArchivos_Select]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MonitorFX_ConfArchivos_Select] (  @idAmbiente  SMALLINT)

AS 

SELECT idArchivo					

      ,Arch_sCodigo			

      ,Arch_sDescripcion

      ,cA.idTipoArchivo
 
      ,Arch_sRutaFisica

      ,Arch_sNombreFisico

      ,cA.idSeparador

      ,Arch_bHabilitado

      ,Arch_bGrabaLog

      ,Arch_dHoraInicio

      ,Arch_dHoraFinal

      ,Arch_sCodColor

      ,idAmbiente

	  ,Arch_bDirectorio

	  , tA.sExtension 

	  , tS.iCodSeparador

  FROM [dbo].[MonitorFX_TblConfArchivos] cA

 LEFT 

  JOIN dbo.MonitorFX_TblTipoArchivos  tA 

    on Ta.idTipoArchivo = cA.idTipoArchivo

 INNER 

  JOIN dbo.MonitorFX_TblSeparadores tS 

    on tS.idSeparador  = cA.idSeparador 

 WHERE [Arch_bHabilitado] = 1

   AND idAmbiente = @idAmbiente ;
GO
