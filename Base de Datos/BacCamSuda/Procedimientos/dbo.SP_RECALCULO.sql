USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RECALCULO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- SP_HELPTEXT SP_RECALCULO
CREATE PROCEDURE [dbo].[SP_RECALCULO] 
--                 (@codmon   CHAR(3),
--                  @mercado  CHAR(4),
--                  @tipopera CHAR(1),
--                  @mtodolar NUMERIC(19,4),
--                  @ticam    NUMERIC(19,4))
AS
BEGIN
     SET NOCOUNT ON
     DECLARE  @MTOUSD    NUMERIC(17,4)
     DECLARE  @MTOCLP    NUMERIC(17,4)
     DECLARE  @PMECO    FLOAT
     DECLARE  @PMEVE    FLOAT
     DECLARE  @PMECOFI    FLOAT
     DECLARE  @PMEVEFI    FLOAT
     DECLARE  @POSINI    NUMERIC(17,4)
     DECLARE  @POSIC    NUMERIC(17,4)
     DECLARE  @PREINI    FLOAT
     DECLARE  @UTILI    NUMERIC(17,4)
     
     DECLARE  @TOTCOUS    NUMERIC(17,4)
     DECLARE  @TOTVEUS    NUMERIC(17,4)
     DECLARE  @TOTCOPE    NUMERIC(17,4)
     DECLARE  @TOTVEPE    NUMERIC(17,4)
     
     DECLARE  @TOGCOUS    NUMERIC(17,4)
     DECLARE  @TOGVEUS    NUMERIC(17,4)
     DECLARE  @TOGCOPE    NUMERIC(17,4)
     DECLARE  @TOGVEPE    NUMERIC(17,4)
     DECLARE  @PTOCOM     NUMERIC(17,4)
     DECLARE  @PTOVEN     NUMERIC(17,4)
     DECLARE  @PMECOPO    FLOAT
     DECLARE  @PMEVEPO    FLOAT
     DECLARE  @UTILIPO    NUMERIC(17,4)
     DECLARE  @TOTCOUSPO   NUMERIC(17,4)
     DECLARE  @TOTVEUSPO   NUMERIC(17,4)
     DECLARE  @TOTCOPEPO   NUMERIC(17,4)
     DECLARE  @TOTVEPEPO   NUMERIC(17,4)
     DECLARE  @PCIERRE    FLOAT
     DECLARE  @PCIERREFI   FLOAT
     DECLARE  @UTILTOT    NUMERIC(17,4)
     DECLARE  @POSICION    CHAR(1)
     DECLARE  @PMEDIO    CHAR(1)
     
     DECLARE  @SIGNO    CHAR(1)
     DECLARE  @RESULTADO   CHAR(1)
     DECLARE  @PMEVEPOS    NUMERIC(17,4)
     DECLARE  @PMECOPOS    NUMERIC(17,4)
     DECLARE  @TOTCO    NUMERIC(17,4)
     DECLARE  @TOTVE    NUMERIC(17,4)
     DECLARE  @CODIGO    NUMERIC(3)
     DECLARE  @RENTAB    NUMERIC(3)
     DECLARE  @NPOS    NUMERIC(3)
     DECLARE  @NPOSAUX    NUMERIC(3)
     DECLARE  @MONPEINI    NUMERIC(17,4)
     DECLARE  @RENTA    NUMERIC(3)
     DECLARE  @NRENAUX    NUMERIC(3)
     DECLARE  @PREFIN    NUMERIC(14,4)
     DECLARE  @PREINIFI    NUMERIC(14,4)
     DECLARE  @POSINIMX    NUMERIC(17,4)
     DECLARE  @POSICMX    NUMERIC(17,4)
     DECLARE  @FECHA    CHAR(8)
     /*=======================================================================*/
     /* Valores Iniciales */
     /*=======================================================================*/
     SELECT @FECHA  = CONVERT(CHAR(8),acfecpro,112),
     @POSINI = ACPOSINI, --vmposini,
     @POSIC  = ACPOSIC,  --vmposini,
     @PREINI = ACPREINI, --vmpreini,
     @PREFIN = acfinan
       FROM VIEW_POSICION_SPT , MEAC
      WHERE CONVERT(CHAR(8),vmfecha,112) = CONVERT(CHAR(8),acfecpro,112) 
        AND vmcodigo = 'USD'
     SELECT @POSINIMX = vmposini
       FROM VIEW_POSICION_SPT
      WHERE vmcodigo = 13       -- 'USD'
