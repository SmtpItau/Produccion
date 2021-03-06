USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NUMOPE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_NUMOPE]
                        (
                            @entidad   char(2),
                            @tipmer    char(4),
                            @tipope    char(1),
                            @cliente   char(30),
                            @monto     numeric(19,4),
                            @tipcam    numeric(19,4),
                            @numope    numeric(7) = 0 output
                          )
as
begin
set nocount on
     update MEAC
        set accorope = (accorope + 1)
      where acentida = @entidad
     if @@error <> 0
     begin
          select -1,'NO SE PUEDE CAPTURAR CORRELATIVO'
          return -1
     end   
     if @tipmer = 'ptas'
     begin
          if @tipope = 'c'
             begin
                  update MEAC
                     set acultpta = 'compra    '+@cliente,
                         acultmon = @monto ,
                         acultpre = @tipcam
             end
          else
             begin
                  update MEAC
                     set acultpta = 'venta     '+@cliente,
                         acultmon = @monto ,
                         acultpre = @tipcam
             end
     end
     select @numope = accorope from MEAC
set nocount off
end

GO
