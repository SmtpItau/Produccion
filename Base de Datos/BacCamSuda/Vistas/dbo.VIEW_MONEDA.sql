USE [BacCamSuda]
GO
/****** Object:  View [dbo].[VIEW_MONEDA]    Script Date: 11-05-2022 16:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VIEW_MONEDA]
AS
      SELECT      
      mncodmon,
      mnnemo,
      mnsimbol,
      mnglosa,
      mncodsuper,
      mnnemsuper,
      mncodbanco,
      mnnembanco,
      mnbase,
      mnredondeo,
      mndecimal,
      mncodpais,
      mnrrda,
      mnfactor,
      mnrefusd,
      mnlocal,
      mnextranj,
      mnvalor,
      mnrefmerc,
      mningval,
      mntipmon,
      mnperiodo,
      mnmx,
      mncodfox,
      mnvalfox,
      mncodcor,
      codigo_pais,
      mniso_coddes,
      mnlimite,
      mncodcorrespC,
      mncodcorrespV,
      mncanasta,
      MNCTACAMB,
      mncodBancoC,
      mncodBancoV
     FROM 
         bacparamsuda..MONEDA


GO