-- SELECT * FROM VIEW_POSICION_SPT
     /*=======================================================================*/
     /* Totales */
     /*=======================================================================*/
     SELECT @TOTCOUS =            SUM(momonmo) FROM MEMO WHERE motipope = 'C' and moestatus <> 'A' and (motipmer = 'PTAS' or motipmer = 'EMPR') and mocodmon = 'USD'
     SELECT @TOTCOUS = @TOTCOUS + ISNULL((SELECT SUM(momonmo) FROM MEMO WHERE moestatus <> 'A' and motipmer = 'CANJ'),0) 
     SELECT @TOTCOUS = @TOTCOUS + ISNULL((SELECT SUM(moussme) FROM MEMO WHERE moestatus <> 'A' and motipmer = 'ARBI' and motipope = 'V' and mocodcnv = 'USD'),0)
     SELECT @TOTVEUS =            SUM(momonmo) FROM MEMO WHERE motipope = 'V' and moestatus <> 'A' and (motipmer = 'PTAS' or motipmer = 'EMPR') and mocodmon = 'USD'
     SELECT @TOTVEUS = @TOTVEUS + ISNULL((SELECT SUM(momonmo) FROM MEMO WHERE moestatus <> 'A' and motipmer = 'CANJ'),0) 
     SELECT @TOTVEUS = @TOTVEUS + ISNULL((SELECT SUM(moussme) FROM MEMO WHERE moestatus <> 'A' and motipmer = 'ARBI' and motipope = 'C' and mocodcnv = 'USD'),0) 
     SELECT @TOTCOPE =            SUM(momonpe) FROM MEMO WHERE motipope = 'C' and moestatus <> 'A' and (motipmer = 'PTAS' or motipmer = 'EMPR') and mocodmon = 'USD'
     SELECT @TOTCOPE = @TOTCOPE + ISNULL((SELECT SUM(momonmo*moticam) FROM MEMO WHERE moestatus <> 'A' and motipmer = 'CANJ'),0)
     SELECT @TOTCOPE = @TOTCOPE + ISNULL((SELECT SUM(momonpe)         FROM MEMO WHERE moestatus <> 'A' and motipmer = 'ARBI' and motipope = 'V' and mocodcnv = 'USD'),0)
     SELECT @TOTVEPE =            SUM(momonpe) FROM MEMO WHERE motipope = 'V' and moestatus <> 'A' and (motipmer = 'PTAS' or motipmer = 'EMPR') and mocodmon = 'USD'
     SELECT @TOTVEPE = @TOTVEPE + ISNULL((SELECT SUM(momonmo*motctra) FROM MEMO WHERE moestatus <> 'A' and motipmer = 'CANJ'),0)
     SELECT @TOTVEPE = @TOTVEPE + ISNULL((SELECT SUM(momonpe)         FROM MEMO WHERE moestatus <> 'A' and motipmer = 'ARBI' and motipope = 'C' and mocodcnv = 'USD'),0)
     /*=======================================================================*/
     /* Precios Medios */
     /*=======================================================================*/
     SELECT @PMECO = @TOTCOPE / @TOTCOUS
     SELECT @PMEVE = @TOTVEPE / @TOTVEUS
     SELECT @PMECOFI = ((@TOTCOPE / @TOTCOUS) * @PREFIN)
     SELECT @PMEVEFI = ((@TOTVEPE / @TOTVEUS) * @PREFIN)
     IF @POSINI >= 0
        BEGIN 
          SELECT @TOGCOUS = @TOTCOUS + @POSINI 
          SELECT @TOGCOPE = @TOTCOPE + ROUND(@POSINI * @PREINI,0)
          SELECT @PTOCOM  = ROUND(@TOGCOPE / @TOGCOUS,4)   
          SELECT @TOGVEUS = @TOTVEUS 
          SELECT @TOGVEPE = @TOTVEPE 
          SELECT @PTOVEN  = @PMEVE   
        END
     ELSE
        BEGIN 
          SELECT @TOGVEUS = @TOTVEUS + @POSINI
          SELECT @TOGVEPE = @TOTVEPE + ROUND(@POSINI * @PREINI,0)
          SELECT @PTOVEN  = ROUND(@TOGVEPE / @TOGVEUS,4)   
          SELECT @TOGCOUS = @TOTCOUS 
          SELECT @TOGCOPE = @TOTCOPE 
          SELECT @PTOCOM  = @PMECO   
        END 
     /*=======================================================================*/
     /* Utilidad & Trading */
     /*=======================================================================*/
     /*IF @TOTCOUS >= @TOTVEUS
        SELECT @UTILI = ROUND( @TOTVEUS * (@PMEVE - @PMECO) , 0 )
     ELSE
        SELECT @UTILI = ROUND( @TOTCOUS * (@PMEVE - @PMECO) , 0 )
     */
     IF @TOGCOUS >= @TOGVEUS
        SELECT @UTILI = ROUND( @TOGVEUS * (@PTOVEN - @PTOCOM) , 0 )
     ELSE
        SELECT @UTILI = ROUND( @TOGCOUS * (@PTOVEN - @PTOCOM) , 0 )
     /*=======================================================================*/
     /* Calculos con Posicion */
     /*======================================================================*/
     IF @POSINI > 0
        BEGIN
           SELECT @TOTVEUSPO  = @TOTVEUS
      SELECT @PMEVEPO    = @PMEVE
      SELECT @TOTCOUSPO  = @TOTCOUS + @POSINI
             SELECT @PMECOPO    = ((@TOTCOPE + (@POSINI*@PREINI)) / (@TOTCOUS + @POSINI) )
      SELECT @PCIERREFI  = (@PMECOPO * @PREFIN)
      SELECT @PREINIFI   = (@PREINI  * @PREFIN)
  
        END
     IF @POSINI < 0
        BEGIN
      SELECT @TOTCOUSPO  = @TOTCOUS
      SELECT @PMECOPO    = @PMECO
      SELECT @TOTVEUSPO  = @TOTVEUS + @POSINI
      SELECT @PMEVEPO    = ( (@TOTVEPE + (ABS(@POSINI) * @PREINI)) / (@TOTVEUS + ABS(@POSINI)) )
      SELECT @PCIERREFI  = (@PMEVEPO * @PREFIN)
      SELECT @PREINIFI   = (@PREINI * @PREFIN)
        END
     IF @POSINI = 0
        BEGIN
      SELECT @PMECOPO    = @PMECO
      SELECT @PMEVEPO    = @PMEVE
      SELECT @TOTCOUSPO  = @TOTCOUS
      SELECT @TOTVEUSPO  = @TOTVEUSPO
      SELECT @PCIERREFI  = @PMECO
      SELECT @PREINIFI   = 0
        END
     --- Modificar calculos
     /*IF @TOTCOUSPO > 0
        SELECT @UTILIPO = ( @TOTVEUSPO * (@PMEVEPO - @PMECOPO) )
     ELSE
        SELECT @UTILIPO = ( @TOTCOUSPO * (@PMEVEPO - @PMECOPO) )
     */
     IF @POSINI > 0
        SELECT @UTILIPO = ROUND(( @POSINI * (@PTOVEN - @PREINI) ),0)
     ELSE
        SELECT @UTILIPO = ROUND(( @POSINI * (@PREINI - @PTOCOM) ),0)
     SELECT @POSIC = ( @POSINI + (ISNULL(@TOTCOUS,0.0) - ISNULL(@TOTVEUS,0.0)) )
     SELECT @POSICMX = ( ISNULL(@POSINIMX,0.0) + (ISNULL(@TOTCOUS,0.0) - ISNULL(@TOTVEUS,0.0)) )
     /*IF @POSIC >= 0
        SELECT @PCIERRE = @PMECO
     ELSE
        SELECT @PCIERRE = @PMEVE
     */
     IF @POSIC >= 0
        SELECT @PCIERRE = @PTOCOM
     ELSE
        SELECT @PCIERRE = @PTOVEN
     SELECT @UTILTOT = ISNULL(@UTILI,0.0) + ISNULL(@UTILIPO,0.0)
     /*======================================================================================*/
     /* End Calculos Posicion */
     /*======================================================================================*/
     UPDATE MEAC
        SET actotco   = ISNULL( @TOTCOUS  , 0.0 ),  -- Total Compra
            actotve   = ISNULL( @TOTVEUS  , 0.0 ),  -- Total Venta
            acpmeve   = ISNULL( @PMEVE    , 0.0 ),  -- Precio Promedio Venta
            acpmeco   = ISNULL( @PMECO    , 0.0 ),  -- Precio Promedio Compra
            acposic   = ISNULL( @POSIC    , 0.0 ),  -- Posicion 
            actotcopo  = ISNULL( @TOTCOUSPO, 0.0 ),  -- Total de compra + posicion 
            actotvepo  = ISNULL( @TOTVEUSPO, 0.0 ),  -- Total de venta  + posicion
            acpmecopo  = ISNULL( @PMECOPO  , 0.0 ),  -- Precio de compra + precio posicion
            acpmevepo  = ISNULL( @PMEVEPO  , 0.0 ),  -- Precio de venta  + precio posicion
            acutili   = ISNULL( @UTILI    , 0.0 ),  -- Utilidad Trading
            acutilipo  = ISNULL( @UTILIPO  , 0.0 ),  -- Utilidad Posicion
            acprecie   = ISNULL( @PCIERRE  , 0.0 ),  -- Precio de Cierre
            acutiltot  = ISNULL( @UTILTOT  , 0.0 ),  -- Utilidad Total 
            acpmevefi  = ISNULL( @PMEVEFI  , 0.0 ),  --
            acpmecofi  = ISNULL( @PMECOFI  , 0.0 ),  --
            acpreciefi = ISNULL( @PCIERREFI, 0.0 ),  --
            acpreinifi = ISNULL( @PREINIFI , 0.0 )   --
     UPDATE VIEW_POSICION_SPT
        SET vmfecha    = @Fecha + ' ' + CONVERT(CHAR(12), GETDATE(), 114),    -- con hora para actualizaciÃ³n en lÃ­nea
            vmtotco   = ISNULL( @TOTCOUS  , 0.0 ),
            vmtotve   = ISNULL( @TOTVEUS  , 0.0 ),
            vmpmeco   = ISNULL( @PMECO    , 0.0 ),
            vmpmeve   = ISNULL( @PMEVE    , 0.0 ),
            vmposic   = ISNULL( @POSIC    , 0.0 ),
            vmtotcopo  = ISNULL( @TOTCOUSPO, 0.0 ),
            vmtotvepo  = ISNULL( @TOTVEUSPO, 0.0 ),
            vmpmecopo  = ISNULL( @PMECOPO  , 0.0 ),
            vmPmevepo  = ISNULL( @PMEVEPO  , 0.0 ),
            vmutili   = ISNULL( @UTILI    , 0.0 ),
            vmutilipo  = ISNULL( @UTILIPO  , 0.0 ),
            vmprecierre= ISNULL( @PCIERRE  , 0.0 ),
            vmutiltot  = ISNULL( @UTILTOT  , 0.0 ) --,    
      WHERE vmcodigo = 'USD' 
        AND CONVERT(CHAR(8),vmfecha,112) = @Fecha 
 
     UPDATE VIEW_VALOR_MONEDA
        SET vmposic = ISNULL( @POSICMX , 0.0 ),
            vmtotco = ISNULL( @TOTCOUS , 0.0 ),
            vmtotve = ISNULL( @TOTVEUS , 0.0 )
      WHERE vmcodigo = 13  -- 'USD'
END -- PROCEDURE
-- SELECT * FROM VIEW_VALOR_MONEDA



GO
