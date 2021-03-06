USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_EMI_GRB_DAT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_EMI_GRB_DAT]
		(	@rut		numeric(9)	,
			@dv		char(1)		,
			@cod		numeric(9)	,
			@nom		char(60)	,
			@clasi		char(40)	,
			@clasi2		char(40)	,
			@tipo_c1	char(20)	,
			@tipo_l1	char(20)	,
			@tipo_c2	char(20)	,
			@tipo_l2	char(20)	)
as
begin
	set nocount on
	
	if exists(select * from text_emi_itl where rut_emi = @rut and digito_ver = @dv and codigo = @cod) begin
		update	text_emi_itl
		set 	CLASIFICACION1 = @clasi	,
			nom_emi = @nom		,
			CLASIFICACION2 = @clasi2,
			tipo_corto1 = @tipo_c1	,
			tipo_largo1 = @tipo_L1	,
			tipo_corto2 = @tipo_C2	,
			tipo_largo2 = @tipo_l2	
		where	rut_emi = @rut 
		and	digito_ver = @dv 
		and 	codigo = @cod
	end
	else begin
		insert	into text_emi_itl 
		(	rut_emi		,
			digito_ver	,
			codigo		,
			nom_emi		,
			CLASIFICACION1	,			
                        CLASIFICACION2	,
			tipo_corto1 	,
			tipo_largo1 	,
			tipo_corto2 	,
			tipo_largo2 	)
		values
			(	@rut		,
				@dv		,
				@cod		,
				@nom		,
				@clasi		,
				@clasi2 	,
				@tipo_c1	,
				@tipo_L1	,
				@tipo_C2	,
				@tipo_l2	)
	end 
	
	set nocount off
end

GO
