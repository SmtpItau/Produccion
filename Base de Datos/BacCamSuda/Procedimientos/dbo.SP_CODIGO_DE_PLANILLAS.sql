USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CODIGO_DE_PLANILLAS]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_CODIGO_DE_PLANILLAS]
 ( 
   @codigotabla float,
   @codigo varchar(255),
   @sw  numeric(1)
 )
as
begin
 declare @aux varchar(255)
 select @aux = 'select codigo_numerico ,codigo_caracter ,glosa '
 select @aux = @aux +  'from VIEW_AYUDA_PLANILLA '
 select @aux = @aux + 'where codigo_tabla = ' + @codigotabla
        
        if @sw = 1 
 begin
            select @aux = @aux + ' and codigo_numerico = ' + convert(numeric,@codigo)
        end else begin
            select @aux = @aux + ' and codigo_caracter = ' + @codigo
        end
 
 execute ( @aux )
end 

GO
