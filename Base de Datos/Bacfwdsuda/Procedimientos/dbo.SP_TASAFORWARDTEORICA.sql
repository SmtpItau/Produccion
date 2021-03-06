USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TASAFORWARDTEORICA]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_TASAFORWARDTEORICA]
   (   @Fecha           DATETIME   
   ,   @dFechaVctoInst  DATETIME
   ,   @dFechaVctoOper  DATETIME
   ,   @iTasaBenchMark  NUMERIC(21,4)
   ,   @iDuration       FLOAT
   ,   @iRetTasaFwdTeo  NUMERIC(21,4) OUTPUT
   )
AS
BEGIN
/*  Dur: 4.7472, Spot 3.40
 declare @pp float
exec SP_TASAFORWARDTEORICAMAP '20050125', '20100901', '20060209' , 3.40, 4.7472 , @pp
 select @pp 

Cambios 23 Junio:
MAP Contingencia Tecno 01
1- Faltó multiplicar por 100 el ICP mensual antes de utilizarlo, falla en la especificación.
2- Redondear con 1 decimal el ICP mensual antes de utilizarlo.
3- Falla calcula en la fecha proximo nueve
4- Evitar que haga select debido a que retorna .
5- Para que no moleste el retorno
6- Anulacion de resta de plazo negativo
7- Adaptacion del uso del duration
*/
   SET NOCOUNT ON

   SELECT  @iRetTasaFwdTeo = 0.0

   DECLARE @nBase    NUMERIC
   SELECT  @nBase    = 360.0

   DECLARE @IPC      INT
   SELECT  @IPC      = 502

   DECLARE @TPM      INT
   SELECT  @TPM      = 807

   DECLARE @iError   INT
   SELECT  @iError   = 0


   --> (1.0) Determina Plazos Residuales del Contrato y del Instrumento
   DECLARE @RemContrato             NUMERIC(9)
   ,       @RemPapel                NUMERIC(9)

   SELECT  @RemContrato           = DATEDIFF(DAY,@Fecha,@dFechaVctoOper)
   SELECT  @RemPapel              = DATEDIFF(DAY,@Fecha,@dFechaVctoInst)
   
   IF @RemContrato <= 0.0
   BEGIN
      SELECT @iRetTasaFwdTeo = @iTasaBenchMark
      RETURN 
   END
   -->     *********************************************   


   --> (2.0) Se Determina Proximo Dia Nueve a Partir de la Fecha de Calculo
   DECLARE @dFechaProximoNueve      DATETIME
   IF DAY(@Fecha) = 9
      SELECT @dFechaProximoNueve  = @Fecha
   ELSE
      -- SELECT @dFechaProximoNueve  = DATEADD(DAY,9,DATEADD(DAY,(DAY(DATEADD(MONTH,1,@Fecha))*-1),DATEADD(MONTH,1,@Fecha))) MAP Tecno Contigencia 03
       select @dFechaProximoNueve = ( case when day( @Fecha ) > 9 then 
                                                           dateadd( mm, 1, dateadd( dd, - day( @Fecha ) + 9, @Fecha ) )                                                                    
                                                    else 
                                                           dateadd( dd, 9 + - day( @Fecha ) ,  @Fecha )
                                                    end  )
   -->     *********************************************
--   select 'debug' ,  @dFechaProximoNueve

   --> (3.1) Se Determina Cantidad de Dias Entre las Fechas de Calculo y Proximo Dia Nueve
   DECLARE @RemIpcVigente           NUMERIC(9)
   SELECT  @RemIpcVigente         = DATEDIFF(DAY,@Fecha,@dFechaProximoNueve)
   IF @RemIpcVigente < 0.0                  -- MAP Contingencia Tecno 06
      SELECT  @RemIpcVigente      = 0.0     -- MAP Contingnecia Tecno 06

   --> (3.2) Se Determina Cantidad de Dias Entre las Fechas Proximo Dia Nueve y Fecha Vcto del Contrato
   DECLARE @RemIpcProximo           NUMERIC(9)
   SELECT  @RemIpcProximo         = DATEDIFF(DAY,@dFechaProximoNueve,@dFechaVctoOper)

   IF @RemIpcProximo < 0.0
      SELECT  @RemIpcProximo      = 0.0
   -->     *********************************************


   --> (4.0) Determina Fechas para Rescatar el IPC Vigente
   DECLARE @dFechaIPC_Inicial_Vig   DATETIME
   ,       @dFechaIPC_Termino_Vig   DATETIME
      --> (4.1) Obtiene fecha Termino Restando 2 Meses al Dia Nueve
   SELECT  @dFechaIPC_Termino_Vig = DATEADD(MONTH , -2 , @dFechaProximoNueve)
      --> (4.2) Obtiene Dia primero a la fecha anterior obtenida
   SELECT  @dFechaIPC_Termino_Vig = DATEADD(DAY,1,DATEADD(DAY , (DAY(@dFechaIPC_Termino_Vig)*-1),@dFechaIPC_Termino_Vig))
      --> (4.3) Obtiene fecha Inicio Restando 1 Meses a la fecha Termino
