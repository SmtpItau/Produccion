USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_LIMITE_OPERADOR_MX]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZA_LIMITE_OPERADOR_MX]( @numope float)
as
begin

return

	declare @mtoTrans float
        declare @usuario varchar(12)

	select @mtoTrans = MontoTransaccion, 
	       @usuario  = Operador
          from Baclineas..LIMITE_TRANSACCION 
         where NumeroOperacion = @numope 
           and id_sistema = 'BFW' 
           and FechaOperacion = ( select acfecproc from mfac )

            Update Baclineas..MATRIZ_ATRIBUCION_INSTRUMENTO
               SET Acumulado_Diario  = Acumulado_Diario - @mtoTrans
             WHERE  Usuario           = @usuario
	       and  id_sistema        = 'BFW'

	    delete from Baclineas..LIMITE_TRANSACCION 
             where NumeroOperacion = @numope 
               and id_sistema = 'BFW' 
               and FechaOperacion = ( select acfecproc from mfac )

End

GO
