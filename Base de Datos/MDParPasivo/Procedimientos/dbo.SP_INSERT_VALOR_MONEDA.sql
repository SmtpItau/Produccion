USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_VALOR_MONEDA]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERT_VALOR_MONEDA]
AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON

	DELETE VALOR_MONEDA

	DELETE desarrollo.MDVM WHERE VMFECHA = '19930701' AND VMCODIGO =  432
	DELETE desarrollo.MDVM WHERE VMFECHA = '19930701' AND VMCODIGO =  433
	DELETE desarrollo.MDVM WHERE VMFECHA = '19960701' AND VMCODIGO =  433
	DELETE desarrollo.MDVM WHERE VMFECHA = '19941001' AND VMCODIGO =  431
	DELETE desarrollo.MDVM WHERE VMFECHA = '19950201' AND VMCODIGO =  431

 
	INSERT INTO VALOR_MONEDA (
		vmcodigo              ,
		vmvalor               ,
		vmptacmp              ,
		vmptavta              ,
		vmfecha               ,
		vmparidad             ,
		vmposini              ,	
		vmposic               ,
		vmtotco               ,
		vmtotve               ,
		vmvalor_BO                                            )
	SELECT	CONVERT(NUMERIC(5),VMCODIGO)     ,
		CONVERT(FLOAT,VMVALOR)               ,
		0                     ,
		0                     ,
		VMFECHA               ,
		0                     ,
		0                     ,
		0                     ,
		0                     ,
		0                     ,
		0
	FROM desarrollo.MDVM
	WHERE VMCODIGO NOT IN ( 12, 201, 221, 429, 430, 501, 901, 996 )

END

GO
