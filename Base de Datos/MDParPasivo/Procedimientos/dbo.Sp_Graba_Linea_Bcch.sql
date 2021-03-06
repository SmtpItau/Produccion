USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_Linea_Bcch]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Graba_Linea_Bcch]
                  (	
			@id_sistema		CHAR(3)		,
			@codigo_linea		VARCHAR(5)	,
			@descripcion		VARCHAR(50)	,
			@fechaasignacion	DATETIME	,		
			@fechavencimiento	DATETIME	,	
			@fechafinContrato	DATETIME	,	
			@bloqueado		VARCHAR(1)	,
			@totalasignado		NUMERIC(19,4)	,
			@totalocupado		NUMERIC(19,4)	,
			@totaldisponible	NUMERIC(19,4)	,
			@totalexceso		NUMERIC(19,4)	,
                        @Sw                     CHAR   (1)
                  )   
AS
BEGIN
      
   SET DATEFORMAT DMY
   SET NOCOUNT ON  


            IF @Sw = '1' BEGIN

               DELETE FROM LINEA_CREDITO_BCCH 

            END

            INSERT INTO LINEA_CREDITO_BCCH
                        (
			 id_sistema
			,codigo_linea
			,descripcion
			,fechaasignacion
			,fechavencimiento
			,fechafinContrato
			,bloqueado
			,totalasignado
			,totalocupado
			,totaldisponible
			,totalexceso

			)         
		VALUES
                        (
			 @id_sistema
			,@codigo_linea
			,@descripcion
			,@fechaasignacion
			,@fechavencimiento
			,@fechafinContrato
			,@bloqueado
			,@totalasignado
			,@totalocupado
			,@totaldisponible
			,@totalexceso
			)    


  SET NOCOUNT OFF

END
  






















GO
