USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_TRANSFERENCIA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_BORRAR_TRANSFERENCIA]( @Numero_Operacion  NUMERIC(7)      ,
                                          @Tipo                 CHAR(1) = '' ,
                                          @Correlativo       NUMERIC(2) =  0 )
AS
BEGIN
     SET NOCOUNT ON
     DELETE FROM tbTransferencia
           WHERE numero_operacion = @numero_operacion
             AND (tipo            = @tipo        OR @tipo        = '')
             AND (correlativo     = @correlativo OR @correlativo =  0)
         
     IF @@ERROR<>0  
        SELECT -1, 'No se puede(n) eliminar Transferencia(s) de operacion ' + CONVERT(VARCHAR(10),@numero_operacion)
END



GO
