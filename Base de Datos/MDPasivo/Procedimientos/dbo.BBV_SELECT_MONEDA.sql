USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_MONEDA]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SELECT_MONEDA]
AS
SELECT mncodmon,mnnemo,mnsimbol,mnglosa,mncodsuper,mnnemsuper,mncodbanco,mnnembanco,mnbase,mnredondeo,mndecimal,
       mnrrda,mnfactor,mnrefusd,mnlocal,mnextranj,mnvalor,mnrefmerc,mntipmon,mnperiodo,mnmx,mncodfox,mnvalfox,
       mncodcor,codigo_pais,codigo_canasta,codigo_variabilidad,estado,tipo_indicador,codigo_fuenteinformacion,
       flag_factorderiesgo,Ocurrencia
FROM MONEDA
GO
