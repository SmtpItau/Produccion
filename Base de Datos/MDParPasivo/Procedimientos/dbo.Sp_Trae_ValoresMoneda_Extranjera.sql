USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Trae_ValoresMoneda_Extranjera]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Trae_ValoresMoneda_Extranjera]( @vmcodigo1 NUMERIC (3)  ,
                              @vmmes  INTEGER   , 
                              @vmano  INTEGER          ,
	       		      @vmperiodo      NUMERIC (  2)     )
AS   
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON
  
  CREATE TABLE #VALORESMONEDA(  	codigo  NUMERIC(3,0)  ,
     		            		fecha   DATETIME  ,
     				        valor   NUMERIC(19,4) NULL  )
 
   DECLARE @fechainicio   DATETIME,
    @fechafinal   DATETIME,
    @xvalor     NUMERIC(19,4)
    SELECT @fechainicio = CONVERT(DATETIME,ltrim( str(@vmano)) +  case when @vmmes <  10 THEN '0' +  ltrim( str( @vmmes))  ELSE  ltrim( str( @vmmes))  END + '01' )   
    SELECT @fechafinal  = CONVERT(DATETIME,DATEADD(day,-1,dateadd(month,1,@FechaInicio)),112)

IF  @vmperiodo = 1 
BEGIN
  WHILE @fechainicio < = @fechafinal
   BEGIN
   
   IF EXISTS(SELECT vmvalor_BO FROM VALOR_MONEDA WHERE vmcodigo = @vmcodigo1 AND vmfecha = @fechainicio)
     SELECT @xvalor = vmvalor_BO FROM VALOR_MONEDA WHERE vmcodigo = @vmcodigo1 AND vmfecha = @fechainicio
     
   ELSE
     SELECT @xvalor = 0
   INSERT INTO #VALORESMONEDA VALUES(@vmcodigo1,@fechainicio,@xvalor)
                           SELECT @fechainicio = DATEADD(day,1,@fechainicio)
   END
   SELECT codigo,CONVERT(CHAR(10),fecha,103), valor FROM #VALORESMONEDA ORDER BY fecha
END
ELSE
BEGIN
   IF EXISTS(SELECT vmcodigo,CONVERT(CHAR(10),vmfecha,103), vmvalor_BO FROM VALOR_MONEDA WHERE @fechainicio = vmfecha and vmcodigo = @vmcodigo1) 
       SELECT vmcodigo,CONVERT(CHAR(10),vmfecha,103), vmvalor_BO FROM VALOR_MONEDA WHERE vmfecha = @fechainicio and vmcodigo = @vmcodigo1
   ELSE
 begin 
        SELECT @xvalor = 0
    INSERT INTO #VALORESMONEDA VALUES(@vmcodigo1,@fechainicio,@xvalor)
        SELECT codigo,CONVERT(CHAR(10),Fecha,103), ISNULL(Valor,0) FROM #VALORESMONEDA ORDER BY fecha                           
 end 
END

END

GO
