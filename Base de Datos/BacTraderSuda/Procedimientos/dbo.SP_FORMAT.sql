USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FORMAT]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FORMAT]( @nnumero  numeric(19)  ,
    @cformato  char(70) output )  with recompile
as
begin
/*
 funcion  : sp_format
 objetivo : formatear numeros con separador de miles.
 autor    : miguel gajardo
 fecha    : 29 de junio de 2000
 modificacion : 08 de noviembre de 2000
*/
declare @cont   integer
declare @cadena   char(70)
declare @chrformato  char(1)
declare @armaformato  char(60)
declare @separador  integer
select @cadena = convert(char(50),round(@nnumero,0))
select @separador = 0
select @armaformato = ''
select @cont = len(ltrim(rtrim(@cadena)))
 while @cont >= 1
 begin
                --select @cont
  select @chrformato = substring(@cadena,@cont,1)
  select @cont = @cont - 1
  if @chrformato is not null 
  begin
   select @armaformato = @chrformato + @armaformato
   select @separador = @separador + 1
   
   if @separador = 3 and @cont >= 1 
   begin
    select @separador =  0
    select @armaformato = ',' + @armaformato
   end
   
  end
 end
select @cformato = @armaformato
end
/*
declare @formatonumerico char(60)
declare @monto   numeric(19)
select @monto = 5000000000/1000
execute sp_format @monto,@formatonumerico output
select @formatonumerico
sp_who
*/

GO
