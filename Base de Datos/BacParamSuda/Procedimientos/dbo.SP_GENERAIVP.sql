USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERAIVP]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GENERAIVP] ( @nMes     INTEGER ,
                                @nAnn     INTEGER ,
                                @nValIpc  FLOAT   ,
				@vValIVP  FLOAT   ,
				@dfecha	  DATETIME)
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Mes      CHAR(02)
   DECLARE @MesT     CHAR(02)
   DECLARE @MesA     CHAR(02)
   DECLARE @dFini    CHAR(10)
   DECLARE @dFfin    CHAR(10)
   DECLARE @xFipc    CHAR(10)
   DECLARE @xFecha   CHAR(10)
   DECLARE @nIVPIni  FLOAT
   DECLARE @f6matipc CHAR(10)
   DECLARE @f6matras CHAR(10)
   DECLARE @nIpc6ma  FLOAT
   DECLARE @nDifDias INTEGER
   DECLARE @nFacDias FLOAT
   DECLARE @nFacAux  FLOAT
   DECLARE @nFactor  FLOAT
   DECLARE @nDDias   INTEGER
   DECLARE @a        INTEGER
   DECLARE @nValIvp  FLOAT

--<<*******************************************************************************  
--<< Fecha de Inicio
--<< Mes Actual
--<<*******************************************************************************
   IF @nMes < 10  
      SELECT @Mes = RTRIM('0' + CONVERT(CHAR(1),@nMes))
   ELSE  
      SELECT @Mes = RTRIM(CONVERT(CHAR(2),@nMes))
      SELECT @dFini = CONVERT(CHAR(4),@nAnn) + @Mes + '09'


--<<******************************************************************************   
--<< Fecha de Termino
--<< Mes Termino
--<<******************************************************************************
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



--<<******************************************************************************
--<< Fecha de I.P.C.
--<< Mes Anterior, PUBLICADO EN EL MES ACTUAL
--<<******************************************************************************
   IF @nMes = 1
      SELECT @MesA = '12'
   ELSE
      SELECT @MesA = CONVERT(CHAR(2),@nMes - 1)

   IF DATALENGTH(RTRIM(@MesA)) = 1  SELECT @MesA = '0' + @MesA
      
   IF @nMes = 1
   BEGIN      
      SELECT @xFipc   = CONVERT(CHAR(4),@nAnn - 1) + @MesA + '01'
      
   END
   ELSE       
   BEGIN      
      SELECT @xFipc   = CONVERT(CHAR(4),@nAnn) + @MesA + '01'      
   END

   

--<<*****************************************************************************
--<< Buscamos 6 Meses Atras
--<<*****************************************************************************
   SELECT @f6matipc = CONVERT(CHAR(10),DATEADD (MONTH, -6, @xFipc),112)
   SELECT @f6matras = CONVERT(CHAR(10),DATEADD (MONTH, -6, @dFini),112)


--<<*****************************************************************************
--<< Busqueda del indice del I.P.C.
--<<*****************************************************************************
   SELECT @nIpc6ma = vmvalor 
   FROM   valor_moneda 
   WHERE  vmcodigo = 502 
          AND   vmfecha = @f6matipc  
  
   SELECT @nIpc6ma = ISNULL( @nIpc6ma, 0)

-- SELECT @nIpc6ma = ISNULL(@sValIpc, 0)
   SELECT @nIVPIni = @vValIVP

  --***************************************************************************** 
  -- Calculo y Grabacion de I.V.P.
  --*****************************************************************************
  --SELECT @nDifDias = ISNULL(DATEDIFF(Day, @dFini , @f6matras) , 0)

  SELECT @nDifDias = ISNULL(DATEDIFF(Day, @f6matras, @dFini) , 0)

  EXECUTE SP_DIV  1.0 , @nDifdias, @nFacDias   OUTPUT
  EXECUTE SP_DIV  @nValIpc, @nIpc6ma, @nFacAux OUTPUT
  SELECT @nFactor = POWER ( ISNULL ( @nFacAux, 0.0) , @nFacDias )

  --<<*****************************************************************************
  SELECT @xFecha = CONVERT(CHAR(10), DATEADD  ( Day, 1, @dFini ), 112)
  SELECT @nDDias = DATEDIFF ( Day, @xFecha, @dFfin) + 1
  SELECT @a = 0

  WHILE @a < @nDDias
    BEGIN
       SELECT @a = @a + 1
       SELECT @nValIvp = ROUND ( @nIVPIni * POWER ( @nFactor, @a), 2)

       IF EXISTS( SELECT vmvalor FROM valor_moneda WHERE vmcodigo   = 997 AND vmfecha = @xFecha )
          UPDATE valor_moneda  SET vmvalor = @nValIVP WHERE vmcodigo = 997
                                             AND   vmfecha  = @xFecha
       ELSE
          INSERT INTO valor_moneda    ( vmcodigo, vmvalor , vmfecha )
                      VALUES (      997, @nVALIVP, @xFecha )
       
       SELECT @xFecha = CONVERT(CHAR(10),DATEADD(Day, 1, @xFecha),112)
    END


    --<<*****************************************************************************
    --<< Grabamos El I.P.C.
    --<<*****************************************************************************
    IF EXISTS ( SELECT vmvalor FROM valor_moneda  WHERE vmcodigo = 502 AND vmfecha = @xFipc )
       UPDATE valor_moneda  
          SET vmvalor = @nValIpc 
        WHERE vmcodigo = 502
          AND vmfecha  = @xFipc
    ELSE
       INSERT INTO valor_moneda    ( vmcodigo, vmvalor , vmfecha )
                   VALUES (      502, @nValIpc, @xFipc  )


   IF EXISTS ( SELECT vmvalor FROM valor_moneda  WHERE vmcodigo = 502 AND vmfecha = @f6matipc )
       UPDATE valor_moneda
          SET vmvalor = @nIpc6ma
        WHERE vmcodigo = 502
          AND vmfecha  = @f6matipc
    ELSE
       INSERT INTO valor_moneda    ( vmcodigo, vmvalor , vmfecha   )
                   VALUES (      502, @nIpc6ma, @f6matipc )
       
   SELECT @xFecha = CONVERT(CHAR(10), DATEADD  ( Day, 1, @dFini ), 112)


   SELECT CONVERT(CHAR(10),vmfecha,103), vmvalor 
     FROM valor_moneda  
    WHERE vmcodigo = 997
      AND vmfecha >= @xFecha 
      AND vmfecha < DATEADD(Day,@nDDias,@xFecha)  
    ORDER BY vmfecha                

   SET NOCOUNT OFF

   RETURN
      
END                                          

-- SP_AUTORIZA_EJECUTAR 'BACUSER'
-- Sp_GeneraIVP  5, 2002, 110.26, 16919.34, '20020509'
-- SELECT* FROM VALOR_MONEDA WHERE VMCODIGO=997 AND VMFECHA > '20020501' ORDER BY VMFECHA
GO
