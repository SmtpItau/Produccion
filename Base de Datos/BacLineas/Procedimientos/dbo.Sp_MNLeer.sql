USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MNLeer]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO








CREATE PROCEDURE [dbo].[Sp_MNLeer]
   (
   @mncodmon1 NUMERIC (3,0)
   )
AS
BEGIN
 SELECT mncodmon ,
  mnnemo  ,
  mnsimbol ,
  mnglosa  ,
  mnredondeo ,
  mnbase  ,
  mntipmon ,
  mncodbanco ,
  mnperiodo ,
  mncodsuper ,
  mncodfox ,
  codigo_pais ,
  mncodcor ,
  mnextranj ,
  mnrefmerc ,
  mnrefusd ,
  mnlimite ,
  mncodcorrespC ,
  mncodcorrespV ,
  mnctacamb,
  mncanasta
 FROM MONEDA
 WHERE mncodmon=@mncodmon1
 RETURN
END










GO
