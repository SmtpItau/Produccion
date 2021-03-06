USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FACTORESBIDASK]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FACTORESBIDASK] 
               (
                  @NumMon    NUMERIC(10)
               )
AS 
BEGIN
   SET NOCOUNT ON
   DECLARE @dfecha DATETIME   
   IF EXISTS ( SELECT distinct fecha FROM MFBIDASK, MFAC WHERE fecha = acfecproc ) 
   BEGIN
      SELECT @dfecha = acfecproc FROM MFAC
   END ELSE BEGIN
      SELECT @dfecha = acfecante FROM MFAC
   END

   CREATE TABLE #temp ( codmon  NUMERIC( 03 )      ,
                        glosamn CHAR   ( 35 )      ,
                        codigo  NUMERIC( 03 )      ,
                        periodo CHAR   ( 06 )      ,
                        numero  NUMERIC( 04 )      ,
                        tipo    CHAR   ( 01 )      ,
                        glosa   CHAR   ( 15 )      ,
                        mnemo   CHAR   ( 12 )      ,
                        bid     FLOAT              ,
                        ask     FLOAT              ,
                        parcom  FLOAT              ,
                        parvta  FLOAT              ,
                        factor  NUMERIC( 09 )     ,
   valor FLOAT
                      )

       
   INSERT INTO #temp  ( codmon  ,
                        glosamn ,
                        codigo  ,
                        periodo ,
                        numero  ,                            
                        tipo    ,
                        glosa   ,
                        mnemo   ,
                        bid     ,
                        ask     ,
                        parcom  ,
                        parvta  ,
                        factor ,
   valor
                      ) 

SELECT DISTINCT 
   MFCA.cacodmon1  ,
   mdmn.mnglosa  ,
   mdpe.pecodigo  ,
                    mdpe.peperiodo  ,
         mdpe.penumero  ,
      mdpe.petipo  ,
      mdpe.peglosa   ,
      mdmn.mnnemo  ,
                    'a'=0   ,
                    'b'=0   ,
                    'c'=0   ,
                    'd'=0   ,
                    mdmn.mnfactor  ,
   'e'=0
       FROM    MFCA   ,
      VIEW_PERIODO_TASA_BIDASK mdpe,
                    VIEW_MONEDA mdmn 
            WHERE   MFCA.cacodmon1 = mdmn.mncodmon AND
                (mdmn.mncodmon = @NumMon  OR
      @NumMon  = 0)  AND
                    mdmn.mnmx = 'C'  AND
                    mdmn.mncodmon <> 13

        UPDATE #temp SET #temp.bid = MFBIDASK.bid,
                         #temp.ask = MFBIDASK.ask
        FROM   MFBIDASK
        WHERE  MFBIDASK.fecha   = @dfecha       AND
               MFBIDASK.moneda  = #temp.codmon  AND
               MFBIDASK.periodo = #temp.codigo  
        UPDATE #temp SET #temp.parcom = v.vmptacmp ,
                         #temp.parvta = v.vmptavta ,
    #temp.valor  = v.vmvalor
        FROM   VIEW_VALOR_MONEDA v
        WHERE  v.vmcodigo = #temp.codmon AND
        v.vmfecha  = @dfecha  

   SELECT * FROM #temp ORDER BY codigo
   SET NOCOUNT OFF
END
GO
