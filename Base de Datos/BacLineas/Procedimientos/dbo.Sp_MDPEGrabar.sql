USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDPEGrabar]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_MDPEGrabar    fecha de la secuencia de comandos: 03/04/2001 15:18:09 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_MDPEGrabar    fecha de la secuencia de comandos: 14/02/2001 09:58:30 ******/
CREATE PROCEDURE [dbo].[Sp_MDPEGrabar]
       (
        @ncodigo NUMERIC(03,0)   , -- C«digo
 @cperiodo      CHAR(6)  , -- Tipo de Perdodo
 @nnumero NUMERIC(03,0) , -- Intervalo de Tiempo
 @ctipo   CHAR(1)  , -- Tipo
 @cglosa         CHAR(15)   -- Glosa  
       )
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
   /*=======================================================================*/
   IF EXISTS( 
              SELECT pecodigo,
           peperiodo,
                     penumero ,
                     petipo   ,
                     peglosa             
       FROM PERIODO_TASA_BIDASK
       WHERE pecodigo = @ncodigo
            ) BEGIN
      /*====================================================================*/
      /*====================================================================*/
 UPDATE  PERIODO_TASA_BIDASK
 SET peperiodo = @cperiodo ,
  penumero = @nnumero ,
  petipo = @ctipo  ,
  peglosa = @cglosa         
 WHERE  pecodigo = @ncodigo
   /*=======================================================================*/
   /*=======================================================================*/
   END ELSE BEGIN
      /*====================================================================*/
      /*====================================================================*/
      INSERT INTO PERIODO_TASA_BIDASK ( pecodigo, peperiodo, penumero, petipo, peglosa )
             VALUES    ( @ncodigo, @cperiodo, @nnumero, @ctipo, @cglosa )
   END
SET NOCOUNT OFF
SELECT 0
END






GO
