USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MNLeetodo1]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_MNLeetodo1]
AS
BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy

       SELECT	mncodmon,
		mnnemo,
		mnsimbol,
		mnglosa,
		mncodsuper,
		mnnemsuper,
		mncodbanco,
		mnnembanco,
		mnbase,
		mnredondeo,
		mndecimal,
--		mncodpais,
		mnrrda,
		mnfactor,
		mnrefusd,
		mnlocal,
		mnextranj,
		mnvalor,
		mnrefmerc,
--		mningval,
		mntipmon,
		mnperiodo,
		mnmx,
		mncodfox,
		mnvalfox,
		mncodcor,
		codigo_pais
--		mniso_coddes
       FROM
               MONEDA
         WHERE  ESTADO<>'A'

       RETURN
SET NOCOUNT OFF
END




GO
