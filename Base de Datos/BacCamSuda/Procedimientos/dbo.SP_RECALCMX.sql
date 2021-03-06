USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RECALCMX]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RECALCMX]
         ( @CodMon CHAR(3) )
AS
BEGIN
SET NOCOUNT ON
------<< Actualiza Posicion US$
EXECUTE sp_ReCalc 'USD'
IF @CodMon = 'USD' 
   RETURN
---------------------------<< Declaracion de variables para Actualizar Posicion MX
DECLARE  @PMECO       FLOAT,
         @PMEVE       FLOAT,
         @PARINI      FLOAT,
         @PREINI      FLOAT,
         @POSINI      NUMERIC(17,4),
         @POSUSD      NUMERIC(17,4),
         @POSCLP      NUMERIC(17,0),
         @POSIC       NUMERIC(17,4),
         @UTILI       NUMERIC(17,4),
         @POSITINI    NUMERIC(17,4),
         @POSITION    NUMERIC(17,4),
         @TOTCOMX     NUMERIC(17,4),
         @TOTVEMX     NUMERIC(17,4),
         @TOTCOUS     NUMERIC(17,4),
         @TOTVEUS     NUMERIC(17,4),
         @TOTCOPE     NUMERIC(17,4),
         @TOTVEPE     NUMERIC(17,4)
DECLARE  @PMECOPO     FLOAT,
         @PMEVEPO     FLOAT,
         @UTILIPO     NUMERIC(17,4),
         @TOTCOMXPO   NUMERIC(17,4),
         @TOTVEMXPO   NUMERIC(17,4),
         @TOTCOUSPO   NUMERIC(17,4),
         @TOTVEUSPO   NUMERIC(17,4),
         @TOTCOPEPO   NUMERIC(17,0),
         @TOTVEPEPO   NUMERIC(17,0)
DECLARE  @PCIERRE     FLOAT,
         @PCOSTO      FLOAT,
         @PCOSTO2     FLOAT,
         @UTILTOT     NUMERIC(19,4)
DECLARE  @NEGOCIO     NUMERIC(1)
DECLARE  @CODIGO      NUMERIC(3)
DECLARE  @RRDA        CHAR(1)
DECLARE  @FECHA       CHAR(8)
---------------------------<< DATOS BASICOS DEL NEGOCIO -- PENDIENTE A PETICION DEL USUARIO
SELECT @NEGOCIO  = 0       -- CONSOLIDADO                 -- SEGUN MENEG
/*******************************************************************************
SELECT @Negocio  = 1       -- Trading Spot                -- segun MENEG
SELECT @Negocio  = 2       -- Liquidacion Entrega Fisica  -- segun MENEG
SELECT @Negocio  = 3       -- Arbitrajes                  -- segun MENEG
*******************************************************************************/
IF EXISTS (SELECT * FROM VIEW_POSICION_SPT  WHERE vmnegocio = @NEGOCIO)
   SELECT @FECHA    = CONVERT(CHAR(8),acfecpro,112),
          @POSINI   = vmposini,
          @POSIC    = vmposini,
          @PARINI   = vmparidad,
          @PREINI   = vmpreini,
          @POSCLP   = vmpreini * vmposini,
          @POSITINI = vmpositini
     FROM VIEW_POSICION_SPT , MEAC
    WHERE CONVERT(CHAR(8),vmfecha,112) = CONVERT(CHAR(8),acfecpro,112)
      AND vmcodigo = @CODMON
SELECT @RRDA   = mnrrda,
       @CODIGO = mncodmon
  FROM VIEW_MONEDA
 WHERE SUBSTRING(mnnemo,1,3) = @CODMON
IF @RRDA <> 'M'       -- Moneda es mas fuerte que USD
   SELECT @POSUSD = @POSINI / (CASE @PARINI WHEN 0 THEN 1 ELSE @PARINI END)
