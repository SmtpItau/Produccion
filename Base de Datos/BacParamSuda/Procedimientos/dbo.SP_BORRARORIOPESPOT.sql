USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRARORIOPESPOT]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BORRARORIOPESPOT] 
/* *********************************************************************************/
/* PROCEDIMIENTO   : sp_BorrarOriOpeSpot                                           */
/* BASES DE DATOS  : BacPARAMSuda                                                  */
/* PARAM. ENTRADA  :                                                               */
/* PARAM. SALIDA   :                                                               */
/* Descripción     : Borra Registros Origenes de Operaciones Spot                  */
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
  delete FROM TABLA_GENERAL_DETALLE WHERE tbcateg = 2700
  set nocount off
END  -- DEL SP
GO
