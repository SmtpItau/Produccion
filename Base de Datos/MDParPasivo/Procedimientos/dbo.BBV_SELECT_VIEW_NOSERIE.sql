USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_VIEW_NOSERIE]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SELECT_VIEW_NOSERIE]
AS
SELECT nsrutcart,nsnumdocu,nscorrela,nsrutemi,nsmonemi,nstasemi,nsbasemi,nsfecemi,nsfecven,nsserie,nscodigo,
       keyid_desk_manager,libro_desk_manager,numero_pu
FROM VIEW_NOSERIE
GO
