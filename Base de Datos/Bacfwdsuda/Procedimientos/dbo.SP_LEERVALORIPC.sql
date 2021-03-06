USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERVALORIPC]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEERVALORIPC] ( @nano NUMERIC ( 4, 0 ) )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE   @conta        NUMERIC(2)
 DECLARE   @cFecha       CHAR(10)
 DECLARE   @nUltValorUf     NUMERIC(12,2)
 DECLARE   @nUltValorIPC NUMERIC(6,2)
 DECLARE   @nValorUF  NUMERIC(12,2)
 /*=======================================================================*/
 /*=======================================================================*/
 CREATE TABLE #tmpproyuf
         (
          tmpfeccalc     DATETIME             NOT NULL,
          tmpvaloripc    NUMERIC(6,2)          NOT NULL,
          tmpvaloruf     NUMERIC(12,2)         NOT NULL
         ) 
SELECT @conta = 1
IF EXISTS( SELECT vmfecha  FROM  VIEW_VALOR_MONEDA
    WHERE SUBSTRING(CONVERT(CHAR(10),vmfecha,112),1,4)= CONVERT(CHAR(4),@nano) AND vmcodigo = 500) BEGIN
   /*======================================================================*/
   /* En Caso de conocerse los Valores del IPC en la Tabla MDVM se Cargan */
   /* Desde ahÑ y el Resto lo Extrae desde la Tabla MDIPC   */
   /*======================================================================*/
   INSERT INTO #tmpproyuf 
   SELECT DATEADD ( dd, 8, a.vmfecha ) ,
     a.vmvalor ,
  b.vmvalor
   FROM   VIEW_VALOR_MONEDA a ,
         VIEW_VALOR_MONEDA  b   
   WHERE  SUBSTRING(CONVERT(CHAR(10),a.vmfecha,112),1,4) = CONVERT(CHAR(4),@nano)       AND 
     a.vmcodigo                                     = 500                          AND
         b.vmfecha                                      = DATEADD ( dd, 8, a.vmfecha ) AND 
         b.vmcodigo                                     = 998
   SET ROWCOUNT 1  
 
   SELECT  @cFecha  = CONVERT(CHAR(10),tmpfeccalc,112)   ,
         @nUltValorUf   = tmpvaloruf   ,
         @nUltValorIPC  = tmpvaloripc 
   FROM  #tmpproyuf  ORDER BY  tmpfeccalc  DESC                                                                                                                                                                                                                
                                            
   SET ROWCOUNT 0
   /*======================================================================*/
   /* Extrae los Datos Desde Tabla MDIPC, si no Existieran los Carga     */
   /*======================================================================*/
   IF EXISTS( SELECT ipcfeccal  FROM  MDIPC
              WHERE ipcfeccal > @cFecha AND
             SUBSTRING(CONVERT(CHAR(10), MDIPC.ipcfeccal,112),1,4)= CONVERT(CHAR(4),@nano)) BEGIN
      INSERT INTO #tmpproyuf
      SELECT ipcfeccal  ,
 
                ipcvaloripc ,
                ipcvaloruf
 
      FROM   MDIPC
      WHERE  CONVERT(CHAR(10),ipcfeccal, 112 ) > @cFecha AND SUBSTRING(CONVERT(CHAR(10), MDIPC.ipcfeccal,112),1,4)= CONVERT(CHAR(4),@nano)
   END ELSE BEGIN
      /*======================================================================*/
      /* Carga los Datos Iniciales ya que no Existe en Ninguna Parte         */
      /*======================================================================*/
      SELECT @cFecha= SUBSTRING(@cFecha,5,2)
      SELECT @conta = CONVERT(NUMERIC(2),@cFecha) + 1
      WHILE @conta < 13  BEGIN
         INSERT INTO #tmpproyuf
         SELECT  CONVERT(DATETIME, CONVERT(CHAR(2),@conta) + '/09/' + CONVERT(CHAR(4),@nano) ) ,
     
             0 ,
                 0
         SELECT @conta = @conta + 1
      END 
      /*======================================================================*/
      /* Calcula Proyeccicn de UF en base al Ultimo IPC conocido            */
      /*======================================================================*/
      SELECT @conta = CONVERT(NUMERIC(2),@cFecha) + 1
      WHILE @conta < 13  BEGIN  
         EXECUTE Sp_CalculaUFIPC @conta , @nUltValorIPC , @nUltValorUf ,@nValorUF OUTPUT
         UPDATE #tmpproyuf SET tmpvaloruf = @nValorUF  WHERE
         CONVERT(NUMERIC(2),SUBSTRING(CONVERT(CHAR(10),tmpfeccalc,112),5,2))= @conta
         SELECT @nUltValorIPC = tmpvaloripc FROM #tmpproyuf WHERE
         CONVERT(NUMERIC(2),SUBSTRING(CONVERT(CHAR(10),tmpfeccalc,112),5,2))= @conta
         SELECT @nUltValorUf = @nValorUF
                
         SELECT @conta = @conta + 1
      END
   END
