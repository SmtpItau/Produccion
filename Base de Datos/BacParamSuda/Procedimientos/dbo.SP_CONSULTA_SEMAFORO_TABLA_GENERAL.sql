USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_SEMAFORO_TABLA_GENERAL]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_SEMAFORO_TABLA_GENERAL]
                         @NEMO    CHAR(10)
						,@tbcateg NUMERIC
AS
BEGIN

   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CONSULTAR DETALLES DE SEMAFOROS TABLA GENERAL DETALLES      */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 19/08/2015                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   
   SELECT tbcodigo1
         ,tbtasa
         ,tbfecha
         ,tbvalor
         ,tbglosa
     FROM BacParamSuda.dbo.TABLA_GENERAL_DETALLE WHERE nemo = @NEMO AND tbcateg = @tbcateg
END

GO
