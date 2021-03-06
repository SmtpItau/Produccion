USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELMODIIB]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PAPELMODIIB]
    (@nRutcart NUMERIC (09,0) ,
    @nNumoper NUMERIC (10,0) ,
    @cTipoImp CHAR(01) )
AS
BEGIN
SET NOCOUNT ON
 DECLARE @nDiaSem INTEGER  ,
  @nDia  INTEGER  ,
  @nMes  INTEGER  ,
  @nAnn  INTEGER  ,
  @cFecEmis CHAR  (40) ,
  @cFecVens CHAR (40) ,
  @cFecEmi CHAR (40) ,
  @cFecVen CHAR (40) ,
  @Forpai  CHAR (25)  ,
  @Forpav  CHAR (25) ,
  @Cust  CHAR (01) ,
  @Custodia CHAR (25) ,
  @Rutcli  NUMERIC (9,0) ,
  @Dig  CHAR (01) ,
  @Nomcli  CHAR (40) ,
  @Dircli  CHAR (40) ,
  @Nomoper CHAR (40) ,
  @Ret  CHAR (01) ,
  @Retiro  CHAR (15) ,
  @nRutcar NUMERIC (09,0) ,
  @nomemp  CHAR (40) ,
  @rutpro  CHAR (12) ,
  @fecpro  CHAR (10) ,
  @monpac  CHAR (05) ,
  @mtoesc  CHAR (170) ,
  @TotalC  NUMERIC (19,4) ,
  @IntESC  CHAR (170) ,
  @Interes NUMERIC (19,4) ,
  @Obser  CHAR (70) ,
  @NumSol  NUMERIC (9,0) ,
  @linea1  CHAR (70) ,
  @linea2  CHAR (65) ,
  @linea3  CHAR (65) ,
  @linea4  CHAR (65) ,
  @linea5  CHAR (65) ,
  @glocopia CHAR (25) ,
  @nCopia  INTEGER  ,
  @nMoneda INTEGER  ,
  @nValinip NUMERIC (19,4) ,
  @nValvtop NUMERIC (19,4) ,
  @nValmon NUMERIC (19,4) ,
  @dFecinip DATETIME ,
  @cMonLet CHAR (120) ,
  @cPalab1 CHAR (115) ,
  @cPalab2 CHAR (115) ,
  @cValinip CHAR (20) ,
  @cInteres CHAR (20) ,
  @cDato  CHAR (01) ,
  @nLargo  INTEGER  ,
  @nMtopal NUMERIC (19,4) ,
  @hora  CHAR(8)  ,
  @cSettlement CHAR(50) ,
  @cPFE  CHAR(50) ,
  @cCCE  CHAR(50) ,
  @cEmisorInstPlazo CHAR(255),
  @xMiinstser CHAR(12)
 IF @cTipoImp='P'
  SELECT @nCopia = papapimp FROM MDPA WHERE panumoper=@nNumoper
 ELSE
  SELECT @nCopia = paconimp FROM MDPA WHERE panumoper=@nNumoper
 SELECT @glocopia = '.'
 SELECT @nDiaSem = DATEPART(WEEKDAY,mofecinip)     ,
  @nDia  = DATEPART(DAY,mofecinip)     ,
  @nMes  = DATEPART(MONTH,mofecinip)     ,
  @nAnn  = DATEPART(YEAR,mofecinip)     ,
  @dFecinip = mofecinip       ,
  @NumSol  = monsollin       ,
  @Obser  = moobserv       ,
  @linea1  = moobserv2       ,
  @nMoneda = momonpact       ,
  @Nomoper = nombre       ,
  @nomemp  = ISNULL(rcnombre,'')      ,
  @rutpro  = STR(rcrut)+'-'+rcdv     ,
  @fecpro  = ISNULL(CONVERT(CHAR(10),acfecproc,103),'')   ,
  @hora  = mohora
 FROM MDMO, VIEW_USUARIO, VIEW_ENTIDAD,MDAC
 WHERE monumoper=@nNumoper 
 AND  morutcart=@nRutcart 
        AND     morutcart = rcrut
 AND  motipoper='IB' 
 AND mostatreg <> 'A' 
 AND  mousuario=substring(usuario,1,12)
 IF @nMes =  1  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Enero de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  2  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Febrero de '    + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  3  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Marzo de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  4  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Abril de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  5  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Mayo de '       + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  6  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Junio de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  7  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Julio de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  8  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Agosto de '     + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  9  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Septiembre de ' + CONVERT(CHAR(4),@nAnn)
 IF @nMes = 10  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Octubre de '    + CONVERT(CHAR(4),@nAnn)
 IF @nMes = 11  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Noviembre de '  + CONVERT(CHAR(4),@nAnn)
 IF @nMes = 12  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Diciembre de '  + CONVERT(CHAR(4),@nAnn)
 IF @nDiaSem = 1 SELECT @cFecEmis = 'Domingo '   + @cFecEmis 
 IF @nDiaSem = 2 SELECT @cFecEmis = 'Lunes '     + @cFecEmis
 IF @nDiaSem = 3 SELECT @cFecEmis = 'Martes '    + @cFecEmis
 IF @nDiaSem = 4 SELECT @cFecEmis = 'Miercoles ' + @cFecEmis
 IF @nDiaSem = 5 SELECT @cFecEmis = 'Jueves '    + @cFecEmis
 IF @nDiaSem = 6 SELECT @cFecEmis = 'Viernes '   + @cFecEmis
        IF @nDiaSem = 7 SELECT @cFecEmis = 'Sabado '    + @cFecEmis
 SELECT @linea2 = ' ' ,
  @linea3 = ' ' ,
  @linea4 = ' '
 SELECT @nDiaSem = DATEPART(WEEKDAY,mofecvenp) ,
  @nDia  = DATEPART(DAY,mofecvenp) ,
  @nMes  = DATEPART(MONTH,mofecvenp) ,
  @nAnn  = DATEPART(YEAR,mofecvenp)
 FROM MDMO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='IB' AND mostatreg <> 'A'
 IF @nMes =  1  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Enero de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  2  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Febrero de '    + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  3  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Marzo de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  4  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Abril de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  5  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Mayo de '       + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  6  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Junio de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  7  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Julio de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  8  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Agosto de '     + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  9  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Septiembre de ' + CONVERT(CHAR(4),@nAnn)
 IF @nMes = 10  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Octubre de '    + CONVERT(CHAR(4),@nAnn)
 IF @nMes = 11  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Noviembre de '  + CONVERT(CHAR(4),@nAnn)
 IF @nMes = 12  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Diciembre de '  + CONVERT(CHAR(4),@nAnn)
 
 IF @nDiaSem = 1 SELECT @cFecVens = 'Domingo '   + @cFecVens
 IF @nDiaSem = 2 SELECT @cFecVens = 'Lunes '     + @cFecVens
 IF @nDiaSem = 3 SELECT @cFecVens = 'Martes '    + @cFecVens
 IF @nDiaSem = 4 SELECT @cFecVens = 'Miercoles ' + @cFecVens
 IF @nDiaSem = 5 SELECT @cFecVens = 'Jueves '    + @cFecVens
 IF @nDiaSem = 6 SELECT @cFecVens = 'Viernes '   + @cFecVens
 IF @nDiaSem = 7 SELECT @cFecVens = 'Sabado '    + @cFecVens
 SELECT @TotalC  = movalinip  ,
  @nValinip = movalinip  ,
  @Cust  = mocondpacto  ,
  @Rutcli  = morutcli  ,
  @Ret  = motipret  ,
  @Interes = movalvenp - movalinip ,
  @nValvtop = movalvenp  ,
  @xMiinstser = moinstser
 FROM MDMO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='IB' AND mostatreg <> 'A'
 SELECT @Monpac = mnnemo
 FROM VIEW_MONEDA, MDMO
 WHERE morutcart=@nRutcart AND monumoper=@nNumoper AND motipoper='IB' AND
  mostatreg <> 'A' AND momonpact=mncodmon
 SELECT @cMonLet = 'pesos   m/l,   por  concepto   de   intereses,   valores   que   me   obligo   a   pagar    en   esta   ciudad,  calle' ,
  @nMtopal = @TotalC
 IF @nMoneda<>999
 BEGIN
  IF @nmoneda <>13
   SELECT @nvalmon = ISNULL(vmvalor,0.0) FROM VIEW_valor_moneda WHERE vmcodigo=@nmoneda AND vmfecha=@dfecinip
  ELSE
   SELECT @nvalmon  = 1
  SELECT @nValinip = ROUND(@TotalC/@nValmon,4)
  SELECT @Interes = @nValvtop - @nValinip  ,
   @nMtopal = @nValinip
  IF @nMoneda=998
   SELECT @cMonlet = 'unidades de fomento m/l,  por concepto de  intereses,  valores  que  me  obligo  a  pagar  en  esta  ciudad, calle'
  ELSE
   SELECT @cMonLet = 'd«lares  m/l,  por concepto   de   intereses,  valores   que   me   obligo   a   pagar   en   esta  ciudad,  calle'
 END
 SELECT @cValinip = CONVERT(CHAR,@nValinip)
 SELECT @nLargo  = DATALENGTH(SUBSTRING(@cValinip,1,CHARINDEX('.',@cValinip)-1))
 SELECT @cValinip = STUFF(@cValinip,CHARINDEX('.',@cValinip),1,',')
 WHILE @nlargo-3>0
 BEGIN
  SELECT @cDato = SUBSTRING(@cValinip,@nLargo-3,1)
  IF @cDato<>''
   SELECT @cValinip = STUFF(@cValinip, @nLargo-3,1,@cDato+'.')
  SELECT @nLargo = DATALENGTH(SUBSTRING(@cValinip,1,CHARINDEX('.',@cValinip)-1))
 END
 SELECT @cInteres = CONVERT(CHAR,@Interes)
 SELECT @nLargo  = DATALENGTH(SUBSTRING(@cInteres,1,CHARINDEX('.',@cInteres)-1))
 SELECT @cInteres = STUFF(@cInteres,CHARINDEX('.',@cInteres),1,',')
 WHILE @nLargo-3>0
 BEGIN
  SELECT @cDato = SUBSTRING(@cInteres,@nLargo-3,1)
  IF @cDato<>''
    
 SELECT @cInteres = STUFF(@cInteres, @nLargo-3,1,@cDato+'.')
  SELECT @nLargo = DATALENGTH(SUBSTRING(@cInteres,1,CHARINDEX('.',@cInteres)-1))
 END
 IF @nMoneda=999
  SELECT @cPalab1 = 'la suma de $ '+@cValinip+'.-'     ,
   @cPalab2 = 'pesos m/l, por concepto de capital, m~s la suma de $  '+@cInteres
 ELSE
 BEGIN
  SELECT @cPalab1 = 'la suma de dinero equivalente en pesos moneda legal de '+RTRIM(@Monpac)+' '+@cValinip+'.-'
  IF @nMoneda=998
   SELECT @cPalab2 = 'unidades de fomento, por concepto de capital, m~s la suma de  UF '+@cInteres
  ELSE
   SELECT @cPalab2 = 'd«lares, por concepto de capital, m~s la suma de U$ '+@cInteres
 END
