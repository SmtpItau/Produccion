USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MNLeetodo]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_MNLeetodo]
AS
BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy

       SELECT	mncodmon	,--1
		mnnemo		,--2
		mnsimbol	,--3
		mnglosa		,--4
		mncodsuper	,--5
		mnnemsuper	,--6
		mncodbanco	,--7
		mnnembanco	,--8
		mnbase		,--9
		mnredondeo	,--10
		mndecimal	,--11
		mnrrda		,--13
		mnfactor	,--14
		mnrefusd	,--15
		mnlocal		,--16
		mnextranj	,--17
		mnvalor		,--18
		mnrefmerc	,--19
		mntipmon	,--21
		mnperiodo	,--22
		mnmx		,--23
		mncodfox	,--24
		mnvalfox	,--25
		mncodcor	,--26
		codigo_pais	--27
--		mniso_coddes	 --28
       FROM
               MONEDA
       WHERE ESTADO<>'A'

       RETURN
SET NOCOUNT OFF
END


GO
