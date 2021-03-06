USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_MTN_DETALLE_GRUPAL]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MTN_DETALLE_GRUPAL]
		(
			@iFlag 		CHAR(01)         -- I
		,	@iCodigo	CHAR(05) = ''    -- 07
		,	@iSistema	CHAR(03) = ''    -- BTR
		,	@iRutemisor	NUMERIC  = 0     -- 0 
		,       @iCodinst       NUMERIC  = 0     -- 15
		,	@iMoneda	INTEGER  = 0     -- 999  
		,	@iDescripcion	CHAR(50) = ''    -- Bonos de Bancos y Lchr terceros
		,	@iTipemisor	INTEGER  = 0     -- 2
		,	@iGlosaemisor	CHAR(50) = ''    -- INSTITUCION FINANCIERA        
       		,	@iCondicion	CHAR(20) = ''    -- ''
                ,       @Opcion         CHAR(01) = ''    -- ''

		)
AS
BEGIN
 SET NOCOUNT ON

  IF @iFlag = 'I'
    BEGIN

       IF @OPCION = 'E' BEGIN
		

            DELETE   GRUPO_POSICION_DETALLE
            WHERE    codigo_grupo = @iCodigo
            RETURN              
       END

                  	IF NOT EXISTS(SELECT 1 
        	   	   FROM GRUPO_POSICION_DETALLE
			   WHERE codigo_grupo = @iCodigo
				 AND sistema      = @iSistema
			         AND rut_emisor   = @irutemisor
				 AND codigo_instrumento = @icodinst
				 AND codigo_moneda      = @iMoneda
				 AND descripcion        = @iDescripcion
                                 AND tipo_emisor        = @iTipemisor
                                 AND Condicion          = @iCondicion)

--- select    *  from GRUPO_POSICION_DETALLE

--SELECT 'PASA'

		  BEGIN

			INSERT INTO GRUPO_POSICION_DETALLE
				(
					codigo_grupo 
				,	descripcion 
				,	Codigo_Moneda
				,   	sistema
			   	,   	rut_emisor 
		   		,   	tipo_emisor 
			   	,   	codigo_instrumento  		
                                ,       Glosa_Tipo_Emisor 
                                ,       Condicion
				)
			  VALUES
				(
					@iCodigo
				,	@iDescripcion
				,	@iMoneda
		   		,   	@iSistema
			   	,   	@irutemisor
			   	,   	@iTipemisor
			   	,   	@icodinst
                                ,       @iGlosaemisor                                 
                                ,       @iCondicion                                       
				)
		SELECT 0,'Grabación Correcta'

		RETURN
	  END
	  ELSE
	  BEGIN


                 UPDATE GRUPO_POSICION_DETALLE SET 
            			codigo_grupo = @iCodigo
			,	descripcion  = @iDescripcion
			,	Codigo_Moneda= @iMoneda
			,   	sistema      = @iSistema
		   	,   	rut_emisor   = @irutemisor
		   	,   	tipo_emisor  = @iTipemisor
		   	,   	codigo_instrumento = @icodinst  		
                        ,       Glosa_Tipo_Emisor  = @iGlosaemisor
                        ,       Condicion        = @iCondicion

                 WHERE codigo_grupo = @iCodigo
		   AND sistema      = @iSistema
		   AND rut_emisor   = @irutemisor
		   AND codigo_instrumento = @icodinst
		   AND codigo_moneda      = @iMoneda
		   AND descripcion        = @iDescripcion
                   AND tipo_emisor        = @iTipemisor
                   AND Condicion          = @iCondicion
    


		RETURN
	  END
    END

  IF @iFlag = 'B'
    BEGIN



         IF  EXISTS(SELECT 1 
        	   	   FROM GRUPO_POSICION_DETALLE
			   WHERE codigo_grupo = @iCodigo
				 AND sistema      = @iSistema)




                     SELECT codigo_grupo
                           ,sistema
                           ,rut_emisor 
                           ,tipo_emisor
                           ,codigo_instrumento 
                           ,codigo_moneda
                           ,descripcion  
                           ,'NombreSist'   = (SELECT nombre_sistema FROM BACPARAMSUDA..SISTEMA_CNT    WHERE id_sistema =sistema) 
                           ,'NombreEmisor' = case when rut_emisor =0 then '' 
                                                  else (SELECT emnombre FROM BACPARAMSUDA..EMISOR WHERE emrut =rut_emisor)
                                             end
                           ,'GlosaInst'    = case when  @iSistema ='BTR' then (SELECT inglosa FROM BACPARAMSUDA..instrumento WHERE incodigo =codigo_instrumento)
                                                  else  (SELECT Nom_Familia FROM BACBONOSEXTSUDA..text_fml_inm WHERE Cod_familia =codigo_instrumento)
                                             END
                           ,'GlosaMoneda' =(SELECT mnglosa FROM BACPARAMSUDA..MONEDA WHERE mncodmon =codigo_moneda)
                           ,'Serie'       = case when  @iSistema ='BTR' then (SELECT inserie FROM BACPARAMSUDA..instrumento WHERE incodigo =codigo_instrumento)
       else  (SELECT Nom_Familia FROM BACBONOSEXTSUDA..text_fml_inm WHERE Cod_familia =codigo_instrumento)
                                             END  
                           ,'GlosaTipoEmi' = Glosa_Tipo_Emisor
                           ,Condicion
   
                     FROM  GRUPO_POSICION_DETALLE
                     WHERE codigo_grupo = @iCodigo
	               AND sistema      = @iSistema



         ELSE 

            SELECT 'NO'


         
    END


    IF @iFlag = 'M'
    BEGIN

     IF  EXISTS(SELECT 1 
        	FROM GRUPO_POSICION_DETALLE
                WHERE codigo_grupo = @iCodigo  AND
                sistema      = @iSistema AND
                codigo_moneda      = @iMoneda)

