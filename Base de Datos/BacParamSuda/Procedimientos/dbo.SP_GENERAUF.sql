USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERAUF]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GENERAUF] ( @nMes     INTEGER ,
                               @nAnn     INTEGER ,
                               @nValIpc  FLOAT   ,
                               @nUltUF   FLOAT   )    
AS
BEGIN
   SET NOCOUNT ON
 DECLARE @Mes     CHAR(02)
 DECLARE @MesT    CHAR(02)
 DECLARE @MesA    CHAR(02)
 DECLARE @dFini   DATETIME
 DECLARE @dFfin   DATETIME
 DECLARE @xFipc   DATETIME
 DECLARE @xFecha  DATETIME
 DECLARE @nUfIni  FLOAT
 DECLARE @nDDias  INTEGER
 DECLARE @nValUF  FLOAT
 DECLARE @nTotal  FLOAT
 DECLARE @nTotal1 FLOAT 
 DECLARE @nFactor FLOAT
 DECLARE @a       INTEGER
  
 -- Fecha de Inicio Mes Actual
 IF @nMes < 10  
  SELECT @Mes = RTRIM('0' + CONVERT(CHAR(1),@nMes))
 ELSE  
  SELECT @Mes = RTRIM(CONVERT(CHAR(2),@nMes))
 SELECT @dFini = CONVERT(CHAR(4),@nAnn) + @Mes + '09'
 -- Fecha de Termino Mes Termino
 IF @nMes = 12 
  BEGIN
   SELECT @MesT  = '01'
   SELECT @dFfin = CONVERT(CHAR(4),@nAnn + 1 ) + @MesT + '09'
  END
 ELSE
  BEGIN
   IF @nMes >= 9  
    SELECT @MesT = RTRIM(CONVERT(CHAR(2),@nMes + 1))
   ELSE
    SELECT @MesT = '0' + RTRIM(CONVERT(CHAR(1),@nMes + 1))
   SELECT @dFfin = CONVERT(CHAR(4),@nAnn) + @MesT + '09'
  END    
 
 -- Fecha de I.P.C. Mes Anterior, Publicado en el Mes Actual
-- SELECT @xFipc = CONVERT(CHAR(4),@nAnn) + @Mes + '01' 
 IF @nMes = 1
  SELECT @MesA = '12'
 ELSE
  SELECT @MesA = CONVERT(CHAR(2),@nMes - 1)
 IF DATALENGTH(RTRIM(@MesA)) = 1  SELECT @MesA = '0' + @MesA
      
 IF @nMes = 1
  SELECT @xFipc   = CONVERT(CHAR(4),@nAnn - 1) + @MesA + '01'
 ELSE       
  SELECT @xFipc   = CONVERT(CHAR(4),@nAnn) + @MesA + '01'      
 -- Buscar Valor UF de Fecha de Inicio
 SELECT @nUfIni = @nUltUF
 IF @nUfIni = 0 OR @nUfIni IS NULL
  SELECT @nUfIni = 0.0
 -- Grabacion de una UF
 SELECT @xfecha  = DATEADD(Day, 1, @dFini)
    SELECT @nDDias  = DATEDIFF(Day, @xfecha, @dFfin ) + 1
 EXECUTE SP_DIV @nValIpc, 100.0, @nTotal OUTPUT
 SELECT @nTotal  = @nTotal + 1
 EXECUTE SP_DIV  1 , @nDDias, @nTotal1 OUTPUT
 SELECT @nFactor = POWER( @nTotal ,@nTotal1 )
 SELECT @a = 0
 WHILE @a < @nDDias
  BEGIN
   SELECT @a = @a + 1
   SELECT @nValUF = ROUND ( @nUFini * ( POWER ( @nFactor, @a) ), 2)                    
   IF EXISTS(SELECT vmvalor FROM valor_moneda WHERE vmcodigo = 998 AND vmfecha  = @xfecha)
    UPDATE  valor_moneda SET vmvalor = @nValUF  
    WHERE  vmcodigo = 998
     AND   vmfecha  = @xfecha
   ELSE  
    INSERT INTO valor_moneda   ( vmcodigo, vmvalor, vmfecha )
    VALUES ( 998     , @nValUF, @xfecha )          
    SELECT @xfecha = DATEADD(Day, 1, @xfecha)
  END 
 -- Grabar I.P.C.
 IF EXISTS (SELECT vmvalor FROM valor_moneda WHERE vmcodigo = 500 AND vmfecha  = @xFipc)
  UPDATE  valor_moneda SET vmvalor = @nValIpc
  WHERE  vmcodigo = 500
   AND   vmfecha  = @xFipc
 ELSE  
  INSERT INTO valor_moneda   ( vmcodigo, vmvalor, vmfecha )
  VALUES ( 500     , @nValIpc, @xFipc )
 SELECT  CONVERT(CHAR(10),vmfecha,103), vmvalor 
 FROM  valor_moneda 
 WHERE  vmcodigo = 998 
  AND vmfecha  >  @dFini
 ORDER BY vmfecha
   SET NOCOUNT OFF
   RETURN
      
END
-- delete valor_moneda where vmcodigo=500 and vmfecha='20020101'
-- Sp_GeneraUF 1, 2002, -0.3, 16262.66
GO
