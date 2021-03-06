USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFOVI]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFOVI]
AS
BEGIN
 DECLARE @cArchivo VARCHAR(30)
 DECLARE @cBuffer  VARCHAR(60)
 DECLARE @cExecute VARCHAR(200)
 DECLARE @Largo    NUMERIC(5)
 DECLARE @User   CHAR(30)
 DECLARE @cMacro   CHAR(30)
 DECLARE @cEject   CHAR(80)
       -- Determina nombre de archivos temporales
 SELECT @User     = 'Inforvi'
 SELECT @Largo    = CONVERT(NUMERIC(5,0),DATALENGTH(RTRIM(@User)))
 SELECT @cArchivo = RTRIM(@user) + CONVERT(CHAR(14),GETDATE(),114)
 SELECT @cArchivo = STUFF( @cArchivo,10,1,'_')
 SELECT @cArchivo = STUFF( @cArchivo,13,1,'_')
 SELECT @cArchivo = STUFF( @cArchivo,16,1,'_')
 SELECT @cArchivo = LTRIM(@cArchivo)
 SELECT @cBuffer  = 'SELECT * INTO ' + @cArchivo  + ' FROM #temp2'
----- Sacar encabezado del reporte------------
 SELECT 'Empresa'    = 'A,'+ISNULL(MDAC.acnomprop,''),
        'Rutpro'     = ISNULL(RTRIM(CONVERT(CHAR(9),MDAC.acrutprop)) +'-'+ MDAC.acdigprop,''),
        'Fec_pro'    = ISNULL(CONVERT(CHAR(10),MDAC.acfecproc,103),''),
        'Fec_Rep'    = ISNULL(CONVERT(CHAR(10),MDAC.acfecproc,103),''),
        'Cliente'    = Space(40),
        'Cartera'    = Space(50),
        'T_Cartera'  = SPACE(25),
        'NíDocumento'= Space(14),
        'Serie'      = Space(12),
        'Emisor'     = Space(10),
        'F_Emi'      = Space(10),
        'F_Vto'      = Space(10),
        'Tas_Emi'    = CONVERT(NUMERIC(09,4),0),
        'Bas_Emi'    = CONVERT(NUMERIC(03,0),0),
        'Mon_Emi'    = Space(5),
        'Nominal'    = CONVERT(NUMERIC(19,4),0),
        'TIR'        = CONVERT(NUMERIC(09,4),0),
        'PVP'        = CONVERT(NUMERIC(07,2),0),
        'Tas_Est'    = CONVERT(NUMERIC(09,4),0),
        'Venta'      = CONVERT(NUMERIC(19,4),0),
        'F_Inip'     = Space(10),
        'F_Venp'     = Space(10),
        'Taspact'    = CONVERT(NUMERIC(09,4),0),
        'Baspact'    = CONVERT(NUMERIC(03,0),0),
        'Monpact'    = SPACE(5),
        'Valinipact' = CONVERT(NUMERIC(19,4),0),
        'Valvenpact' = CONVERT(NUMERIC(19,4),0),
        'Val_Presen' = CONVERT(NUMERIC(19,4),0),
        'F_Pagoi'    = SPACE(25),
        'F_pagov'    = SPACE(25),
        'T_Custod'   = Space(25),
        'Pago_hoy'   = Space(25),
        'cod_cart'   = 0,
        'Cod_Monpact'= 0,
        'Cod_Fpago'  = 0,
        'Cod_Fpagv'  = 0,
        'Numoper'    = 0,
        'Correla'    = 0             
 INTO #TEMP
 FROM mdac
