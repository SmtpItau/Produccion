USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_ValoresMoneda]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Graba_ValoresMoneda]
                                          (	@xCodigo		NUMERIC(3)		,
						@xFecha		DATETIME		,
						@xValor		NUMERIC(19,4)		)
AS
BEGIN
      
   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
   SET DATEFORMAT dmy
   SET NOCOUNT ON  

   DECLARE @DO FLOAT,
           @tipo_moneda 		CHAR(1)		,
           @debil_fuerte 		CHAR(1)		,
           @paridad   			NUMERIC(12,4)	,
           @nemo   			CHAR(8)		,
           @area_defecto 		CHAR(5)
           ,@fecha_anterior_habil  	DATETIME         
           ,@pais 			NUMERIC(5)
           ,@plaza 			NUMERIC(5)
	   ,@fecha_proceso		DATETIME

     SELECT	@fecha_proceso = fecha_proceso	,
		@plaza =codigo_plaza,
            	@pais  =codigo_pais
     FROM 	DATOS_GENERALES WITH (NOLOCK)

     CREATE TABLE #FERIADO(FECHA DATETIME)
     INSERT INTO #FERIADO EXEC SP_CON_FECHA_FERIADO @pais,@plaza,@xfecha,3,1
     SELECT @fecha_anterior_habil = fecha FROM #FERIADO
       
     IF EXISTS(SELECT 1 FROM VALOR_MONEDA WITH (NOLOCK) WHERE vmcodigo = @xCodigo AND vmfecha = @xFecha)
            UPDATE VALOR_MONEDA WITH (ROWLOCK)
		SET		vmvalor = @xValor 
		WHERE vmcodigo = @xCodigo AND vmfecha = @xFecha
     ELSE
            INSERT INTO VALOR_MONEDA WITH (ROWLOCK)
			(	vmcodigo	,
				vmfecha	,
				vmvalor	)
		VALUES(		@xCodigo	,
				@xFecha	,
				@xValor	)

     SELECT @do = 1 

     SELECT @do = CASE WHEN vmvalor = 0 THEN 1 else vmvalor END
     FROM VALOR_MONEDA WITH (NOLOCK)
     WHERE vmcodigo = 994 and vmfecha = @xfecha
         
     SELECT @tipo_moneda   = mnextranj ,
            @debil_fuerte  = mnrrda,
            @nemo          = mnnemo
     FROM MONEDA WITH (NOLOCK) 
     WHERE mncodmon = @xcodigo
        
     SELECT @area_defecto = 'PTAS'

     SELECT @area_defecto = codigo_area
     FROM AREA_PRODUCTO WITH (NOLOCK)
     WHERE posicion_cambio = 1
     
     IF @tipo_moneda ='0' BEGIN
    
        IF @debil_fuerte ='D' 
            EXEC sp_div @do,@xvalor , @paridad output
        ELSE
            EXEC sp_div @xvalor,@do , @paridad output


        SELECT @paridad = ROUND(@paridad,4)
--        SELECT = CASE WHEN @debil_fuerte ='D' then else @xvalor/@do END
       UPDATE VALOR_MONEDA WITH (ROWLOCK)
		SET vmparidad = @paridad 
	WHERE vmcodigo = @xcodigo and vmfecha = @xfecha

/*
         IF NOT EXISTS(SELECT vmcodigo FROM VIEW_POSICION WHERE vmfecha = @xfecha 
                                                          AND   vmcodigo =@nemo
                                                          AND   codigo_area = @area_defecto)  BEGIN
            INSERT INTO VIEW_POSICION WITH (ROWLOCK)
                    (     
                          codigo_area
                     ,    vmcodigo
                     ,    vmfecha
                     ,    vmposini
                     ,    vmparidad
                     ,    vmparmes
                    ,     vmpreini
                    )
                   VALUES
                    (    
                          @area_defecto
                     ,    @nemo
                     ,    @xfecha  
                     ,    0
                     ,    @paridad
                     ,    0          
                     ,  @xValor
                    )         
         END ELSE BEGIN

               UPDATE VIEW_POSICION WITH (ROWLOCK)
               SET vmparidad                    =    @paridad ,
                   vmpreini                     =    @xValor
               WHERE vmcodigo                     =    @nemo
               AND CONVERT(CHAR(10),vmfecha,112)  =    @xFECHA
               AND codigo_area                    =    @area_defecto                

         END

         IF  (SELECT vmparmes FROM VIEW_POSICION WHERE vmcodigo   =    @nemo
                               AND CONVERT(CHAR(10),vmfecha,112)  =    @xFECHA
                               AND codigo_area                    =    @area_defecto) = 0 BEGIN

                   
                 SELECT 'parmes' = vmparmes , 'codigo' = vmcodigo ,'Fecha' = vmfecha
                 INTO #POSICION 
                 FROM VIEW_POSICION a 
                 WHERE  vmfecha =   @fecha_anterior_habil
                 AND    a.CODIGO_AREA   =   @AREA_defecto
                 AND    VMCODIGO      =@nemo

                 UPDATE VIEW_POSICION WITH (ROWLOCK)
                 SET    vmparmes                  =   parmes
                 FROM   #POSICION 
                 WHERE  vmfecha                   =   @xfecha
                 AND    CODIGO_AREA                     = @area_defecto
                 AND    VMCODIGO                    =   codigo
                 AND    DATEPART(MONTH,fecha) = DATEPART(MONTH,CONVERT(DATETIME,@xfecha))
     
          END
*/
     END

IF @@ERROR <> 0 BEGIN
  SELECT 'NO'
  RETURN
END

	IF @xCodigo = 444 AND @xFecha = @fecha_proceso
		BEGIN
			EXEC SP_CALC_PROMEDIOCAMARA	
		END


SELECT 'SI'
END


GO
