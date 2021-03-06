USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[bbv_select_view_movimiento_cambio1]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create procedure [dbo].[bbv_select_view_movimiento_cambio1]
(@fecha DATETIME)
AS
BEGIN
	select Motipmer, Monumope,Motipope, Morutcli, Monomcli,Mocodmon,Mocodcnv, Momonmo, Moticam, Momonpe,Moentre,Morecib,
	       Moparme, Moussme, Movaluta1, Movaluta2,mofech
	from view_movimiento_cambio
	where mofech = @fecha
	and Moestatus <> 'A'
	union
	select Motipmer, Monumope, 'V', Morutcli, Monomcli, Mocodmon, Mocodcnv, Momonmo, Motctra, Mouss30, Forma_Pago_Cli_Nac,
	       Forma_Pago_Cli_ext, Moparme, Moussme,Valuta_Cli_Nac, Valuta_Cli_Ext, mofech
	from view_movimiento_cambio
	where mofech = @fecha
	and motipmer = 'canj'
	and Moestatus <> 'A'
	order by motipmer, motipope, Monomcli
END

GO
