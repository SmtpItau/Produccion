USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_ACTUALIZA_MONTOS_ELEGIBLES]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RTECNICA_ACTUALIZA_MONTOS_ELEGIBLES]
AS
BEGIN
 
 SET NOCOUNT ON
 
 --declaracion de variables locales 
 DECLARE @uf  FLOAT,
  @Dolar  FLOAT,
  @fecproc DATETIME
 --recupero el valor de la uf
 SELECT  @uf = VMVALOR
        FROM  view_valor_moneda , mdac
 WHERE  vmcodigo = 998 AND vmfecha = acfecproc
 
 SELECT  @Dolar = VMVALOR
 FROM  view_valor_moneda , mdac
 WHERE  vmcodigo = 994 AND vmfecha = acfecproc
 --recupero la fecha de proceso
 SELECT  @fecproc = acfecproc
 FROM  mdac
 UPDATE  tbtr_cod_elg
 SET saldo_menos = 0,
  saldo_mas = 0,
  reserva_menos = 0,
  reserva_mas = 0
------------//////////CALCULO DE LOS MONTOS A MAS Y MENOS DE 90 DIAS DE LA TABLA mdcp //////////---------
 UPDATE  tbtr_cod_elg
 SET saldo_menos = ISNULL( ( SELECT SUM( ROUND( cpvalvenc / 1000 ,0)) FROM mdcp WHERE cpcodigo = 6 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) < 91 ) ,0 ) ,
  saldo_mas   = ISNULL( ( SELECT SUM( ROUND( cpvalvenc / 1000 ,0)) FROM mdcp WHERE cpcodigo = 6 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) > 90 ) ,0 ) 
 WHERE  codigo = 1
 --montos para la cuenta '195M'
 UPDATE  tbtr_cod_elg
 SET saldo_menos = ISNULL( ( SELECT SUM( ROUND( cpvptirc / 1000,0)) FROM mdcp WHERE cpcodigo = 400 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) < 91 ) ,0 ) ,
  saldo_mas   = ISNULL( ( SELECT SUM( ROUND( cpvptirc / 1000,0)) FROM mdcp WHERE cpcodigo = 400 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) > 90 ) ,0 ) 
 WHERE  codigo = 5
 --montos para la cuenta '195E'
 UPDATE  tbtr_cod_elg
 SET saldo_menos = ISNULL( ( SELECT SUM( ROUND( cpvalvenc * @UF / 1000,0)) FROM mdcp WHERE cpcodigo = 7 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) < 91 ) ,0 ) ,
  saldo_mas   = ISNULL( ( SELECT SUM( ROUND( cpvalvenc * @UF / 1000,0)) FROM mdcp WHERE cpcodigo = 7 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) > 90 ) ,0 ) 
 WHERE  codigo = 2
 --montos para la cuenta '1.926'
 UPDATE  tbtr_cod_elg
 SET saldo_menos = isnull( ( SELECT SUM( ROUND( cpvalvenc * @UF / 1000,0)) FROM mdcp WHERE cpcodigo = 4 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) < 91 ) ,0 ),
  saldo_mas   = isnull( ( SELECT SUM( ROUND( cpvalvenc * @UF / 1000,0)) FROM mdcp WHERE cpcodigo = 4 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) > 90 ) ,0 )
 WHERE  codigo = 17
 --montos para la cuenta '1.926'
 UPDATE  tbtr_cod_elg
 SET saldo_menos = isnull(( SELECT SUM( ROUND( cpvalvenc * @UF / 1000,0)) FROM mdcp WHERE cpcodigo = 300 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) < 91 ),0),
  saldo_mas   = isnull(( SELECT SUM( ROUND( cpvalvenc * @UF / 1000,0)) FROM mdcp WHERE cpcodigo = 300 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) > 90 ),0)
 WHERE  codigo = 18
-- UPDATE  tbtr_cod_elg
-- SET saldo_menos = isnull(( SELECT SUM( ROUND( cpvalvenc * @UF / 1000,0)) FROM mdcp WHERE cpcodigo = 400 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) < 91 ),0),
--  saldo_mas   = isnull(( SELECT SUM( ROUND( cpvalvenc * @UF / 1000,0)) FROM mdcp WHERE cpcodigo = 400 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) > 90 ),0)
-- WHERE  codigo = 6
 --montos para cta 1010-depositos de liquidez
 UPDATE  tbtr_cod_elg
 SET saldo_menos = ISNULL( ( SELECT SUM( ROUND( civalcomp / 1000,0)) FROM mdci WHERE cicodigo = 992 and cirutcli =  '97029000' AND DATEDIFF( DAY, cifecemi, cifecven ) < 91 ) ,0 ) ,
  saldo_mas   = ISNULL( ( SELECT SUM( ROUND( civalcomp / 1000,0)) FROM mdci WHERE cicodigo = 992 and cirutcli =  '97029000' AND DATEDIFF( DAY, cifecemi, cifecven ) > 90 ) ,0 ) 
 WHERE  codigo = 19
 --montos para cta 1958 PRD
 UPDATE  tbtr_cod_elg
 SET saldo_menos = isnull( ( SELECT SUM( ROUND( cpvalvenc * @Dolar / 1000,0)) FROM mdcp WHERE cpcodigo = 31 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) < 91 ) ,0 ),
  saldo_mas   = isnull( ( SELECT SUM( ROUND( cpvalvenc * @Dolar / 1000,0)) FROM mdcp WHERE cpcodigo = 31 AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) > 90 ) ,0 )
 WHERE  codigo = 20