---- Sacar registros correspondientes a la data del reporte ---------------
 INSERT #Temp
       SELECT 'Empresa'    = 'B,'+ISNULL(MDAC.acnomprop,''),
              'Rutpro'     = ISNULL(RTRIM(CONVERT(CHAR(9),MDAC.acrutprop)) +'-'+ MDAC.acdigprop,''),
              'Fec_pro'    = ISNULL(CONVERT(CHAR(10),MDAC.acfecproc,103),''),
              'Fec_Rep'    = ISNULL(CONVERT(CHAR(10),MDAC.acfecproc,103),''),
              'Cliente'    = ISNULL(VIEW_CLIENTE.clnombre,''),
              'Cartera'    = ISNULL(VIEW_ENTIDAD.rcnombre,''),
              'T_Cartera'  = SPACE(25),
              'NíDocumento'= ISNULL((RTRIM(CONVERT(CHAR(10),MDMO.monumoper))+'-'+CONVERT(CHAR(3),MDMO.mocorrela)),''),
              'Serie'      = ISNULL(MDMO.moinstser,''),
              'Emisor'     = ISNULL(VIEW_EMISOR.emgeneric,''),
              'F_Emi'      = ISNULL(CONVERT(CHAR(10),MDMO.mofecemi,103),''),
              'F_Vto'      = ISNULL(CONVERT(CHAR(10),MDMO.mofecven,103),''),
              'Tas_Emi'    = ISNULL(MDMO.motasemi,0),
              'Bas_Emi'    = ISNULL(MDMO.mobasemi,0),
              'Mon_Emi'    = ISNULL(VIEW_MONEDA.mnnemo,''),
              'Nominal'    = ISNULL(MDMO.monominal,0),
              'TIR'        = ISNULL(MDMO.motir,0),
              'PVP'        = ISNULL(MDMO.mopvp,0),
              'Tas_Est'    = ISNULL(MDMO.motasest,0),
              'Venta'      = ISNULL(MDMO.momtps,0),
              'F_Inip'     = ISNULL(CONVERT(CHAR(10),MDMO.mofecinip,103),''),
              'F_Venp'     = ISNULL(CONVERT(CHAR(10),MDMO.mofecvenp,103),''),
              'Taspact'    = ISNULL(MDMO.motaspact,0),
              'Baspact'    = ISNULL(MDMO.mobaspact,0),
              'Monpact'    = SPACE(5),
              'Valinipact' = ISNULL(MDMO.movalinip,0),
              'Valvenpact' = ISNULL(MDMO.movalvenp,0),
              'Val_Presen' = ISNULL(MDMO.movpresen,0),
              'F_Pagoi'    = SPACE(25),
              'F_pagov'    = SPACE(25),
              'T_Custod'   = 'CUSTODIA PROPIA',
              'Pago_hoy'   = CASE MDMO.mopagohoy WHEN 'N' THEN 'Pago maana' ELSE '' END,
              'cod_cart'   = ISNULL(MDMO.motipcart,0),
              'Cod_Monpact'= ISNULL(MDMO.momonpact,0),
              'Cod_Fpago'  = ISNULL(MDMO.moforpagi,0),
              'Cod_Fpagv'  = ISNULL(MDMO.moforpagv,0),
              'Numoper'    = ISNULL(mdmo.monumoper,0),
              'Correla'    = ISNULL(mdmo.mocorrela,0)             
  FROM mdac, MDMO, VIEW_CLIENTE, VIEW_ENTIDAD, VIEW_EMISOR, VIEW_MONEDA
         WHERE MDMO.motipoper='VI' AND MDMO.mostatreg <> 'A' AND
               VIEW_CLIENTE.clrut=mdmo.morutcli AND VIEW_ENTIDAD.rcrut=mdmo.morutcart AND
        VIEW_EMISOR.emrut=mdmo.morutemi AND VIEW_MONEDA.mncodmon=mdmo.momonemi
  
------- Nemotecnico de la moneda del pacto -----------------
 UPDATE #temp
        SET monpact=VIEW_MONEDA.mnnemo
        FROM #TEMP, VIEW_MONEDA
        WHERE VIEW_MONEDA.mncodmon=#temp.cod_monpact
------- Glosa de la forma de pago al inicio ----------------
 UPDATE #temp
        SET F_pagoi=VIEW_FORMA_PAGO.glosa
        FROM #TEMP, VIEW_FORMA_PAGO
        WHERE   CONVERT(NUMERIC(6),VIEW_FORMA_PAGO.codigo)=#temp.Cod_Fpago --Forma Pago
------- Glosa forma de pago al vencimiento -----------------
 UPDATE #temp
        SET F_pagov=VIEW_FORMA_PAGO.glosa
        FROM #TEMP, VIEW_FORMA_PAGO
        WHERE   CONVERT(NUMERIC(6),VIEW_FORMA_PAGO.codigo)=#temp.Cod_Fpagv --Forma Pago
------- Glosa de acuerdo al tipo de cartera ----------------
 UPDATE #temp
        SET T_cartera=MDTC.tbglosa
        FROM #TEMP, MDTC
        WHERE  mdtc.tbcateg=204 and CONVERT(NUMERIC(6),mdtc.tbcodigo1)=#temp.Cod_cart
 SELECT * INTO #Temp2
        FROM #Temp
        ORDER BY #temp.numoper + #temp.correla
        EXECUTE (@cBuffer)
        SELECT  @cExecute = 'master.dbo.xp_cmdshell "BCP BT_CHILE..' + @cArchivo +' out C:\BTCHILE\INFOVI\' + @cArchivo + '.TXT /c /t, /r \n /SBAC-SRV /Usa /PETHERNET"'
        EXECUTE  ( @cExecute )
     -- combinar los datos con la cabecera.-
        SELECT  @cExecute = 'master.dbo.xp_cmdshell "COPY C:\BTCHILE\INFOVI\Einfovi.TXT+C:\BTCHILE\INFOVI\'+ @cArchivo+'.TXT  C:\JFSRVR\'+@cArchivo+'.dat"'
        EXECUTE (@cExecute)
        SELECT @cMacro = 'DROP TABLE ' + @cArchivo
        EXECUTE (@cMacro)
        SELECT  @cEject = 'master.dbo.xp_cmdshell "DEL C:\BTCHILE\INFOVI\' + @cArchivo + '.TXT"'
        EXECUTE (@cEject)
END


GO
