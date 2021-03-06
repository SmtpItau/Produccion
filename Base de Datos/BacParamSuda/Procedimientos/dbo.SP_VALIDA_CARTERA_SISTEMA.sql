USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_CARTERA_SISTEMA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create Procedure [dbo].[SP_VALIDA_CARTERA_SISTEMA]
						@Sistema Char   (03)	,
						@TipoOP  Char   (05)	,
						@Cartera Numeric(10)	,
						@Nombre  Char   (60)	

As
Begin
Declare @Glosa Char    (60)	 ,
	@Carte Numeric (10)

--	If (Select )


Select Distinct @Glosa  =  rcnombre
from BacParamSuda.dbo.TIPO_CARTERA
Where rcsistema = @Sistema
  And rcrut     = @Cartera

if @Nombre <> @Glosa
begin
	Select -1,'Codigo de la Cartera existe con la Glosa ' + @Glosa
	Return 0
end

Select Distinct @Carte = rcrut
from BacParamSuda.dbo.TIPO_CARTERA
Where rcsistema = @Sistema
  And rcnombre  = @Nombre

if @Carte <> @Cartera
begin
	Select -2,'Nombre de la Cartera existe con el Codigo ' + ltrim(@Carte)
	Return 0
end


select 0,'OK'

End
GO