------------////////// CALCULO DE LOS MONTOS A MAS Y MENOS DE 90 DIAS DE LA TABLA mdcp  //////////---------
------------////////// PARA PAPELES EN RESERVA TECNICA         //////////---------
 --montos para la cuenta 193
 UPDATE  tbtr_cod_elg
 set reserva_menos   = ISNULL( ( SELECT SUM( ROUND( cpvalvenc / 1000 ,0)) FROM mdcp WHERE cpcodigo = 6 AND cpreserva_tecnica = 'M' AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) < 91 ) ,0 ) ,
  reserva_mas  = ISNULL( ( SELECT SUM( ROUND( cpvalvenc / 1000 ,0)) FROM mdcp WHERE cpcodigo = 6 AND cpreserva_tecnica = 'M' AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) > 90 ) ,0 ) 
 WHERE  codigo = 1
 --montos para la cuenta '195E'
 UPDATE  tbtr_cod_elg
 set reserva_menos   = ISNULL( ( SELECT SUM( ROUND( cpvalvenc * @UF / 1000,0)) FROM mdcp WHERE cpcodigo = 7 AND cpreserva_tecnica = 'M' AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) < 91 ) ,0 ) ,
  reserva_mas  = ISNULL( ( SELECT SUM( ROUND( cpvalvenc * @UF / 1000,0)) FROM mdcp WHERE cpcodigo = 7 AND cpreserva_tecnica = 'M' AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) > 90 ) ,0 ) 
 WHERE  codigo = 2
 --montos para la cuenta '195M'
 UPDATE  tbtr_cod_elg
 SET reserva_menos = ISNULL( ( SELECT SUM( ROUND( cpvptirc / 1000,0)) FROM mdcp WHERE cpcodigo = 400 AND cpreserva_tecnica = 'M' AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) < 91 ) ,0 ) ,
  reserva_mas   = ISNULL( ( SELECT SUM( ROUND( cpvptirc / 1000,0)) FROM mdcp WHERE cpcodigo = 400 AND cpreserva_tecnica = 'M' AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) > 90 ) ,0 ) 
 WHERE  codigo = 5
 --montos para la cuenta '1.926'
 UPDATE  tbtr_cod_elg
 set reserva_menos   = ISNULL( ( SELECT SUM( ROUND( cpvalvenc * @UF / 1000,0)) FROM mdcp WHERE cpcodigo = 4 AND cpreserva_tecnica = 'M' AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) < 91 ) ,0 ) ,
  reserva_mas  = ISNULL( ( SELECT SUM( ROUND( cpvalvenc * @UF / 1000,0)) FROM mdcp WHERE cpcodigo = 4 AND cpreserva_tecnica = 'M' AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) > 90 ) ,0 ) 
 WHERE  codigo = 17
 --montos para la cuenta '1.926'
 UPDATE  tbtr_cod_elg
 set reserva_menos   = ISNULL( ( SELECT SUM( ROUND( cpvalvenc * @UF / 1000,0)) FROM mdcp WHERE cpcodigo = 300 AND cpreserva_tecnica = 'M' AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) < 91 ) ,0 ) ,
  reserva_mas  = ISNULL( ( SELECT SUM( ROUND( cpvalvenc * @UF / 1000,0)) FROM mdcp WHERE cpcodigo = 300 AND cpreserva_tecnica = 'M' AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) > 90 ) ,0 )
 WHERE  codigo = 18
-- UPDATE  tbtr_cod_elg
-- set reserva_menos   = ISNULL( ( SELECT SUM( ROUND( cpvalvenc * @UF / 1000,0)) FROM mdcp WHERE cpcodigo = 400 AND cpreserva_tecnica = 'M' AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) < 91 ) ,0 ) ,
--  reserva_mas  = ISNULL( ( SELECT SUM( ROUND( cpvalvenc * @UF / 1000,0)) FROM mdcp WHERE cpcodigo = 400 AND cpreserva_tecnica = 'M' AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) > 90 ) ,0 )
-- WHERE  codigo = 6
 --montos para cta 1010-depositos de liquidez 
 UPDATE  tbtr_cod_elg
 set reserva_menos   = ISNULL( ( SELECT SUM( ROUND(civalcomp/1000,0)) FROM mdci WHERE cicodigo = 992 and cirutcli =  '97029000' and sucursal_inicio = -1 /*'M'*/ AND DATEDIFF( DAY, cifecemi, cifecven  ) < 91 ) ,0 ) ,
  reserva_mas  = ISNULL( ( SELECT SUM( ROUND(civalcomp/1000,0)) FROM mdci WHERE cicodigo = 992 and cirutcli =  '97029000' and sucursal_inicio = -1 /*'M'*/ AND DATEDIFF( DAY, cifecemi, cifecven  ) > 90 ) ,0 ) 
 WHERE  codigo = 19
 --montos para la cuenta 1958 PRD
 UPDATE  tbtr_cod_elg
 set reserva_menos   = ISNULL( ( SELECT SUM( ROUND( cpvalvenc * @dolar / 1000,0)) FROM mdcp WHERE cpcodigo = 31 AND cpreserva_tecnica = 'M' AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) < 91 ) ,0 ) ,
  reserva_mas  = ISNULL( ( SELECT SUM( ROUND( cpvalvenc * @dolar / 1000,0)) FROM mdcp WHERE cpcodigo = 31 AND cpreserva_tecnica = 'M' AND DATEDIFF( DAY, @fecproc, cpfecpcup ) < 91 AND DATEDIFF( DAY, cpfeccomp, cpfecven ) > 90 ) ,0 ) 
 WHERE  codigo = 20
END

GO
