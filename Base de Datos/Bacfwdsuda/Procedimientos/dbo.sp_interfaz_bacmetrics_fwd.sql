USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_interfaz_bacmetrics_fwd]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_interfaz_bacmetrics_fwd]
AS BEGIN 
SET NOCOUNT ON
DECLARE @fecha DATETIME
SELECT  @fecha = acfecproc   --CONVERT(DATETIME, @fecha1, 121)
FROM  mfac 
DELETE  bmportafolio 
WHERE  sistema = 'BFW' AND fecha = @fecha
DELETE  bmportafolioflujos
WHERE  sistema = 'BFW' AND fecha = @fecha
--|---------------------------------------------------
--| Toda la Cartera Vigente al Cierre de Día
--|---------------------------------------------------
INSERT INTO bmportafolio
SELECT @fecha     , --fecha] [datetime] NOT NULL ,
 b.acrutprop    , --rutcartera] [numeric](9, 0) NOT NULL ,
 'BFW'     , --sistema] [char] (10) NOT NULL ,
 CONVERT(CHAR(10),a.cacodpos1)  , --producto] [char] (10) NOT NULL ,
 a.catipoper    , --tipoper] [char] (10) NOT NULL ,
 a.canumoper    , --numoper] [char] (20) NOT NULL ,
 ''     , --familia] [char] (10) NOT NULL ,
 (SUBSTRING(d.mnnemo,1,3) + '/' + SUBSTRING(e.mnnemo,1,3))  , --instser] [char] (10) NOT NULL ,
 a.cacodcart    , --tipcarter] [char] (1) NOT NULL ,
 a.camtomon1fin    , --posicion] [float] NOT NULL ,
 a.catipcam    , --tasa] [float] NOT NULL ,
 0     , --base] [numeric](3, 0) NOT NULL ,
 1     , --tipotasa] [numeric](1, 0) NOT NULL ,
 0     , --monreaj] [numeric](3, 0) NOT NULL ,
 0     , --moncont] [numeric](3, 0) NOT NULL ,
 999     , --moncomp] [numeric](3, 0) NOT NULL ,
 CONVERT(CHAR(8),a.cafecha,112)  , --fecinic] [datetime] NOT NULL ,
 CONVERT(CHAR(8),a.cafecvcto,112) , --fecvcto] [datetime] NOT NULL ,
 a.camtomon2ini    , --valinic] [float] NOT NULL ,
 a.camtomon2fin    , --valvcto] [float] NOT NULL ,
 ''     , --cuentacon] [char] (15) NOT NULL ,
 a.camtomon1ini    , --capitalum] [float] NOT NULL ,
 a.caequmon1    , --capitalclp] [float] NOT NULL ,
 0     , --interesum] [float] NOT NULL ,
 (a.caperddiferir + a.cautildiferir) , --interesclp] [float] NOT NULL ,
 a.cactacambio_c    , --reajuste] [float] NOT NULL ,
 a.caclpmoneda1    , --valpresen] [float] NOT NULL ,
 a.caoperador    , --operador] [char] (15) NOT NULL ,
 0     , --tasatrans] [float] NOT NULL ,
 ''     , --fecemis] [datetime] NOT NULL ,
 0     , --tasemis] [float] NOT NULL ,
 0     , --basemis] [numeric](3, 0) NOT NULL ,
 0     , --rutemis] [numeric](9, 0) NOT NULL ,
 ''     , --genemis] [char] (10) NOT NULL ,
 a.cacodigo    , --rutclie] [numeric](9, 0) NOT NULL ,
 a.cacodcli    , --codclie] [numeric](10, 0) NOT NULL ,
 ''     , --mascara] [char] (10) NOT NULL ,
 'N'     , --seriado] [char] (1) NOT NULL ,
 0     , --tablap12] [numeric](10, 0) NOT NULL ,
 ''     , --filler1] [char] (50) NOT NULL ,
 ''     , --filler2] [char] (50) NOT NULL ,
 ''     , --filler3] [char] (50) NOT NULL ,
 ''      --filler4] [char] (50) NOT NULL 
FROM mfca  a ,
 mfac  b ,
 view_moneda d ,
 view_moneda e 
WHERE a.cafecvcto > b.acfecproc AND
 d.mncodmon  = a.cacodmon1 AND
 e.mncodmon  = a.cacodmon2 AND
 a.cafecvcto > @fecha  AND
 a.cacodpos1 <> 2
