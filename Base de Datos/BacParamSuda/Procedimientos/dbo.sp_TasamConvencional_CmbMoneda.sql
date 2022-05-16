USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_TasamConvencional_CmbMoneda]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_TasamConvencional_CmbMoneda]
as
begin
set nocount on
	select 'mnnemo' =convert(char(8),mnnemo),
		mncodmon
	 from  MONEDA
	WHERE (mnmx <>'C') or  mncodmon=13
set nocount off
END
GO
