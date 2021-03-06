USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_Trae_Interfaz]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_Trae_Interfaz]
   (   @TIPO_INTERFAZ      CHAR(1)
   ,   @ENTIDAD            NUMERIC(9) = 0
   ,   @SISTEMA            CHAR(3)
   ,   @AREA               VARCHAR(5)
   ,   @CODIGO_INTERFAZ    CHAR(30)  
   ,   @iTipo_Retorno      Char(1) = '0'
   ,   @Fecha_Salida       Char(8) = ' '
    )
AS
BEGIN

SET DATEFORMAT dmy

DECLARE @FECHA_PROCESO          DATETIME
DECLARE @FECHA_PROXIMO_PROCESO  DATETIME
DECLARE @CONTADOR               INTEGER
DECLARE @VARIABLE               INTEGER
DECLARE @SE_TRANSMITE           INTEGER
DECLARE @FECHA_AUX              DATETIME
DECLARE @codigo_cartera	        numeric	(10)
DECLARE @rut_entidad	        numeric	(9)
DECLARE @id_sistema	        char	(3)
--DECLARE @codigo_Interfaz	char	(30)
DECLARE @nombre	                varchar	(20)  
DECLARE @descripcion	        varchar	(50)   
DECLARE @ruta_acceso	        varchar	(100)    
--DECLARE @tipo_interfaz	        char	(1)     
DECLARE @Diaria	                numeric	(1)
DECLARE @Dias	                char	(40)     
DECLARE @Mensual	        numeric	(2)
DECLARE @Casilla	        char	(30)     
DECLARE @Nemotecnico	        numeric	(1)
DECLARE @Path_Inicio	        char	(100)
DECLARE @Archivo_Inicio	        char	(20)
DECLARE @Fijo_Inicio	        char	(15)
DECLARE @Fecha_Inicio	        char	(15)
DECLARE @Extencion_Inicio	char	(15)
DECLARE @Path_Final	        char	(100)
DECLARE @Archivo_Final	        char	(20)
DECLARE @Fijo_Final	        char	(15)
DECLARE @Fecha_Final	        char	(15)
DECLARE @Extencion_Final	char	(15)
DECLARE @PLAZA                  numeric (5)
DECLARE @PAIS                   numeric (5)
--DECLARE @DIA                    numeric (2)
DECLARE @DIA                    CHAR(100)
DECLARE @DIA_AUX                CHAR(100)
DECLARE @POS                    INTEGER


CREATE TABLE #SP_RESULTADO( FECHA    DATETIME , TIPO    INTEGER )

CREATE TABLE #NUMERO(
                        NUMERO    DATETIME
                     )