--   select 'debug', '@dFechaIPC_Termino_Vig', @dFechaIPC_Termino_Vig
   SELECT  @dFechaIPC_Inicial_Vig = DATEADD(MONTH,-1,@dFechaIPC_Termino_Vig)
--   select 'debug', '@dFechaIPC_Inicial_Vig', @dFechaIPC_Inicial_Vig 
   -->     *********************************************

   --> (5.0) Determina Fechas para Rescatar el Proximo IPC Vigente
   DECLARE @dFechaIPC_Inicial_Prx   DATETIME
   ,       @dFechaIPC_Termino_Prx   DATETIME
      --> (5.1) Obtiene fecha Termino Restando 1 Meses al Dia Nueve
   SELECT  @dFechaIPC_Termino_Prx = DATEADD(MONTH , -1 , @dFechaProximoNueve)
      --> (5.2) Obtiene Dia primero a la fecha anterior obtenida
   SELECT  @dFechaIPC_Termino_Prx = DATEADD(DAY,1,DATEADD(DAY , (DAY(@dFechaIPC_Termino_Prx)*-1),@dFechaIPC_Termino_Prx))
      --> (5.3) Obtiene fecha Inicio Restando 1 Meses a la fecha Termino
   SELECT  @dFechaIPC_Inicial_Prx = DATEADD(MONTH,-1,@dFechaIPC_Termino_Prx)

--   select 'debug' , '@dFechaIPC_Inicial_Prx', @dFechaIPC_Inicial_Prx
--   select 'debug', '@dFechaIPC_Termino_Prx', @dFechaIPC_Termino_Prx
   -->     *********************************************

   --> (6.0) Rescata los Valores de Ipc, para Determinar IPC Vigente
   DECLARE @iValIpc_Inicial_Vig    FLOAT
   ,       @iValIpc_Termino_Vig    FLOAT

   SELECT  @iValIpc_Inicial_Vig    = vmvalor
   FROM    BacParamSuda..VALOR_MONEDA WITH (NoLOck)
   WHERE   vmfecha                 = @dFechaIPC_Inicial_Vig
   AND     vmcodigo                = @IPC

   SELECT  @iValIpc_Termino_Vig    = vmvalor
   FROM    BacParamSuda..VALOR_MONEDA WITH (NoLOck)
   WHERE   vmfecha                 = @dFechaIPC_Termino_Vig
   AND     vmcodigo                = @IPC

   IF @iValIpc_Inicial_Vig = 0.0 OR @iValIpc_Inicial_Vig IS NULL
   BEGIN
      SELECT -1 , 'Valor Para IPC a la Fecha ' + CONVERT(CHAR(10),@dFechaIPC_Inicial_Vig,103) + ' No Existe.'
      SELECT @iError = -1
      RETURN -1
   END
   IF @iValIpc_Termino_Vig = 0.0 OR @iValIpc_Termino_Vig IS NULL
   BEGIN
      SELECT -2 , 'Valor Para IPC a la Fecha ' + CONVERT(CHAR(10),@dFechaIPC_Termino_Vig,103) + ' No Existe.'
      SELECT @iError = -2
      RETURN -2
   END
   -->     *********************************************
 
   --> (7.0) Determina Variacion IPC Vigente
   DECLARE @iVariacionVigente      FLOAT
   SELECT  @iVariacionVigente      = ( @iValIpc_Termino_Vig - @iValIpc_Inicial_Vig ) / @iValIpc_Inicial_Vig 
   SELECT  @iVariacionVigente  =   round( @iVariacionVigente * 100.0 , 1 )-- MAP Contingencia Tecno 01
   -->     *********************************************

   --> (8.0) Determina Variacion IPC Vigente Anualizado
   DECLARE @iVar_IPC_Vigente       FLOAT
   SELECT  @iVar_IPC_Vigente       = ( POWER((1.0 + @iVariacionVigente / 100.0),12.0) - 1.0 ) * 100.0
   -->     *********************************************


   --> (9.0) Rescata los Valores de Ipc, para Determinar Proximo IPC
   DECLARE @iValIpc_Inicial_Prx    FLOAT
   ,       @iValIpc_Termino_Prx    FLOAT

   SELECT  @iValIpc_Inicial_Prx    = vmvalor
   FROM    BacParamSuda..VALOR_MONEDA WITH (NoLOck)
   WHERE   vmfecha                 = @dFechaIPC_Inicial_Prx
   AND     vmcodigo                = @IPC

   SELECT  @iValIpc_Termino_Prx    = ISNULL(vmvalor,0.0)
   FROM    BacParamSuda..VALOR_MONEDA WITH (NoLOck)
   WHERE   vmfecha                 = @dFechaIPC_Termino_Prx
   AND     vmcodigo                = @IPC


   IF @iValIpc_Inicial_Prx = 0.0 OR @iValIpc_Inicial_Prx IS NULL
   BEGIN
      SELECT -3 , 'Valor Para IPC a la Fecha ' + CONVERT(CHAR(10),@dFechaIPC_Inicial_Prx,103) + ' No Existe.'
      SELECT @iError = -3
      RETURN -3
   END
   -- MAP Contingencia Tecno 04, evitar que haga select debido a que retorna y es normal que no exista el índice
   IF @iValIpc_Termino_Prx = 0.0 OR @iValIpc_Termino_Prx IS NULL
   BEGIN
