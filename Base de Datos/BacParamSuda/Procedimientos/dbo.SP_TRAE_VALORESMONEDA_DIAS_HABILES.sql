USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_VALORESMONEDA_DIAS_HABILES]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TRAE_VALORESMONEDA_DIAS_HABILES]    
                          @vmcodigo1 NUMERIC (3) 
                         ,@vmmes     INTEGER
                         ,@vmano     INTEGER 
                         ,@vmperiodo NUMERIC (2)
						 ,@sPais     INT  = 6



AS    
BEGIN    
    
	SET NOCOUNT ON   


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CALCULO DE FERIADOS SOBRE FECHAS                            */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 21/07/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
     DECLARE @fechaAux DATETIME
	        ,@HABIL    CHAR(01)
			,@fecha    DATETIME


   /*-----------------------------------------------------------------------------*/
   /* CREACION DE TABLA DE SALIDA                                                 */
   /*-----------------------------------------------------------------------------*/
     DECLARE @SALIDA TABLE
	 (CODIGO INT
	 ,FECHA  DATETIME
	 ,VALOR  FLOAT
	 ,HABIL  VARCHAR(01))

   /*-----------------------------------------------------------------------------*/
   /* CREACION DE TABLA PRINCIPAL DE SP OFICIAL                                   */
   /*-----------------------------------------------------------------------------*/
     DECLARE @SP_SALIDA TABLE
	 (CODIGO INT
	 ,FECHA  VARCHAR(10)
	 ,VALOR  FLOAT)


   /*-----------------------------------------------------------------------------*/
   /* POBLAR REGISTROS DEL SP ORIGINAL                                            */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @SP_SALIDA
     EXECUTE BacParamSuda.dbo.SP_TRAE_VALORESMONEDA @vmcodigo1,@vmmes,@vmano,@vmperiodo


   /*-----------------------------------------------------------------------------*/
   /* VARIABLES DE CURSOR                                                         */
   /*-----------------------------------------------------------------------------*/
     DECLARE @CUR_CODIGO INT
	        ,@CUR_FECHA  VARCHAR(10)
	        ,@CUR_VALOR  FLOAT


   /*-----------------------------------------------------------------------------*/
   /* CURSOR DE REGISTROS QUE EVALUARA SI EXISTEN FERIADOS                        */
   /*-----------------------------------------------------------------------------*/
     DECLARE CURSOR_FECHAS CURSOR FOR
	  SELECT CODIGO 
	        ,FECHA  
	        ,VALOR  
        FROM @SP_SALIDA 
   	   ORDER BY FECHA ASC     

        OPEN CURSOR_FECHAS
       FETCH NEXT FROM CURSOR_FECHAS INTO @CUR_CODIGO 
	                                     ,@CUR_FECHA
										 ,@CUR_VALOR



   /*-----------------------------------------------------------------------------*/
   /* INICIO DE CICLO POR FECHA                                                   */
   /*-----------------------------------------------------------------------------*/
     WHILE @@FETCH_STATUS  = 0 BEGIN


	   /*----------------------------------------------------------------*/
	   /* CONTRUCION DE FECHA                                            */
	   /*----------------------------------------------------------------*/
         SET @fecha = CONVERT(DATETIME, SUBSTRING(@CUR_FECHA,7,4)
                                      + '-'
					   				  + SUBSTRING(@CUR_FECHA,4,2)
                                      + '-'
									  + SUBSTRING(@CUR_FECHA,1,2))	     



	   /*----------------------------------------------------------------*/
	   /* VALIDA SI ES UNA FECHA VALIDA                                  */
	   /*----------------------------------------------------------------*/
	     SET @fechaAux = @fecha
	     EXECUTE BacParamSuda.dbo.SP_MUESTRAFECHAVALIDA @fechaAux output, @sPais, 1

		 IF @fechaAux = @fecha BEGIN
		    SET @HABIL = 'S'
		 END
		 ELSE BEGIN
		    SET @HABIL = 'N'
		 END 

	   /*----------------------------------------------------------------*/
	   /* INSERTO DATOS EN LA SALIDA                                     */
	   /*----------------------------------------------------------------*/
	     INSERT INTO @SALIDA
		 (CODIGO       , FECHA      , VALOR       , HABIL )
		 VALUES
		 (@CUR_CODIGO  , @fecha     , @CUR_VALOR  , @HABIL )



       FETCH NEXT FROM CURSOR_FECHAS INTO @CUR_CODIGO 
	                                     ,@CUR_FECHA
										 ,@CUR_VALOR


     END
     CLOSE CURSOR_FECHAS
     DEALLOCATE CURSOR_FECHAS

   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
     SELECT CODIGO 
	       ,FECHA 
	       ,VALOR  
	       ,HABIL
	   FROM @SALIDA

  
END

GO
