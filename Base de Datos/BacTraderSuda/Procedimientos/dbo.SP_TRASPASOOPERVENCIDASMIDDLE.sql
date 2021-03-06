USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRASPASOOPERVENCIDASMIDDLE]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TRASPASOOPERVENCIDASMIDDLE]
AS
BEGIN
   SET NOCOUNT ON

   -- SP_TRASPASOOPERVENCIDASMIDDLE
   -- PENDIENTE: mantener la fecha de Early Termination
   /*=======================================================================*/
   /* Proceso de traspaso  de vencimientos									*/
   /*=======================================================================*/

   DECLARE @dfecante     DATETIME
         , @dfecproc     DATETIME
         , @dfecproxpro  DATETIME

   SELECT  @dfecante     = acfecante
   ,       @dfecproc     = acfecproc 
   ,       @dfecproxpro  = acfecprox
   FROM    MDAC          with (nolock)

   /*=======================================================================*/
   /* Proceso de traspaso  de cartera a base historica                      */
   /*=======================================================================*/


    INSERT INTO  BacLineas..TBL_RIEFIN_HIS_DRV_MIDDLE_OFFICE 
    ( MddMod
     ,MddNumOpe
     ,MddSujEarlyTerminationSN
     ,MddSujEarlyTerminationFecha
     ,MddSujEarlyTerminationPeriodo
     ,MddTipPer
     ,MddModRel
     ,MddOpeRel
     ,MddFecVcto )         
    SELECT
      MddMod
     ,MddNumOpe
     ,MddSujEarlyTerminationSN
     ,MddSujEarlyTerminationFecha
     ,MddSujEarlyTerminationPeriodo
     ,MddTipPer
     ,MddModRel
     ,MddOpeRel
     ,MddFecVcto
    FROM BacLineas..TBL_RIEFIN_DRV_MIDDLE_OFFICE with (nolock)
    WHERE MddFecVcto < @dfecproc
  
    IF @@ERROR<>0
    BEGIN
      SELECT 'NO', 'No se pudo traspasar registro a Historico'
      SET NOCOUNT OFF
      RETURN
    END


   /*=======================================================================*/
   /* Proceso de borrado de vctos. de cartera                               */
   /*=======================================================================*/

    DELETE FROM BacLineas..TBL_RIEFIN_DRV_MIDDLE_OFFICE
    WHERE MddFecVcto < @dfecproc

    IF @@ERROR <> 0
    BEGIN
      SELECT 'NO', 'No se pudieron eliminar Registros de tabla BacLineas..TBL_RIEFIN_DRV_MIDDLE_OFFICE'
      SET NOCOUNT OFF
      RETURN
    END

     SET NOCOUNT OFF

END
GO
