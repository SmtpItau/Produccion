USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_GeneraIVP]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_GeneraIVP] 
                              ( @nMes     INTEGER ,
                                @nAnn     INTEGER ,
                                @nValIpc  FLOAT   , 
                                @valivp   FLOAT   ,
                                @fecha    DATETIME
                               )    
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

   DECLARE @Mes      CHAR(02)
   DECLARE @MesT     CHAR(02)
   DECLARE @MesA     CHAR(02)
   DECLARE @dFini    DATETIME
   DECLARE @dFfin    DATETIME
   DECLARE @xFipc    DATETIME
   DECLARE @xFecha   DATETIME
   DECLARE @nIVPIni  FLOAT
   DECLARE @f6matipc DATETIME
   DECLARE @f6matras DATETIME
   DECLARE @nIpc6ma  FLOAT
   DECLARE @nDifDias INTEGER
   DECLARE @nFacDias FLOAT
   DECLARE @nFacAux  FLOAT
   DECLARE @nFactor  FLOAT
   DECLARE @nDDias   INTEGER
   DECLARE @a        INTEGER
   DECLARE @nValIvp  FLOAT

   --*******************************************************************************  
   -- Fecha de Inicio Mes Actual
   --*******************************************************************************
   IF @nMes < 10 BEGIN
      SELECT @Mes = RTRIM('0' + CONVERT(CHAR(1),@nMes))

   END ELSE BEGIN
      SELECT @Mes = RTRIM(CONVERT(CHAR(2),@nMes))

   END

 --  SELECT @dFini = CONVERT(CHAR(4),@nAnn) + @Mes + '09'
     SELECT @dFini = @fecha

   --******************************************************************************   
   -- Fecha de Termino Mes Termino
   --******************************************************************************
   IF @nMes = 12 BEGIN
      SELECT @dFfin = CONVERT(CHAR(4),@nAnn + 1) + '0109' 

   END ELSE BEGIN
      IF @nMes >=9 BEGIN
         SELECT @MesT = RTRIM(CONVERT(CHAR(2),@nMes + 1))

      END ELSE BEGIN
         SELECT @MesT = '0' + RTRIM(CONVERT(CHAR(1),@nMes + 1))

      END
      SELECT @dFfin = CONVERT(CHAR(4),@nAnn) + @MesT + '09'

   END

   --******************************************************************************
   -- Fecha de I.P.C. Mes Anterior
   --******************************************************************************
   IF @nMes = 1 BEGIN
      SELECT @xFipc = CONVERT(CHAR(4),@nAnn - 1) + '1201'
   END ELSE BEGIN
      IF (@nmes-1) < 10 BEGIN
         SELECT @xFipc = CONVERT(CHAR(4),@nAnn ) + '0' + CONVERT(CHAR(1),@nMes - 1) + '01'
      END ELSE BEGIN
         SELECT @xFipc = CONVERT(CHAR(4),@nAnn ) + CONVERT(CHAR(2),@nMes - 1) + '01'
      END
   END

   --*****************************************************************************   
   -- Buscar Valor UF de Fecha de Inicio
   --*****************************************************************************

  -- SELECT       @nIVPIni = vmvalor 
  --        FROM  VALOR_MONEDA
  --        WHERE vmcodigo = 997       AND
  --              vmfecha  = @dFini

   SELECT @nIVPIni = @Valivp
   
   --*****************************************************************************
   -- Buscamos 6 Meses Atras
   --*****************************************************************************
   SELECT @f6matipc = DATEADD (MONTH, -6, CONVERT(INTEGER,@xFipc))
   SELECT @f6matras = DATEADD (MONTH, -6, @dFini)

   --*****************************************************************************
   -- Busqueda del indice del I.P.C.
   --*****************************************************************************
   SELECT       @nIpc6ma = vmvalor 
          FROM  VALOR_MONEDA 
          WHERE vmcodigo = 502       AND
                vmfecha  = @f6matipc

   SELECT @nIpc6ma = ISNULL( @nIpc6ma, 0)

   --*****************************************************************************
   -- Calculo y Grabacion de I.V.P.
   --*****************************************************************************
   SELECT @nDifDias = DATEDIFF(Day, @dFini , @f6matras)
   SELECT @nDifDias = DATEDIFF(Day, @f6matras, @dFini)

   EXECUTE Sp_Div  1.0 , @nDifdias, @nFacDias   OUTPUT
   EXECUTE Sp_Div  @nValIpc, @nIpc6ma, @nFacAux OUTPUT

   SELECT @nFactor = POWER ( ISNULL ( @nFacAux, 0.0) , @nFacDias )

   --*****************************************************************************
   --*****************************************************************************
   SELECT @xFecha = DATEADD  ( Day, 1, @dFini )
   SELECT @nDDias = DATEDIFF ( Day, @xFecha, @dFfin) + 1
   SELECT @a = 0

   --*****************************************************************************
   --*****************************************************************************
   WHILE @a < @nDDias BEGIN
      SELECT @a = @a + 1
      SELECT @nValIvp = ISNULL( ROUND ( @nIVPIni * POWER ( @nFactor, @a), 2), 0.0 )

      IF EXISTS(
                 SELECT vmvalor 
                        FROM  VALOR_MONEDA
                        WHERE vmcodigo   = 997 AND 
                              vmfecha = @xFecha
                ) BEGIN
         UPDATE       VALOR_MONEDA 
                SET   vmvalor  = @nValIVP 
                WHERE vmcodigo = 997       AND
                      vmfecha  = @xFecha

      END ELSE BEGIN         INSERT INTO VALOR_MONEDA   ( vmcodigo, vmvalor , vmfecha )
                             VALUES (      997, @nVALIVP, @xFecha )
      END
       
      SELECT @xFecha = DATEADD(Day, 1, @xFecha)

   END

   --*****************************************************************************
   -- Grabamos El I.P.C.
   --*****************************************************************************
   IF EXISTS(
             SELECT       vmvalor 
                    FROM  VALOR_MONEDA
                    WHERE vmcodigo = 502 AND
                          vmfecha  = @xFipc
            ) BEGIN
      UPDATE VALOR_MONEDA SET vmvalor = @nValIpc WHERE vmcodigo = 502
                                          AND   vmfecha  = @xFipc
   END ELSE BEGIN
      INSERT INTO VALOR_MONEDA   (vmcodigo, vmvalor , vmfecha)
                                 VALUES (502, @nValIpc, CONVERT(VARCHAR,@xFipc) )

   END

   SELECT @xFecha = DATEADD  ( Day, 1, @dFini )

   SELECT       CONVERT(CHAR(10),vmfecha,103), vmvalor 
          FROM  VALOR_MONEDA 
          WHERE vmcodigo  = 997       AND
                vmfecha  >= @xFecha   AND
                vmfecha  < DATEADD(Day,@nDDias,@xFecha)                  
          ORDER BY vmfecha

   SET NOCOUNT OFF      	

END


GO