/* SELECT @Forpai = tbglosa 
 FROM MdTc, MdMo
 WHERE tbcateg=1 AND CONVERT(NUMERIC(6),tbcodigo1)=moforpagi 
        AND  monumoper=@nNumoper AND morutcart=@nRutcart AND
  motipoper='IB' AND mostatreg <> 'A'
 SELECT @Forpav = tbglosa
 FROM MdTc, MdMo
 WHERE tbcateg=1 AND CONVERT(NUMERIC(6),tbcodigo1)=moforpagv --forma de pago
          AND monumoper=@nNumoper AND morutcart=@nRutcart AND
  motipoper='IB' AND mostatreg <> 'A'
*/
 SELECT @Forpai = glosa 
 FROM VIEW_FORMA_DE_PAGO, MDMO
 WHERE codigo=moforpagi --forma de pago
        AND  monumoper=@nNumoper AND morutcart=@nRutcart 
 AND motipoper='IB' AND mostatreg <>'A'
 SELECT @Forpav = glosa
 FROM VIEW_FORMA_DE_PAGO, MDMO
 WHERE codigo=moforpagv --forma de pago
        AND  monumoper=@nNumoper 
 AND  morutcart=@nRutcart 
 AND motipoper='IB' 
 AND  mostatreg <>'A'
 IF @Cust='S'
  SELECT @Custodia = 'Con Custodia'
 ELSE
  SELECT @Custodia = 'Sin Custodia'
         
 SELECT  @Nomcli = clnombre  ,
  @Dircli = cldirecc  ,
  @Dig = ISNULL(cldv,'')
 FROM VIEW_CLIENTE
 WHERE clrut=@Rutcli
     
 IF @Ret='V'
  SELECT @Retiro = 'Vamos'
 
 ELSE
  SELECT @Retiro = 'Vienen'
        
 EXECUTE SP_MONTOESCRITO @nMtopal, @Mtoesc OUTPUT
 EXECUTE SP_MONTOESCRITO @interes, @Intesc OUTPUT
 EXECUTE SP_PAPELETA_LIMITES 'IB'     ,
     @nNumoper    ,
     @cSettlement  OUTPUT  ,
     @cPFE   OUTPUT  ,
     @cEmisorInstPlazo OUTPUT  ,
     @cCCE   OUTPUT
 SELECT 'nomemp' = ISNULL(@nomemp,'')          ,
         'rutemp' = ISNULL(@rutpro,'')          ,
    'fecpro' = ISNULL(@fecpro,'')          ,
         'nomope' = ISNULL(@Nomoper,'')          ,
         'nominal' = ISNULL(movpresen,0)          ,
  'Mtoesc' = ISNULL(SUBSTRING(@mtoesc,1,120),'')        ,
  'numdocu' = RTRIM(CONVERT(CHAR(10),ISNULL(monumoper,0)))+'-'+RTRIM(CONVERT(CHAR(3),ISNULL(mocorrela,0))) ,
  'mtofin' = ISNULL(movalvenp,0)          ,
  'Tir'  = ISNULL(motaspact,0)          ,
  'fecvto' = ISNULL(CONVERT(CHAR(10),mofecvenp,103),'')       ,
  'plazo'         = CONVERT(CHAR(05),ISNULL(DATEDIFF(DAY,mofecinip,mofecvenp),0) )    ,
  'interes' = ISNULL(@Interes,0)          ,
  'nomcli' = ISNULL(@Nomcli,'')          ,
  'dircli' = ISNULL(@Dircli,'')          ,
  'forpai' = ISNULL(@forpai,'')          ,
  'CtaCte' = CONVERT(CHAR(10),'0')          ,
  'rutcli' = STR(@Rutcli)+'-'+@Dig          ,
  'custodia' = ISNULL(@Custodia,'')          ,
         'forpav' = ISNULL(@forpav,'')          ,
         'tipret' = ISNULL( @Retiro,'')          ,
  'Numoper' = CONVERT(CHAR(10),monumoper)         ,
         'serie'  = ISNULL(moinstser,'')          ,
                'titulo' = CASE moinstser WHEN 'ICOL' THEN 'INTERBANCARIO COLOCACION' ELSE 'INTERBANCARIO CAPTACION' END    ,
  'Monpacto' = ISNULL(mnnemo,'')          ,
  'glomon' = ISNULL(mnglosa,'')          ,
                'Base'  = ISNULL(CONVERT(CHAR(03),mobaspact),'')       ,
  'fecemi' = ISNULL(@cFecEmis,'')          ,
  'fecven' = ISNULL(@cFecvens,'')          ,
                'interes' = ISNULL(@intesc,'')          ,
                'Obser'  = ISNULL(@Obser,'')          ,
         'Linea1' = ISNULL(@linea1,'')          ,
         'Linea2' = ISNULL(@linea2,'')          ,
         'Linea3' = ISNULL(@linea3,'')          ,
         'Linea4' = ISNULL(@linea4,'')          ,
         'Linea5' = ISNULL(@linea5,'')          ,
         'copia'  = ISNULL(@glocopia,'')          ,
  'valinium' = ISNULL(@nValinip,0.0)          ,
  'palabras' = ISNULL(@cMonlet,'')          ,
  'palab1' = ISNULL(@cPalab1,'')          ,
  'palab2' = ISNULL(@cPalab2,'')          ,
  'hora'  = @hora            ,
  'Lim_Settle' = @cSettlement           ,
  'Lim_EmiPlz' = @cEmisorInstPlazo
        FROM MDMO, VIEW_MONEDA
        WHERE morutcart=@nRutcart AND monumoper=@nNumoper AND motipoper='IB' AND mostatreg <> 'A' AND
  momonpact=mncodmon
SET NOCOUNT OFF
 RETURN
END
-- select * from mdmo where motipoper='IB'
-- SP_PAPELmodiIB 78221830,2,P

GO