ELSE
   SELECT @POSUSD = @POSINI * @PARINI 
---------------------------<< Totales MEMO (PTAS-EMPR-ARBI-ARBM)
SELECT @TOTCOMX = ISNULL(SUM(momonmo),0) FROM MEMO WHERE motipOpe = 'C' AND mocodmon = @CODMON and moestatus <> 'A'
SELECT @TOTVEMX = ISNULL(SUM(momonmo),0) FROM MEMO WHERE motipOpe = 'V' AND mocodmon = @CODMON and moestatus <> 'A'
 
SELECT @TOTCOUS = ISNULL(SUM(moussme),0) FROM MEMO WHERE motipOpe = 'C' AND mocodmon = @CODMON and moestatus <> 'A'
SELECT @TOTVEUS = ISNULL(SUM(moussme),0) FROM MEMO WHERE motipOpe = 'V' AND mocodmon = @CODMON and moestatus <> 'A'
SELECT @TOTCOPE = ISNULL(SUM(momonpe),0) FROM MEMO WHERE motipOpe = 'C' AND mocodmon = @CODMON and moestatus <> 'A'
SELECT @TOTVEPE = ISNULL(SUM(momonpe),0) FROM MEMO WHERE motipOpe = 'V' AND mocodmon = @CODMON and moestatus <> 'A'
---------------------------<< Precios Medios
IF @RRDA <> 'M'      -- MONEDA ES MAS FUERTE QUE USD
   BEGIN
        SELECT @PMECO = (CASE WHEN @TOTCOUS = 0 THEN 0 ELSE @TOTCOMX / @TOTCOUS END)
        SELECT @PMEVE = (CASE WHEN @TOTVEUS = 0 THEN 0 ELSE @TOTVEMX / @TOTVEUS END)
   END
ELSE
   BEGIN
       -- PRINT 'MULTIPLICA'
       SELECT @PMECO = (CASE WHEN @TOTCOMX = 0 THEN 0 ELSE @TOTCOUS / @TOTCOMX END)
       SELECT @PMEVE = (CASE WHEN @TOTVEMX = 0 THEN 0 ELSE @TOTVEUS / @TOTVEMX END)
   END
---------------------------<< CALCULOS CON POSICION
IF @POSINI > 0
   BEGIN
        SELECT @TOTVEMXPO  =   @TOTVEMX
        SELECT @TOTVEUSPO  =   @TOTVEUS
        SELECT @TOTVEPEPO  =   @TOTVEPE
        SELECT @PMEVEPO    =   @PMEVE
        SELECT @TOTCOMXPO  =   @TOTCOMX + @POSINI
        SELECT @TOTCOUSPO  =   @TOTCOUS + @POSUSD
        SELECT @TOTCOPEPO  =   @TOTCOPE + @POSCLP
        SELECT @PMECOPO    = ( @TOTCOUSPO / CASE @TOTCOMXPO WHEN 0 THEN 1 ELSE @TOTCOMXPO END)
   END
IF @POSINI < 0
   BEGIN
        SELECT @TOTVEMXPO  =   @TOTVEMX + ABS(@POSINI)
        SELECT @TOTVEUSPO  =   @TOTVEUS + ABS(@POSUSD)
        SELECT @TOTVEPEPO  =   @TOTVEPE + ABS(@POSCLP)
        SELECT @PMEVEPO    = ( @TOTVEUSPO / CASE @TOTVEMXPO WHEN 0 THEN 1 ELSE @TOTVEMXPO END)
        SELECT @TOTCOMXPO  =   @TOTCOMX 
        SELECT @TOTCOUSPO  =   @TOTCOUS
        SELECT @TOTCOPEPO  =   @TOTCOPE
        SELECT @PMECOPO    =   @PMECO
   END