--|------------------------------------------------------------
--| Flujo de la Moneda 1 de la Cartera Vigente al Cierre de Día
--|------------------------------------------------------------
INSERT INTO bmportafolioflujos
SELECT  @fecha     , --[fecha] [datetime] NOT NULL ,
 b.acrutprop    , --rutcartera] [numeric](9, 0) NOT NULL ,
 'BFW'     , --sistema] [char] (10) NOT NULL ,
 CONVERT(CHAR(10),a.cacodpos1)  , --[producto] [char] (10) NOT NULL ,
 a.catipoper    , --[tipoper] [char] (10) NOT NULL ,
 a.canumoper    , --[numoper] [char] (20) NOT NULL ,
 1     , --[numcuot] [numeric](3, 0) NOT NULL ,
 CONVERT(CHAR(8),a.cafecvcto,112) , --[fecpago] [datetime] NOT NULL ,
 CASE 
 WHEN  a.catipoper = 'O' THEN a.camtomon1fin
 WHEN a.catipoper = 'C' THEN a.camtomon1fin
 WHEN a.catipoper = 'V' THEN a.camtomon1fin * -1.0
 WHEN a.catipoper = 'A' THEN a.camtomon1fin * -1.0
 ELSE  0 END    , --[capital] [float] NOT NULL ,
 0     , --[interes] [float] NOT NULL ,
 a.camdausd    , --[moneda] [numeric](3, 0) NOT NULL ,
 CASE 
 WHEN  a.catipoper = 'O' THEN 'A' 
 WHEN a.catipoper = 'C' THEN 'A'
 WHEN a.catipoper = 'V' THEN 'P'
 WHEN a.catipoper = 'A' THEN 'P'
 ELSE  '' END    , --[act_pas] [char] (1) NOT NULL ,
 'T'     , --[tipoflujo] [char] (1) NOT NULL ,
 0     , --[tasaper] [float] NOT NULL ,
 0      --[baseper] [numeric](3, 0) NOT NULL 
FROM mfca a ,
 mfac b 
WHERE a.cafecvcto > b.acfecproc
AND a.cafecvcto > @fecha
AND a.cacodpos1 <> 2
--|------------------------------------------------------------
--| Flujo de la Moneda 2 de la Cartera Vigente al Cierre de Día
--|------------------------------------------------------------
INSERT INTO bmportafolioflujos
SELECT  @fecha     , --[fecha] [datetime] NOT NULL ,
 b.acrutprop    , --rutcartera] [numeric](9, 0) NOT NULL ,
 'BFW'     , --sistema] [char] (10) NOT NULL ,
 CONVERT(CHAR(10),a.cacodpos1)  , --[producto] [char] (10) NOT NULL ,
 a.catipoper    , --[tipoper] [char] (10) NOT NULL ,
 a.canumoper    , --[numoper] [char] (20) NOT NULL ,
 2     , --[numcuot] [numeric](3, 0) NOT NULL,
 CONVERT(CHAR(8),a.cafecvcto,112) , --[fecpago] [datetime] NOT NULL     ,
 CASE 
 WHEN  a.catipoper = 'O' THEN a.camtomon2fin * -1.0
 WHEN a.catipoper = 'C' THEN a.camtomon2fin * -1.0
 WHEN a.catipoper = 'V' THEN a.camtomon2fin 
 WHEN a.catipoper = 'A' THEN a.camtomon2fin 
 ELSE  0  END    , --[capital] [float] NOT NULL ,
 0     , --[interes] [float] NOT NULL      ,
 a.cacodmon2    , --[moneda] [numeric](3, 0) NOT NULL ,
 CASE 
 WHEN  a.catipoper = 'O' THEN 'P' 
 WHEN a.catipoper = 'C' THEN 'P'
 WHEN a.catipoper = 'V' THEN 'A'
 WHEN a.catipoper = 'A' THEN 'A'
 ELSE  '' END    , --[act_pas] [char] (1) NOT NULL ,
 'T'     , --[tipoflujo] [char] (1) NOT NULL ,
 0     , --[tasaper] [float] NOT NULL ,
 0      --[baseper] [numeric](3, 0) NOT NULL 
FROM mfca a ,
 mfac b 
WHERE a.cafecvcto > b.acfecproc
AND a.cafecvcto > @fecha
AND a.cacodpos1 <> 2
SET NOCOUNT OFF
END
GO
