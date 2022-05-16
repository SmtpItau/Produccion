USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[view_tabla_glcode]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[view_tabla_glcode] AS
  SELECT Codigo_Transaccion,
         Codigo_Campo_Condicion,
         Codigo_Condicion,
         Descripcion,
         Cuenta_Glcode,
         Cuenta_Supoer,
         Cuenta_Altamira,
         Cuenta_Cosif,
         Cuenta_Cosif_Ger,
         Cuenta_Glcode_INT,
         Cuenta_Glcode_REA,
         Cuenta_Altamira_per 
  FROM BacParamSuda..tabla_glcode


-- Base de Datos --
GO
