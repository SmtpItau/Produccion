USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SW_PARAMETROS]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SW_PARAMETROS]
AS
BEGIN
 SELECT  acsw_pd  , -- Sw Inicio de D-a
  acsw_rc  ,  -- Recompras
  acsw_rv         ,  -- Reventas
  acsw_co         , -- Contabilizaci½n Automatica
  acsw_dv         , -- Devengamiento
  acsw_cm         , -- 
  acsw_mesa       , -- Cierre de mesa
  acsw_pc         , -- Procesos de Cierre
  acsw_fd         , -- Fin de d-a
  acsw_finmes     , -- Fin de mesa
  'acsw_mm'=ISNULL(acsw_mm,'0'),  -- Valorizaci¢n Mark to Market 
  acint_c8 ,
  acint_cte ,
  acint_cteii ,
  acint_p17 ,
  acint_d3 ,
  acint_cli ,
  acint_col ,
  acint_c14 ,
  acint_rcc ,
  acint_ges ,
  acsw_dvprop ,
  acsw_dvci ,
  acsw_dvvi ,
  acsw_dvib ,
  acsw_ges
 FROM  MDAC
END

GO
