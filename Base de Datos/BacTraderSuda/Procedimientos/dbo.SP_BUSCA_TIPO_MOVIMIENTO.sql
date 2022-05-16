USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_TIPO_MOVIMIENTO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_TIPO_MOVIMIENTO]( @tipo_operacion char(5) )
as
begin
set nocount on
select tipo_movimiento_caja,
       genera_docto
  from VIEW_MOVIMIENTO_CNT
 where tipo_operacion = @tipo_operacion
end   /* fin procedimiento */

GO