END ELSE IF EXISTS( SELECT  ipcfeccal FROM  MDIPC
                       
               WHERE SUBSTRING(CONVERT(CHAR(10),ipcfeccal,112),1,4)= CONVERT(CHAR(4),@nano) )BEGIN
   /*======================================================================*/
   /* Existe en Tabla MDIPC y Rescata los valores                       */
   /*======================================================================*/
  
   INSERT INTO #tmpproyuf 
   SELECT ipcfeccal  ,
  ipcvaloripc ,
  ipcvaloruf
   FROM  MDIPC
   WHERE SUBSTRING(CONVERT(CHAR(10),ipcfeccal,112),1,4)= CONVERT(CHAR(4),@nano)
 
   SET ROWCOUNT 1  
 
   SELECT @cFecha = CONVERT(CHAR(10),tmpfeccalc,112)   ,
          @nUltValorUf  = tmpvaloruf   ,
          @nUltValorIPC = tmpvaloripc 
   FROM #tmpproyuf ORDER BY tmpfeccalc DESC 
   SET ROWCOUNT 0
   SELECT @cFecha= SUBSTRING(@cFecha,5,2)
   SELECT @conta = CONVERT(NUMERIC(2),@cFecha) + 1
   WHILE @conta < 13  BEGIN
      INSERT INTO #tmpproyuf
      SELECT  CONVERT(DATETIME, CONVERT(CHAR(2),@conta) + '/09/' + CONVERT(CHAR(4),@nano) ) ,
   0             ,
  
  0
      SELECT @conta = @conta + 1
   END
   SELECT @conta = CONVERT(NUMERIC(2),@cFecha) + 1
   WHILE @conta < 13  BEGIN  
      EXECUTE Sp_CalculaUFIPC @conta , @nUltValorIPC , @nUltValorUf ,@nValorUF OUTPUT
      UPDATE #tmpproyuf SET tmpvaloruf = @nValorUF  WHERE
      CONVERT(NUMERIC(2),SUBSTRING(CONVERT(CHAR(10),tmpfeccalc,112),5,2))= @conta
      SELECT @nUltValorIPC = tmpvaloripc FROM #tmpproyuf WHERE
      CONVERT(NUMERIC(2),SUBSTRING(CONVERT(CHAR(10),tmpfeccalc,112),5,2))= @conta
      SELECT @nUltValorUf = @nValorUF
                
      SELECT @conta = @conta + 1
   END
END ELSE BEGIN
   /*======================================================================*/
   /* Si no Existe en Tabla MDIPC y en Tabla MDVM los Carga en 0 ( CERO )  */
   /*======================================================================*/
   PRINT 'A'
   WHILE @conta < 13  BEGIN
      INSERT INTO #tmpproyuf
      SELECT  CONVERT( DATETIME, CONVERT(CHAR(2), @conta ) + '/09/' + CONVERT(CHAR(4),@nano) )  , 
   0                  ,
   0
      SELECT @conta = @conta + 1
   END
END
SELECT 'Fecha de Calculo' = CONVERT(CHAR(10), tmpfeccalc,103)     ,
       'Valor IPC'   = tmpvaloripc           ,
       'Valor UF'   = tmpvaloruf
FROM   #tmpproyuf
ORDER BY tmpfeccalc   
DROP TABLE  #tmpproyuf  
SET NOCOUNT OFF
RETURN 0
END

GO
