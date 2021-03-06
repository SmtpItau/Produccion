USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Carga_Instrumentos]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Carga_Instrumentos]
AS
BEGIN

SET NOCOUNT ON
/*
    SELECT inserie,inglosa
    FROM BacParamSuda.dbo.INSTRUMENTO
    WHERE  inrutemi in('97029000','60805000')
    ORDER BY inserie
*/
    SELECT	inserie,inglosa
    FROM	BacParamSuda.dbo.INSTRUMENTO
	WHERE	inserie NOT IN(
			'ICAP VV/VC',
			'ICAP VC/VC',
			'ICAP VV/VV C',
			'ICAP VV/VV D',
			'ICOL VV/VC',
			'ICOL VC/VC',
			'ICOL VV/VV C' ,
			'ICOL VV/VV D',
			'ICOL+1',
			'ICAP+1')
	/*
    WHERE	inrutemi in('97029000','60805000')
	*/
    ORDER BY inserie

END
GO
