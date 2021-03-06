USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_CARTERA_SISTEMA_VOLCKER_RULE]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


Create Procedure [dbo].[SP_VALIDA_CARTERA_SISTEMA_VOLCKER_RULE]
						@Sistema Char   (03)	,
						@TipoOP  Char   (05)	,
						@Cartera Numeric(10)	,
						@Nombre  Char   (60)	

As
Begin
Declare @Glosa Char    (60)	 ,
	@Carte Numeric (10)

--	If (Select )


--Select Distinct @Glosa  =  rcnombre
--from BacParamSuda.dbo.TBL_CARTERA_PRODUCTO_VOLCKER_RULE
--Where rcsistema = @Sistema
--  And rcrut     = @Cartera

--if @Nombre <> @Glosa
--begin
--	Select -1,'Codigo de la Cartera existe con la Glosa ' + @Glosa
--	Return 0
--end

Select Distinct @Carte = tbglosa 
FROM	TBL_CARTERA_PRODUCTO_VOLCKER_RULE tcvr with(nolock)
inner join 	TABLA_GENERAL_DETALLE  tgd with(nolock)
on tgd.tbcodigo1	= tcvr.Id_Cartera_VR
and tgd.tbcateg		= 206
Where Id_Sistema	= @Sistema
  And tbglosa		= @Nombre

if @Carte <> @Cartera
begin
	Select -2,'Nombre de la Cartera existe con el Codigo ' + ltrim(@Carte)
	Return 0
end


select 0,'OK'

End

GO
