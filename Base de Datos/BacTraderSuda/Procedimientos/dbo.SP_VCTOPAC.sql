USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VCTOPAC]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_VCTOPAC]
                     (@dFecDesde DATETIME, 
                      @dFecHasta DATETIME)
  AS
  BEGIN
      
     -- Definiciones de variables
     --------------------------------
        DECLARE @cArchivo VARCHAR(30)
        DECLARE @cBuffer  VARCHAR(255)
        DECLARE @cExecute VARCHAR(200)
        DECLARE @User     VARCHAR(100)
        SELECT @User   = 'sp_vctopac'
        SELECT @cArchivo = LTRIM( @user ) + CONVERT(CHAR(14),GETDATE(),114)
        SELECT @cArchivo = STUFF( @cArchivo,13 ,1,'_' )
        SELECT @cArchivo = STUFF( @cArchivo,16,1,'_' )
        SELECT @cArchivo = STUFF( @cArchivo,19,1,'_' )
        SELECT @cArchivo = LTRIM( @cArchivo )
        SELECT @cBuffer  = 'SELECT * INTO ' + @cArchivo  + ' FROM #TEMP1'
     ----------------------------------------------------------------
     -- Temporal 1
     ----------------------------------------------------------------
       SELECT 'nomemp'     = 'A,' + ISNULL( mdac.acnomprop, ''),                                                                       
              'rutemp'     = ISNULL( ( RTRIM (CONVERT( CHAR(9), mdac.acrutprop ) ) + '-' + mdac.acdigprop ),'' ),               
              'fecpro'     = CONVERT(CHAR(10), mdac.acfecproc, 103),                                                            
              'fecdesde'   = CONVERT(CHAR(10), @dFecDesde, 103),
              'fechasta'   = CONVERT(CHAR(10), @dFecHasta, 103),
              'numdocu'    = SPACE(14),
              'tipoper'    = SPACE(03),
              'serie'      = SPACE(12),
              'fecinip'    = SPACE(10),
              'fecvenp'    = SPACE(10),
              'taspact'    = CONVERT ( FLOAT, 0 ),
              'baspact'    = 0,
              'monpact'    = SPACE(03),
              'nominal'    = CONVERT(FLOAT,0), -- Nominal
              'valinip'    = CONVERT(FLOAT,0), -- Valor Inicio del Pacto
              'valvenp'    = CONVERT(FLOAT,0), -- Valor Vencimiento del Pacto
              'interes'    = CONVERT(FLOAT,0)  -- ( Valor Inicio del Pacto ) - ( Valor Vencimiento del Pacto )
       INTO   #TEMP1
       FROM   MDAC
     ---------------------------------------------------
     -- seleccionamos todos los campos de la tabla mdci
     ---------------------------------------------------
       SELECT 'nomemp'     = 'B,' + SPACE(38), 
              'rutemp'     = SPACE(11),
              'fecpro'     = SPACE(10),
              'fecdesde'   = SPACE(10),
              'fechasta'   = SPACE(10),
              'numdoc'     = ISNULL( mdci.cinumdocu, 0),
              'rutcart'    = ISNULL( mdci.cirutcart, 0),
              'correla'    = ISNULL( mdci.cicorrela, 0),
              'numdocu'    = RTRIM(CONVERT(CHAR(10),ISNULL( mdci.cinumdocu, 0))) +'-'+ CONVERT(CHAR(3),ISNULL( mdci.cicorrela, 0)), 
              'tipoper'    = 'CI',
              'serie'      = ISNULL( mdci.ciinstser, ''),
              'seriado'    = SPACE(01),
              'fecinip'    = CONVERT( CHAR(10), mdci.cifecinip, 103 ),
              'fecvenp'    = CONVERT( CHAR(10), mdci.cifecvenp, 103 ),
              'taspact'    = ISNULL( mdci.citaspact, 0 ),
              'baspact'    = mdci.cibaspact,
              'monpact'    = SPACE(03),
              'codmon'     = mdci.cimonpact,
              'nominal'    = ISNULL( mdci.cinominal, 0 ),
              'valinip'    = ISNULL( mdci.civalinip, 0 ),
              'valvenp'    = ISNULL( mdci.civalvenp, 0 ),
              'interes'    = ISNULL( mdci.civalinip, 0 ) - ISNULL( mdci.civalvenp, 0 )
       INTO   #TEMP2
       FROM   MDCI
       WHERE  mdci.cifecvenp >= @dFecDesde
       AND    mdci.cifecvenp <= @dFecHasta
       ORDER BY cinumdocu,
                cicorrela
     ---------------------------------------------------
     -- seleccionamos todos los campos de la tabla mdvi
     ---------------------------------------------------
       SELECT 'nomemp'     = 'B,' + SPACE(38), 
              'rutemp'     = SPACE(11),
              'fecpro'     = SPACE(10),
              'fecdesde'   = SPACE(10),
              'fechasta'   = SPACE(10),
              'numdoc'     = ISNULL( mdvi.vinumdocu, 0),
              'rutcart'    = ISNULL( mdvi.virutcart, 0),
              'correla'    = ISNULL( mdvi.vicorrela, 0),
              'numdocu'    = RTRIM(CONVERT(CHAR(10),ISNULL( mdvi.vinumdocu, 0))) +'-'+ CONVERT(CHAR(03),ISNULL( mdvi.vicorrela, 0)), 
              'tipoper'    = 'VI',
              'serie'      = SPACE(12), 
              'seriado'    = SPACE(01),
              'fecinip'    = CONVERT(CHAR(10),mdvi.vifecinip,103),
              'fecvenp'    = CONVERT(CHAR(10),mdvi.vifecvenp,103),
              'taspact'    = CONVERT(FLOAT,ISNULL(mdvi.vitaspact,0)),
              'baspact'    = mdvi.vibaspact,
              'monpact'    = SPACE(03),
              'codmon'     = mdvi.vimonpact,
              'nominal'    = ISNULL( mdvi.vinominal, 0 ),
              'valinip'    = ISNULL( mdvi.vivalinip, 0 ),
              'valvenp'    = ISNULL( mdvi.vivalvenp, 0 ),
              'interes'    = ISNULL( mdvi.vivalinip, 0 ) - ISNULL( mdvi.vivalvenp, 0 )
       INTO   #TEMP3
       FROM     MDVI
       WHERE  mdvi.vifecvenp >= @dFecDesde
       AND    mdvi.vifecvenp <= @dFecHasta
       ORDER BY vinumdocu,
                vicorrela
     ---------------------------------------------
     -- Actualizamos la serie del mdvi
     ---------------------------------------------
       UPDATE #TEMP3 SET serie   = MDCP.cpinstser,
                         seriado = MDCP.cpseriado
       FROM MDCP
       WHERE numdoc  = MDCP.cpnumdocu
       AND   correla = MDCP.cpcorrela        
    ------------------------------------------------------
    --        Actualizamos NemotTcnico de moneda        --
    ------------------------------------------------------
      UPDATE #TEMP2 SET monpact = SUBSTRING( VIEW_MONEDA.mnnemo, 1, 3)
      FROM   VIEW_MONEDA
      WHERE  codmon = VIEW_MONEDA.mncodmon
      UPDATE #TEMP3 SET monpact = SUBSTRING( VIEW_MONEDA.mnnemo, 1, 3)
      FROM   VIEW_MONEDA
      WHERE  codmon = VIEW_MONEDA.mncodmon
    ------------------------------------------------------
    -- Traspasamos registros de la tabla Temporal 2
    -- y de la tabla Temporal 3 a la Temporal 1
    ------------------------------------------------------
      INSERT INTO #TEMP1 SELECT #TEMP2.nomemp  ,
                                #TEMP2.rutemp  ,
                                #TEMP2.fecpro  ,
                                #TEMP2.fecdesde,
                                #TEMP2.fechasta,
                                #TEMP2.numdocu ,
                                #TEMP2.tipoper ,
                                #TEMP2.serie   ,
                                #TEMP2.fecinip ,
                                #TEMP2.fecvenp ,
                                #TEMP2.taspact ,
                                #TEMP2.baspact ,
                                #TEMP2.monpact ,
                                #TEMP2.nominal ,
                                #TEMP2.valinip ,
                                #TEMP2.valvenp ,
                                #TEMP2.interes 
                         FROM   #TEMP2
                         ORDER BY #TEMP2.Tipoper,
                                  #TEMP2.numdoc ,
                                  #TEMP2.correla
      INSERT INTO #TEMP1 SELECT #TEMP3.nomemp  ,
                                #TEMP3.rutemp  ,
                                #TEMP3.fecpro  ,
                                #TEMP3.fecdesde,
                                #TEMP3.fechasta,
                                #TEMP3.numdocu ,
                                #TEMP3.tipoper ,
                                #TEMP3.serie   ,
                                #TEMP3.fecinip ,
                                #TEMP3.fecvenp ,
                                #TEMP3.taspact ,
                                #TEMP3.baspact ,
                                #TEMP3.monpact ,
                                #TEMP3.nominal ,
                                #TEMP3.valinip ,
                                #TEMP3.valvenp ,
                                #TEMP3.interes
                         FROM   #TEMP3
                         ORDER BY #TEMP3.Tipoper,
                                  #TEMP3.numdoc ,
                                  #TEMP3.correla
     -- Seleccionamos solo los campos que necesitamos imprimir 
     -----------------------------------------------------------
     -- de la tabla temporal.-      
     -----------------------------------------------------------
        SELECT * FROM #TEMP1
        EXECUTE (@cBuffer)
     -- generar datos SDF.-
     ---------------------------------------------
        SELECT  @cExecute = 'master.dbo.xp_cmdshell  BCP BT_CHILE..' + @cArchivo +' out C:\JFSRVR\' + @cArchivo + '.TXT /c  /r \n /t, /SBAC-SRV /Usa /PETHERNET'
        EXECUTE  ( @cExecute )
     -- conbinar  los datos con la cabecera.-
     ----------------------------------------------
        SELECT   @cExecute = 'master.dbo.xp_cmdshell "COPY C:\BTCHILE\VCTOPAC\VCTOPAC.TXT+C:\JFSRVR\'+@cArchivo+'.TXT  C:\JFSRVR\'+@cArchivo+'.dat"'
        EXECUTE (@cExecute)
     -- borra el archivo txt del servidor.-
     ----------------------------------------------
        SELECT   @cExecute = 'master.dbo.xp_cmdshell "DEL C:\JFSRVR\'+@cArchivo+'.txt"'
        EXECUTE (@cExecute)
    
     -- Borra la tabla que se ha creado
     ----------------------------------------------
        SELECT @cExecute = 'drop table ' + @cArchivo
        EXECUTE (@cExecute)
END


GO
