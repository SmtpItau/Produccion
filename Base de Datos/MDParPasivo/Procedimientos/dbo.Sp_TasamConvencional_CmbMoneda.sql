USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TasamConvencional_CmbMoneda]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TasamConvencional_CmbMoneda]
	as
	begin
	set nocount on
        SET DATEFORMAT dmy
	select "mnnemo" =convert(char(8),mnnemo),
		mncodmon
	 from  MONEDA
	WHERE (mnmx <>'C')
	set nocount off
	end











GO