begin       
  

        DELETE   GRUPO_POSICION_DETALLE 
            WHERE codigo_grupo = @iCodigo  AND
               sistema      = @iSistema AND
               rut_emisor  = @iRutemisor AND
               tipo_emisor = @iTipemisor AND
               codigo_instrumento = @iCodinst AND                
               codigo_moneda      = @iMoneda       


	 
		INSERT INTO GRUPO_POSICION_DETALLE
			(
				codigo_grupo 
			,	descripcion 
			,	Codigo_Moneda
			,   	sistema
		   	,   	rut_emisor 
		   	,   	tipo_emisor 
		   	,   	codigo_instrumento  		
			)
		  VALUES
			(
				@iCodigo
			,	@iDescripcion
			,	@iMoneda
		   	,   	@iSistema
		   	,   	@irutemisor
		   	,   	@itipemisor
		   	,   	@icodinst
			)
		SELECT 0,'Modificación Correcta'
		RETURN

      end   

    else

      begin

		INSERT INTO GRUPO_POSICION_DETALLE
			(
				codigo_grupo 
			,	descripcion 
			,	Codigo_Moneda
			,   	sistema
		   	,   	rut_emisor 
		   	,   	tipo_emisor 
		   	,   	codigo_instrumento  		
			)
		  VALUES
			(
				@iCodigo
			,	@iDescripcion
			,	@iMoneda
		   	,   	@iSistema
		   	,   	@irutemisor
		   	,   	@itipemisor
		   	,   	@icodinst
			)
		SELECT 0,'Modificación Correcta'
		RETURN

      end
	       
    END



  IF @iFlag = 'E'
    BEGIN



	DELETE GRUPO_POSICION_DETALLE
	 WHERE codigo_grupo = @iCodigo
           AND sistema      = @iSistema
           AND rut_emisor   = @iRutemisor
           AND codigo_instrumento = @iCodinst
           AND codigo_moneda      = @iMoneda
           AND tipo_emisor        = @iTipemisor
           AND Condicion          = @iCondicion

    END

  IF @iFlag = 'C'
    BEGIN
	SELECT *
	  FROM GRUPO_POSICION

    END

 SET NOCOUNT OFF
END

GO
