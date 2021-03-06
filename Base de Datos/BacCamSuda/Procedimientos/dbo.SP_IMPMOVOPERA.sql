USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPMOVOPERA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_IMPMOVOPERA]( @fechai   char(08),
                                 @fechaf   char(08),
                                 @Oper     CHAR(10),
                                 @Tipo     CHAR(1)
--     @FECHAIMPR CHAR(8),
--            @FECHA    CHAR(8),
--     @HORA     CHAR(12))
--     @fechai   DATETIME,
--                                 @fechaf   DATETIME,
--                                 @Oper     CHAR(10),
--                                 @Tipo     CHAR(1)
)
AS
BEGIN
 DECLARE @xNomprop CHAR(50)
 DECLARE @xRutprop NUMERIC(09)
 DECLARE @xDigprop CHAR(01)
 
  SELECT @xNomprop = acnomprop,
         @xRutprop = acrutprop,
         @xDigprop = acdigprop
    FROM Bactradersuda..mdac
  IF @Tipo='1'
     BEGIN
         DECLARE @fechap DATETIME,
                 @fechat DATETIME
         SELECT  @fechap = acfecpro  FROM meac
         DELETE memoimp
         -- MEMOH
         IF @fechai < CONVERT(CHAR(08),@fechap,112)
         BEGIN
             SELECT  @fechat = CONVERT(DATETIME,@fechaf)
             IF @fechaf = CONVERT(CHAR(08),@fechap,112)
                SELECT  @fechat = DATEADD(dd, -1,@fechap)
             INSERT INTO memoimp
                  SELECT monumope,motipope,morutcli,mocodcli,
                         mocodmon,momonmo ,moussme ,moticam ,
                         motctra ,moticam ,moparme ,mopar30 ,moparme,
                         mooper  ,mofech  ,motipmer,
                         moticam ,moticam ,moticam ,moticam
                    FROM memoh
                   WHERE (@Oper = ' ' OR @Oper =  mooper)
                     AND mofech >= CONVERT(DATETIME,@fechai)
                     AND mofech <= CONVERT(DATETIME,@fechat)
         END
         -- MEMO
         IF @fechaf = CONVERT(CHAR(08),@fechap,112)
            INSERT INTO memoimp
                 SELECT monumope,motipope,morutcli,mocodcli,
                        mocodmon,momonmo ,moussme ,moticam ,
                        motctra ,moticam ,moparme ,mopar30 ,moparme,
                        mooper  ,mofech  ,motipmer,
                        moticam ,moticam ,moticam ,moticam
                   FROM memo
                  WHERE @Oper = ' ' OR @Oper =  mooper
         UPDATE memoimp
            SET motipmer = CASE WHEN motipmer LIKE 'ARB%' THEN 'ARBI' ELSE 'SPOT' END,
                spread   = 0,
                resul    = 0,
                spreadf  = 0,
                resulf   = 0
         -- MEUS
         IF EXISTS (SELECT * FROM memoimp
                            WHERE (motipmer = 'SPOT' OR motipmer='ARBI')
                              AND (@Oper    = ' '    OR mooper  =@Oper ) )
         BEGIN
             DECLARE @MOTIPOPE CHAR(1),
                     @MOUSSME  NUMERIC(17,4),
                     @MOTCTRA  NUMERIC(19,4),
                     @MOTICAM  NUMERIC(19,4),
                     @MOTCFIN  NUMERIC(19,4),
                     @MOPAR30  NUMERIC(19,8),
                     @MOPARME  NUMERIC(19,8),
                     @MOPARFI  NUMERIC(19,8),
                     @MOMONMO  NUMERIC(17,4),
                     @MOOPER   CHAR(10),
                     @MOTIPMER CHAR(4),
                     @MOUSSMET NUMERIC(17,4),
                     @SPREAD   NUMERIC(17,4),
                     @RESUL    NUMERIC(17,4),
                     @SPREADF  NUMERIC(17,4),
                     @RESULF   NUMERIC(17,4),
                     @SPREADA  NUMERIC(17,4),
                     @SPREAD1  NUMERIC(19,4),
                     @SPREADF1 NUMERIC(19,4),
                     @RESULF1  NUMERIC(19,4),
                     @RESUL1   NUMERIC(19,4),
                     @MONUMOPE NUMERIC(7)
             DECLARE cur_memo SCROLL CURSOR
                 FOR SELECT motipope,moussme,motctra,moticam,motcfin,mopar30,
                            moparme,moparfi,momonmo,mooper,motipmer,monumope
                       FROM memoimp
  OPEN cur_memo
             FETCH FIRST FROM cur_memo
                         INTO @motipope,@moussme ,@motctra,@moticam,@motcfin,
                              @mopar30 ,@moparme ,@moparfi,@momonmo,
                              @mooper  ,@motipmer,@monumope
             WHILE (@@FETCH_STATUS = 0)
             BEGIN
               SELECT @moussmet = @moussmet+@moussme
               IF @motipmer='SPOT'
                  BEGIN
                      IF @motipope='C'
                         BEGIN
                            SELECT @spread1  = @motctra -  @moticam
                            SELECT @resul1   = @moussme * (@motctra-@moticam)
                            SELECT @spreadf1 = @motcfin -  @moticam
                            SELECT @resulf1  = @moussme * (@motcfin-@moticam)
                         END
                      ELSE
                         BEGIN
                            SELECT @spread1  = -@motctra +  @moticam
                            SELECT @resul1   =  @moussme * (-@motctra+@moticam)
                            SELECT @spreadf1 = -@motcfin +  @moticam
                            SELECT @resulf1  =  @moussme * (-@motcfin+@moticam)
                         END
                  END
               ELSE
                  BEGIN     -- TipMer <> 'SPOT'
                      IF @motipope='C'
                         BEGIN
                            SELECT @spread1  =   @mopar30 - @moparme
                            IF @mopar30 <> 0
                               SELECT @resul1   = ((@momonmo/@moparme) - (@momonmo/@mopar30)) * -1
                            ELSE
                               SELECT @resul1   = ((@momonmo/@moparme) - 0) * -1
                            SELECT @spreadf1 =   @moparfi-@moparme
                            IF @moparfi <> 0
                               SELECT @resulf1  = ((@momonmo/@moparme) - (@momonmo/@moparfi)) * -1
                            ELSE
                               SELECT @resulf1  = ((@momonmo/@moparme) - 0) * -1
                         END
                      ELSE
                         BEGIN
                            SELECT @SPREAD1  = -@mopar30+@moparme
                            IF @mopar30 <> 0
                               SELECT @RESUL1   = (@momonmo/@moparme) - (@momonmo/@mopar30)
                            ELSE
                               SELECT @RESUL1   = (@momonmo/@moparme) 
                            SELECT @SPREADF1 = -@moparfi+@moparme
                            IF @moparfi <> 0
                               SELECT @RESULF1  = (@momonmo/@moparme) - (@momonmo/@moparfi)
                            ELSE
                               SELECT @RESULF1  = (@momonmo/@moparme)
                         END
                  END
               SELECT @spread  =  @spread  + @spread1
               SELECT @resul   =  @resul   + @resul1
               SELECT @spreadf =  @spreadf + @spreadf1
               SELECT @resulf  =  @resulf  + @resulf1
               UPDATE memoimp
                  SET spread   = spread  + @spread1 ,
                      resul    = resul   + @resul1  ,
                      spreadf  = spreadf + @spreadf1,
                      resulf   = resulf  + @resulf1
                WHERE @monumope=monumope
               FETCH NEXT FROM cur_memo
                          INTO @motipope,@moussme ,@motctra,@moticam,@motcfin,
                               @mopar30 ,@moparme ,@moparfi,@momonmo,
                               @mooper  ,@motipmer,@monumope
             END --WHILE
             CLOSE cur_memo
             DEALLOCATE cur_memo
             SELECT motipope,
      morutcli,
      mocodmon,
      momonmo,
      moussme,
                    moticam,
      motctra,
      motcfin,
      moparme,
      mopar30,
      moparfi,
                    mooper,
      'MOFECH' = CONVERT(CHAR(12),mofech,103),
    motipmer,
                    a.clnombre,
      spread,
      resul,
      spreadf,
      resulf,
                    'XNOMPROP' = @xNomprop,
               'XRUTPROP' = @xRutprop,
      'XDIGPROP' = @xDigprop,
      'HORA'     = CONVERT(CHAR(08),GETDATE(),108),
      'FECHA PROCESO' = CONVERT(CHAR(10),ACFECPRO,103),
      'FECHA EMISION' = CONVERT(CHAR(10),ACFECPRO,103),
      monumope
               FROM meac    ,
                    memoimp ,
             view_cliente a,
                    view_cliente b
              WHERE morutcli = a.clrut AND mocodcli=a.clcodigo
                AND acrut    = b.clrut
                AND motipmer = 'SPOT'
           ORDER BY mofech,monumope
         END
     END   -- @Tipo = 1
  ELSE
     BEGIN -- @Tipo <> 1
         SELECT motipope,
  morutcli,
  mocodmon,
  momonmo,
  moussme,
                moticam,
  motctra,
  motcfin, 
  moparme,
  mopar30,
  moparfi,
                mooper,
  'MOFECH' = CONVERT(CHAR(10),mofech,103),
  motipmer,
                a.clnombre,
  spread,
  resul,
  spreadf,
  resulf,
                'XNOMPROP' = @xNomprop,
  'XRUTPROP' = @xRutprop,
  'XDIGPROP' = @xDigprop,
  'HORA'     = CONVERT(CHAR(08),GETDATE(),108),
  'FECHA PROCESO' = CONVERT(CHAR(10),ACFECPRO,103),
  'FECHA EMISION' = CONVERT(CHAR(10),ACFECPRO,103),
  monumope
 
           FROM meac    ,
                memoimp ,
                view_cliente a,
                view_cliente b
          WHERE morutcli = a.clrut AND mocodcli = a.clcodigo
            AND acrut    = b.clrut AND motipmer = 'ARBI'
       ORDER BY mofech,monumope
         DELETE memoimp
     END
END
GO
