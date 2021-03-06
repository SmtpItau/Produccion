USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_APROB_AUTOMATICA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_APROB_AUTOMATICA]
	(
		@Num_Oper as NUMERIC (10)
	)
AS      
BEGIN      

	SET NOCOUNT ON    

	BEGIN TRANSACTION
	
	DECLARE @Nemo	CHAR(10)

	UPDATE	MDDI
	SET		Estado_Operacion_Linea = ''
	FROM	MDCP
	WHERE	MDCP.cpnumdocu	= MDDI.dinumdocu
	and		MDCP.cpcorrela	= MDDI.dicorrela
	and		MDDI.digenemi	= 'BCO'
	and		MDCP.cpcodigo	IN(9, 11)
	and		MDCP.cpnumdocu	= @Num_Oper

	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRANSACTION
		SELECT -1, 'False'
		RETURN
	END

	UPDATE	MDCP
	SET		Estado_Operacion_Linea = ''
	FROM	MDDI
	WHERE	MDCP.cpnumdocu	= MDDI.dinumdocu
	and		MDCP.cpcorrela	= MDDI.dicorrela
	and		MDDI.digenemi	= 'BCO'
	and		MDCP.cpcodigo	IN(9, 11)
	and		MDCP.cpnumdocu	= @Num_Oper

	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRANSACTION
		SELECT -1, 'False'
		RETURN
	END

	UPDATE  MDMO
	SET		mostatreg	= ''
	WHERE	monumoper	= @Num_Oper
	and		morutemi	= 97023000
	and		mocodigo	IN(9, 11)

	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRANSACTION
		SELECT -1, 'False'
		RETURN
	END

	COMMIT TRANSACTION

	DECLARE @iFound		INT
		SET @iFound		= 1
 
  	 SELECT @iFound		= -1
	   FROM MDMO 
	  WHERE monumoper	= @Num_Oper
		--AND mostatreg  <> ''
		and		morutemi	= 97023000
		and		mocodigo	IN(9, 11)

	IF @iFound = -1
		SELECT -1, 'True'
	ELSE
		SELECT  1, 'False'

	
END
GO
