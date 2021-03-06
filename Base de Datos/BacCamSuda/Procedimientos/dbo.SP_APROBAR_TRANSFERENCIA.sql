USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_APROBAR_TRANSFERENCIA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_APROBAR_TRANSFERENCIA]( @numero_operacion  NUMERIC( 7) ,
                                           @tipo                 CHAR( 1) = '' ,
                                           @correlativo       NUMERIC( 2) =  0 )
AS 
BEGIN
     IF @numero_operacion = 0  BEGIN
        SELECT -1, 'Falta definir Nro.Operacion para aprobar Transferencias'
        RETURN
     END
     IF EXISTS (SELECT * FROM tbTransferencia WHERE numero_operacion = @numero_operacion
                                                AND (tipo            = @tipo        OR @tipo       = '')
                                                AND (correlativo     = @correlativo OR @correlativo = 0))  BEGIN
        UPDATE tbTransferencia SET estado = 'A'
                             WHERE numero_operacion = @numero_operacion
                               AND (tipo            = @tipo        OR @tipo       = '')
                               AND (correlativo     = @correlativo OR @correlativo = 0)
        IF @@error <> 0   
           SELECT -1, 'Transferencias no pudieron ser aprobadas'
     END
END



GO