CREATE TABLE #SALIDA (
                         codigo_cartera	        numeric	(10)
                        ,rut_entidad	        numeric	(9)
                        ,id_sistema	        char	(3)
                        ,codigo_Interfaz	char	(30) 
                        ,nombre	                varchar	(20)
                        ,descripcion	        varchar	(50)   
                        ,ruta_acceso	        varchar	(100)    
                        ,tipo_interfaz	        char	(1)     
                        ,Diaria	                numeric	(1)
                        ,Dias	                char	(40)     
                        ,Mensual	        numeric	(2)
                        ,Casilla	        char	(30)     
                        ,Nemotecnico	        numeric	(1)
                        ,Path_Inicio	        char	(100)
                        ,Archivo_Inicio	        char	(20)
                        ,Fijo_Inicio	        char	(15)
                        ,Fecha_Inicio	        char	(15)
                        ,Extencion_Inicio	char	(15)
                        ,Path_Final	        char	(100)
                        ,Archivo_Final	        char	(20)
                        ,Fijo_Final	        char	(15)
                        ,Fecha_Final	        char	(15)
                        ,Extencion_Final	char	(15)
                    )


      SET NOCOUNT ON

      SELECT @ENTIDAD               = CASE WHEN @ENTIDAD = 0 THEN (SELECT rcrut FROM ENTIDAD) ELSE (SELECT rcrut FROM ENTIDAD) END
      SELECT @FECHA_PROCESO         = (SELECT Fecha_Proceso  FROM DATOS_GENERALES)
      SELECT @FECHA_PROXIMO_PROCESO = (SELECT Fecha_Proxima  FROM DATOS_GENERALES)
      SELECT @PLAZA                 = (SELECT Codigo_Plaza   FROM DATOS_GENERALES)
      SELECT @PAIS                  = (SELECT Codigo_Pais    FROM DATOS_GENERALES)

      IF LTRIM(RTRIM(@Fecha_Salida)) = '' BEGIN
         SELECT @Fecha_Salida = CONVERT(CHAR(8),@FECHA_PROCESO,112)
      END 
      IF @iTipo_Retorno='0' BEGIN          

          SELECT   codigo_cartera
          ,        rut_entidad
          ,        id_sistema
          ,        'Nada'   = ' '
          ,        codigo_interfaz
          ,        'Nombre' = CASE WHEN  LEN(Archivo_Inicio)<>0 THEN  Archivo_Inicio 
                                   ELSE 
                                         ' '
                                  END
          ,        descripcion
          ,        'Path_Inicio_1' = Path_Inicio
          ,        tipo_interfaz
          ,        Diaria
          ,        Dias
          ,        Mensual
          ,        Casilla
          ,        Nemotecnico
          ,        Path_Inicio
          ,        Archivo_Inicio
          ,        Fijo_Inicio
          ,        Fecha_Inicio
          ,        Extencion_Inicio
          ,        Path_Final
          ,        Archivo_Final
          ,        Fijo_Final
          ,        Fecha_Final
          ,        Extencion_Final

          INTO     #TMP_INTERFAZ
          FROM     INTERFAZ
          WHERE              
                   id_sistema         =      @SISTEMA
          AND      rut_entidad        =      @ENTIDAD
          AND      codigo_interfaz    =      @CODIGO_INTERFAZ


          UPDATE #TMP_INTERFAZ
             SET Fecha_Final = CASE WHEN CHARINDEX('DD',Fecha_Final) <> 0 THEN REPLACE(Fecha_Final, 'DD',RIGHT(CONVERT(CHAR(8), @FECHA_SALIDA , 112 ), 2 ))
                                    ELSE REPLACE(Fecha_Final, 'DD','')
                                    END
               , Fecha_Inicio = CASE WHEN CHARINDEX('DD',Fecha_Inicio) <> 0 THEN REPLACE(Fecha_Inicio, 'DD',RIGHT(CONVERT(CHAR(8), @FECHA_SALIDA , 112 ), 2 ))
                                    ELSE REPLACE(Fecha_Inicio, 'DD','')
                                    END

          UPDATE #TMP_INTERFAZ
             SET Fecha_Final = CASE WHEN CHARINDEX('MM',Fecha_Final) <> 0 THEN REPLACE(Fecha_Final, 'MM',SUBSTRING( CONVERT(CHAR(8), @FECHA_SALIDA , 112 ), 5, 2 ))
                                    ELSE REPLACE(Fecha_Final, 'MM','')
                                    END
               , Fecha_Inicio = CASE WHEN CHARINDEX('MM',Fecha_Inicio) <> 0 THEN REPLACE(Fecha_Inicio, 'MM',SUBSTRING( CONVERT(CHAR(8), @FECHA_SALIDA , 112 ), 5, 2 ))
                                    ELSE REPLACE(Fecha_Inicio, 'MM','')
                                    END

          UPDATE #TMP_INTERFAZ
             SET Fecha_Final = CASE WHEN CHARINDEX('AAAA',Fecha_Final) <> 0 THEN REPLACE(Fecha_Final, 'AAAA',LEFT( CONVERT(CHAR(8), @FECHA_SALIDA , 112 ), 4 ))
                                    ELSE REPLACE(Fecha_Final, 'AAAA','')
                                    END
               , Fecha_Inicio = CASE WHEN CHARINDEX('AAAA',Fecha_Inicio) <> 0 THEN REPLACE(Fecha_Inicio, 'AAAA',LEFT( CONVERT(CHAR(8), @FECHA_SALIDA , 112 ), 4 ))
                                    ELSE REPLACE(Fecha_Inicio, 'AAAA','')
                                    END

          UPDATE #TMP_INTERFAZ
             SET Fecha_Final = CASE WHEN CHARINDEX('AA',Fecha_Final) <> 0 THEN REPLACE(Fecha_Final, 'AA',RIGHT(LEFT( CONVERT(CHAR(8), @FECHA_SALIDA , 112 ), 4 ),2))
                                    ELSE REPLACE(Fecha_Final, 'AA','')
                                    END
               , Fecha_Inicio = CASE WHEN CHARINDEX('AA',Fecha_Inicio) <> 0 THEN REPLACE(Fecha_Inicio, 'AA',RIGHT(LEFT( CONVERT(CHAR(8), @FECHA_SALIDA , 112 ), 4 ),2))
                                    ELSE REPLACE(Fecha_Inicio, 'AA','')
                                    END


          UPDATE #TMP_INTERFAZ
             SET Nombre       = CASE WHEN Nombre = '' THEN RTRIM(Fijo_Inicio) + LTRIM(RTRIM(Fecha_Inicio)) + '.' + LTRIM(RTRIM(Extencion_Inicio))
                                     ELSE Nombre
                                     END


          SELECT * FROM #TMP_INTERFAZ

      END ELSE BEGIN

          SELECT @VARIABLE = COUNT(*)
          FROM INTERFAZ WHERE CASILLA <> 'LOCAL'

          SELECT @CONTADOR = 1
    
          WHILE @CONTADOR <= @VARIABLE
          BEGIN

              SET ROWCOUNT @CONTADOR

              SELECT
                     @codigo_cartera	        = codigo_cartera	        
                    ,@rut_entidad	        = rut_entidad	        
                    ,@id_sistema	        = id_sistema	        
                    ,@codigo_Interfaz	        = codigo_Interfaz	
                    ,@nombre	                = nombre	                
                    ,@descripcion	        = descripcion	        
                    ,@ruta_acceso	        = ruta_acceso	        
                    ,@tipo_interfaz	        = tipo_interfaz	        
                    ,@Diaria	                = Diaria	                
                    ,@Dias	                = Dias	                
                    ,@Mensual	                = Mensual	        
                    ,@Casilla	                = Casilla	        
                    ,@Nemotecnico	        = Nemotecnico	        
                    ,@Path_Inicio	        = Path_Inicio	        
                    ,@Archivo_Inicio	        = Archivo_Inicio	        
                    ,@Fijo_Inicio	        = Fijo_Inicio	        
                    ,@Fecha_Inicio	        = Fecha_Inicio	        
                    ,@Extencion_Inicio	        = Extencion_Inicio	
                    ,@Path_Final	        = Path_Final	        
                    ,@Archivo_Final	        = Archivo_Final	        
                    ,@Fijo_Final	        = Fijo_Final	        
                    ,@Fecha_Final	 = Fecha_Final	        
                    ,@Extencion_Final	        = Extencion_Final	
              FROM  INTERFAZ WHERE CASILLA <> 'LOCAL'

              IF @Diaria = 1 OR CHARINDEX( RIGHT( CONVERT( CHAR(8) , @FECHA_PROCESO , 112 ) ,2 )  , @Dias )<>0 BEGIN
                  SELECT @SE_TRANSMITE = 1
              END ELSE BEGIN

                  /* CALCULO PARA ENCONTRAR EL DIA QUE LE CORRESPONDE GENERAR LA INTERFAZ
                  ----------------------------------------------------------------------- */
                  DELETE #NUMERO
                  DELETE #SP_RESULTADO 

                  SELECT @DIA = @DIAS
                  SELECT @POS = 1
                  WHILE LEN( @DIA ) > 0
                  BEGIN    
                      IF CHARINDEX( ',' , @DIA  )<> 0 BEGIN
                          SELECT @DIA_AUX = SUBSTRING( @DIA , @POS , CHARINDEX( ',' , @DIA  )-1 )
                          SELECT @DIA     = REPLACE( @DIA , @DIA_AUX + ',' , '' )
                      END ELSE BEGIN
                          SELECT @DIA_AUX = @DIA
                          SELECT @DIA     = ''
                      END
                      IF LEN( @DIA_AUX ) = 1 BEGIN
                          SELECT @DIA_AUX = '0'+ @DIA_AUX 
                      END
                      IF @DIA_AUX = '99' AND DATEPART(MONTH , @FECHA_PROCESO ) <> DATEPART( MONTH , @FECHA_PROXIMO_PROCESO ) BEGIN
                          INSERT #NUMERO VALUES( @FECHA_PROCESO )                      
                      END ELSE BEGIN                          
                          IF ISDATE( LEFT( CONVERT( CHAR(8) , @FECHA_PROCESO , 112 ) ,4 ) + SUBSTRING( CONVERT( CHAR(8) , @FECHA_PROCESO , 112 ) ,5, 2 ) + @DIA_AUX ) =1 BEGIN
                              INSERT #NUMERO VALUES( LEFT( CONVERT( CHAR(8) , @FECHA_PROCESO , 112 ) ,4 ) + SUBSTRING( CONVERT( CHAR(8) , @FECHA_PROCESO , 112 ) ,5, 2 ) + @DIA_AUX )
                          END                           
                      END
                  END                                        

                  SELECT @FECHA_AUX  = (
                                         SELECT NUMERO 
                                           FROM #NUMERO 
                                          WHERE  (@FECHA_PROCESO         < NUMERO AND 
                                                 @FECHA_PROXIMO_PROCESO > NUMERO)  OR
                                                 @FECHA_PROCESO = NUMERO
                                       )                  


                  IF @FECHA_AUX = @FECHA_PROCESO BEGIN
                      
                      SELECT @SE_TRANSMITE = 1
                      
                  END ELSE BEGIN                      

                      IF EXISTS( SELECT * FROM FERIADO WHERE Pais = @PAIS and Plaza = @Plaza AND Fecha = @FECHA_AUX ) OR 
                        ((DATEPART(dw, @FECHA_AUX) = 6) OR (DATEPART(dw, @FECHA_AUX) = 7)) BEGIN 
                          
                          INSERT INTO #SP_RESULTADO EXEC SP_CON_FECHA_FERIADO @PAIS , @PLAZA , @FECHA_AUX , 1 ,1, @FECHA_AUX OUTPUT 
                          SELECT @SE_TRANSMITE = 1
    
                      END ELSE BEGIN

                          SELECT @SE_TRANSMITE = 0
    
                      END                   

                  END

              END                                                      

              IF @SE_TRANSMITE = 1 BEGIN
                    INSERT #SALIDA VALUES(
                                         @codigo_cartera	
                                        ,@rut_entidad	        
                                        ,@id_sistema	        
                                        ,@codigo_Interfaz	
                                        ,CASE WHEN  LEN(@Archivo_Inicio)<>0 THEN  @Archivo_Inicio 
                                            ELSE 
                                              ''
                                         END
                                        ,@descripcion	        
                                        ,@Path_Inicio	        
                                        ,@tipo_interfaz	        
                                        ,@Diaria	        
                                        ,@Dias	                
                                        ,@Mensual	        
                                        ,@Casilla	        
                                        ,@Nemotecnico	        
                                        ,@Path_Inicio	        
                                        ,@Archivo_Inicio	
                                        ,@Fijo_Inicio	        
                                        ,@Fecha_Inicio
                                        ,@Extencion_Inicio	
                                        ,@Path_Final	        
                                        ,@Archivo_Final	        
                                        ,@Fijo_Final	        
                                        ,@Fecha_Final
                                        ,@Extencion_Final	
                                          )
              END                        
          
              SELECT @CONTADOR = @CONTADOR + 1
          
          END


          UPDATE #SALIDA
             SET Fecha_Final = CASE WHEN CHARINDEX('DD',Fecha_Final) <> 0 THEN REPLACE(Fecha_Final, 'DD',RIGHT(CONVERT(CHAR(8), @FECHA_PROCESO , 112 ), 2 ))
                                    ELSE REPLACE(Fecha_Final, 'DD','')
                                    END
               , Fecha_Inicio = CASE WHEN CHARINDEX('DD',Fecha_Inicio) <> 0 THEN REPLACE(Fecha_Inicio, 'DD',RIGHT(CONVERT(CHAR(8), @FECHA_PROCESO , 112 ), 2 ))
                                    ELSE REPLACE(Fecha_Inicio, 'DD','')
                                    END

          UPDATE #SALIDA
             SET Fecha_Final = CASE WHEN CHARINDEX('MM',Fecha_Final) <> 0 THEN REPLACE(Fecha_Final, 'MM',SUBSTRING( CONVERT(CHAR(8), @FECHA_PROCESO , 112 ), 5, 2 ))
                                    ELSE REPLACE(Fecha_Final, 'MM','')
                                    END
               , Fecha_Inicio = CASE WHEN CHARINDEX('MM',Fecha_Inicio) <> 0 THEN REPLACE(Fecha_Inicio, 'MM',SUBSTRING( CONVERT(CHAR(8), @FECHA_PROCESO , 112 ), 5, 2 ))
                                    ELSE REPLACE(Fecha_Inicio, 'MM','')
                                    END
         UPDATE #SALIDA
             SET Fecha_Final = CASE WHEN CHARINDEX('AAAA',Fecha_Final) <> 0 THEN REPLACE(Fecha_Final, 'AAAA',LEFT( CONVERT(CHAR(8), @FECHA_PROCESO , 112 ), 4 ))
                                    ELSE REPLACE(Fecha_Final, 'AAAA','')
                                    END
               , Fecha_Inicio = CASE WHEN CHARINDEX('AAAA',Fecha_Inicio) <> 0 THEN REPLACE(Fecha_Inicio, 'AAAA',LEFT( CONVERT(CHAR(8), @FECHA_PROCESO , 112 ), 4 ))
                                    ELSE REPLACE(Fecha_Inicio, 'AAAA','')
                                    END
          UPDATE #SALIDA
             SET Fecha_Final = CASE WHEN CHARINDEX('AA',Fecha_Final) <> 0 THEN REPLACE(Fecha_Final, 'AA',RIGHT(LEFT( CONVERT(CHAR(8), @FECHA_PROCESO , 112 ), 4 ),2))
                                    ELSE REPLACE(Fecha_Final, 'AA','')
                                    END
               , Fecha_Inicio = CASE WHEN CHARINDEX('AA',Fecha_Inicio) <> 0 THEN REPLACE(Fecha_Inicio, 'AA',RIGHT(LEFT( CONVERT(CHAR(8), @FECHA_PROCESO , 112 ), 4 ),2))
                                    ELSE REPLACE(Fecha_Inicio, 'AA','')
                                    END

         

          UPDATE #SALIDA
             SET Nombre       = CASE WHEN Nombre = '' THEN RTRIM(Fijo_Inicio) + LTRIM(RTRIM(Fecha_Inicio)) + '.' + LTRIM(RTRIM(Extencion_Inicio))
                                     ELSE Nombre
                                     END



          SELECT * FROM #SALIDA

          SET ROWCOUNT 0
          
      END

      SET NOCOUNT OFF

END



GO
