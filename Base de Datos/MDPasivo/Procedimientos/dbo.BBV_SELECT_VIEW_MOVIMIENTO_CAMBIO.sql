USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_VIEW_MOVIMIENTO_CAMBIO]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SELECT_VIEW_MOVIMIENTO_CAMBIO]
@fecha datetime
AS
select Motipmer, Monumope,Motipope, Morutcli, Monomcli,Mocodmon,Mocodcnv, Momonmo, Moticam, Momonpe,Moentre,Morecib,
Moparme, Moussme 
from view_movimiento_cambio
where mofech = @fecha
and Moestatus <> 'A'
order by motipmer, motipope, Monomcli
GO