IF @POSINI = 0
   BEGIN
        SELECT @TOTVEMXPO  =   @TOTVEMX
        SELECT @TOTVEUSPO  =   @TOTVEUS
        SELECT @TOTVEPEPO  =   @TOTVEPE
        SELECT @PMEVEPO    =   @PMEVE
        SELECT @TOTCOMXPO  =   @TOTCOMX 
        SELECT @TOTCOUSPO  =   @TOTCOUS
        SELECT @TOTCOPEPO  =   @TOTCOPE
        SELECT @PMECOPO    =   @PMECO
   END
---------------------------<< POSICION & PRECIO DE CIERRE
SELECT @POSIC = ( @POSINI + (ISNULL(@TOTCOMX,0.0) - ISNULL(@TOTVEMX,0.0)) )
IF @POSIC >= 0
   SELECT @PCIERRE = @PMECOPO
ELSE
   SELECT @PCIERRE = @PMEVEPO
--------------------------<< UTILIDAD TRADING
SELECT @POSIC = @POSINI + @TOTCOMXPO - @TOTVEMXPO
SELECT @UTILI = 0
IF @TOTCOMXPO < @TOTVEMXPO  --@POSIC >= 0
   SELECT @UTILIPO = ( @TOTCOMXPO * (@PMEVEPO - @PMECOPO) )
ELSE
   SELECT @UTILIPO = ( @TOTVEMXPO * (@PMEVEPO - @PMECOPO) )
SELECT @UTILTOT = ISNULL(@UTILI,0.0) + ISNULL(@UTILIPO,0.0)
---------------------------<< POSITION
SELECT @PCOSTO  =  @PREINI
SELECT @PCOSTO2 = (CASE WHEN @POSIC >= 0 THEN @PMECOPO ELSE @PMEVEPO END)
IF @RRDA <> 'M'      -- MONEDA ES MAS FUERTE QUE USD
   SELECT @PCOSTO2 = (CASE WHEN @PCOSTO2 = 0 THEN 0 ELSE 1 / @PCOSTO2 END)
-- SI @POSIC < 0 => LA RESTA SE INVIERTE AUTOMATICAMENTE POR REGLA DE SIGNOS
SELECT @POSITION = @POSIC * (@PCOSTO - @PCOSTO2)
---------------------------<< ACTUALIZA TABLAS DE POSICION
UPDATE VIEW_POSICION_SPT
   SET vmfecha    = @Fecha + ' ' + convert(char(12), getdate(), 114),    -- con hora para actualizaciÃ³n en lÃ­nea
       vmtotco    = ISNULL( @TOTCOMXPO, 0.0 ),
       vmtotve    = ISNULL( @TOTVEMXPO, 0.0 ),
       vmtotcope  = ISNULL( @TOTCOPEPO, 0.0 ),
       vmtotvepe  = ISNULL( @TOTVEPEPO, 0.0 ),
       vmpmeco    = ISNULL( @PMECOPO  , 0.0 ),
       vmpmeve    = ISNULL( @PMEVEPO  , 0.0 ),
       vmposic    = ISNULL( @POSIC    , 0.0 ),
       vmtotcopo  = ISNULL( @TOTCOMXPO, 0.0 ),
       vmtotvepo  = ISNULL( @TOTVEMXPO, 0.0 ),
       vmpmecopo  = ISNULL( @PMECOPO  , 0.0 ),
       vmpmevepo  = ISNULL( @PMEVEPO  , 0.0 ),
       vmutili    = ISNULL( @UTILIPO  , 0.0 ),
       vmutilipo  = ISNULL( @POSITION , 0.0 ),
       vmposition = ISNULL( @POSITION , 0.0 ),
       vmprecierre= ISNULL( @PCIERRE  , 0.0 ),
       vmutiltot  = ISNULL( @UTILTOT  , 0.0 )
 WHERE CONVERT(CHAR(8),vmfecha,112) = @FECHA
   AND vmnegocio  = @NEGOCIO   -- Consolidado, segun MENEG
   AND vmcodigo   = @CODMON
END



GO
