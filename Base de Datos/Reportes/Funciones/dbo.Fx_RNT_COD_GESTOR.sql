USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_RNT_COD_GESTOR]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select dbo.Fx_RNT_COD_GESTOR('')
--select dbo.Fx_RNT_COD_GESTOR('MFUENTESI')
--select dbo.Fx_RNT_COD_GESTOR('CAVENDAN')
--select dbo.Fx_RNT_COD_GESTOR('IZAÑARTU')
--select dbo.Fx_RNT_COD_GESTOR('RNAVARRETE')
--select dbo.Fx_RNT_COD_GESTOR('RNAVARRE')
--select DBO.Fx_RNT_COD_GESTOR('CFMO1028')
create function [dbo].[Fx_RNT_COD_GESTOR](
    @usuario_org varchar(50)
) returns varchar(8)
as

begin
--SONDA Descripcion:	funcion para evaluar el cod_gestor ( usuario )
--fecha modificacion	2019-03-12
--fecha modificacion	2019-04-04
	declare @salida varchar(50)
	declare @counter int
	declare @usuario_fin varchar(8)


	set @usuario_fin = left(ltrim(rtrim(upper(@usuario_org))),8)  
  
	select @counter = COUNT(1)  
	from   BacParamSuda.dbo.USUARIO   
	where  @usuario_fin = LEFT(ltrim(rtrim(upper(usuario))),8)  


	if @counter<1 begin  
		return 'NO ASIGNADO'
	end 

  
	if @counter>1 begin  
		set @usuario_fin = RIGHT(ltrim(rtrim(upper(@usuario_org))),8)  
	end 
  
	select @counter = COUNT(1)  
	from   BacParamSuda.dbo.USUARIO   
	where   
	--@usuario_fin = right(ltrim(rtrim(upper(usuario))),8)  
	usuario like '%'+@usuario_fin+'%'


	if @counter< 1 begin  
		return 'NO ASIGNADO'
	end  


	set @usuario_fin = replace(@usuario_fin,'Ñ','N')
	set @usuario_fin = replace(@usuario_fin,'á','A')
	set @usuario_fin = replace(@usuario_fin,'á','A')
	set @usuario_fin = replace(@usuario_fin,'é','E')
	set @usuario_fin = replace(@usuario_fin,'í','I')
	set @usuario_fin = replace(@usuario_fin,'ó','O')
	set @usuario_fin = replace(@usuario_fin,'ú','U')

	return right(space(8) + @usuario_fin,8)  

end
GO
