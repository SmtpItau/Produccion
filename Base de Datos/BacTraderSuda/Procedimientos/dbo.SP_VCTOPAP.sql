USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VCTOPAP]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_VCTOPAP]
                               ( @dFecDesde DATETIME, 
                                 @dFecHasta DATETIME )
  AS
  BEGIN
      
        -----------------------------
 -- Definiciones de variables
        -----------------------------
        DECLARE @cArchivo VARCHAR(25)
        DECLARE @cBuffer  VARCHAR(250)
        DECLARE @cExecute VARCHAR(200)
        DECLARE @User     VARCHAR(100)
        SELECT @User   = 'sp_vctopap'     
        SELECT @cArchivo = LTRIM(@user) + CONVERT(CHAR(14),GETDATE(),114)
        SELECT @cArchivo = STUFF( @cArchivo,13, 1,'_' )
        SELECT @cArchivo = STUFF( @cArchivo,16, 1,'_' )
        SELECT @cArchivo = STUFF( @cArchivo,19, 1,'_' )
        SELECT @cArchivo = LTRIM( @cArchivo )
        SELECT @cBuffer   = 'SELECT * ' + 'INTO '  + @cArchivo + ' FROM #TEMP1'
   ----------------------------------------------------
   -- Forma el archivo de datos para el JF.
   ----------------------------------------------------
   -- seleccionamos todos los campos de la tabla MDCP
   ----------------------------------------------------    
   -- tabla temporal 1
   ----------------------------------------------------
       SELECT 'nomemp'     = 'A,' +  ISNULL( mdac.acnomprop, ''),
              'rutemp'     = ISNULL( ( RTRIM (CONVERT( CHAR(9), mdac.acrutprop ) ) + '-' + mdac.acdigprop ),'' ),
              'fecpro'     = CONVERT( CHAR(10), mdac.acfecproc, 103),
              'fecdesde'   = CONVERT( CHAR(10), @dFecDesde, 103 ),
              'fechasta'   = CONVERT( CHAR(10), @dFecHasta, 103 ),
              'numdocu'    = SPACE(14),
              'serie'      = SPACE(12),
              'fecemi'     = SPACE(10),
              'fecven'     = SPACE(10),
              'tasemi'     = CONVERT( FLOAT, 0 ),
              'basemi'     = SPACE(03),
              'monemi'     = SPACE(03),
              'nominal'    = CONVERT( FLOAT, 0 ),
              'tir'        = CONVERT( FLOAT, 0 ),
              'pvp'        = CONVERT( FLOAT, 0 ),
              'mtocom'     = CONVERT( FLOAT, 0 ),
              'vpproc'     = CONVERT( FLOAT, 0 )
       INTO   #TEMP1
       FROM   MDAC
   -----------------------------------------------------
   -- tabla temporal 2
   -----------------------------------------------------
       SELECT 'nomemp'     = 'B,' + SPACE(38),
              'rutemp'     = SPACE(11),
              'fecpro'     = SPACE(10),
              'fecdesde'   = SPACE(10),
              'fechasta'   = SPACE(10),
              'rutcart'    = ISNULL( MDCP.cprutcart, 0),
              'numdoc'     = ISNULL( MDCP.cpnumdocu, 0),
              'correla'    = ISNULL( MDCP.cpcorrela, 0),
              'numdocu'    = RTRIM ( CONVERT(CHAR(10), ISNULL( MDCP.cpnumdocu, 0))) + '-' + CONVERT(CHAR(3), ISNULL( MDCP.cpcorrela, 0) ),
              'serie'      = ISNULL( MDCP.cpinstser, ''),
              'seriado'    = CONVERT(CHAR(01), MDCP.cpseriado),
              'fecemi'     = ISNULL( CONVERT(CHAR(10), MDCP.cpfecemi, 103), ''),
              'fecven'     = ISNULL( CONVERT(CHAR(10), MDCP.cpfecven, 103), ''),
              'tasemi'     = CONVERT( FLOAT, 0 ),
              'basemi'     = SPACE(03),
              'monemi'     = SPACE(03),
              'codmon'     = 0,
              'nominal'    = CONVERT( FLOAT, ISNULL( MDCP.cpnominal, 0) ),
              'tir'        = CONVERT( FLOAT, ISNULL( MDCP.cptircomp, 0) ),
              'pvp'        = CONVERT( FLOAT, ISNULL( MDCP.cppvpcomp, 0) ),
              'mtocom'     = CONVERT( FLOAT, ISNULL( MDCP.cpvalcomp, 0) ),
              'vpproc'     = CONVERT( FLOAT, ISNULL( MDCP.cpvpcomp,  0) )
       INTO   #TEMP2
       FROM   MDAC, MDCP
       WHERE  MDCP.cpfecven >= @dFecDesde
       AND    MDCP.cpfecven <= @dFecHasta
       ORDER BY MDCP.cpnumdocu, 
                MDCP.cpcorrela
     
   --------------------------------------------------------------------
   -- Cuando es seriado
   -------------------------------------------------------------------- 
   -- Actualizamos datos de la tabla de temporal con los datos de serie
   --------------------------------------------------------------------
       UPDATE #TEMP2 SET
              fecemi     = CONVERT( CHAR(10), VIEW_SERIE.sefecemi, 103),
              fecven     = CONVERT( CHAR(10), VIEW_SERIE.sefecven, 103),  
              tasemi     = ISNULL( VIEW_SERIE.setasemi, 0 ),
              basemi     = CONVERT( CHAR(03), VIEW_SERIE.sebasemi ),
              monemi     = '', 
              codmon     = VIEW_SERIE.semonemi
       FROM   VIEW_SERIE
       WHERE  seriado    = 'S'
       AND    serie      = VIEW_SERIE.seserie
   ----------------------------------------------------------------
   --   Cuando no es seriado
   ---------------------------------------------------------------- 
   -- VIEW_NOSERIE
   ----------------------------------------------------------------
       UPDATE #TEMP2 SET
              fecemi     = CONVERT( CHAR(10), VIEW_NOSERIE.nsfecemi, 103 ),
              fecven     = CONVERT( CHAR(10), VIEW_NOSERIE.nsfecven, 103 ),  
              tasemi     = ISNULL( VIEW_NOSERIE.nstasemi, 0 ),
              basemi     = CONVERT( CHAR(03), VIEW_NOSERIE.nsbasemi ),
              monemi     = '',
              codmon     = VIEW_NOSERIE.nsmonemi
       FROM   VIEW_NOSERIE
       WHERE  seriado <> 'S'
       AND    rutcart        = VIEW_NOSERIE.nsrutcart
       AND    numdoc         = VIEW_NOSERIE.nsnumdocu 
       AND    correla        = VIEW_NOSERIE.nscorrela
   ------------------------------------------------------------
   -- Actualizamos GenTrico de la Moneda                     --
   ------------------------------------------------------------ 
       UPDATE #TEMP2 SET monemi = SUBSTRING( VIEW_MONEDA.mnnemo, 1, 3)
       FROM VIEW_MONEDA
       WHERE VIEW_MONEDA.mncodmon = #TEMP2.codmon
                                
       INSERT INTO #TEMP1 SELECT #TEMP2.nomemp   ,
                                 #TEMP2.rutemp   ,
                                 #TEMP2.fecpro   ,
                                 #TEMP2.fecdesde ,
                                 #TEMP2.fechasta ,
                                 #TEMP2.numdocu  ,
                                 #TEMP2.serie    ,
                                 #TEMP2.fecemi   ,
                                 #TEMP2.fecven   ,
                                 #TEMP2.tasemi   ,
                                 #TEMP2.basemi   ,
                                 #TEMP2.monemi   ,
                                 #TEMP2.nominal  ,
                                 #TEMP2.tir      ,
                                 #TEMP2.pvp      ,
                                 #TEMP2.mtocom   ,
                                 #TEMP2.vpproc
                          FROM   #TEMP2
                          ORDER BY #TEMP2.numdoc ,
                                   #TEMP2.correla
                                   
     -------------------------------------------------------------
     -- Seleccionamos solo los campos que necesitamos imprimir de 
     -- la tabla temporal.-      
     -------------------------------------------------------------
        SELECT * FROM #TEMP1
        EXECUTE (@cBuffer)
     -- generar datos SDF.-
     ----------------------
        SELECT  @cExecute = 'master.dbo.xp_cmdshell "BCP BT_CHILE..' + @cArchivo +' out C:\JFSRVR\' + @cArchivo + '.TXT /c /r \n /t , /SBAC-SRV /Usa /PETHERNET"'
        EXECUTE  ( @cExecute )
     -- conbinar  los datos con la cabecera.-
     ----------------------------------------
        SELECT   @cExecute = 'master.dbo.xp_cmdshell "COPY C:\BTCHILE\VCTOPAP\VCTOPAP.TXT+C:\jfsrvr\'+@cArchivo+'.TXT  C:\JFSRVR\'+@cArchivo+'.dat"'
        EXECUTE (@cExecute)
     -- borra el archivo txt del servidor.-
     --------------------------------------
        SELECT   @cExecute = 'master.dbo.xp_cmdshell "DEL C:\jfsrvr\'+@cArchivo+'.txt"'
        EXECUTE (@cExecute)
    
     -- Borra la tabla que se ha creado
     ----------------------------------- 
        SELECT @cExecute = 'drop table ' + @cArchivo
        EXECUTE (@cExecute)
      
END


GO