--      MAP Contigencia Tecno 05 , para que no moleste el retorno
--      SELECT -4 , 'Valor Para IPC a la Fecha ' + CONVERT(CHAR(10),@dFechaIPC_Termino_Prx,103) + ' No Existe.'
      SELECT @iError = -4 
   END  
    
   -->     *********************************************
 
   --> (10.0) Determina Variacion IPC Vigente   
   DECLARE @iVariacionProxima      FLOAT
   SELECT  @iVariacionProxima      = CASE WHEN @iValIpc_Termino_Prx = 0.0 OR @iError = -4 THEN @iVariacionVigente
                                          ELSE                                             ((( @iValIpc_Termino_Prx - @iValIpc_Inicial_Prx ) / @iValIpc_Inicial_Prx) * 100.0)
                                     END
   SELECT @iVariacionProxima = round( @iVariacionProxima      , 1 ) -- MAP Contingencia Tecno 01
-- SELECT @iVariacionProxima = round( @iVariacionProxima * 100, 1 ) -- MAP Contingencia Tecno 01 // 04 Julio 2006
   -->     *********************************************

   --> (11.0) Determina Variacion IPC Vigente Anualizado
   DECLARE @iVar_IPC_Proximo       FLOAT
   SELECT  @iVar_IPC_Proximo       = ( POWER((1.0 + @iVariacionProxima / 100.0),12.0) - 1.0 ) * 100.0
   -->     *********************************************   

   --> (12.0) Determina Tasa Policita Monetaria
   DECLARE @dFechaTMP              DATETIME
   DECLARE @iTasaPoliticaMonetaria FLOAT

   IF NOT EXISTS(SELECT 1 FROM BacParamSuda..VALOR_MONEDA WITH (NoLOck) WHERE vmcodigo = @TPM AND vmvalor <> 0.0 )
   BEGIN
      SELECT -5 , 'No Existe Tasa Policita Monetaria'
      SELECT @iError = -5
      RETURN -5
   END

   SELECT  @dFechaTMP              = MAX(vmfecha)
   FROM    BacParamSuda..VALOR_MONEDA WITH (NoLOck)
   WHERE   vmcodigo                = @TPM
   AND     vmvalor                <> 0.0

   SELECT  @iTasaPoliticaMonetaria = isnull(vmvalor,0.0)
   FROM    BacParamSuda..VALOR_MONEDA WITH (NoLOck)
   WHERE   vmcodigo                = @TPM
   AND     vmfecha                 = @dFechaTMP
   
   IF @iTasaPoliticaMonetaria = 0.0 AND @iTasaPoliticaMonetaria IS NULL
   BEGIN
      SELECT -6 , 'Tasa de Politica Monetaria es Cero.'
      SELECT @iError = -6
      RETURN -6
   END
   -->     *********************************************   


   --> (13.0) Determina Tasa Financiamiento
   DECLARE @iTasaFinanciamiento   FLOAT
   DECLARE @iAux                  FLOAT

   SELECT  @iAux                  = (1.0 + @iTasaPoliticaMonetaria / 100.0)
   SELECT  @iAux                  =  @iAux / POWER(( (1.0 + @iVar_IPC_Vigente / 100.0)), (@RemIpcVigente/@RemContrato))
   SELECT  @iAux                  =  @iAux / POWER(( (1.0 + @iVar_IPC_Proximo / 100.0)), (@RemIpcProximo/@RemContrato))
   SELECT  @iTasaFinanciamiento   = (@iAux - 1.0) * 100.0
   -->     *********************************************   

   --> (14.0) Determina Tasa Forward Teorica
   DECLARE @iTasaFwdTeorica       FLOAT
   DECLARE @iiAux                 FLOAT

   SELECT  @iiAux                 =  POWER( (1.0 + @iTasaBenchMark      / 100.0) , @iDuration )  -- Map Tecno 07
                                  /  POWER( (1.0 + @iTasaFinanciamiento / 100.0) , (@RemContrato / @nBase) )
   SELECT  @iTasaFwdTeorica       =  POWER( @iiAux ,  @nBase / (  @iDuration * @nBase  -  @RemContrato  ) )  - 1.0  -- Map Tecno 07
   SELECT  @iTasaFwdTeorica       = @iTasaFwdTeorica  * 100.0 
   -->     *********************************************   

   --> (15.0) Determina Tasa Forward Teorica a Formato Numeric(21,4) para el Retorno Final
   SELECT  @iRetTasaFwdTeo        = CONVERT(NUMERIC(21,4),@iTasaFwdTeorica)

--   select 'debug', @iRetTasaFwdTeo

   RETURN  @iError
END


GO
