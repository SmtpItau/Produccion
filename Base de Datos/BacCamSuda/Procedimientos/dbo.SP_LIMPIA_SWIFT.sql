USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMPIA_SWIFT]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LIMPIA_SWIFT](
     @numero_swift NUMERIC(10)
    )
AS 
BEGIN
 SET NOCOUNT ON
 
 UPDATE memo
 SET numerointerfaz = '' ,
  moimpreso = ''
 WHERE numerointerfaz   = @numero_swift 
/*
 FROM tbtransferencia
 WHERE numero_operacion = @numero_swift AND 
  usuario   = ''   AND
  usuario1  = ''   AND
  numerointerfaz   = @numero_swift 
*/
 DELETE tbtransferencia_detalle
 FROM tbtransferencia
 WHERE tbtransferencia.numero_operacion = tbtransferencia_detalle.numero_operacion AND
  tbtransferencia.numero_operacion = @numero_swift
--  tbtransferencia.usuario   = ''      AND
--  tbtransferencia.usuario1  = ''      AND
 DELETE tbtransferencia
 WHERE tbtransferencia.numero_operacion = @numero_swift 
/* AND
  tbtransferencia.usuario   = ''   AND
  tbtransferencia.usuario1  = ''
*/
 SET NOCOUNT OFF
END



GO
