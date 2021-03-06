USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_PLANILLAOPERACION]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_BORRAR_PLANILLAOPERACION]
                                            (
                                            @tipo_documento          numeric(1),
                                            @tipo_operacion_cambio   numeric(3),
         @comercio       char(6),
         @concepto       char(3)
                                            )
as
begin
    PRINT '<< BORRANDO >>'
    print @tipo_documento
    print @tipo_operacion_cambio
    --print (@comercio + ' / ' + @concepto)
    delete from VIEW_CODIGO_PLANILLA_AUTOMATICA
          where (@tipo_documento        =  0 or @tipo_documento        = tipo_documento       ) and
                (@tipo_operacion_cambio =  0 or @tipo_operacion_cambio = tipo_operacion_cambio) and
  (@comercio              = '' or @comercio              = comercio       ) and
  (@concepto  = '' or @concepto              = concepto             )
end




GO
