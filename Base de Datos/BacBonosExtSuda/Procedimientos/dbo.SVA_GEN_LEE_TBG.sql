USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_GEN_LEE_TBG]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_GEN_LEE_TBG]
                   (
		    @tccodtab1	NUMERIC(4)
   		    )
AS
BEGIN
set nocount on
	IF @tccodtab1=1	
		begin

		SELECT	tbcodigo1	,
			tbglosa
		FROM	VIEW_TABLA_GENERAL_DETALLE
		WHERE	tbcateg=@tccodtab1
		ORDER BY tbglosa,tbcodigo1

		end
	ELSE
		begin

		SELECT	tbcodigo1	,
			tbglosa
		FROM	VIEW_TABLA_GENERAL_DETALLE
		WHERE	tbcateg=@tccodtab1
		ORDER BY tbcodigo1

		end


set nocount off

END

GO
