USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERORIOPESPOT]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEERORIOPESPOT]
/* *********************************************************************************/
/* PROCEDIMIENTO   : sp_LeerOriOpeSpot                                             */
/* BASES DE DATOS  : BacPARAMSuda                                                  */
/* PARAM. ENTRADA  :                                                               */
/* PARAM. SALIDA   :                                                               */
/* Descripción     : Lee Origenes de Operaciones Spot                              */
/* AUTOR           : Guillermo Reveco C. (SONDA SISTEMAS FINANCIEROS)              */
/* FECHA           : 02/07/2008                                                    */
/* *********************************************************************************/
/*                        MODIFICACIONES                                           */
/* *********************************************************************************/
/* Observacion     :                                                               */
/* AUTOR           :                                                               */
/* FECHA           :                                                               */
/* *********************************************************************************/
AS
BEGIN

  SET NOCOUNT ON
  select tbcodigo1, tbglosa, nemo, tbtasa FROM TABLA_GENERAL_DETALLE WITH (ROWLOCK) WHERE tbcateg = 2700
  order by tbcodigo1
  set nocount off
END  -- DEL SP

GO
