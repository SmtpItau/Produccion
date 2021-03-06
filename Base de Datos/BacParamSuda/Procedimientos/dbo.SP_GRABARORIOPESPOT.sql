USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARORIOPESPOT]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GRABARORIOPESPOT](
@p_tbcodigo1 char(06),
@p_tbglosa   char(50),
@p_nemo      char(10),
@p_tbtasa    numeric(3,0)
)
/* *********************************************************************************/
/* PROCEDIMIENTO   : sp_GrabarOriOpeSpot                                           */
/* BASES DE DATOS  : BacPARAMSuda                                                  */
/* PARAM. ENTRADA  : p_tbcodigo1: Correlativo                                      */
/*                   p_tbglosa  : Glosa de Origen                                  */
/*                   p_nemo     : Codigo de Origen                                 */
/* PARAM. SALIDA   :                                                               */
/* Descripción     : Graba Registro Origenes de Operaciones Spot                   */
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
  insert into TABLA_GENERAL_DETALLE 
   ( tbcateg, tbcodigo1   , tbtasa   , tbfecha,
     tbvalor, tbglosa     , nemo
   )
  values
   ( 2700   , @p_tbcodigo1, @p_tbtasa, ''     ,
     0      , @p_tbglosa  , @p_nemo
   )
  set nocount off
END  -- DEL SP
GO
