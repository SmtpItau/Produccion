USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_SEMAFORO_IBS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CONSULTAR POR ESTADO DEL SERVICIO DE ARTICULO84             */
   /* AUTOR         : PABLO MONCADA AGUILERA                                      */
   /* FECHA CRACION : 21/11/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/

CREATE PROCEDURE [dbo].[SP_CONSULTA_SEMAFORO_IBS]
AS
BEGIN
   SELECT tbtasa FROM BacParamSuda.dbo.TABLA_GENERAL_DETALLE WHERE nemo = 'BFW' AND tbcateg = 8604
END
GO
