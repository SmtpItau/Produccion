USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_leeforpag2_MONEDA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create procedure [dbo].[sp_leeforpag2_MONEDA](	@nMoneda integer  )
AS

begin
	select	codigo ,
		glosa
	from	VIEW_FORMA_DE_PAGO,
		VIEW_MONEDA_FORMA_DE_PAGO
	where 	mfcodfor = codigo 
	AND	(mfcodmon = 13)


END

-- Base de Datos --
GO
