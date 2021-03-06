USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_Emisor]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*************************************************************************************
EXEC Sp_Graba_Emisor  97051000, '1', 'BANCO DEL DESARROLLO', 'DES', '', 0, '1', 1, 'S'
sp_help Emisor
**************************************************************************************/
CREATE PROCEDURE [dbo].[Sp_Graba_Emisor](	@xRut		NUMERIC(9)	,
					@xDv		CHAR(1)		,
					@xNombre	CHAR(40)	,
					@xGeneric	CHAR(10)	,
					@xDirecc	CHAR(40)	,
					@xComuna	NUMERIC(4)	,
					@xTipoE	        CHAR(3)		,
					@xCodigo	NUMERIC(5)	,
                                        @emglosa        CHAR(1)         )
AS
BEGIN

   DECLARE @vGenerico	CHAR(10)

   SET NOCOUNT ON
   SET DATEFORMAT dmy

  IF EXISTS (SELECT 1 FROM EMISOR WHERE emgeneric = @xGeneric AND emrut <> @xRut ) 
  BEGIN

       SELECT 'GENERICO','Generico del Cliente ya existe'
       RETURN

  END


  IF EXISTS(SELECT 1 FROM Emisor WHERE emrut = @xrut) BEGIN
	SELECT @vGenerico = emgeneric FROM Emisor WHERE emrut = @xrut

        UPDATE EMISOR SET 	emnombre 	=	@xNombre		,
				emgeneric	=	@xGeneric		,
				emdirecc	=	@xDirecc		,
				emcomuna	=	@xComuna		,
				emtipo		=	@xTipoE		        ,
				emcodigo	=	@xCodigo		,
	                        emglosa         =       @emglosa
	WHERE 			emrut  		=       @xRut

	---------------------------------------------------------------------------------
	--ACTUALIZACIÓN DE CARTERA DISPONIBLE CON EL NUEVO GENERICO (SOLO SI SE MODIFICA)
	---------------------------------------------------------------------------------
/*
	IF @vGenerico <> @xGeneric BEGIN		
		UPDATE VIEW_CARTERA_DISPONIBLE
		SET DIGENEMI    = @xGeneric
		FROM VIEW_CARTERA_PROPIA, VIEW_SERIE
		WHERE CPSERIADO = 'S'
		AND SEMASCARA   = CPMASCARA
		AND SERUTEMI    = @xrut
		AND CPNUMDOCU   = DINUMDOCU
		AND CPCORRELA   = DICORRELA

		UPDATE VIEW_CARTERA_DISPONIBLE
		SET DIGENEMI    = @xGeneric
		FROM VIEW_CARTERA_PROPIA, VIEW_NOSERIE
		WHERE CPSERIADO = 'N'
		AND CPNUMDOCU   = NSNUMDOCU
		AND CPCORRELA   = NSCORRELA
		AND NSRUTEMI    = @xrut
		AND CPNUMDOCU   = DINUMDOCU
		AND CPCORRELA   = DICORRELA
	END
*/
	---------------------------------------------------------------------------------
     
  END ELSE BEGIN
     INSERT INTO Emisor(	emrut		,
				emdv		,
				emnombre	,
				emgeneric	,
				emdirecc	,
				emcomuna	,
				emtipo		,
				emcodigo	,
	                        emglosa         ) 
    	VALUES(			@xRut		,
				@xDv		,
				@xNombre	,
				@xGeneric	,
				@xDirecc	,
				@xComuna	,
				@xTipoE	        ,
				@xCodigo	,
	                        @emglosa        )
  END
IF @@error <> 0  BEGIN
   SET NOCOUNT OFF
       SELECT 'NO'
       RETURN
END

SET NOCOUNT OFF
SELECT 'SI'
END
GO
