USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_OPERACIONES_PTE]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGA_OPERACIONES_PTE]
   (   @Mitag     INTEGER    = 0
   ,   @MiFecha   DATETIME   = ''
   ,   @MiNumero  NUMERIC(9) = 0
   )
AS
BEGIN
   SET NOCOUNT ON

   IF @Mitag = 0
   BEGIN
      SELECT /*001*/ morutcli
      ,      /*002*/ mocodcli
      ,      /*003*/ monomcli
      ,      /*004*/ monumope
      ,      /*005*/ CASE WHEN motipope = 'C' THEN 'Compra' ELSE 'Venta' END 
      ,      /*006*/ mocodmon
      ,      /*007*/ mocodcnv
      ,      /*008*/ momonmo
      ,      /*009*/ moussme
      ,      /*010*/ moticam
      ,      /*011*/ moparme
      ,      /*012*/ momonpe
      ,      /*013*/ CASE WHEN moestatus = 'A' THEN 'Anulada'
                          WHEN moestatus = ' ' THEN 'Vigente'
                          WHEN moestatus = 'R' THEN 'Rechazada'
                          WHEN moestatus = 'P' THEN 'Pendiente'
                     END
      FROM   MEMO_PUENTE
      WHERE  mofech = @MiFecha
      ORDER BY mofech , motipope , monumope
      
      RETURN
   END

   IF @Mitag = 1
   BEGIN
      UPDATE MEMO_PUENTE
      SET    moestatus = 'A'
      WHERE  monumope  = @MiNumero

      RETURN
   END

END




GO
