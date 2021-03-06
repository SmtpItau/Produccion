USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PLANILLON_CALCULA_SECCION3]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_PLANILLON_CALCULA_SECCION3]
            (
            @dfecha  char(8)         ,   
            @ncodigo int  ,
            @ntipo          int             ,
            @ncantidad int output ,
            @nmonto  float output
            )
as 
begin
   set nocount on
     select @ncantidad      = count(*)      ,
            @nmonto         = sum(p.monto_dolares)
       FROM TBCODIGOSOMA    O,
            VIEW_PLANILLA_SPT     P
      where planilla_fecha          = @dfecha
        and p.tipo_operacion_cambio = @ncodigo
        and p.tipo_documento        = @ntipo
        and o.codigo_numerico       = p.tipo_operacion_cambio
      group by p.tipo_operacion_cambio
   set nocount off
end



GO
